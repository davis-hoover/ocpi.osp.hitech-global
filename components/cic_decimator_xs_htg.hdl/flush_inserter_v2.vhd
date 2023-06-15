-- Flush inserter primitive
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
use ieee.math_real.all;

entity flush_inserter_v2 is
  generic (
    data_width_g         : integer          := 8;
    opcode_width_g       : integer          := 3;
    byte_enable_width_g  : integer          := 1;
    max_message_length_g : integer          := 2048;
    flush_opcode_g       : std_logic_vector := "011";
    data_opcode_g        : std_logic_vector := "000"
    );
  port (
    clk                : in  std_logic;
    reset              : in  std_logic;
    flush_length       : in  unsigned;
    take_in            : in  std_logic;  -- High when data can be taken
    take_out           : out std_logic;  -- High when data should be taken
    -- Input interface signals
    input_som          : in  std_logic := '0';
    input_eom          : in  std_logic;
    input_eof          : in  std_logic := '0';
    input_valid        : in  std_logic;
    input_byte_enable  : in  std_logic_vector(byte_enable_width_g - 1 downto 0);
    input_opcode       : in  std_logic_vector(opcode_width_g - 1 downto 0);
    input_data         : in  std_logic_vector(data_width_g - 1 downto 0);
    input_ready        : in  std_logic;
    -- Output interface signals
    output_som         : out std_logic;
    output_eom         : out std_logic;
    output_eof         : out std_logic;
    output_valid       : out std_logic;
    output_byte_enable : out std_logic_vector(byte_enable_width_g - 1 downto 0);
    output_opcode      : out std_logic_vector(opcode_width_g - 1 downto 0);
    output_data        : out std_logic_vector(data_width_g - 1 downto 0);
    output_ready       : out std_logic
    );
end flush_inserter_v2;

architecture rtl of flush_inserter_v2 is

  type state_t is (passthrough_message_s, flush_s);
  signal take_flush_opcode : std_logic;
  signal flush_hold        : std_logic;
  signal flush_counter     : unsigned(flush_length'range);
  signal message_counter   : unsigned(integer(ceil(log2(real(max_message_length_g)))) - 1 downto 0);
  signal current_state     : state_t;

begin

  ------------------------------------------------------------------------------
  -- Flush Logic
  ------------------------------------------------------------------------------
  flush_state_machine_p : process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        current_state     <= passthrough_message_s;
        take_flush_opcode <= '0';
      else
        case current_state is
          when passthrough_message_s =>
            if input_ready = '1' then
              -- If the input opcode is a flush and we have not yet flushed
              -- the data samples.
              if input_opcode = flush_opcode_g and take_flush_opcode = '0' then
                if flush_length = 0 then
                  take_flush_opcode <= '1';
                else
                  current_state   <= flush_s;
                  flush_counter   <= (flush_length - 1);
                  message_counter <= to_unsigned((max_message_length_g - 1), message_counter'length);
                end if;
              elsif (input_eom = '1' and take_in = '1') then
                -- Clear after the flush is sent. Check if EOM as flush could
                -- be a split message.
                take_flush_opcode <= '0';
              end if;
            end if;
          when flush_s =>
            if take_in = '1' then
              if message_counter = 0 then
                message_counter <= to_unsigned((max_message_length_g - 1), message_counter'length);
              else
                message_counter <= message_counter - 1;
              end if;
              flush_counter <= flush_counter - 1;
              if flush_counter = 0 then
                take_flush_opcode <= '1';
                current_state     <= passthrough_message_s;
              end if;
            end if;
        end case;
      end if;
    end if;
  end process;

  -- Disables input until data has been flushed
  flush_hold <= '0' when input_opcode /= flush_opcode_g or take_flush_opcode = '1' else '1';
  -- Flush interface signals
  output_mux_p : process(current_state, input_ready, input_data, input_valid,
                         input_som, input_eom, input_eof, input_byte_enable, input_opcode,
                         flush_counter, flush_length, flush_hold, message_counter)
  begin
    if (current_state = passthrough_message_s) then
      output_ready       <= input_ready and not flush_hold;
      output_data        <= input_data;
      output_valid       <= input_valid;
      output_som         <= input_som;
      output_eom         <= input_eom;
      output_eof         <= input_eof;
      output_byte_enable <= input_byte_enable;
      output_opcode      <= input_opcode;
    else
      output_ready <= '1';
      output_data  <= (others => '0');
      output_valid <= '1';
      if flush_counter = (flush_length - 1) or message_counter = (max_message_length_g - 1) then
        output_som <= '1';
      else
        output_som <= '0';
      end if;
      if flush_counter = 0 or message_counter = 0 then
        output_eom <= '1';
      else
        output_eom <= '0';
      end if;
      output_eof         <= '0';
      output_byte_enable <= (others => '1');
      output_opcode      <= data_opcode_g;
    end if;
  end process;

  -- Passthrough take except when we are flushing
  take_out <= take_in and not flush_hold;

end rtl;
