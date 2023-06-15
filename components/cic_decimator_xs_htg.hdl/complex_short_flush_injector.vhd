-- Flush injector for complex short protocol
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

-- On receipt of a flush opcode, applies backpressure to the input port and
-- generates an input message of `flush_length` stream samples of value zero,
-- before releasing backpressure and sending on the flush opcode. All other
-- message types passthrough undelayed.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.cic_decimator_xs_htg_worker_defs.all;
--library sdr_interface;
--use sdr_interface.sdr_interface.flush_inserter_v2;

entity complex_short_flush_injector is
  generic (
    data_in_width_g      : integer := 32;
    max_message_length_g : integer := 4096
    );
  port (
    clk             : in  std_logic;
    reset           : in  std_logic;
    take_in         : in  std_logic;
    input_in        : in  worker_input_in_t;
    flush_length    : in  unsigned;
    input_out       : out worker_input_out_t;
    input_interface : out worker_input_in_t
    );
end complex_short_flush_injector;

architecture rtl of complex_short_flush_injector is

  constant opcode_width_c      : integer := integer(ceil(log2(real(complex_short_timed_sample_opcode_t'pos(complex_short_timed_sample_opcode_t'high)))));
  constant byte_enable_width_c : integer := input_in.byte_enable'length;

  function opcode_to_slv(inop : in complex_short_timed_sample_opcode_t) return std_logic_vector is
  begin
    return std_logic_vector(to_unsigned(complex_short_timed_sample_opcode_t'pos(inop), opcode_width_c));
  end function;

  function slv_to_opcode(inslv : in std_logic_vector(opcode_width_c - 1 downto 0)) return complex_short_timed_sample_opcode_t is
  begin
    return complex_short_timed_sample_opcode_t'val(to_integer(unsigned(inslv)));
  end function;

  signal input_opcode           : std_logic_vector(opcode_width_c - 1 downto 0);
  signal input_interface_opcode : std_logic_vector(opcode_width_c - 1 downto 0);
  signal input_interface_data   : std_logic_vector(data_in_width_g - 1 downto 0);

begin

  input_opcode <= opcode_to_slv(input_in.opcode);

  flush_inserter_i : entity work.flush_inserter_v2
    generic map (
      data_width_g         => data_in_width_g,
      opcode_width_g       => opcode_width_c,
      byte_enable_width_g  => byte_enable_width_c,
      max_message_length_g => max_message_length_g,
      flush_opcode_g       => opcode_to_slv(complex_short_timed_sample_flush_op_e),
      data_opcode_g        => opcode_to_slv(complex_short_timed_sample_sample_op_e)
      )
    port map (
      clk                => clk,
      reset              => reset,
      flush_length       => flush_length,
      take_in            => take_in,
      take_out           => input_out.take,
      input_som          => '0',
      input_eom          => input_in.eom,
      input_eof          => input_in.eof,
      input_valid        => input_in.valid,
      input_byte_enable  => input_in.byte_enable,
      input_opcode       => input_opcode,
      input_data         => input_in.data,
      input_ready        => input_in.ready,
      output_som         => open,
      output_eom         => input_interface.eom,
      output_eof         => input_interface.eof,
      output_valid       => input_interface.valid,
      output_byte_enable => input_interface.byte_enable,
      output_opcode      => input_interface_opcode,
      output_data        => input_interface_data,
      output_ready       => input_interface.ready
      );

  input_interface.data   <= input_interface_data;
  input_interface.opcode <= slv_to_opcode(input_interface_opcode);

end rtl;
