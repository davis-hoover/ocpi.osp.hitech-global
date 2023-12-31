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

library ieee; use ieee.std_logic_1164.all, ieee.numeric_std.all;
use ieee.math_real.all;
library ocpi, axi, cdc;
library ocpi_core_bsv; use ocpi_core_bsv.all;

entity rfdc is
  port(
    ctl_is_oper     : in std_logic;
    axis_resetn     : in std_logic;
    -- AXI-Lite slave ports
    s_ctrl_axi_in   : in  axi.lite32.axi_m2s_t;
    s_ctrl_axi_out  : out axi.lite32.axi_s2m_t;
    s_dac0_axi_in   : in  axi.lite32.axi_m2s_t;
    s_dac0_axi_out  : out axi.lite32.axi_s2m_t;
    s_dac1_axi_in   : in  axi.lite32.axi_m2s_t;
    s_dac1_axi_out  : out axi.lite32.axi_s2m_t;
    s_dac2_axi_in   : in  axi.lite32.axi_m2s_t;
    s_dac2_axi_out  : out axi.lite32.axi_s2m_t;
    s_dac3_axi_in   : in  axi.lite32.axi_m2s_t;
    s_dac3_axi_out  : out axi.lite32.axi_s2m_t;
    s_adc0_axi_in   : in  axi.lite32.axi_m2s_t;
    s_adc0_axi_out  : out axi.lite32.axi_s2m_t;
    s_adc1_axi_in   : in  axi.lite32.axi_m2s_t;
    s_adc1_axi_out  : out axi.lite32.axi_s2m_t;
    s_adc2_axi_in   : in  axi.lite32.axi_m2s_t;
    s_adc2_axi_out  : out axi.lite32.axi_s2m_t;
    s_adc3_axi_in   : in  axi.lite32.axi_m2s_t;
    s_adc3_axi_out  : out axi.lite32.axi_s2m_t;
    -- RX path clock inputs
    rx_clks_p       : in  std_logic_vector(4-1 downto 0);
    rx_clks_n       : in  std_logic_vector(4-1 downto 0);
    -- TX path clock inputs
    tx_clks_p       : in  std_logic_vector(1-1 downto 0);
    tx_clks_n       : in  std_logic_vector(1-1 downto 0);
    -- sysref clock input pair
    sysref_p        : in  std_logic;
    sysref_n        : in  std_logic;
    -- RF inputs
    rf_rxs_p        : in  std_logic_vector(6-1 downto 0);
    rf_rxs_n        : in  std_logic_vector(6-1 downto 0);
    rf_txs_p        : out std_logic_vector(3-1 downto 0);
    rf_txs_n        : out std_logic_vector(3-1 downto 0);
    -- AXI-Stream ports for complex TX paths, TDATA is Q [31:16], I [15:0]
    tx_aclks        : out std_logic_vector(1-1 downto 0); -- associated with all s_axis
    s_axis_0_tdata  : in  std_logic_vector(32-1 downto 0);
    s_axis_0_tvalid : in  std_logic;
    s_axis_0_tready : out std_logic;
    s_axis_1_tdata  : in  std_logic_vector(32-1 downto 0);
    s_axis_1_tvalid : in  std_logic;
    s_axis_1_tready : out std_logic;
    -- AXI-Stream ports for complex RX paths, TDATA is Q [31:16], I [15:0]
    rx_aclks        : out std_logic_vector(2-1 downto 0); -- associated with all m_axis
    rx_aresets      : out std_logic_vector(2-1 downto 0); -- active-high, associated with all m_axis
    m_axis_0_tdata  : out std_logic_vector(32-1 downto 0);
    m_axis_0_tvalid : out std_logic;
    m_axis_0_tready : in  std_logic;
    m_axis_1_tdata  : out std_logic_vector(32-1 downto 0);
    m_axis_1_tvalid : out std_logic;
    m_axis_1_tready : in  std_logic);
end entity rfdc;
architecture structural of rfdc is

  COMPONENT usp_rf_data_converter_0
    PORT (
      adc0_clk_p : IN STD_LOGIC;
      adc0_clk_n : IN STD_LOGIC;
      clk_adc0 : OUT STD_LOGIC;
      adc1_clk_p : IN STD_LOGIC;
      adc1_clk_n : IN STD_LOGIC;
      clk_adc1 : OUT STD_LOGIC;
      adc2_clk_p : IN STD_LOGIC;
      adc2_clk_n : IN STD_LOGIC;
      clk_adc2 : OUT STD_LOGIC;
      adc3_clk_p : IN STD_LOGIC;
      adc3_clk_n : IN STD_LOGIC;
      clk_adc3 : OUT STD_LOGIC;
      dac2_clk_p : IN STD_LOGIC;
      dac2_clk_n : IN STD_LOGIC;
      clk_dac2 : OUT STD_LOGIC;
      clk_dac3 : OUT STD_LOGIC;
      s_axi_aclk : IN STD_LOGIC;
      s_axi_aresetn : IN STD_LOGIC;
      s_axi_awaddr : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
      s_axi_awvalid : IN STD_LOGIC;
      s_axi_awready : OUT STD_LOGIC;
      s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axi_wvalid : IN STD_LOGIC;
      s_axi_wready : OUT STD_LOGIC;
      s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_bvalid : OUT STD_LOGIC;
      s_axi_bready : IN STD_LOGIC;
      s_axi_araddr : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
      s_axi_arvalid : IN STD_LOGIC;
      s_axi_arready : OUT STD_LOGIC;
      s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      s_axi_rvalid : OUT STD_LOGIC;
      s_axi_rready : IN STD_LOGIC;
      irq : OUT STD_LOGIC;
      sysref_in_p : IN STD_LOGIC;
      sysref_in_n : IN STD_LOGIC;
      vin0_01_p : IN STD_LOGIC;
      vin0_01_n : IN STD_LOGIC;
      vin0_23_p : IN STD_LOGIC;
      vin0_23_n : IN STD_LOGIC;
      vin1_23_p : IN STD_LOGIC;
      vin1_23_n : IN STD_LOGIC;
      vin2_01_p : IN STD_LOGIC;
      vin2_01_n : IN STD_LOGIC;
      vin2_23_p : IN STD_LOGIC;
      vin2_23_n : IN STD_LOGIC;
      vin3_23_p : IN STD_LOGIC;
      vin3_23_n : IN STD_LOGIC;
      vout20_p : OUT STD_LOGIC;
      vout20_n : OUT STD_LOGIC;
      vout30_p : OUT STD_LOGIC;
      vout30_n : OUT STD_LOGIC;
      vout32_p : OUT STD_LOGIC;
      vout32_n : OUT STD_LOGIC;
      m0_axis_aresetn : IN STD_LOGIC;
      m0_axis_aclk : IN STD_LOGIC;
      m00_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m00_axis_tvalid : OUT STD_LOGIC;
      m00_axis_tready : IN STD_LOGIC;
      m01_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m01_axis_tvalid : OUT STD_LOGIC;
      m01_axis_tready : IN STD_LOGIC;
      m02_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m02_axis_tvalid : OUT STD_LOGIC;
      m02_axis_tready : IN STD_LOGIC;
      m03_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m03_axis_tvalid : OUT STD_LOGIC;
      m03_axis_tready : IN STD_LOGIC;
      m1_axis_aresetn : IN STD_LOGIC;
      m1_axis_aclk : IN STD_LOGIC;
      m12_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m12_axis_tvalid : OUT STD_LOGIC;
      m12_axis_tready : IN STD_LOGIC;
      m13_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m13_axis_tvalid : OUT STD_LOGIC;
      m13_axis_tready : IN STD_LOGIC;
      m2_axis_aresetn : IN STD_LOGIC;
      m2_axis_aclk : IN STD_LOGIC;
      m20_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m20_axis_tvalid : OUT STD_LOGIC;
      m20_axis_tready : IN STD_LOGIC;
      m21_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m21_axis_tvalid : OUT STD_LOGIC;
      m21_axis_tready : IN STD_LOGIC;
      m22_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m22_axis_tvalid : OUT STD_LOGIC;
      m22_axis_tready : IN STD_LOGIC;
      m23_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m23_axis_tvalid : OUT STD_LOGIC;
      m23_axis_tready : IN STD_LOGIC;
      m3_axis_aresetn : IN STD_LOGIC;
      m3_axis_aclk : IN STD_LOGIC;
      m32_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m32_axis_tvalid : OUT STD_LOGIC;
      m32_axis_tready : IN STD_LOGIC;
      m33_axis_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      m33_axis_tvalid : OUT STD_LOGIC;
      m33_axis_tready : IN STD_LOGIC;
      s2_axis_aresetn : IN STD_LOGIC;
      s2_axis_aclk : IN STD_LOGIC;
      s20_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s20_axis_tvalid : IN STD_LOGIC;
      s20_axis_tready : OUT STD_LOGIC;
      s3_axis_aresetn : IN STD_LOGIC;
      s3_axis_aclk : IN STD_LOGIC;
      s30_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s30_axis_tvalid : IN STD_LOGIC;
      s30_axis_tready : OUT STD_LOGIC;
      s32_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      s32_axis_tvalid : IN STD_LOGIC;
      s32_axis_tready : OUT STD_LOGIC
    );
  END COMPONENT;

  component clk_wiz_0 is
    port(
      clk_out1 : out std_logic;
      reset    : in  std_logic;
      locked   : out std_logic;
      clk_in1  : in  std_logic);
  end component clk_wiz_0;

  component axi_interconnect is
    port(
      ctl_is_oper    : in std_logic;
      s_ctrl_axi_in  : in  axi.lite32.axi_m2s_t;
      s_ctrl_axi_out : out axi.lite32.axi_s2m_t;
      s_dac0_axi_in  : in  axi.lite32.axi_m2s_t;
      s_dac0_axi_out : out axi.lite32.axi_s2m_t;
      s_dac1_axi_in  : in  axi.lite32.axi_m2s_t;
      s_dac1_axi_out : out axi.lite32.axi_s2m_t;
      s_dac2_axi_in  : in  axi.lite32.axi_m2s_t;
      s_dac2_axi_out : out axi.lite32.axi_s2m_t;
      s_dac3_axi_in  : in  axi.lite32.axi_m2s_t;
      s_dac3_axi_out : out axi.lite32.axi_s2m_t;
      s_adc0_axi_in  : in  axi.lite32.axi_m2s_t;
      s_adc0_axi_out : out axi.lite32.axi_s2m_t;
      s_adc1_axi_in  : in  axi.lite32.axi_m2s_t;
      s_adc1_axi_out : out axi.lite32.axi_s2m_t;
      s_adc2_axi_in  : in  axi.lite32.axi_m2s_t;
      s_adc2_axi_out : out axi.lite32.axi_s2m_t;
      s_adc3_axi_in  : in  axi.lite32.axi_m2s_t;
      s_adc3_axi_out : out axi.lite32.axi_s2m_t;
      m_axi_in       : in  axi.lite32.axi_s2m_t;
      m_axi_out      : out axi.lite32.axi_m2s_t);
  end component axi_interconnect;

  constant FIFO_DEPTH : positive := 16;
  signal zeros_32 : std_logic_vector(32-1 downto 0)
                  := (others => '0');
  signal zero      : std_logic := '0';
  -- ctl clk domain
  signal ctl_resetn : std_logic := '0';
  signal ctl_axi_reset : std_logic := '0';
  signal interconnect_to_xilinx_rfdc_ip_axi_in : axi.lite32.axi_s2m_t := (
      aw => (READY => '0'),
      ar => (READY => '0'),
      w => (READY => '0'),
      r => (DATA => (others => '0'), RESP => (others => '0'), VALID => '0'),
      b => (RESP => (others => '0'), VALID => '0'));
  signal interconnect_to_xilinx_rfdc_ip_axi_out : axi.lite32.axi_m2s_t := (
      a => (CLK => '0', RESETn => '0'),
      aw => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      ar => (ADDR => (others => '0'), VALID => '0', PROT => (others => '0')),
      w => (DATA => (others => '0'), STRB => (others => '0'), VALID => '0'),
      r => (READY => '0'),
      b => (READY => '0'));
  -- rx_0 clk domain
  -- TODO consolidate rx_0 "clk domain"/signals entirely into the clk_90 domain which is what it really is
  --signal rx_0_clk                   : std_logic := '0';
  signal rx_0_reset                 : std_logic := '0';
  signal rx_0_resetn                : std_logic := '0';
  signal rfdc_to_rx_0_combiner_0_tdata  : std_logic_vector(16-1 downto 0)
                                        := (others => '0');
  signal rfdc_to_rx_0_combiner_0_tvalid : std_logic := '0';
  signal rfdc_to_rx_0_combiner_0_tready : std_logic := '0';
  signal rfdc_to_rx_0_combiner_1_tdata  : std_logic_vector(16-1 downto 0)
                                        := (others => '0');
  signal rfdc_to_rx_0_combiner_1_tvalid : std_logic := '0';
  signal rfdc_to_rx_0_combiner_1_tready : std_logic := '0';
  -- TODO consolidate rx_1 "clk domain"/signals entirely into the clk_90 domain which is what it really is
  -- rx_1 clk domain
  --signal rx_1_clk                   : std_logic := '0';
  signal rx_1_reset                 : std_logic := '0';
  signal rx_1_resetn                : std_logic := '0';
  signal rfdc_to_rx_1_combiner_0_tdata  : std_logic_vector(16-1 downto 0)
                                        := (others => '0');
  signal rfdc_to_rx_1_combiner_0_tvalid : std_logic := '0';
  signal rfdc_to_rx_1_combiner_0_tready : std_logic := '0';
  signal rfdc_to_rx_1_combiner_1_tdata  : std_logic_vector(16-1 downto 0)
                                        := (others => '0');
  signal rfdc_to_rx_1_combiner_1_tvalid : std_logic := '0';
  signal rfdc_to_rx_1_combiner_1_tready : std_logic := '0';
  -- TODO consolidate rx_2 "clk domain"/signals entirely into the clk_90 domain which is what it really is
  -- rx_2 clk domain (only needed to rfdc_ip's unused axi-stream port)
  --signal rx_2_clk                   : std_logic := '0';
  signal rx_2_resetn                : std_logic := '0';
  -- TODO consolidate rx_3 "clk domain"/signals entirely into the clk_90 domain which is what it really is
  -- rx_3 clk domain (only needed to rfdc_ip's unused axi-stream port)
  --signal rx_3_clk                   : std_logic := '0';
  signal rx_3_resetn                : std_logic := '0';
  -- TODO consolidate tx_0 "clk domain"/signals entirely into the clk_90 domain which is what it really is
  -- tx_0 clk domain
  signal tx_0_clk    : std_logic := '0';
  signal tx_0_reset  : std_logic := '0';
  signal tx_0_resetn : std_logic := '0';
  -- clk_90 domain
  signal clk_90 : std_logic := '0';
  signal clk_90_locked : std_logic := '0';
  -- debug
  attribute mark_debug : string;
  attribute mark_debug of ctl_resetn : signal is "true";
  attribute mark_debug of s_ctrl_axi_in : signal is "true";
  attribute mark_debug of axis_resetn : signal is "true";
  attribute mark_debug of clk_90_locked : signal is "true";
  attribute mark_debug of rx_0_reset : signal is "true";
  attribute mark_debug of rx_0_resetn : signal is "true";
  --attribute mark_debug of rx_1_reset : signal is "true";
  --attribute mark_debug of rx_1_resetn : signal is "true";
  --attribute mark_debug of tx_0_reset : signal is "true";
  --attribute mark_debug of tx_0_resetn : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_0_tdata : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_0_tvalid : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_0_tready : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_1_tdata : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_1_tvalid : signal is "true";
  attribute mark_debug of rfdc_to_rx_0_combiner_1_tready : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_0_tdata : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_0_tvalid : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_0_tready : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_1_tdata : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_1_tvalid : signal is "true";
  --attribute mark_debug of rfdc_to_rx_1_combiner_1_tready : signal is "true";
begin

  interconnect : axi_interconnect
    port map(
      ctl_is_oper    => ctl_is_oper,
      s_ctrl_axi_in  => s_ctrl_axi_in,
      s_ctrl_axi_out => s_ctrl_axi_out,
      s_dac0_axi_in  => s_dac0_axi_in,
      s_dac0_axi_out => s_dac0_axi_out,
      s_dac1_axi_in  => s_dac1_axi_in,
      s_dac1_axi_out => s_dac1_axi_out,
      s_dac2_axi_in  => s_dac2_axi_in,
      s_dac2_axi_out => s_dac2_axi_out,
      s_dac3_axi_in  => s_dac3_axi_in,
      s_dac3_axi_out => s_dac3_axi_out,
      s_adc0_axi_in  => s_adc0_axi_in,
      s_adc0_axi_out => s_adc0_axi_out,
      s_adc1_axi_in  => s_adc1_axi_in,
      s_adc1_axi_out => s_adc1_axi_out,
      s_adc2_axi_in  => s_adc2_axi_in,
      s_adc2_axi_out => s_adc2_axi_out,
      s_adc3_axi_in  => s_adc3_axi_in,
      s_adc3_axi_out => s_adc3_axi_out,
      m_axi_in       => interconnect_to_xilinx_rfdc_ip_axi_in,
      m_axi_out      => interconnect_to_xilinx_rfdc_ip_axi_out);

  tx_aclks(0)   <= clk_90;--tx_0_clk;
  rx_aclks(0)   <= clk_90;--rx_0_clk;
  rx_aclks(1)   <= clk_90;--rx_1_clk;
  rx_aresets(0) <= rx_0_reset;
  rx_aresets(1) <= rx_1_reset;

  ctl_resetn <= s_ctrl_axi_in.a.resetn and axis_resetn and clk_90_locked;
  ctl_axi_reset <= not s_ctrl_axi_in.a.resetn;

  rx_0_reset_synchronizer : cdc.cdc.reset
    generic map(
      SRC_RST_VALUE => '0')
    port map(
      src_rst   => ctl_resetn,
      dst_clk   => clk_90,--rx_0_clk,
      dst_rst   => rx_0_reset,
      dst_rst_n => rx_0_resetn);

  rx_1_reset_synchronizer : cdc.cdc.reset
    generic map(
      SRC_RST_VALUE => '0')
    port map(
      src_rst   => ctl_resetn,
      dst_clk   => clk_90,--rx_1_clk,
      dst_rst   => rx_1_reset,
      dst_rst_n => rx_1_resetn);

  rx_2_reset_synchronizer : cdc.cdc.reset
    generic map(
      SRC_RST_VALUE => '0')
    port map(
      src_rst   => ctl_resetn,
      dst_clk   => clk_90,--rx_2_clk,
      dst_rst   => open,
      dst_rst_n => rx_2_resetn);

  rx_3_reset_synchronizer : cdc.cdc.reset
    generic map(
      SRC_RST_VALUE => '0')
    port map(
      src_rst   => ctl_resetn,
      dst_clk   => clk_90,--rx_3_clk,
      dst_rst   => open,
      dst_rst_n => rx_3_resetn);

  tx_0_reset_synchronizer : cdc.cdc.reset
    generic map(
      SRC_RST_VALUE => '0')
    port map(
      src_rst   => ctl_resetn,
      dst_clk   => clk_90,--tx_0_clk,
      dst_rst   => tx_0_reset,
      dst_rst_n => tx_0_resetn);

  xilinx_rfdc_ip : usp_rf_data_converter_0
    port map(
      adc0_clk_p => rx_clks_p(0),
      adc0_clk_n => rx_clks_n(0),
      clk_adc0 => open,--rx_0_clk,
      adc1_clk_p => rx_clks_p(2),
      adc1_clk_n => rx_clks_n(2),
      clk_adc1 => open,--rx_2_clk, -- unused
      adc2_clk_p => rx_clks_p(1),
      adc2_clk_n => rx_clks_p(1),
      clk_adc2 => open,--rx_1_clk,
      adc3_clk_p => rx_clks_p(3),
      adc3_clk_n => rx_clks_n(3),
      clk_adc3 => open,--rx_3_clk, -- unused
      dac2_clk_p => tx_clks_p(0),
      dac2_clk_n => tx_clks_n(0),
      clk_dac2 => tx_0_clk,
      clk_dac3 => open,
      s_axi_aclk => s_ctrl_axi_in.a.clk,
      s_axi_aresetn => s_ctrl_axi_in.a.resetn,
      s_axi_awaddr  => interconnect_to_xilinx_rfdc_ip_axi_out.aw.ADDR(18-1 downto 0),
      s_axi_awvalid => interconnect_to_xilinx_rfdc_ip_axi_out.aw.VALID,
      s_axi_awready => interconnect_to_xilinx_rfdc_ip_axi_in.aw.READY,
      s_axi_wdata   => interconnect_to_xilinx_rfdc_ip_axi_out.w.DATA,
      s_axi_wstrb   => interconnect_to_xilinx_rfdc_ip_axi_out.w.STRB,
      s_axi_wvalid  => interconnect_to_xilinx_rfdc_ip_axi_out.w.VALID,
      s_axi_wready  => interconnect_to_xilinx_rfdc_ip_axi_in.w.READY,
      s_axi_bresp   => interconnect_to_xilinx_rfdc_ip_axi_in.b.RESP,
      s_axi_bvalid  => interconnect_to_xilinx_rfdc_ip_axi_in.b.VALID,
      s_axi_bready  => interconnect_to_xilinx_rfdc_ip_axi_out.b.READY,
      s_axi_araddr  => interconnect_to_xilinx_rfdc_ip_axi_out.ar.ADDR(18-1 downto 0),
      s_axi_arvalid => interconnect_to_xilinx_rfdc_ip_axi_out.ar.VALID,
      s_axi_arready => interconnect_to_xilinx_rfdc_ip_axi_in.ar.READY,
      s_axi_rdata   => interconnect_to_xilinx_rfdc_ip_axi_in.r.DATA,
      s_axi_rresp   => interconnect_to_xilinx_rfdc_ip_axi_in.r.RESP,
      s_axi_rvalid  => interconnect_to_xilinx_rfdc_ip_axi_in.r.VALID,
      s_axi_rready  => interconnect_to_xilinx_rfdc_ip_axi_out.r.READY,
      irq => open,
      sysref_in_p => sysref_p,
      sysref_in_n => sysref_n,
      vin0_01_p => rf_rxs_p(0),
      vin0_01_n => rf_rxs_n(0),
      vin0_23_p => rf_rxs_p(4),
      vin0_23_n => rf_rxs_n(4),
      vin1_23_p => rf_rxs_p(2),
      vin1_23_n => rf_rxs_n(2),
      vin2_01_p => rf_rxs_p(1),
      vin2_01_n => rf_rxs_n(1),
      vin2_23_p => rf_rxs_p(5),
      vin2_23_n => rf_rxs_n(5),
      vin3_23_p => rf_rxs_p(3),
      vin3_23_n => rf_rxs_n(3),
      vout20_p => rf_txs_p(2),
      vout20_n => rf_txs_n(2),
      vout30_p => rf_txs_p(0),
      vout30_n => rf_txs_n(0),
      vout32_p => rf_txs_p(1),
      vout32_n => rf_txs_n(1),
      m0_axis_aresetn => rx_0_resetn,
      m0_axis_aclk => clk_90,--rx_0_clk,
      m00_axis_tdata  => rfdc_to_rx_0_combiner_0_tdata,
      m00_axis_tvalid => rfdc_to_rx_0_combiner_0_tvalid,
      m00_axis_tready => rfdc_to_rx_0_combiner_0_tready,
      m01_axis_tdata  => rfdc_to_rx_0_combiner_1_tdata,
      m01_axis_tvalid => rfdc_to_rx_0_combiner_1_tvalid,
      m01_axis_tready => rfdc_to_rx_0_combiner_1_tready,
      m02_axis_tdata => open,
      m02_axis_tvalid => open,
      m02_axis_tready => '0',
      m03_axis_tdata => open,
      m03_axis_tvalid => open,
      m03_axis_tready => '0',
      m1_axis_aresetn => rx_2_resetn,
      m1_axis_aclk => clk_90,--rx_2_clk,
      m12_axis_tdata => open,
      m12_axis_tvalid => open,
      m12_axis_tready => '0',
      m13_axis_tdata => open,
      m13_axis_tvalid => open,
      m13_axis_tready => '0',
      m2_axis_aresetn => rx_1_resetn,
      m2_axis_aclk => clk_90,--rx_1_clk,
      m20_axis_tdata  => rfdc_to_rx_1_combiner_0_tdata,
      m20_axis_tvalid => rfdc_to_rx_1_combiner_0_tvalid,
      m20_axis_tready => rfdc_to_rx_1_combiner_0_tready,
      m21_axis_tdata  => rfdc_to_rx_1_combiner_1_tdata,
      m21_axis_tvalid => rfdc_to_rx_1_combiner_1_tvalid,
      m21_axis_tready => rfdc_to_rx_1_combiner_1_tready,
      m22_axis_tdata => open,
      m22_axis_tvalid => open,
      m22_axis_tready => '0',
      m23_axis_tdata => open,
      m23_axis_tvalid => open,
      m23_axis_tready => '0',
      m3_axis_aresetn => rx_3_resetn,
      m3_axis_aclk => clk_90,--rx_3_clk,
      m32_axis_tdata => open,
      m32_axis_tvalid => open,
      m32_axis_tready => '0',
      m33_axis_tdata => open,
      m33_axis_tvalid => open,
      m33_axis_tready => '0',
      s2_axis_aresetn => tx_0_resetn,
      s2_axis_aclk => clk_90,--tx_0_clk,
      s20_axis_tdata => zeros_32,
      s20_axis_tvalid => zero,
      s20_axis_tready => open,
      s3_axis_aresetn => tx_0_resetn,
      s3_axis_aclk => clk_90,--tx_0_clk,
      s30_axis_tdata => s_axis_0_tdata,
      s30_axis_tvalid => s_axis_0_tvalid,
      s30_axis_tready => s_axis_0_tready,
      s32_axis_tdata => s_axis_1_tdata,
      s32_axis_tvalid => s_axis_1_tvalid,
      s32_axis_tready => s_axis_1_tready);

  clock_converter : clk_wiz_0
    port map(
      clk_out1 => clk_90,
      reset    => ctl_axi_reset,
      locked   => clk_90_locked,
      clk_in1  => tx_0_clk);

  rx_0_combiner : entity work.axis_combiner
    port map(
      s_axis_0_tdata  => rfdc_to_rx_0_combiner_0_tdata,
      s_axis_0_tvalid => rfdc_to_rx_0_combiner_0_tvalid,
      s_axis_0_tready => rfdc_to_rx_0_combiner_0_tready,
      s_axis_1_tdata  => rfdc_to_rx_0_combiner_1_tdata,
      s_axis_1_tvalid => rfdc_to_rx_0_combiner_1_tvalid,
      s_axis_1_tready => rfdc_to_rx_0_combiner_1_tready,
      m_axis_tdata    => m_axis_0_tdata,
      m_axis_tvalid   => m_axis_0_tvalid,
      m_axis_tready   => m_axis_0_tready);

  rx_1_combiner : entity work.axis_combiner
    port map(
      s_axis_0_tdata  => rfdc_to_rx_1_combiner_0_tdata,
      s_axis_0_tvalid => rfdc_to_rx_1_combiner_0_tvalid,
      s_axis_0_tready => rfdc_to_rx_1_combiner_0_tready,
      s_axis_1_tdata  => rfdc_to_rx_1_combiner_1_tdata,
      s_axis_1_tvalid => rfdc_to_rx_1_combiner_1_tvalid,
      s_axis_1_tready => rfdc_to_rx_1_combiner_1_tready,
      m_axis_tdata    => m_axis_1_tdata,
      m_axis_tvalid   => m_axis_1_tvalid,
      m_axis_tready   => m_axis_1_tready);

end structural;
