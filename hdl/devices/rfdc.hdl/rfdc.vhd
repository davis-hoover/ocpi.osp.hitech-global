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
-- A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
-- details.
--
-- You should have received a copy of the GNU Lesser General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

library IEEE; use IEEE.std_logic_1164.all; use ieee.numeric_std.all;
library ocpi; use ocpi.wci.all; use ocpi.types.all;
library axi, rfdc;
library protocol; use protocol.iqstream.all;
architecture structural of worker is
  -- ctl clk domain
  signal ctl_is_oper : std_logic := '0';
  signal ctl_reset  : std_logic := '0';
  signal ctl_resetn : std_logic := '0';
  signal ctl_axi_converter_to_rfdc_prim_rfdc_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_axi_converter_to_rfdc_prim_rfdc_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_dac0_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_dac0_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_dac1_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_dac1_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_dac2_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_dac2_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_dac3_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_dac3_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_adc0_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_adc0_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_adc1_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_adc1_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_adc2_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_adc2_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal ctl_adc3_axi_in : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  signal ctl_adc3_axi_out : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));

  signal ctl_0_demarshaller_to_ctl_tx_0_converter_pro : protocol_t
                                                      := PROTOCOL_ZERO;
  signal ctl_0_demarshaller_to_ctl_tx_0_converter_rdy : std_logic := '0';
  signal ctl_tx_0_converter_to_tx_0_cdc_tdata  : std_logic_vector(32-1 downto 0)
                                               := (others => '0');
  signal ctl_tx_0_converter_to_tx_0_cdc_tvalid        : std_logic := '0';
  signal ctl_tx_0_converter_to_tx_0_cdc_tready        : std_logic := '0';
  signal ctl_1_demarshaller_to_ctl_tx_1_converter_pro : protocol_t
                                                      := PROTOCOL_ZERO;
  signal ctl_1_demarshaller_to_ctl_tx_1_converter_rdy : std_logic := '0';
  signal ctl_tx_1_converter_to_tx_1_cdc_tdata  : std_logic_vector(32-1 downto 0)
                                               := (others => '0');
  signal ctl_tx_1_converter_to_tx_1_cdc_tvalid        : std_logic := '0';
  signal ctl_tx_1_converter_to_tx_1_cdc_tready        : std_logic := '0';
  signal ctl_0_cdc_to_ctl_rx_0_fifo_tdata      : std_logic_vector(32-1 downto 0)
                                               := (others => '0');
  signal ctl_0_cdc_to_ctl_rx_0_fifo_tvalid            : std_logic := '0';
  signal ctl_0_cdc_to_ctl_rx_0_fifo_tready            : std_logic := '0';
  signal ctl_rx_0_fifo_to_rx_0_converter_tdata        : std_logic_vector(32-1 downto 0)
                                                      := (others => '0');
  signal ctl_rx_0_fifo_to_rx_0_converter_tvalid       : std_logic := '0';
  signal ctl_rx_0_fifo_to_rx_0_converter_tready       : std_logic := '0';
  signal ctl_rx_0_converter_to_ctl_0_marshaller_pro   : protocol_t
                                                      := PROTOCOL_ZERO;
  signal ctl_rx_0_converter_to_ctl_0_marshaller_rdy   : std_logic := '0';
  signal ctl_1_cdc_to_ctl_rx_1_fifo_tdata       : std_logic_vector(32-1 downto 0)
                                                := (others => '0');
  signal ctl_1_cdc_to_ctl_rx_1_fifo_tvalid            : std_logic := '0';
  signal ctl_1_cdc_to_ctl_rx_1_fifo_tready            : std_logic := '0';
  signal ctl_rx_1_fifo_to_rx_1_converter_tdata  : std_logic_vector(32-1 downto 0)
                                                := (others => '0');
  signal ctl_rx_1_fifo_to_rx_1_converter_tvalid       : std_logic := '0';
  signal ctl_rx_1_fifo_to_rx_1_converter_tready       : std_logic := '0';
  signal ctl_rx_1_converter_to_ctl_1_marshaller_pro   : protocol_t
                                                      := PROTOCOL_ZERO;
  signal ctl_rx_1_converter_to_ctl_1_marshaller_rdy   : std_logic := '0';
  -- rx_0/rx_1 clk domains
  signal rx_aclks                      : std_logic_vector(2-1 downto 0)
                                       := (others => '0');
  signal rx_aresets                    : std_logic_vector(2-1 downto 0)
                                       := (others => '0');
  signal rx_aresets_n                  : std_logic_vector(2-1 downto 0)
                                       := (others => '0');
  signal rfdc_prim_to_ctl_0_cdc_tdata  : std_logic_vector(32-1 downto 0)
                                       := (others => '0');
  signal rfdc_prim_to_ctl_0_cdc_tvalid : std_logic := '0';
  signal rfdc_prim_to_ctl_0_cdc_tready : std_logic := '0';
  signal rfdc_prim_to_ctl_1_cdc_tdata  : std_logic_vector(32-1 downto 0)
                                       := (others => '0');
  signal rfdc_prim_to_ctl_1_cdc_tvalid : std_logic := '0';
  signal rfdc_prim_to_ctl_1_cdc_tready : std_logic := '0';
  signal ctl_0_cdc_src_enq             : std_logic := '0';
  signal ctl_0_cdc_dst_deq             : std_logic := '0';
  signal ctl_1_cdc_src_enq             : std_logic := '0';
  signal ctl_1_cdc_dst_deq             : std_logic := '0';
  -- tx_0 clk domain
  signal tx_aclks                     : std_logic_vector(1-1 downto 0)
                                      := (others => '0');
  signal tx_0_cdc_to_rfdc_prim_tdata  : std_logic_vector(32-1 downto 0)
                                      := x"00FFFF00";--(others => '0');
  signal tx_0_cdc_to_rfdc_prim_tvalid : std_logic := '0';
  signal tx_0_cdc_to_rfdc_prim_tready : std_logic := '0';
  signal tx_0_cdc_src_enq             : std_logic := '0';
  signal tx_0_cdc_dst_deq             : std_logic := '0';
  signal tx_1_cdc_to_rfdc_prim_tdata  : std_logic_vector(32-1 downto 0)
                                      := x"00FFFF00";--(others => '0');
  signal tx_1_cdc_to_rfdc_prim_tvalid : std_logic := '0';
  signal tx_1_cdc_to_rfdc_prim_tready : std_logic := '0';
  signal tx_1_cdc_src_enq             : std_logic := '0';
  signal tx_1_cdc_dst_deq             : std_logic := '0';
  -- debug
  attribute mark_debug : string;
  attribute mark_debug of ctl_0_demarshaller_to_ctl_tx_0_converter_pro : signal is "true";
  attribute mark_debug of ctl_0_demarshaller_to_ctl_tx_0_converter_rdy : signal is "true";
  attribute mark_debug of ctl_tx_0_converter_to_tx_0_cdc_tdata : signal is "true";
  attribute mark_debug of ctl_tx_0_converter_to_tx_0_cdc_tvalid : signal is "true";
  attribute mark_debug of ctl_tx_0_converter_to_tx_0_cdc_tready : signal is "true";
  --attribute mark_debug of ctl_tx_1_converter_to_tx_1_cdc_tdata : signal is "true";
  --attribute mark_debug of ctl_tx_1_converter_to_tx_1_cdc_tvalid : signal is "true";
  --attribute mark_debug of ctl_tx_1_converter_to_tx_1_cdc_tready : signal is "true";
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_fifo_tdata : signal is "true";
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_fifo_tvalid : signal is "true";
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_fifo_tready : signal is "true";
  --attribute mark_debug of ctl_1_cdc_to_ctl_rx_1_converter_tdata : signal is "true";
  --attribute mark_debug of ctl_1_cdc_to_ctl_rx_1_converter_tvalid : signal is "true";
  --attribute mark_debug of ctl_1_cdc_to_ctl_rx_1_converter_tready : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_0_cdc_tdata : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_0_cdc_tvalid : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_0_cdc_tready : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_1_cdc_tdata : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_1_cdc_tvalid : signal is "true";
  --attribute mark_debug of rfdc_prim_to_ctl_1_cdc_tready : signal is "true";
  attribute mark_debug of tx_0_cdc_to_rfdc_prim_tdata : signal is "true";
  attribute mark_debug of tx_0_cdc_to_rfdc_prim_tvalid : signal is "true";
  attribute mark_debug of tx_0_cdc_to_rfdc_prim_tready : signal is "true";
  --attribute mark_debug of tx_1_cdc_to_rfdc_prim_tdata : signal is "true";
  --attribute mark_debug of tx_1_cdc_to_rfdc_prim_tvalid : signal is "true";
  --attribute mark_debug of tx_1_cdc_to_rfdc_prim_tready : signal is "true";

  -- TODO remove
  signal ctl_0_cdc_to_ctl_rx_0_converter_tdata : std_logic_vector(32-1 downto 0)
                                               := (others => '0');
  signal ctl_0_cdc_to_ctl_rx_0_converter_tvalid       : std_logic := '0';
  signal ctl_0_cdc_to_ctl_rx_0_converter_tready       : std_logic := '0';
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_converter_tdata : signal is "true";
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_converter_tvalid : signal is "true";
  attribute mark_debug of ctl_0_cdc_to_ctl_rx_0_converter_tready : signal is "true";
begin

  -- defer rfdc ip axi-lite start until operating state is entered (allows
  -- device proxy(ies), which use this worker as a slave, to ensure
  -- rfdc-external clocks are stable and glitch-free before calling start() on
  -- this worker which takes rfdc axi-lite out of reset -
  -- ref https://docs.xilinx.com/r/en-US/pg269-rf-data-converter/Resets)
  ctl_is_oper <= '1' when (ctl_in.is_operating = btrue) else '0';
  ctl_reset <= '1' when (ctl_in.reset = btrue) or (ctl_is_oper = '0') else '0';
  ctl_resetn <= not ctl_reset;

  ctl_axi_converter : axi.lite32.raw2axi_lite32
    port map(
      clk     => ctl_in.clk,
      reset   => ctl_reset,
      raw_in  => props_in.raw,
      raw_out => props_out.raw,
      axi_in  => ctl_axi_converter_to_rfdc_prim_rfdc_axi_out,
      axi_out => ctl_axi_converter_to_rfdc_prim_rfdc_axi_in);

  ctl_dac0_axi_in.a.clk    <= ctl_in.clk;
  ctl_dac0_axi_in.a.resetn <= ctl_resetn;
  ctl_dac0_axi_in.aw.addr  <= s_dac0_axi_in.aw_addr;
  ctl_dac0_axi_in.aw.valid <= s_dac0_axi_in.aw_valid;
  ctl_dac0_axi_in.aw.prot  <= s_dac0_axi_in.aw_prot;
  s_dac0_axi_out.aw_ready  <= ctl_dac0_axi_out.aw.ready;
  ctl_dac0_axi_in.ar.addr  <= s_dac0_axi_in.ar_addr;
  ctl_dac0_axi_in.ar.valid <= s_dac0_axi_in.ar_valid;
  ctl_dac0_axi_in.ar.prot  <= s_dac0_axi_in.ar_prot;
  s_dac0_axi_out.ar_ready  <= ctl_dac0_axi_out.ar.ready;
  ctl_dac0_axi_in.w.data   <= s_dac0_axi_in.w_data;
  ctl_dac0_axi_in.w.strb   <= s_dac0_axi_in.w_strb;
  ctl_dac0_axi_in.w.valid  <= s_dac0_axi_in.w_valid;
  s_dac0_axi_out.w_ready   <= ctl_dac0_axi_out.w.ready;
  s_dac0_axi_out.r_data    <= ctl_dac0_axi_out.r.data;
  s_dac0_axi_out.r_resp    <= ctl_dac0_axi_out.r.resp;
  s_dac0_axi_out.r_valid   <= ctl_dac0_axi_out.r.valid;
  ctl_dac0_axi_in.r.ready  <= s_dac0_axi_in.r_ready;
  s_dac0_axi_out.b_resp    <= ctl_dac0_axi_out.b.resp;
  s_dac0_axi_out.b_valid   <= ctl_dac0_axi_out.b.valid;
  ctl_dac0_axi_in.b.ready  <= s_dac0_axi_in.b_ready;

  ctl_dac1_axi_in.a.clk    <= ctl_in.clk;
  ctl_dac1_axi_in.a.resetn <= ctl_resetn;
  ctl_dac1_axi_in.aw.addr  <= s_dac1_axi_in.aw_addr;
  ctl_dac1_axi_in.aw.valid <= s_dac1_axi_in.aw_valid;
  ctl_dac1_axi_in.aw.prot  <= s_dac1_axi_in.aw_prot;
  s_dac1_axi_out.aw_ready  <= ctl_dac1_axi_out.aw.ready;
  ctl_dac1_axi_in.ar.addr  <= s_dac1_axi_in.ar_addr;
  ctl_dac1_axi_in.ar.valid <= s_dac1_axi_in.ar_valid;
  ctl_dac1_axi_in.ar.prot  <= s_dac1_axi_in.ar_prot;
  s_dac1_axi_out.ar_ready  <= ctl_dac1_axi_out.ar.ready;
  ctl_dac1_axi_in.w.data   <= s_dac1_axi_in.w_data;
  ctl_dac1_axi_in.w.strb   <= s_dac1_axi_in.w_strb;
  ctl_dac1_axi_in.w.valid  <= s_dac1_axi_in.w_valid;
  s_dac1_axi_out.w_ready   <= ctl_dac1_axi_out.w.ready;
  s_dac1_axi_out.r_data    <= ctl_dac1_axi_out.r.data;
  s_dac1_axi_out.r_resp    <= ctl_dac1_axi_out.r.resp;
  s_dac1_axi_out.r_valid   <= ctl_dac1_axi_out.r.valid;
  ctl_dac1_axi_in.r.ready  <= s_dac1_axi_in.r_ready;
  s_dac1_axi_out.b_resp    <= ctl_dac1_axi_out.b.resp;
  s_dac1_axi_out.b_valid   <= ctl_dac1_axi_out.b.valid;
  ctl_dac1_axi_in.b.ready  <= s_dac1_axi_in.b_ready;

  ctl_dac2_axi_in.a.clk    <= ctl_in.clk;
  ctl_dac2_axi_in.a.resetn <= ctl_resetn;
  ctl_dac2_axi_in.aw.addr  <= s_dac2_axi_in.aw_addr;
  ctl_dac2_axi_in.aw.valid <= s_dac2_axi_in.aw_valid;
  ctl_dac2_axi_in.aw.prot  <= s_dac2_axi_in.aw_prot;
  s_dac2_axi_out.aw_ready  <= ctl_dac2_axi_out.aw.ready;
  ctl_dac2_axi_in.ar.addr  <= s_dac2_axi_in.ar_addr;
  ctl_dac2_axi_in.ar.valid <= s_dac2_axi_in.ar_valid;
  ctl_dac2_axi_in.ar.prot  <= s_dac2_axi_in.ar_prot;
  s_dac2_axi_out.ar_ready  <= ctl_dac2_axi_out.ar.ready;
  ctl_dac2_axi_in.w.data   <= s_dac2_axi_in.w_data;
  ctl_dac2_axi_in.w.strb   <= s_dac2_axi_in.w_strb;
  ctl_dac2_axi_in.w.valid  <= s_dac2_axi_in.w_valid;
  s_dac2_axi_out.w_ready   <= ctl_dac2_axi_out.w.ready;
  s_dac2_axi_out.r_data    <= ctl_dac2_axi_out.r.data;
  s_dac2_axi_out.r_resp    <= ctl_dac2_axi_out.r.resp;
  s_dac2_axi_out.r_valid   <= ctl_dac2_axi_out.r.valid;
  ctl_dac2_axi_in.r.ready  <= s_dac2_axi_in.r_ready;
  s_dac2_axi_out.b_resp    <= ctl_dac2_axi_out.b.resp;
  s_dac2_axi_out.b_valid   <= ctl_dac2_axi_out.b.valid;
  ctl_dac2_axi_in.b.ready  <= s_dac2_axi_in.b_ready;

  ctl_dac3_axi_in.a.clk    <= ctl_in.clk;
  ctl_dac3_axi_in.a.resetn <= ctl_resetn;
  ctl_dac3_axi_in.aw.addr  <= s_dac3_axi_in.aw_addr;
  ctl_dac3_axi_in.aw.valid <= s_dac3_axi_in.aw_valid;
  ctl_dac3_axi_in.aw.prot  <= s_dac3_axi_in.aw_prot;
  s_dac3_axi_out.aw_ready  <= ctl_dac3_axi_out.aw.ready;
  ctl_dac3_axi_in.ar.addr  <= s_dac3_axi_in.ar_addr;
  ctl_dac3_axi_in.ar.valid <= s_dac3_axi_in.ar_valid;
  ctl_dac3_axi_in.ar.prot  <= s_dac3_axi_in.ar_prot;
  s_dac3_axi_out.ar_ready  <= ctl_dac3_axi_out.ar.ready;
  ctl_dac3_axi_in.w.data   <= s_dac3_axi_in.w_data;
  ctl_dac3_axi_in.w.strb   <= s_dac3_axi_in.w_strb;
  ctl_dac3_axi_in.w.valid  <= s_dac3_axi_in.w_valid;
  s_dac3_axi_out.w_ready   <= ctl_dac3_axi_out.w.ready;
  s_dac3_axi_out.r_data    <= ctl_dac3_axi_out.r.data;
  s_dac3_axi_out.r_resp    <= ctl_dac3_axi_out.r.resp;
  s_dac3_axi_out.r_valid   <= ctl_dac3_axi_out.r.valid;
  ctl_dac3_axi_in.r.ready  <= s_dac3_axi_in.r_ready;
  s_dac3_axi_out.b_resp    <= ctl_dac3_axi_out.b.resp;
  s_dac3_axi_out.b_valid   <= ctl_dac3_axi_out.b.valid;
  ctl_dac3_axi_in.b.ready  <= s_dac3_axi_in.b_ready;

  ctl_adc0_axi_in.a.clk    <= ctl_in.clk;
  ctl_adc0_axi_in.a.resetn <= ctl_resetn;
  ctl_adc0_axi_in.aw.addr  <= s_adc0_axi_in.aw_addr;
  ctl_adc0_axi_in.aw.valid <= s_adc0_axi_in.aw_valid;
  ctl_adc0_axi_in.aw.prot  <= s_adc0_axi_in.aw_prot;
  s_adc0_axi_out.aw_ready  <= ctl_adc0_axi_out.aw.ready;
  ctl_adc0_axi_in.ar.addr  <= s_adc0_axi_in.ar_addr;
  ctl_adc0_axi_in.ar.valid <= s_adc0_axi_in.ar_valid;
  ctl_adc0_axi_in.ar.prot  <= s_adc0_axi_in.ar_prot;
  s_adc0_axi_out.ar_ready  <= ctl_adc0_axi_out.ar.ready;
  ctl_adc0_axi_in.w.data   <= s_adc0_axi_in.w_data;
  ctl_adc0_axi_in.w.strb   <= s_adc0_axi_in.w_strb;
  ctl_adc0_axi_in.w.valid  <= s_adc0_axi_in.w_valid;
  s_adc0_axi_out.w_ready   <= ctl_adc0_axi_out.w.ready;
  s_adc0_axi_out.r_data    <= ctl_adc0_axi_out.r.data;
  s_adc0_axi_out.r_resp    <= ctl_adc0_axi_out.r.resp;
  s_adc0_axi_out.r_valid   <= ctl_adc0_axi_out.r.valid;
  ctl_adc0_axi_in.r.ready  <= s_adc0_axi_in.r_ready;
  s_adc0_axi_out.b_resp    <= ctl_adc0_axi_out.b.resp;
  s_adc0_axi_out.b_valid   <= ctl_adc0_axi_out.b.valid;
  ctl_adc0_axi_in.b.ready  <= s_adc0_axi_in.b_ready;

  ctl_adc1_axi_in.a.clk    <= ctl_in.clk;
  ctl_adc1_axi_in.a.resetn <= ctl_resetn;
  ctl_adc1_axi_in.aw.addr  <= s_adc1_axi_in.aw_addr;
  ctl_adc1_axi_in.aw.valid <= s_adc1_axi_in.aw_valid;
  ctl_adc1_axi_in.aw.prot  <= s_adc1_axi_in.aw_prot;
  s_adc1_axi_out.aw_ready  <= ctl_adc1_axi_out.aw.ready;
  ctl_adc1_axi_in.ar.addr  <= s_adc1_axi_in.ar_addr;
  ctl_adc1_axi_in.ar.valid <= s_adc1_axi_in.ar_valid;
  ctl_adc1_axi_in.ar.prot  <= s_adc1_axi_in.ar_prot;
  s_adc1_axi_out.ar_ready  <= ctl_adc1_axi_out.ar.ready;
  ctl_adc1_axi_in.w.data   <= s_adc1_axi_in.w_data;
  ctl_adc1_axi_in.w.strb   <= s_adc1_axi_in.w_strb;
  ctl_adc1_axi_in.w.valid  <= s_adc1_axi_in.w_valid;
  s_adc1_axi_out.w_ready   <= ctl_adc1_axi_out.w.ready;
  s_adc1_axi_out.r_data    <= ctl_adc1_axi_out.r.data;
  s_adc1_axi_out.r_resp    <= ctl_adc1_axi_out.r.resp;
  s_adc1_axi_out.r_valid   <= ctl_adc1_axi_out.r.valid;
  ctl_adc1_axi_in.r.ready  <= s_adc1_axi_in.r_ready;
  s_adc1_axi_out.b_resp    <= ctl_adc1_axi_out.b.resp;
  s_adc1_axi_out.b_valid   <= ctl_adc1_axi_out.b.valid;
  ctl_adc1_axi_in.b.ready  <= s_adc1_axi_in.b_ready;

  ctl_adc2_axi_in.a.clk    <= ctl_in.clk;
  ctl_adc2_axi_in.a.resetn <= ctl_resetn;
  ctl_adc2_axi_in.aw.addr  <= s_adc2_axi_in.aw_addr;
  ctl_adc2_axi_in.aw.valid <= s_adc2_axi_in.aw_valid;
  ctl_adc2_axi_in.aw.prot  <= s_adc2_axi_in.aw_prot;
  s_adc2_axi_out.aw_ready  <= ctl_adc2_axi_out.aw.ready;
  ctl_adc2_axi_in.ar.addr  <= s_adc2_axi_in.ar_addr;
  ctl_adc2_axi_in.ar.valid <= s_adc2_axi_in.ar_valid;
  ctl_adc2_axi_in.ar.prot  <= s_adc2_axi_in.ar_prot;
  s_adc2_axi_out.ar_ready  <= ctl_adc2_axi_out.ar.ready;
  ctl_adc2_axi_in.w.data   <= s_adc2_axi_in.w_data;
  ctl_adc2_axi_in.w.strb   <= s_adc2_axi_in.w_strb;
  ctl_adc2_axi_in.w.valid  <= s_adc2_axi_in.w_valid;
  s_adc2_axi_out.w_ready   <= ctl_adc2_axi_out.w.ready;
  s_adc2_axi_out.r_data    <= ctl_adc2_axi_out.r.data;
  s_adc2_axi_out.r_resp    <= ctl_adc2_axi_out.r.resp;
  s_adc2_axi_out.r_valid   <= ctl_adc2_axi_out.r.valid;
  ctl_adc2_axi_in.r.ready  <= s_adc2_axi_in.r_ready;
  s_adc2_axi_out.b_resp    <= ctl_adc2_axi_out.b.resp;
  s_adc2_axi_out.b_valid   <= ctl_adc2_axi_out.b.valid;
  ctl_adc2_axi_in.b.ready  <= s_adc2_axi_in.b_ready;

  ctl_adc3_axi_in.a.clk    <= ctl_in.clk;
  ctl_adc3_axi_in.a.resetn <= ctl_resetn;
  ctl_adc3_axi_in.aw.addr  <= s_adc3_axi_in.aw_addr;
  ctl_adc3_axi_in.aw.valid <= s_adc3_axi_in.aw_valid;
  ctl_adc3_axi_in.aw.prot  <= s_adc3_axi_in.aw_prot;
  s_adc3_axi_out.aw_ready  <= ctl_adc3_axi_out.aw.ready;
  ctl_adc3_axi_in.ar.addr  <= s_adc3_axi_in.ar_addr;
  ctl_adc3_axi_in.ar.valid <= s_adc3_axi_in.ar_valid;
  ctl_adc3_axi_in.ar.prot  <= s_adc3_axi_in.ar_prot;
  s_adc3_axi_out.ar_ready  <= ctl_adc3_axi_out.ar.ready;
  ctl_adc3_axi_in.w.data   <= s_adc3_axi_in.w_data;
  ctl_adc3_axi_in.w.strb   <= s_adc3_axi_in.w_strb;
  ctl_adc3_axi_in.w.valid  <= s_adc3_axi_in.w_valid;
  s_adc3_axi_out.w_ready   <= ctl_adc3_axi_out.w.ready;
  s_adc3_axi_out.r_data    <= ctl_adc3_axi_out.r.data;
  s_adc3_axi_out.r_resp    <= ctl_adc3_axi_out.r.resp;
  s_adc3_axi_out.r_valid   <= ctl_adc3_axi_out.r.valid;
  ctl_adc3_axi_in.r.ready  <= s_adc3_axi_in.r_ready;
  s_adc3_axi_out.b_resp    <= ctl_adc3_axi_out.b.resp;
  s_adc3_axi_out.b_valid   <= ctl_adc3_axi_out.b.valid;
  ctl_adc3_axi_in.b.ready  <= s_adc3_axi_in.b_ready;

  ctl_0_demarshaller : iqstream_demarshaller
    generic map(
      WSI_DATA_WIDTH => in0_in.data'length)
    port map(
      clk       => ctl_in.clk,
      rst       => ctl_reset,
      idata     => in0_in.data,
      ivalid    => in0_in.valid,
      iready    => in0_in.ready,
      isom      => in0_in.som,
      ieom      => in0_in.eom,
      ieof      => in0_in.eof,
      itake     => in0_out.take,
      oprotocol => ctl_0_demarshaller_to_ctl_tx_0_converter_pro,
      oeof      => open,
      ordy      => ctl_0_demarshaller_to_ctl_tx_0_converter_rdy);

  ctl_tx_0_converter : iqstream_to_axis_converter
    port map(
      iprotocol     => ctl_0_demarshaller_to_ctl_tx_0_converter_pro,
      irdy          => ctl_0_demarshaller_to_ctl_tx_0_converter_rdy,
      m_axis_tdata  => ctl_tx_0_converter_to_tx_0_cdc_tdata,
      m_axis_tvalid => ctl_tx_0_converter_to_tx_0_cdc_tvalid,
      m_axis_tready => ctl_tx_0_converter_to_tx_0_cdc_tready);

  tx_0_cdc_src_enq <=
      ctl_tx_0_converter_to_tx_0_cdc_tvalid and
      ctl_tx_0_converter_to_tx_0_cdc_tready;

  tx_0_cdc_dst_deq <=
      tx_0_cdc_to_rfdc_prim_tvalid and
      tx_0_cdc_to_rfdc_prim_tready;

  tx_0_cdc : cdc.cdc.fifo
    generic map(
      WIDTH       => in0_in.data'length,
      DEPTH       => 16)
    port map(
      src_CLK     => ctl_in.clk,
      src_RST     => ctl_reset,
      src_ENQ     => tx_0_cdc_src_enq,
      src_in      => ctl_tx_0_converter_to_tx_0_cdc_tdata,
      src_FULL_N  => ctl_tx_0_converter_to_tx_0_cdc_tready,
      dst_CLK     => tx_aclks(0),
      dst_DEQ     => tx_0_cdc_dst_deq,
      dst_out     => tx_0_cdc_to_rfdc_prim_tdata,
      dst_EMPTY_N => tx_0_cdc_to_rfdc_prim_tvalid);

  ctl_1_demarshaller : iqstream_demarshaller
    generic map(
      WSI_DATA_WIDTH => in1_in.data'length)
    port map(
      clk       => ctl_in.clk,
      rst       => ctl_reset,
      idata     => in1_in.data,
      ivalid    => in1_in.valid,
      iready    => in1_in.ready,
      isom      => in1_in.som,
      ieom      => in1_in.eom,
      ieof      => in1_in.eof,
      itake     => in1_out.take,
      oprotocol => ctl_1_demarshaller_to_ctl_tx_1_converter_pro,
      oeof      => open,
      ordy      => ctl_1_demarshaller_to_ctl_tx_1_converter_rdy);

  ctl_tx_1_converter : iqstream_to_axis_converter
    port map(
      iprotocol     => ctl_1_demarshaller_to_ctl_tx_1_converter_pro,
      irdy          => ctl_1_demarshaller_to_ctl_tx_1_converter_rdy,
      m_axis_tdata  => ctl_tx_1_converter_to_tx_1_cdc_tdata,
      m_axis_tvalid => ctl_tx_1_converter_to_tx_1_cdc_tvalid,
      m_axis_tready => ctl_tx_1_converter_to_tx_1_cdc_tready);

  tx_1_cdc_src_enq <=
      ctl_tx_1_converter_to_tx_1_cdc_tvalid and
      ctl_tx_1_converter_to_tx_1_cdc_tready;

  tx_1_cdc_dst_deq <=
      tx_1_cdc_to_rfdc_prim_tvalid and
      tx_1_cdc_to_rfdc_prim_tready;

  tx_1_cdc : cdc.cdc.fifo
    generic map(
      WIDTH       => in1_in.data'length,
      DEPTH       => 16)
    port map(
      src_CLK     => ctl_in.clk,
      src_RST     => ctl_reset,
      src_ENQ     => tx_1_cdc_src_enq,
      src_in      => ctl_tx_1_converter_to_tx_1_cdc_tdata,
      src_FULL_N  => ctl_tx_1_converter_to_tx_1_cdc_tready,
      dst_CLK     => tx_aclks(0),
      dst_DEQ     => tx_1_cdc_dst_deq,
      dst_out     => tx_1_cdc_to_rfdc_prim_tdata,
      dst_EMPTY_N => tx_1_cdc_to_rfdc_prim_tvalid);

  rfdc_prim : rfdc.rfdc_pkg.rfdc
    port map(
      ctl_is_oper     => ctl_is_oper,
      axis_resetn     => std_logic(props_in.axis_resetn),
      s_ctrl_axi_in   => ctl_axi_converter_to_rfdc_prim_rfdc_axi_in,
      s_ctrl_axi_out  => ctl_axi_converter_to_rfdc_prim_rfdc_axi_out,
      s_dac0_axi_in   => ctl_dac0_axi_in,
      s_dac0_axi_out  => ctl_dac0_axi_out,
      s_dac1_axi_in   => ctl_dac1_axi_in,
      s_dac1_axi_out  => ctl_dac1_axi_out,
      s_dac2_axi_in   => ctl_dac2_axi_in,
      s_dac2_axi_out  => ctl_dac2_axi_out,
      s_dac3_axi_in   => ctl_dac3_axi_in,
      s_dac3_axi_out  => ctl_dac3_axi_out,
      s_adc0_axi_in   => ctl_adc0_axi_in,
      s_adc0_axi_out  => ctl_adc0_axi_out,
      s_adc1_axi_in   => ctl_adc1_axi_in,
      s_adc1_axi_out  => ctl_adc1_axi_out,
      s_adc2_axi_in   => ctl_adc2_axi_in,
      s_adc2_axi_out  => ctl_adc2_axi_out,
      s_adc3_axi_in   => ctl_adc3_axi_in,
      s_adc3_axi_out  => ctl_adc3_axi_out,
      rx_clks_p       => rx_clks_p,
      rx_clks_n       => rx_clks_n,
      tx_clks_p       => tx_clks_p,
      tx_clks_n       => tx_clks_n,
      sysref_p        => sysref_p,
      sysref_n        => sysref_n,
      rf_rxs_p        => rf_rxs_p,
      rf_rxs_n        => rf_rxs_n,
      rf_txs_p        => rf_txs_p,
      rf_txs_n        => rf_txs_n,
      tx_aclks        => tx_aclks,
      s_axis_0_tdata  => tx_0_cdc_to_rfdc_prim_tdata,
      s_axis_0_tvalid => tx_0_cdc_to_rfdc_prim_tvalid,
      s_axis_0_tready => tx_0_cdc_to_rfdc_prim_tready,
      s_axis_1_tdata  => tx_1_cdc_to_rfdc_prim_tdata,
      s_axis_1_tvalid => tx_1_cdc_to_rfdc_prim_tvalid,
      s_axis_1_tready => tx_1_cdc_to_rfdc_prim_tready,
      rx_aclks        => rx_aclks,
      rx_aresets      => rx_aresets,
      m_axis_0_tdata  => rfdc_prim_to_ctl_0_cdc_tdata,
      m_axis_0_tvalid => rfdc_prim_to_ctl_0_cdc_tvalid,
      m_axis_0_tready => rfdc_prim_to_ctl_0_cdc_tready,
      m_axis_1_tdata  => rfdc_prim_to_ctl_1_cdc_tdata,
      m_axis_1_tvalid => rfdc_prim_to_ctl_1_cdc_tvalid,
      m_axis_1_tready => rfdc_prim_to_ctl_1_cdc_tready);

  rx_aresets_n(0) <= not rx_aresets(0);
  rx_aresets_n(1) <= not rx_aresets(1);

  ctl_0_cdc_src_enq <=
      rfdc_prim_to_ctl_0_cdc_tvalid and
      rfdc_prim_to_ctl_0_cdc_tready;

  ctl_0_cdc_dst_deq <=
      ctl_0_cdc_to_ctl_rx_0_fifo_tvalid and
      ctl_0_cdc_to_ctl_rx_0_fifo_tready;

  ctl_0_cdc : cdc.cdc.fifo
    generic map(
      WIDTH       => out0_out.data'length,
      DEPTH       => 16)
    port map(
      src_CLK     => rx_aclks(0),
      src_RST     => rx_aresets(0),
      src_ENQ     => ctl_0_cdc_src_enq,
      src_in      => rfdc_prim_to_ctl_0_cdc_tdata,
      src_FULL_N  => rfdc_prim_to_ctl_0_cdc_tready,
      dst_CLK     => ctl_in.clk,
      dst_DEQ     => ctl_0_cdc_dst_deq,
      dst_out     => ctl_0_cdc_to_ctl_rx_0_fifo_tdata,
      dst_EMPTY_N => ctl_0_cdc_to_ctl_rx_0_fifo_tvalid);

  ctl_rx_0_fifo : entity work.oneshot_fifo
    port map(
      aclk          => ctl_in.clk,
      aresetn       => rx_aresets_n(0),
      bypass        => '0',--std_logic(props_in.bypass_oneshot_fifo),
      s_axis_tdata  => ctl_0_cdc_to_ctl_rx_0_fifo_tdata,
      s_axis_tvalid => ctl_0_cdc_to_ctl_rx_0_fifo_tvalid,
      s_axis_tready => ctl_0_cdc_to_ctl_rx_0_fifo_tready,
      m_axis_tdata  => ctl_rx_0_fifo_to_rx_0_converter_tdata,
      m_axis_tvalid => ctl_rx_0_fifo_to_rx_0_converter_tvalid,
      m_axis_tready => ctl_rx_0_fifo_to_rx_0_converter_tready);

  ctl_rx_0_converter : axis_to_iqstream_converter
    port map(
      s_axis_tdata  => ctl_rx_0_fifo_to_rx_0_converter_tdata,
      s_axis_tvalid => ctl_rx_0_fifo_to_rx_0_converter_tvalid,
      s_axis_tready => ctl_rx_0_fifo_to_rx_0_converter_tready,
      oprotocol     => ctl_rx_0_converter_to_ctl_0_marshaller_pro,
      ordy          => ctl_rx_0_converter_to_ctl_0_marshaller_rdy);

  ctl_0_marshaller : iqstream_marshaller
    generic map(
      WSI_DATA_WIDTH    => out0_out.data'length,
      WSI_MBYTEEN_WIDTH => out0_out.byte_enable'length)
    port map(
      clk          => rx_aclks(0),
      rst          => rx_aresets(0),
      iprotocol    => ctl_rx_0_converter_to_ctl_0_marshaller_pro,
      ieof         => bfalse,
      irdy         => ctl_rx_0_converter_to_ctl_0_marshaller_rdy,
      odata        => out0_out.data,
      ovalid       => out0_out.valid,
      obyte_enable => out0_out.byte_enable,
      ogive        => out0_out.give,
      osom         => out0_out.som,
      oeom         => out0_out.eom,
      oeof         => out0_out.eof,
      oready       => out0_in.ready);

  ctl_1_cdc_src_enq <=
      rfdc_prim_to_ctl_1_cdc_tvalid and
      rfdc_prim_to_ctl_1_cdc_tready;

  ctl_1_cdc_dst_deq <=
      ctl_1_cdc_to_ctl_rx_1_fifo_tvalid and
      ctl_1_cdc_to_ctl_rx_1_fifo_tready;

  ctl_1_cdc : cdc.cdc.fifo
    generic map(
      WIDTH       => out1_out.data'length,
      DEPTH       => 16)
    port map(
      src_CLK     => rx_aclks(1),
      src_RST     => rx_aresets(1),
      src_ENQ     => ctl_1_cdc_src_enq,
      src_in      => rfdc_prim_to_ctl_1_cdc_tdata,
      src_FULL_N  => rfdc_prim_to_ctl_1_cdc_tready,
      dst_CLK     => ctl_in.clk,
      dst_DEQ     => ctl_1_cdc_dst_deq,
      dst_out     => ctl_1_cdc_to_ctl_rx_1_fifo_tdata,
      dst_EMPTY_N => ctl_1_cdc_to_ctl_rx_1_fifo_tvalid);

  ctl_rx_1_fifo : entity work.oneshot_fifo
    port map(
      aclk          => ctl_in.clk,
      aresetn       => rx_aresets_n(1),
      bypass        => '1',--std_logic(props_in.bypass_oneshot_fifo),
      s_axis_tdata  => ctl_1_cdc_to_ctl_rx_1_fifo_tdata,
      s_axis_tvalid => ctl_1_cdc_to_ctl_rx_1_fifo_tvalid,
      s_axis_tready => ctl_1_cdc_to_ctl_rx_1_fifo_tready,
      m_axis_tdata  => ctl_rx_1_fifo_to_rx_1_converter_tdata,
      m_axis_tvalid => ctl_rx_1_fifo_to_rx_1_converter_tvalid,
      m_axis_tready => ctl_rx_1_fifo_to_rx_1_converter_tready);

  ctl_rx_1_converter : axis_to_iqstream_converter
    port map(
      s_axis_tdata  => ctl_rx_1_fifo_to_rx_1_converter_tdata,
      s_axis_tvalid => ctl_rx_1_fifo_to_rx_1_converter_tvalid,
      s_axis_tready => ctl_rx_1_fifo_to_rx_1_converter_tready,
      oprotocol     => ctl_rx_1_converter_to_ctl_1_marshaller_pro,
      ordy          => ctl_rx_1_converter_to_ctl_1_marshaller_rdy);

  ctl_1_marshaller : iqstream_marshaller
    generic map(
      WSI_DATA_WIDTH    => out1_out.data'length,
      WSI_MBYTEEN_WIDTH => out1_out.byte_enable'length)
    port map(
      clk          => rx_aclks(1),
      rst          => rx_aresets(1),
      iprotocol    => ctl_rx_1_converter_to_ctl_1_marshaller_pro,
      ieof         => bfalse,
      irdy         => ctl_rx_1_converter_to_ctl_1_marshaller_rdy,
      odata        => out1_out.data,
      ovalid       => out1_out.valid,
      obyte_enable => out1_out.byte_enable,
      ogive        => out1_out.give,
      osom         => out1_out.som,
      oeom         => out1_out.eom,
      oeof         => out1_out.eof,
      oready       => out1_in.ready);

end structural;
