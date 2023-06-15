-- Delay module for down sampled complex short protocol
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
-- delay_g should be set to the delay in clock cycles of the module that
-- processes sample data.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.cic_decimator_xs_htg_worker_defs.all;
--library sdr_interface;
--use sdr_interface.sdr_interface.downsample_protocol_interface_delay_v2;

entity complex_short_down_sampled_protocol_delay is
  generic (
    delay_g         : integer := 1;
    data_in_width_g : integer := 32
    );
  port (
    clk                 : in  std_logic;
    reset               : in  std_logic;
    enable              : in  std_logic;  -- High when output is ready
    decimation_factor   : in  unsigned(15 downto 0);
    take_in             : in  std_logic;  -- High when data is taken from input
    input_in            : in  worker_input_in_t;
    -- Connect output from data processing module.
    processed_stream_in : in  std_logic_vector(data_in_width_g - 1 downto 0);
    -- When high the processed data stream is discarded.
    processed_mask_in   : in  std_logic;
    output_out          : out worker_output_out_t;
    -- Pause data processing and input when high.
    input_hold_out      : out std_logic
    );
end complex_short_down_sampled_protocol_delay;

architecture rtl of complex_short_down_sampled_protocol_delay is

  constant opcode_width_c : integer := integer(
    ceil(log2(real(complex_short_timed_sample_opcode_t'pos(
      complex_short_timed_sample_opcode_t'high)))));
  constant byte_enable_width_c : integer := input_in.byte_enable'length;

  function opcode_to_slv(inop : in complex_short_timed_sample_opcode_t) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(complex_short_timed_sample_opcode_t'pos(inop), opcode_width_c));
  end function;

  function slv_to_opcode(inslv : in std_logic_vector(opcode_width_c - 1 downto 0))
    return complex_short_timed_sample_opcode_t is
  begin
    return complex_short_timed_sample_opcode_t'val(to_integer(unsigned(inslv)));
  end function;


  signal input_hold    : std_logic;
  signal input_opcode  : std_logic_vector(opcode_width_c - 1 downto 0);
  signal output_opcode : std_logic_vector(opcode_width_c - 1 downto 0);
  signal output_valid  : std_logic;
  signal output_eom    : std_logic;
  signal output_data   : std_logic_vector(data_in_width_g - 1 downto 0);

  signal sample_interval_r : unsigned(15 downto 0);
  signal sample_interval   : unsigned(data_in_width_g + 15 downto 0);

begin

  input_opcode <= opcode_to_slv(input_in.opcode);

  protocol_delay_i : entity work.downsample_protocol_interface_delay_v2
    generic map (
      delay_g                  => delay_g,
      data_width_g             => data_in_width_g,
      opcode_width_g           => opcode_width_c,
      byte_enable_width_g      => byte_enable_width_c,
      processed_data_opcode_g  => opcode_to_slv(complex_short_timed_sample_sample_op_e),
      time_opcode_g            => opcode_to_slv(complex_short_timed_sample_time_op_e),
      sample_interval_opcode_g => opcode_to_slv(complex_short_timed_sample_sample_interval_op_e)
      )
    port map (
      clk                 => clk,
      reset               => reset,
      enable              => enable,
      take_in             => take_in,
      input_hold_out      => input_hold_out,
      processed_stream_in => processed_stream_in,
      processed_mask_in   => processed_mask_in,
      input_som           => '0',
      input_eom           => input_in.eom,
      input_eof           => input_in.eof,
      input_valid         => input_in.valid,
      input_ready         => input_in.ready,
      input_byte_enable   => input_in.byte_enable,
      input_opcode        => input_opcode,
      input_data          => input_in.data,
      output_som          => open,
      output_eom          => output_eom,
      output_eof          => output_out.eof,
      output_valid        => output_valid,
      output_give         => output_out.give,
      output_byte_enable  => output_out.byte_enable,
      output_opcode       => output_opcode,
      output_data         => output_data
      );

  sample_interval_clk_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' or (enable = '1' and output_valid = '1' and output_eom = '1') then
        sample_interval_r <= (others => '0');
      elsif enable = '1' and output_valid = '1' and output_opcode = opcode_to_slv(complex_short_timed_sample_sample_interval_op_e) then
        sample_interval_r <= sample_interval(sample_interval'high downto output_data'length);
      end if;
    end if;
  end process;

  sample_interval <= (unsigned(output_data) * unsigned(decimation_factor)) + sample_interval_r;

  sample_interval_p : process(enable, output_valid, output_opcode, output_data, sample_interval)
  begin
    if enable = '1' and output_valid = '1' and output_opcode = opcode_to_slv(complex_short_timed_sample_sample_interval_op_e) then
      output_out.data <= std_logic_vector(sample_interval(output_data'range));
    else
      output_out.data <= output_data;
    end if;
  end process;

  output_out.valid  <= output_valid;
  output_out.eom    <= output_eom;
  output_out.opcode <= slv_to_opcode(output_opcode);

end rtl;
