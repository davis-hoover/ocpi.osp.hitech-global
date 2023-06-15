-- HDL Implementation of CIC decimator.
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library ocpi;
use ocpi.types.all;
--library sdr_dsp;
--use sdr_dsp.sdr_dsp.cic_dec;
--use sdr_dsp.sdr_dsp.rounding_halfup;

architecture rtl of worker is

  -- Set input and output sizes to 16 bit
  constant input_word_size_c  : integer := 16;
  constant output_word_size_c : integer := 16;
  -- Sets the size of the internal registers used to store the cic calculations
  constant cic_word_size_c    : integer := to_integer(cic_reg_size);
  -- Sets number of comb and integrator stages
  constant comb_stages_c      : integer := to_integer(cic_order);
  constant int_stages_c       : integer := to_integer(cic_order);
  constant diff_delay_c       : integer := to_integer(cic_diff_delay);
  -- Set delay through CIC and rounding primitive
  constant delay_c            : integer := comb_stages_c + int_stages_c + 2;
  -- Interface signals
  signal enable               : std_logic;
  signal input_interface      : worker_input_in_t;
  signal input_hold           : std_logic;
  signal data_valid_in        : std_logic;
  signal data_in_i            : signed(input_word_size_c - 1 downto 0);
  signal data_in_q            : signed(input_word_size_c - 1 downto 0);
  signal output               : worker_output_out_t;

  -- CIC signals
  signal cic_data_valid     : std_logic;
  signal data_out_i         : signed(cic_word_size_c - 1 downto 0);
  signal data_out_q         : signed(cic_word_size_c - 1 downto 0);
  signal rounded_data_out_i : signed(output_word_size_c - 1 downto 0);
  signal rounded_data_out_q : signed(output_word_size_c - 1 downto 0);
  signal overflow_sticky_i  : std_logic;
  signal overflow_sticky_q  : std_logic;
  signal scale_factor       : integer range 0 to cic_word_size_c - 1;
  signal round_data_valid   : std_logic;
  signal processed_data     : std_logic_vector(output_out.data'high downto 0);

begin

  ------------------------------------------------------------------------------
  -- Flush inject
  ------------------------------------------------------------------------------
  -- Insert flush directly into input data stream.
  -- input_interface is used instead of input_in in rest of component.
  -- Take (request) data when output port ready.
  flush_insert_i : entity work.complex_short_flush_injector
    generic map (
      data_in_width_g      => input_in.data'length,
      max_message_length_g => to_integer(ocpi_max_bytes_output)/4
      )
    port map (
      clk             => ctl_in.clk,
      reset           => ctl_in.reset,
      take_in         => enable,
      input_in        => input_in,
      flush_length    => props_in.flush_length,
      input_out       => input_out,
      input_interface => input_interface
      );

  ------------------------------------------------------------------------------
  -- Data interface
  ------------------------------------------------------------------------------
  -- CIC processing runs when data output is ready
  enable <= output_in.ready and (not input_hold);

  data_valid_in <= '1' when input_interface.opcode = complex_short_timed_sample_sample_op_e
                   and input_interface.valid = '1'
                   else '0';

  -- Split I and Q data
  data_in_i <= signed(input_interface.data(input_word_size_c - 1 downto 0));
  data_in_q <= signed(input_interface.data((2 * input_word_size_c) - 1 downto input_word_size_c));

  -- Interface delay module
  -- Delays streaming interface signals to align with the delay introduced by
  -- the CIC calculation.
  interface_delay_i : entity work.complex_short_down_sampled_protocol_delay
    generic map (
      delay_g         => delay_c,
      data_in_width_g => input_in.data'length
      )
    port map (
      clk                 => ctl_in.clk,
      reset               => ctl_in.reset,
      enable              => output_in.ready,
      decimation_factor   => props_in.down_sample_factor,
      take_in             => '1',
      input_in            => input_interface,
      processed_stream_in => processed_data,
      processed_mask_in   => round_data_valid,  -- 1 when CIC is outputting data
      output_out          => output_out,
      input_hold_out      => input_hold
      );

  -- ---------------------------------------------------------------------------
  -- CIC Decimators
  -- ---------------------------------------------------------------------------
  -- Instantiate two CIC modules for I and Q streams
  cic_module_i : entity work.cic_dec
    generic map (
      int_stages_g       => int_stages_c,
      comb_stages_g      => comb_stages_c,
      diff_delay_g       => diff_delay_c,
      input_word_size_g  => input_word_size_c,
      output_word_size_g => cic_word_size_c
      )
    port map (
      clk                => ctl_in.clk,
      reset              => ctl_in.reset,
      clk_en             => enable,
      data_valid_in      => data_valid_in,
      data_in            => data_in_i,
      down_sample_factor => props_in.down_sample_factor,
      data_valid_out     => cic_data_valid,
      data_out           => data_out_i
      );

  cic_module_q : entity work.cic_dec
    generic map (
      int_stages_g       => int_stages_c,
      comb_stages_g      => comb_stages_c,
      diff_delay_g       => diff_delay_c,
      input_word_size_g  => input_word_size_c,
      output_word_size_g => cic_word_size_c
      )
    port map (
      clk                => ctl_in.clk,
      reset              => ctl_in.reset,
      clk_en             => enable,
      data_valid_in      => data_valid_in,
      data_in            => data_in_q,
      down_sample_factor => props_in.down_sample_factor,
      data_valid_out     => open,
      data_out           => data_out_q
      );

  -- ---------------------------------------------------------------------------
  -- Output rounding and scaling
  -- ---------------------------------------------------------------------------
  -- Round output using half-up adder
  scale_factor <= to_integer(props_in.scale_output);

  halfup_rounder_i : entity work.rounding_halfup
    generic map (
      input_width_g  => cic_word_size_c,
      output_width_g => output_word_size_c,
      saturation_en_g => false
      )
    port map(
      clk                    => ctl_in.clk,
      reset                  => ctl_in.reset,
      clk_en                 => enable,
      status_overflow_sticky => overflow_sticky_i,
      data_in                => data_out_i,
      data_valid_in          => cic_data_valid,
      binary_point           => scale_factor,
      data_out               => rounded_data_out_i,
      data_valid_out         => round_data_valid
      );

  halfup_rounder_q : entity work.rounding_halfup
    generic map (
      input_width_g  => cic_word_size_c,
      output_width_g => output_word_size_c,
      saturation_en_g => false
      )
    port map(
      clk                    => ctl_in.clk,
      reset                  => ctl_in.reset,
      clk_en                 => enable,
      status_overflow_sticky => overflow_sticky_q,
      data_in                => data_out_q,
      data_valid_in          => cic_data_valid,
      binary_point           => scale_factor,
      data_out               => rounded_data_out_q,
      data_valid_out         => open
      );

  props_out.overflow_sticky <= btrue when
      (overflow_sticky_i = '1') or (overflow_sticky_q = '1') else bfalse;

  processed_data <= std_logic_vector(rounded_data_out_q) & std_logic_vector(rounded_data_out_i);

end rtl;
