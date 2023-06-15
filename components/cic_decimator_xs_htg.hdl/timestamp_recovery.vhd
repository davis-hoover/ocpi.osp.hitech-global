-- Timestamp recovery primitive.
--
-- This file is protected by Copyright. Please refer to the COPYRIGHT file
-- distributed with this source distribution.
--
-- This file is part of OpenCPI <http://www.opencpi.org>
--
-- OpenCPI is free software: you can redistribute it and/or modify it under the
-- terms of the GNU Lesser General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option) any
-- later version.
--
-- OpenCPI is distributed in the hope that it will be useful, but WITHOUT ANY
-- WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
-- A PARTICULAR PURPOSE. See the GNU Lesser General Public License for
-- more details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

-- Recovers the timestamp of each incoming sample by taking a timestamp update
-- message and incrementing it by the sample interval for each new sample
-- received. timestamp_[unit/fraction]_out and
-- sample_interval_[unit/fraction]_out are valid at the point when
-- data_valid_in is high. This means timestamp and sample interval can be
-- registered at the same time as the input data to a component.
-- The timestamp calculation is split over multiple clock cycles to avoid
-- timing issues caused by the high resolution of the timestamp. The primitive
-- is fully pipelined and asserts no backpressure. When a new timestamp is
-- received the next data sample will have this timestamp. When a new
-- sample interval is received the next data sample timestamp will be the last
-- calculated using the old sample interval. Subsequent timestamps are advanced
-- using the new sample rate. Users are advised that after a sample interval
-- change, a timestamp opcode should be sent for best results. This is due to
-- the abiguity of exactly when between two samples the change occurred.
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity timestamp_recovery is
  generic (
    -- Must be a factor of ADDER_WIDTH_G.
    DATA_IN_WIDTH_G : integer := 8;
    -- Must be a factor of time_width_c (128).
    ADDER_WIDTH_G   : integer := 32
    );
  port (
    clk                          : in  std_logic;
    reset                        : in  std_logic;
    enable                       : in  std_logic;
    timestamp_valid_in           : in  std_logic;
    sample_interval_valid_in     : in  std_logic;
    data_valid_in                : in  std_logic;
    data_in                      : in  std_logic_vector(DATA_IN_WIDTH_G - 1 downto 0);
    timestamp_units_out          : out std_logic_vector(31 downto 0);
    timestamp_fraction_out       : out std_logic_vector(63 downto 0);
    sample_interval_units_out    : out std_logic_vector(31 downto 0);
    sample_interval_fraction_out : out std_logic_vector(63 downto 0)
    );
end timestamp_recovery;

architecture rtl of timestamp_recovery is
  -- Module constants
  constant time_width_c     : integer := timestamp_units_out'length + timestamp_fraction_out'length;
  constant adder_stages_c   : integer := time_width_c / ADDER_WIDTH_G;
  constant inputs_per_add_c : integer := ADDER_WIDTH_G / DATA_IN_WIDTH_G;

  -- Define array types
  type adder_array_t is array (adder_stages_c - 1 downto 0) of unsigned(time_width_c downto 0);
  type adder_in_array_t is array (adder_stages_c - 1 downto 0) of unsigned(ADDER_WIDTH_G downto 0);

  -- Input data width adapter signals
  signal data_in_partial               : std_logic_vector(ADDER_WIDTH_G - 1 downto 0);
  signal data_in_partial_r             : std_logic_vector(ADDER_WIDTH_G - DATA_IN_WIDTH_G - 1 downto 0);
  signal data_in_partial_valid_reg     : std_logic_vector(inputs_per_add_c - 1 downto 0);
  signal timestamp_partial_valid       : std_logic;
  signal sample_interval_partial_valid : std_logic;

  -- Adder pipeline signals
  signal adder_in_previous        : adder_in_array_t;
  signal adder_in_sample_interval : adder_in_array_t;
  signal adder_in_timestamp       : adder_in_array_t;
  signal adder_in_new_data        : unsigned(ADDER_WIDTH_G downto 0);
  signal adder_array              : adder_array_t;
  signal adder_load               : std_logic_vector(adder_stages_c - 1 downto 0);
  signal adder_carry              : std_logic_vector(adder_stages_c - 1 downto 0);

  -- Recovered timestamp and sample interval
  signal sample_interval : std_logic_vector(time_width_c - 1 downto 0);
  signal timestamp       : std_logic_vector(time_width_c - 1 downto 0);
begin
  ------------------------------------------------------------------------------
  -- Input data width adapter
  ------------------------------------------------------------------------------
  -- When DATA_IN_WIDTH_G == ADDER_WIDTH_G pass input signals through.
  no_width_adapter_gen : if (inputs_per_add_c = 1) generate
    data_in_partial               <= data_in;
    timestamp_partial_valid       <= timestamp_valid_in;
    sample_interval_partial_valid <= sample_interval_valid_in;
  end generate;
  -- Otherwise convert from DATA_IN_WIDTH_G wide interface to a ADDER_WIDTH_G
  -- wide interface.
  width_adapter_valid_1plus_gen : if (inputs_per_add_c > 1) generate
    data_in_valid_shift_reg_p : process(clk)
    begin
      if rising_edge(clk) then
        if reset = '1' then
          data_in_partial_valid_reg <= (0 => '1', others => '0');
        elsif enable = '1' then
          if sample_interval_valid_in = '1' or timestamp_valid_in = '1' then
            -- Shift register used as a counter
            data_in_partial_valid_reg <= data_in_partial_valid_reg(data_in_partial_valid_reg'high - 1 downto 0) & data_in_partial_valid_reg(data_in_partial_valid_reg'high);
          end if;
        end if;
      end if;
    end process;
    data_in_partial               <= data_in & data_in_partial_r;
    timestamp_partial_valid       <= data_in_partial_valid_reg(data_in_partial_valid_reg'high) and timestamp_valid_in;
    sample_interval_partial_valid <= data_in_partial_valid_reg(data_in_partial_valid_reg'high) and sample_interval_valid_in;
  end generate;
  -- When 2 inputs per addition register last input value
  width_adapter_2_gen : if (inputs_per_add_c = 2) generate
    data_in_shift_reg_p : process(clk)
    begin
      if rising_edge(clk) then
        if reset = '1' then
          data_in_partial_r <= (others => '0');
        elsif enable = '1' then
          if sample_interval_valid_in = '1' or timestamp_valid_in = '1' then
            data_in_partial_r <= data_in;
          end if;
        end if;
      end if;
    end process;
  end generate;
  -- When more than 2 inputs per addition create shift register to store
  -- older input values.
  width_adapter_2plus_gen : if (inputs_per_add_c > 2) generate
    data_in_shift_reg_p : process(clk)
    begin
      if rising_edge(clk) then
        if reset = '1' then
          data_in_partial_r <= (others => '0');
        elsif enable = '1' then
          if sample_interval_valid_in = '1' or timestamp_valid_in = '1' then
            data_in_partial_r <= data_in & data_in_partial_r(data_in_partial_r'high downto DATA_IN_WIDTH_G);
          end if;
        end if;
      end if;
    end process;
  end generate;
  ------------------------------------------------------------------------------
  -- Sample interval register
  ------------------------------------------------------------------------------
  -- Stores the current sample rate of the system.
  -- New sample rate values are loaded in ADDER_WIDTH_G bits at a time into the
  -- correct location in the sample_interval register. Values must be loaded
  -- into the correct locations rather than shifted as, when a new sample
  -- interval is being loaded, each value is used on the next clock edge in the
  -- adder pipeline. Shifting would cause it to be added with the wrong part of
  -- the timestamp.
  sample_interval_reg_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        sample_interval <= (others => '0');
      else
        if enable = '1' and sample_interval_partial_valid = '1' then
          sample_interval_reg_gen : for in_gen in 0 to adder_stages_c - 1 loop
            if adder_load(in_gen) = '1' then
              sample_interval(((in_gen + 1) * ADDER_WIDTH_G) - 1 downto (in_gen * ADDER_WIDTH_G)) <= data_in_partial;
            end if;
          end loop;
        end if;
      end if;
    end if;
  end process;
  -- Outputs from module
  sample_interval_units_out    <= sample_interval(sample_interval'high downto sample_interval_fraction_out'length);
  sample_interval_fraction_out <= sample_interval(sample_interval_fraction_out'high downto 0);
  ------------------------------------------------------------------------------
  -- Timestamp register
  ------------------------------------------------------------------------------
  -- Stores the timestamp of the next sample sent on the interface.
  -- New timestamps are shifted in ADDER_WIDTH_G bits at a time.
  -- After a valid data sample is received the timestamp is updated from the
  -- output of the pipelined adder.
  timestamp_reg_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        timestamp <= (others => '0');
      else
        if enable = '1' then
          if timestamp_partial_valid = '1' then
            timestamp <= data_in_partial & timestamp(timestamp'high downto data_in_partial'length);
          elsif data_valid_in = '1' then
            timestamp <= std_logic_vector(adder_array(adder_array'high)(time_width_c - 1 downto 0));
          end if;
        end if;
      end if;
    end if;
  end process;
  -- Outputs from module
  timestamp_units_out    <= timestamp(timestamp'high downto timestamp_fraction_out'length);
  timestamp_fraction_out <= timestamp(timestamp_fraction_out'high downto 0);

  ------------------------------------------------------------------------------
  -- Load controller for adder pipeline
  ------------------------------------------------------------------------------
  -- Controls which stage of the adder pipeline is being updated with new
  -- timestamp or sample rate value from the interface. A '1' in the position
  -- equivalent to the stage number means new data should be loaded.
  adder_load_reg_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        adder_load <= (0 => '1', others => '0');
      else
        if enable = '1' and (timestamp_partial_valid = '1' or sample_interval_partial_valid = '1') then
          adder_load <= adder_load(adder_load'high - 1 downto 0) & adder_load(adder_load'high);
        end if;
      end if;
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Added input type and width conversions
  ------------------------------------------------------------------------------
  -- This should not synthesis any logic. It is just making copy of existing
  -- signals and resizing them so they can be fed into an adder that is 1 bit
  -- wider so the overflow can be captured.
  adder_input_p : process(adder_array, sample_interval, timestamp, data_in_partial)
  begin
    adder_inputs_gen : for stage in 0 to adder_stages_c - 1 loop
      adder_in_previous(stage)        <= resize(unsigned(adder_array(stage)(((stage + 1) * ADDER_WIDTH_G) - 1 downto stage*ADDER_WIDTH_G)), ADDER_WIDTH_G + 1);
      adder_in_sample_interval(stage) <= resize(unsigned(sample_interval (((stage + 1) * ADDER_WIDTH_G) - 1 downto stage*ADDER_WIDTH_G)), ADDER_WIDTH_G + 1);
      adder_in_timestamp(stage)       <= resize(unsigned(timestamp (((stage + 1) * ADDER_WIDTH_G) - 1 downto stage*ADDER_WIDTH_G)), ADDER_WIDTH_G + 1);
    end loop;
    adder_in_new_data <= resize(unsigned(data_in_partial), ADDER_WIDTH_G + 1);
  end process;
  -- Get the carry bit from the last stage of the pipelined addition.
  adder_carry_p : process(adder_array)
  begin
    adder_carry_gen : for stage in 1 to adder_stages_c - 1 loop
      adder_carry(stage) <= adder_array(stage - 1)(ADDER_WIDTH_G * stage);
    end loop;
    adder_carry(0) <= '0';
  end process;

  ------------------------------------------------------------------------------
  -- Adder pipeline
  ------------------------------------------------------------------------------
  -- Creates a pipeline of adder_stages_c x ADDER_WIDTH_G bit adders as well
  -- as adder_stages_c x (time_width_c + 1) bit registers.
  -- The goal is to split the time_width_c bit wide addition over adder_stages_c
  -- clock cycles. After loading a new timestamp or sample interval, the
  -- pipeline can output a new timestamp on every clock edge.
  -- The calculation is split over multiple clock cycles as the timestamp
  -- is 128 bits by default. A 128 bit addition in a single clock cycle can
  -- cause timing issues in some designs.
  -- In the example where adder_stages_c is 4 and ADDER_WIDTH_G = 32:
  -- Stage 0 will contain the addition of the 32 LSBs of the timestamp
  -- Stage 1 will contain the addition of the 64 LSBs of the timestamp
  -- Stage 2 will contain the addition of the 96 LSBs of the timestamp
  -- Stage 3 will contain the addition of the full timestamp. The carry bit
  -- in the final stage should be ignored as the timestamp is a signed number
  -- and should never overflow in normal circumstances.
  pipelined_adder_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        adder_array <= (others => (others => '0'));
      else
        if enable = '1' then
          -- Perform next addition
          generate_adder_pipeline : for stage in 0 to adder_stages_c - 1 loop
            if adder_load(stage) = '1' and timestamp_partial_valid = '1' then
              -- If we are loading a new timestamp, the source of INPUT1 to
              -- the adder should be the new data_in value. INPUT2 is the
              -- relevant part of sample interval value.
              adder_array(stage)(((stage + 1) * ADDER_WIDTH_G) downto (stage * ADDER_WIDTH_G)) <= adder_in_new_data + adder_in_sample_interval(stage) + ("" & adder_carry(stage));
            elsif adder_load(stage) = '1' and sample_interval_partial_valid = '1' then
              -- If we are loading a new sample interval then the source of
              -- INPUT1 is the new data_in value and the source of INPUT2
              -- is the relevant part of the current timestamp.
              adder_array(stage)(((stage + 1) * ADDER_WIDTH_G) downto (stage * ADDER_WIDTH_G)) <= adder_in_new_data + adder_in_timestamp(stage) + ("" & adder_carry(stage));
            elsif data_valid_in = '1' or timestamp_partial_valid = '1' or sample_interval_partial_valid = '1' then
              -- Otherwise, INPUT1 is the previous value for that stage.
              -- INPUT2 is still the sample interval.
              adder_array(stage)(((stage + 1) * ADDER_WIDTH_G) downto (stage * ADDER_WIDTH_G)) <= adder_in_previous(stage) + adder_in_sample_interval(stage) + ("" & adder_carry(stage));
            end if;
          end loop;
          -- Register already added bits to next stage of pipeline.
          generate_register_pipeline : for stage in 1 to adder_stages_c - 1 loop
            if timestamp_partial_valid = '1' or sample_interval_partial_valid = '1' or data_valid_in = '1' then
              adder_array(stage)((stage * ADDER_WIDTH_G) - 1 downto 0) <= adder_array(stage - 1)((stage * ADDER_WIDTH_G) - 1 downto 0);
            end if;
          end loop;
        end if;
      end if;
    end if;
  end process;

end rtl;
