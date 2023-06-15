-- Downsample protocol interface delay primitive.
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

-- Creates a variable length delay pipeline for all interface signals in order
-- to align interface signals with a module that processes sample data.
-- Delay_G should be set to the delay in clock cycles of the module that
-- processes sample data. When a timestamp opcode is received, the module
-- delays sending it until the next valid output sample. The timestamp is
-- corrected so that it represents the time of next output sample, and not
-- the input sample it was attached to, as that sample may have
-- been down sampled.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library work;
--use work.sdr_interface.timestamp_recovery;

entity downsample_protocol_interface_delay_v2 is
  generic (
    delay_g                     : positive         := 1;
    data_width_g                : positive         := 8;
    opcode_width_g              : positive         := 3;
    byte_enable_width_g         : positive         := 1;
    processed_data_opcode_g     : std_logic_vector := "000";
    time_opcode_g               : std_logic_vector := "001";
    sample_interval_opcode_g    : std_logic_vector := "010";
    decimated_sample_interval_g : boolean          := false
    );
  port (
    clk                 : in  std_logic;
    reset               : in  std_logic;
    enable              : in  std_logic;         -- Advances the delay line.
    take_in             : in  std_logic := '1';  -- Qualifies _valid and _ready.
    -- Pause data processing and input when high.
    input_hold_out      : out std_logic;
    processed_stream_in : in  std_logic_vector(data_width_g - 1 downto 0);
    -- When high the processed data stream is valid.
    processed_mask_in   : in  std_logic;
    -- Input interface signals
    input_som           : in  std_logic := '0';
    input_eom           : in  std_logic;
    input_eof           : in  std_logic := '0';
    input_valid         : in  std_logic;
    input_ready         : in  std_logic;
    input_byte_enable   : in  std_logic_vector(byte_enable_width_g - 1 downto 0);
    input_opcode        : in  std_logic_vector(opcode_width_g - 1 downto 0);
    input_data          : in  std_logic_vector(data_width_g - 1 downto 0);
    -- Output interface signals
    output_som          : out std_logic;
    output_eom          : out std_logic;
    output_eof          : out std_logic;
    output_valid        : out std_logic;
    output_give         : out std_logic;
    output_byte_enable  : out std_logic_vector(byte_enable_width_g - 1 downto 0);
    output_opcode       : out std_logic_vector(opcode_width_g - 1 downto 0);
    output_data         : out std_logic_vector(data_width_g - 1 downto 0)
    );
end downsample_protocol_interface_delay_v2;

architecture rtl of downsample_protocol_interface_delay_v2 is

  constant timestamp_unit_width_c     : integer := 32;
  constant timestamp_fraction_width_c : integer := 64;

  constant outputs_per_input_c : integer := (timestamp_unit_width_c + timestamp_fraction_width_c)/ data_width_g;

  type state_t is (passthrough_message_s, send_timestamp_s, send_stream_data_s);

  type byte_enable_array_t is array (delay_g - 1 downto 0) of std_logic_vector(byte_enable_width_g - 1 downto 0);
  type opcode_array_t is array (delay_g - 1 downto 0) of std_logic_vector(opcode_width_g - 1 downto 0);
  type data_array_t is array (delay_g - 1 downto 0) of std_logic_vector(data_width_g - 1 downto 0);

  -- Interface delay registers
  signal input_register_take        : std_logic_vector(delay_g - 1 downto 0);
  signal input_register_som         : std_logic_vector(delay_g - 1 downto 0);
  signal input_register_eom         : std_logic_vector(delay_g - 1 downto 0);
  signal input_register_eof         : std_logic_vector(delay_g - 1 downto 0);
  signal input_register_valid       : std_logic_vector(delay_g - 1 downto 0);
  signal input_register_byte_enable : byte_enable_array_t;
  signal input_register_opcode      : opcode_array_t;
  signal input_register_data        : data_array_t;

  -- Delayed input signals (signals just point to end of input_register
  -- delay signals)
  signal delayed_input_take        : std_logic;
  signal delayed_input_som         : std_logic;
  signal delayed_input_eom         : std_logic;
  signal delayed_input_eof         : std_logic;
  signal delayed_input_valid       : std_logic;
  signal delayed_input_byte_enable : std_logic_vector(byte_enable_width_g - 1 downto 0);
  signal delayed_input_opcode      : std_logic_vector(opcode_width_g - 1 downto 0);
  signal delayed_input_data        : std_logic_vector(data_width_g - 1 downto 0);

  -- Output register
  signal output_temp_give        : std_logic;
  signal output_temp_som         : std_logic;
  signal output_temp_eom         : std_logic;
  signal output_temp_eof         : std_logic;
  signal output_temp_valid       : std_logic;
  signal output_temp_byte_enable : std_logic_vector(byte_enable_width_g - 1 downto 0);
  signal output_temp_opcode      : std_logic_vector(opcode_width_g - 1 downto 0);
  signal output_temp_data        : std_logic_vector(data_width_g - 1 downto 0);

  signal input_hold            : std_logic;
  signal clk_en                : std_logic;
  signal output_data_valid     : std_logic;
  signal output_since_eom      : std_logic;
  -- Timestamp signals
  signal timestamp             : std_logic_vector(timestamp_unit_width_c + timestamp_fraction_width_c - 1 downto 0);
  signal timestamp_units       : std_logic_vector(timestamp_unit_width_c - 1 downto 0);
  signal timestamp_fraction    : std_logic_vector(timestamp_fraction_width_c - 1 downto 0);
  signal timestamp_valid       : std_logic;
  signal sample_interval_valid : std_logic;
  signal data_valid            : std_logic;
  signal timestamp_data_valid  : std_logic;
  -- Delayed interface signals
  signal data_r                : std_logic_vector(output_data'high downto 0);
  signal eom_r                 : std_logic;
  signal timestamp_r           : std_logic_vector(timestamp'high downto 0);
  signal output_word_counter   : unsigned(3 downto 0);
  -- State machine signals
  signal current_state         : state_t;
  signal missed_timestamp      : std_logic;
  -- Ouput internal signal
  signal output_give_i         : std_logic;
  signal output_valid_i        : std_logic;

begin

  -- Input hold is high when outputting a timestamp message. This should
  -- assert backpressure on the input interface, and disable the clock enable
  -- on any processes working on input data.
  input_hold     <= '1' when current_state = send_timestamp_s or current_state = send_stream_data_s else '0';
  input_hold_out <= input_hold;
  clk_en         <= enable and not input_hold;
  ------------------------------------------------------------------------------
  -- Input delay
  ------------------------------------------------------------------------------
  -- Add delay to align data with respective flow control signals
  delay_pipeline_1_gen : if delay_g = 1 generate
    interface_delay_pipeline_p : process(clk)
    begin
      if rising_edge(clk) then
        if reset = '1' then
          input_register_take  <= (others => '0');
          input_register_valid <= (others => '0');
        elsif(clk_en = '1') then
          input_register_take(0)  <= input_ready and take_in;
          input_register_valid(0) <= input_valid and take_in;
        end if;
        -- Other registers don't need to be reset as gated by
        -- input_register_take and/or valid.
        if(clk_en = '1') then
          input_register_som(0)         <= input_som;
          input_register_eom(0)         <= input_eom;
          input_register_eof(0)         <= input_eof;
          input_register_byte_enable(0) <= input_byte_enable;
          input_register_opcode(0)      <= input_opcode;
          input_register_data(0)        <= input_data;
        end if;
      end if;
    end process;
  end generate;
  -- If delay is more than 1 create shift register of input record.
  delay_pipeline_2_plus_gen : if delay_g > 1 generate
    interface_delay_pipeline_p : process(clk)
    begin
      if rising_edge(clk) then
        if reset = '1' then
          input_register_take  <= (others => '0');
          input_register_valid <= (others => '0');
        elsif(clk_en = '1') then
          input_register_take  <= input_register_take(delay_g - 2 downto 0) & (input_ready and take_in);
          input_register_valid <= input_register_valid(delay_g - 2 downto 0) & (input_valid and take_in);
        end if;
        -- Other registers don't need to be reset as gated by
        -- input_register_take and/or valid.
        if(clk_en = '1') then
          input_register_som         <= input_register_som(delay_g - 2 downto 0) & input_som;
          input_register_eom         <= input_register_eom(delay_g - 2 downto 0) & input_eom;
          input_register_eof         <= input_register_eof(delay_g - 2 downto 0) & input_eof;
          input_register_byte_enable <= input_register_byte_enable(delay_g - 2 downto 0) & input_byte_enable;
          input_register_opcode      <= input_register_opcode(delay_g - 2 downto 0) & input_opcode;
          input_register_data        <= input_register_data(delay_g - 2 downto 0) & input_data;
        end if;
      end if;
    end process;
  end generate;

  -- Shortcut signals pointing to end of delay pipeline.
  delayed_input_take        <= input_register_take(input_register_take'high);
  delayed_input_som         <= input_register_som(input_register_som'high);
  delayed_input_eom         <= input_register_eom(input_register_eom'high);
  delayed_input_eof         <= input_register_eof(input_register_eof'high);
  delayed_input_valid       <= input_register_valid(input_register_valid'high);
  delayed_input_byte_enable <= input_register_byte_enable(input_register_byte_enable'high);
  delayed_input_opcode      <= input_register_opcode(input_register_opcode'high);
  delayed_input_data        <= input_register_data(input_register_data'high);

  -- Low when an input sample is not valid or has been removed due to down
  -- sampling.
  output_data_valid <= processed_mask_in and delayed_input_valid;

  ------------------------------------------------------------------------------
  -- Timestamp calculation
  ------------------------------------------------------------------------------
  timestamp_valid <= '1' when
                     delayed_input_opcode = time_opcode_g and
                     delayed_input_valid = '1' else '0';
  sample_interval_valid <= '1' when
                           delayed_input_opcode = sample_interval_opcode_g and
                           delayed_input_valid = '1' else '0';
  data_valid <= '1' when
                delayed_input_opcode = processed_data_opcode_g and
                delayed_input_valid = '1' else '0';

  output_sample_interval_gen : if decimated_sample_interval_g generate
    timestamp_data_valid <= output_data_valid;
  end generate;
  input_sample_interval_gen : if not decimated_sample_interval_g generate
    timestamp_data_valid <= data_valid;
  end generate;

  timestamp_i : entity work.timestamp_recovery
    generic map (
      adder_width_g   => 32,
      data_in_width_g => data_width_g
      )
    port map (
      clk                          => clk,
      reset                        => reset,
      enable                       => clk_en,
      timestamp_valid_in           => timestamp_valid,
      sample_interval_valid_in     => sample_interval_valid,
      data_valid_in                => timestamp_data_valid,
      data_in                      => delayed_input_data,
      timestamp_units_out          => timestamp_units,
      timestamp_fraction_out       => timestamp_fraction,
      sample_interval_units_out    => open,
      sample_interval_fraction_out => open
      );
  -- Create full timestamp
  timestamp <= timestamp_units & timestamp_fraction;
  ------------------------------------------------------------------------------
  -- Interface state machine
  ------------------------------------------------------------------------------
  interface_state_machine_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        current_state    <= passthrough_message_s;
        missed_timestamp <= '0';
        output_since_eom <= '0';
      -- Enable not clk_en as must continue to run when input_hold = 1
      elsif (enable = '1') then
        case current_state is
          when passthrough_message_s =>
            -- If a timestamp is received on input port, set a flag.
            -- NB. Input timestamp messages are suppressed and not passed to
            -- the output, as they may point to a sample that has been removed
            -- due to down sampling.
            if timestamp_valid = '1' then
              missed_timestamp <= '1';
            end if;

            if output_temp_eom = '1' and output_temp_give = '1' then
              output_since_eom <= '0';
            elsif output_data_valid = '1' then
              output_since_eom <= '1';
            end if;

            -- If we have flagged that a timestamp has been received then
            -- wait until the next valid stream message is received.
            -- Until then continue to pass through all other opcodes.
            -- If the message is valid, register it as it will not be passed
            -- to the output until after the timestamp has been sent.
            if data_valid = '1' and missed_timestamp = '1' and processed_mask_in = '1' then
              data_r              <= processed_stream_in;
              eom_r               <= delayed_input_eom;
              current_state       <= send_timestamp_s;
              timestamp_r         <= timestamp;
              output_word_counter <= to_unsigned(outputs_per_input_c - 1, output_word_counter'length);
            end if;
          when send_timestamp_s =>
            -- Shift timestamp right by the length of the output data interface
            timestamp_r         <= std_logic_vector(unsigned(timestamp_r) srl output_data'length);
            -- Update number of remaining shifts
            output_word_counter <= output_word_counter - 1;
            -- When all output words are sent go back to passthrough state
            if output_word_counter = 0 then
              current_state <= send_stream_data_s;
            end if;
          when send_stream_data_s =>
            -- Send the first valid stream message after the timestamp. This
            -- was registered in the passthrough state.
            current_state    <= passthrough_message_s;
            -- Reset the missed timestamp flag as the timestamp has now been
            -- sent.
            missed_timestamp <= '0';
        end case;
      end if;
    end if;
  end process;
  ------------------------------------------------------------------------------
  -- Output MUX
  ------------------------------------------------------------------------------

  output_mux_p : process(current_state, delayed_input_som, delayed_input_eom, delayed_input_eof,
                         delayed_input_valid, delayed_input_opcode,
                         delayed_input_byte_enable, delayed_input_data,
                         delayed_input_take, processed_stream_in, output_data_valid,
                         missed_timestamp, data_r, eom_r, output_word_counter,
                         timestamp_r)
  begin
    if (current_state = passthrough_message_s) then
      -- In passthrough condition, pass all signals through directly except
      -- a timestamp, the first stream message after a timestamp, or
      -- a non-valid stream where both SOM and EOM are 0, or a 1 length
      -- message input where the data has been removed due to down sampling.
      if (delayed_input_opcode = time_opcode_g) or
        (missed_timestamp = '1' and delayed_input_opcode = processed_data_opcode_g) or
        (delayed_input_opcode = processed_data_opcode_g and delayed_input_eom = '0' and output_data_valid = '0') or
        (delayed_input_opcode = processed_data_opcode_g and delayed_input_eom = '1' and delayed_input_valid = '1' and output_data_valid = '0' and output_since_eom = '0') then
        output_temp_give  <= '0';
        output_temp_valid <= '0';
      else
        output_temp_give <= delayed_input_take;
        -- Suppress valid / byte enable when a stream message has been down
        -- sampled.
        if (delayed_input_opcode = processed_data_opcode_g) then
          output_temp_valid       <= output_data_valid;
          output_temp_byte_enable <= (others => '1');
        else
          output_temp_valid       <= delayed_input_valid;
          output_temp_byte_enable <= delayed_input_byte_enable;
        end if;
      end if;
      output_temp_som    <= delayed_input_som;
      output_temp_eom    <= delayed_input_eom;
      output_temp_eof    <= delayed_input_eof;
      output_temp_opcode <= delayed_input_opcode;
      -- When the delayed interface opcode is the sample opcode output the
      -- processed sample data rather than the delayed data.
      if delayed_input_opcode = processed_data_opcode_g then
        output_temp_data <= processed_stream_in;
      else
        output_temp_data <= delayed_input_data;
      end if;
    elsif current_state = send_timestamp_s then
      output_temp_data        <= timestamp_r(output_temp_data'high downto 0);
      output_temp_give        <= '1';
      output_temp_valid       <= '1';
      output_temp_byte_enable <= (others => '1');
      output_temp_opcode      <= time_opcode_g;
      if output_word_counter = (outputs_per_input_c - 1) then
        output_temp_som <= '1';
      else
        output_temp_som <= '0';
      end if;
      if output_word_counter = 0 then
        output_temp_eom <= '1';
      else
        output_temp_eom <= '0';
      end if;
      output_temp_eof <= '0';
    else                                -- current_state = send_stream_data_s
      output_temp_data        <= data_r;
      output_temp_give        <= '1';
      output_temp_valid       <= '1';
      output_temp_byte_enable <= (others => '1');
      output_temp_opcode      <= processed_data_opcode_g;
      output_temp_som         <= '1';
      output_temp_eom         <= eom_r;
      output_temp_eof         <= '0';
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Output Register
  ------------------------------------------------------------------------------
  -- Add a one clock cycle delay to the output due to logic delay of complex
  -- output MUX.
  output_register_p : process(clk)
  begin
    if rising_edge(clk) then
      if(enable = '1') then
        output_give_i      <= output_temp_give;
        output_data        <= output_temp_data;
        output_valid_i     <= output_temp_valid;
        output_byte_enable <= output_temp_byte_enable;
        output_opcode      <= output_temp_opcode;
        output_som         <= output_temp_som;
        output_eom         <= output_temp_eom;
        output_eof         <= output_temp_eof;
      end if;
    end if;
  end process;
  output_give  <= output_give_i;
  output_valid <= output_valid_i;
end rtl;
