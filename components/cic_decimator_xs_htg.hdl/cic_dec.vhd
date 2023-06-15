-- HDL Implementation of a CIC decimator.
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

-- Description : Cascaded integrator-comb filter (CIC) base decimator
-- ----------------------------------------------------------------------------
-- Usage :
-- Decimates an input signal using a CIC filter
-- See http://dspguru.com/sites/dspguru/files/cic.pdf for more information
-- on CIC filters.
-- Number of integrator and comb stages can be set with a generic
-- For typical usage int_stages_g == comb_stages_g
-- The gain of the filter is G = (R*M)^N where:
-- R is the decimation factor which can be set at runtime.
-- M is differential delay
-- N is the number of integrator and comb sections
-- The size of the output and intermediate calculation registers is given by:
-- bits_out = ceil[N*(log2(R*M))+bits_in]
-- E.g. for a max 36 bit output size and 16 bit input size, the largest
-- decimation factor would be R = floor[(2^((36-16)/3))/2] = 50 (when N=3,M=2)
-- ----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity cic_dec is
  generic (
    int_stages_g       : integer := 3;
    comb_stages_g      : integer := 3;
    diff_delay_g       : integer := 2;
    input_word_size_g  : integer := 16;
    output_word_size_g : integer := 36;  -- ceil([N*log2(RM)]+input_bits)
    dec_factor_size_g  : integer := 16
    );

  port (
    clk                : in  std_logic;
    reset              : in  std_logic;
    clk_en             : in  std_logic;
    data_valid_in      : in  std_logic;
    data_in            : in  signed(input_word_size_g - 1 downto 0);
    down_sample_factor : in  unsigned(dec_factor_size_g - 1 downto 0);
    data_valid_out     : out std_logic;
    data_out           : out signed(output_word_size_g - 1 downto 0)
    );
end cic_dec;

architecture rtl of cic_dec is

  -- Define array types
  type integrate_array_t is array(0 to int_stages_g - 1) of
    signed(output_word_size_g - 1 downto 0);
  type comb_array_t is array(0 to int_stages_g - 1) of
    signed(output_word_size_g - 1 downto 0);
  type diff_delay_t is array(0 to diff_delay_g - 1) of comb_array_t;

  -- Pipeline integrators
  signal int_array  : integrate_array_t;
  signal int_data   : signed(output_word_size_g - 1 downto 0);
  signal int_data_r : signed(output_word_size_g - 1 downto 0);
  signal int_delay  : std_logic_vector(int_stages_g - 1 downto 0);
  signal int_valid  : std_logic;

  -- Pipelined combs
  signal comb_array  : comb_array_t;
  signal delay_array : diff_delay_t;
  signal comb_delay  : std_logic_vector(comb_stages_g - 1 downto 0);
  signal comb_valid  : std_logic_vector(comb_stages_g downto 0);

  -- Down sample counter signals
  signal dec_count               : unsigned(down_sample_factor'length - 1 downto 0);
  signal down_sampled_data_valid : std_logic;

begin

  -- Check CIC settings are not set to 0
  assert diff_delay_g /= 0 report "diff_delay_g must be greater than 0" severity failure;
  assert int_stages_g /= 0 report "int_stages_g must be greater than 0" severity failure;
  assert comb_stages_g /= 0 report "comb_stages_g must be greater than 0" severity failure;

  -----------------------------------------------------------------------------
  -- Integrator stage
  -----------------------------------------------------------------------------

  integrate_stage_p : process(clk)
  begin
    if rising_edge(clk) then

      if (reset = '1') then
        int_array <= (others => (others => '0'));
        int_delay <= (others => '0');
      elsif (clk_en = '1') then

        -- Track which samples are valid in the integration pipeline
        int_delay <= int_delay(int_stages_g - 2 downto 0) & data_valid_in;

        -- Shift new samples into the integration pipeline
        if (data_valid_in = '1') then
          int_array(0) <= resize(data_in, output_word_size_g) + int_array(0);
        end if;

        for gen_var in 1 to int_stages_g - 1 loop
          -- Advance the pipeline if the previous integration stage is done
          if int_delay(gen_var - 1) = '1' then
            int_array(gen_var) <= int_array(gen_var - 1) + int_array(gen_var);
          end if;
        end loop;

      end if;
    end if;
  end process;

  int_valid <= int_delay(int_stages_g - 1);
  int_data  <= int_array(int_stages_g - 1);

  -----------------------------------------------------------------------------
  -- Down sample stage
  -----------------------------------------------------------------------------

  -- int_valid     ___|---|___|---|___|---|___|---|___
  -- Dec factor=1  -----------------------------------
  -- Dec factor=2  ___|-------|_______|-------|___________
  -- Dec factor=3  ___|-------|_______________|------|______
  -- etc..

  decimate_stage_p : process(clk)
  begin
    if rising_edge(clk) then

      if (reset = '1') then
        dec_count               <= to_unsigned(1, down_sample_factor'length);
        down_sampled_data_valid <= '0';
      elsif (clk_en = '1') then
        if (int_valid = '1') then
          if (dec_count = to_unsigned(1, down_sample_factor'length)) then
            -- When we reach the desired count the counter is reset
            dec_count               <= down_sample_factor;
            -- When counter == 1, the down_sampled_data_valid
            -- line goes high for one clk cycle
            down_sampled_data_valid <= '1';
          else
            -- When the counter is != to 1 then dec the counter and
            -- set the down_sampled_data_valid line low.
            dec_count               <= (dec_count - 1);
            down_sampled_data_valid <= '0';
          end if;
        else
          down_sampled_data_valid <= '0';
        end if;
      end if;
    end if;

  end process;

  -- Delay the integrated data by 1 clock cycle to align it with
  -- the down_sampled_data_valid signal
  int_data_delay_p : process(clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        int_data_r <= (others => '0');
      elsif (clk_en = '1') then
        int_data_r <= int_data;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Comb stage
  -----------------------------------------------------------------------------
  comb_stage_p : process(clk)
  begin
    if rising_edge(clk) then

      if (reset = '1') then
        comb_array <= (others => (others => '0'));
        comb_delay <= (others => '0');

      elsif (clk_en = '1') then

        -- comb_delay marks which stages have valid inputs
        comb_delay <= comb_delay(comb_stages_g - 2 downto 0) & down_sampled_data_valid;

        -- Update first comb stage
        if (down_sampled_data_valid = '1') then
          comb_array(0) <= int_data_r - delay_array(diff_delay_g - 1)(0);
        end if;

        -- Update the remaining comb stages
        for gen_var in 1 to comb_stages_g - 1 loop
          if comb_delay(gen_var - 1) = '1' then
            comb_array(gen_var) <= comb_array(gen_var - 1) - delay_array(diff_delay_g - 1)(gen_var);
          end if;
        end loop;

      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Comb delay register
  -----------------------------------------------------------------------------
  -- Creates a delayed version of the input to each comb stage
  delay_gen : if diff_delay_g = 1 generate
    comb_delay_reg_p : process(clk)
    begin
      if rising_edge(clk) then

        if (reset = '1') then
          delay_array(0) <= (others => (others => '0'));

        elsif (clk_en = '1') then

          -- If input to first comb is valid, then register the input
          if down_sampled_data_valid = '1' then
            delay_array(0)(0) <= int_data_r;
          end if;
          -- For each comb stage, if input to current stage is valid,
          -- then register the last input to the current stage.
          for gen_var in 1 to comb_stages_g - 1 loop
            if comb_delay(gen_var - 1) = '1' then
              delay_array(0)(gen_var) <= comb_array(gen_var - 1);
            end if;
          end loop;

        end if;
      end if;
    end process;
  end generate;

  -----------------------------------------------------------------------------
  -- Comb delay pipeline (when differential delay is > 1)
  -----------------------------------------------------------------------------
  -- If the differential delay is greater than 1 then add additional delay
  -- stages for the inputs to each CIC comb stage

  -- comb_valid vector stores which of the inputs to each of the comb stages
  -- are valid. e.g. comb_valid
  comb_valid <= comb_delay & down_sampled_data_valid;

  delay_pipe_gen : if diff_delay_g > 1 generate
    comb_delay_pipeline_p : process(clk)
    begin
      if rising_edge(clk) then

        if (reset = '1') then
          delay_array <= (others => (others => (others => '0')));
        elsif (clk_en = '1') then

          -- If input to first comb is valid, then register the input
          if down_sampled_data_valid = '1' then
            delay_array(0)(0) <= int_data_r;
          end if;
          -- For each comb stage, if input to current stage is valid,
          -- then register the last input to the current stage.
          for gen_var in 1 to comb_stages_g - 1 loop
            if comb_delay(gen_var - 1) = '1' then
              delay_array(0)(gen_var) <= comb_array(gen_var - 1);
            end if;
          end loop;

          -- For each extra delay register, register the previous comb stage
          -- inputs one more time
          for delay_gen_var in 1 to diff_delay_g - 1 loop
            -- For each comb stage, if input to current stage is valid,
            -- then register the last input to the current stage.
            for gen_var in 0 to comb_stages_g - 1 loop
              if comb_valid(gen_var) = '1' then
                delay_array(delay_gen_var)(gen_var) <= delay_array(delay_gen_var - 1)(gen_var);
              end if;
            end loop;
          end loop;

        end if;
      end if;
    end process;
  end generate;

  -----------------------------------------------------------------------------
  -- Data output
  -----------------------------------------------------------------------------
  data_valid_out <= comb_delay(comb_stages_g - 1);
  data_out       <= comb_array(comb_stages_g - 1);

end rtl;
