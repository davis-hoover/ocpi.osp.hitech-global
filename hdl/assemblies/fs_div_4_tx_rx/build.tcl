# This file is protected by Copyright. Please refer to the COPYRIGHT file
# distributed with this source distribution.
#
# This file is part of OpenCPI <http://www.opencpi.org>
#
# OpenCPI is free software: you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# OpenCPI is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

set xci_path "../../../../primitives/rfdc/gen/tmp/managed_ip_project/managed_ip_project.srcs/sources_1/ip/usp_rf_data_converter_0/usp_rf_data_converter_0.xci"
add_files -norecurse "$xci_path"
export_ip_user_files -of_objects [get_files "$xci_path"] -force -quiet
set clk_xci_path "../../../../primitives/rfdc/gen/tmp/managed_ip_project/managed_ip_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci"
add_files -norecurse "$clk_xci_path"
export_ip_user_files -of_objects [get_files "$clk_xci_path"] -force -quiet
# the below line is modified per assembly/config/container combo, and the format of the property value is <assembly_<platform>_<pfconfig>_<container> (remove trailing _<container> if default container is used)
set_property top fs_div_4_tx_rx_zrf8_48dr_cfg_rfdc_j3_j13_j18_j20_cnt [current_fileset]
link_design -name netlist_1
# comment out below line to add useful print of available clock names
#puts [all_clocks]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFADC0_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFADC1_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFADC2_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFADC3_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFDAC1_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFDAC2_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks RFDAC3_CLK]
set_false_path -from [get_clocks clk_fpga_0] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFADC0_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFADC1_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFADC2_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFADC3_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFDAC1_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFDAC2_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks RFDAC3_CLK]
set_false_path -from [get_clocks clk_out1_clk_wiz_0_1] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFADC0_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFADC1_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFADC2_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFADC3_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFDAC1_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFDAC2_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFDAC3_CLK] -to [get_clocks clk_fpga_0]
set_false_path -from [get_clocks RFADC0_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFADC1_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFADC2_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFADC3_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFDAC1_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFDAC2_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
set_false_path -from [get_clocks RFDAC3_CLK] -to [get_clocks clk_out1_clk_wiz_0_1]
#create_debug_core u_ila_0 ila
#set_property C_DATA_DEPTH 65536 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#create_debug_core u_ila_1 ila
#set_property C_DATA_DEPTH 65536 [get_debug_cores u_ila_1]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
#connect_debug_port u_ila_0/clk [get_nets [list ftop/pfconfig_i/zrf8_48dr_i/worker/ps/U0/U0/pl_clk0 ]]
#connect_debug_port u_ila_1/clk [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/xilinx_rfdc_ip/inst/i_usp_rf_data_converter_0_bufg_gt_ctrl/clk_dac2 ]]
#set_property port_width 20 [get_debug_ports u_ila_0/probe0]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[15]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[16]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[17]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[18]} {ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/count[19]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 36 [get_debug_ports u_ila_0/probe1]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[0]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[1]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[2]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[3]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[4]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[5]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[6]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[7]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[8]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[9]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[10]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[11]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[12]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[13]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[14]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[15]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[16]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[17]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[18]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[19]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[20]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[21]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[22]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[23]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[24]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[25]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[26]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[27]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[28]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[29]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[30]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[31]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[32]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[33]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[34]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_in[35]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 36 [get_debug_ports u_ila_0/probe2]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[0]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[1]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[2]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[3]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[4]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[5]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[6]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[7]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[8]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[9]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[10]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[11]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[12]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[13]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[14]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[15]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[16]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[17]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[18]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[19]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[20]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[21]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[22]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[23]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[24]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[25]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[26]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[27]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[28]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[29]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[30]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[31]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[32]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[33]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[34]} {ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_d_out[35]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 32 [get_debug_ports u_ila_0/probe3]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[15]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[16]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[17]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[18]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[19]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[20]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[21]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[22]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[23]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[24]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[25]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[26]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[27]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[28]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[29]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[30]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tdata[31]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 32 [get_debug_ports u_ila_0/probe4]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
#connect_debug_port u_ila_0/probe4 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[15]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[16]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[17]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[18]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[19]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[20]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[21]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[22]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[23]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[24]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[25]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[26]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[27]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[28]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[29]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[30]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tdata[31]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe5]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
#connect_debug_port u_ila_0/probe5 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/allow_passage ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe6]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
#connect_debug_port u_ila_0/probe6 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/axis_resetn ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe7]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
#connect_debug_port u_ila_0/probe7 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tready ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe8]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
#connect_debug_port u_ila_0/probe8 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_converter_tvalid ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe9]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
#connect_debug_port u_ila_0/probe9 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tready ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe10]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
#connect_debug_port u_ila_0/probe10 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_0_cdc_to_ctl_rx_0_fifo_tvalid ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe11]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
#connect_debug_port u_ila_0/probe11 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/ctl_resetn ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe12]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
#connect_debug_port u_ila_0/probe12 [get_nets [list ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_deq ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe13]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
#connect_debug_port u_ila_0/probe13 [get_nets [list ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_empty_n ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe14]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
#connect_debug_port u_ila_0/probe14 [get_nets [list ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_enq ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe15]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
#connect_debug_port u_ila_0/probe15 [get_nets [list ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_full_n ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe16]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
#connect_debug_port u_ila_0/probe16 [get_nets [list ftop/fs_div_4_tx_rx_i/assy/fifo0/rv/worker/fifo_reset_n ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe17]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
#connect_debug_port u_ila_0/probe17 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_rx_0_fifo/tvalid ]]
#set_property port_width 16 [get_debug_ports u_ila_1/probe0]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
#connect_debug_port u_ila_1/probe0 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[0]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[1]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[2]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[3]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[4]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[5]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[6]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[7]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[8]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[9]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[10]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[11]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[12]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[13]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[14]} {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tdata[15]} ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe1]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
#connect_debug_port u_ila_1/probe1 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tready ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe2]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
#connect_debug_port u_ila_1/probe2 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_0_tvalid ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe3]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe3]
#connect_debug_port u_ila_1/probe3 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_1_tready ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe4]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe4]
#connect_debug_port u_ila_1/probe4 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rfdc_to_rx_0_combiner_1_tvalid ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe5]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe5]
#connect_debug_port u_ila_1/probe5 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rx_0_reset ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe6]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe6]
#connect_debug_port u_ila_1/probe6 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/rx_0_resetn ]]
