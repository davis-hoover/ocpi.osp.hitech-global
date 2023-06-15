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

library IEEE; use IEEE.std_logic_1164.all; use ieee.numeric_std.all;
library ocpi; use ocpi.types.all; -- remove this to avoid all ocpi name collisions
library util; use util.util.all;

architecture rtl of lmx2594_worker is

  -- Internal signals
  constant data_width_c : natural := 16;
  constant addr_width_c : natural := 7;

  -- Worker Control Interface support
  signal addr    : unsigned(addr_width_c-1 downto 0);
  signal wr_data : std_logic_vector(data_width_c-1 downto 0);
  signal rd_data : std_logic_vector(data_width_c-1 downto 0);
  signal done    : bool_t := bfalse;

  -- SPI intermediate signals
  signal sdi  : std_logic;
  signal sdo  : std_logic;
  signal sclk : std_logic;
  signal cs_n : std_logic;

begin

  SPI_CE <= '1' when (ctl_in.is_operating = '1') else '0';

  addr <= props_in.raw.address(addr_width_c downto 1);
  wr_data <= props_in.raw.data(15 downto 0)
             when (props_in.raw.byte_enable = "0011") else
             props_in.raw.data(31 downto 16);
  props_out.raw.data <= rd_data & rd_data;
  props_out.raw.error <= '0';
  props_out.raw.done  <= done;

  spi : entity work.spi_lmx2594
    generic map(
      data_width    => data_width_c,
      addr_width    => addr_width_c,
      clock_divisor => 8)
    port map(
      clk     => ctl_in.clk,
      reset   => ctl_in.reset,
      renable => props_in.raw.is_read,
      wenable => props_in.raw.is_write,
      addr    => addr,
      wdata   => wr_data,
      rdata   => rd_data,
      done    => done,
      sdo     => sdo,
      sclk    => sclk,
      sen     => cs_n,
      sdio    => sdi);

  signals_i : entity work.signals
    port map (
      i_cs_n     => cs_n,
      i_sclk     => sclk,
      i_sdi      => sdi,
      o_sdo      => sdo,
      o_buf_cs_n => SPI_CS_N,
      o_buf_sclk => SPI_SCLK,
      o_buf_sdi  => SPI_SDI,
      i_buf_sdo  => SPI_SDO);

  ------------------------------------------------------------------------------
  -- DEBUG: ILA
  ------------------------------------------------------------------------------

  gen_debug : if its(VIVADO_ILA_p) generate
    signal probe0 : std_logic_vector(511 downto 0);

    component ila_0 is
      port (
        clk    : in std_logic;
        probe0 : in std_logic_vector(511 downto 0));
    end component;

  begin

    ila_i : ila_0
      port map (
        clk    => ctl_in.clk,
        probe0 => probe0);

    probe0 <= (511 downto 115 => '0') &
              sdo &                                     -- 1b
              sdi &                                     -- 1b
              sclk &                                    -- 1b
              cs_n &                                    -- 1b
              done &                                    -- 1b
              rd_data &                                 -- 8b
              wr_data &                                 -- 8b
              props_in.raw.byte_enable &                -- 4b
              props_in.raw.data &                       -- 32b
              std_logic_vector(addr) &                  -- 8b
              std_logic_vector(props_in.raw.address) &  -- 32b
              props_in.raw.is_read &                    -- 1b
              props_in.raw.is_write &                   -- 1b
              ctl_in.reset;                             -- 1b

  end generate;

  end rtl;
