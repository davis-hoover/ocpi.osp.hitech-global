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
set_property top fs_div_4_tx_zrf8_48dr_cfg_rfdc_j3_j13_j18_j20_cnt_1rx_1tx_zrf8_48dr_j3_j13_j18_j20 [current_fileset]
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
# ILAs were added using the following steps
# 1. Use mark_debug VHDL synthesis directive within worker source code
# 2. (Re-)build dependent worker heirarchy according to workers whose synthesis directives were modified
# 3. Build assembly until opt.out and then cancel build with Ctrl-C
# 4. Use vivado (in bash session separate from OpenCPI's) to open the container..../target..../<assembly...>.xpr project
# 5. Run synthesis in the vivado GUI
# 6. Open the synthesized design
# 7. Run through the setup debug process until the ILAs have been inserted in the design
# 8. Copy the commands from the vivado TCL window, which correspond to ILA insertion, into this build.tcl script
# 9. Ensure that the assembly Makefile includes the following line: export HdlPreOptHook=../build.tcl
# 10. Clean and re-build the assembly

# comment out below lines to remove ILAs
#create_debug_core u_ila_0 ila
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#startgroup 
#set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0 ]
#set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0 ]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0 ]
#set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0 ]
#endgroup
#create_debug_core u_ila_1 ila
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_1]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
#startgroup 
#set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_1 ]
#set_property C_ADV_TRIGGER true [get_debug_cores u_ila_1 ]
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1 ]
#set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_1 ]
#endgroup
#connect_debug_port u_ila_0/clk [get_nets [list ftop/pfconfig_i/zrf8_48dr_i/worker/ps/U0/U0/pl_clk0 ]]
#connect_debug_port u_ila_1/clk [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/rfdc_prim/tx_aclks[0]} ]]
#set_property port_width 32 [get_debug_ports u_ila_0/probe0]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[0]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[1]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[2]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[3]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[4]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[5]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[6]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[7]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[8]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[9]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[10]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[11]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[12]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[13]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[14]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[15]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[16]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[17]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[18]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[19]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[20]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[21]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[22]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[23]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[24]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[25]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[26]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[27]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[28]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[29]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[30]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tdata[31]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 16 [get_debug_ports u_ila_0/probe1]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][0]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][1]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][2]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][3]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][4]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][5]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][6]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][7]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][8]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][9]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][10]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][11]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][12]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][13]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][14]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][i][15]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 16 [get_debug_ports u_ila_0/probe2]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][q][15]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 16 [get_debug_ports u_ila_0/probe3]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq][data][i][15]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 32 [get_debug_ports u_ila_0/probe4]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
#connect_debug_port u_ila_0/probe4 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[0]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[1]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[2]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[3]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[4]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[5]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[6]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[7]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[8]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[9]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[10]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[11]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[12]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[13]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[14]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[15]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[16]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[17]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[18]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[19]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[20]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[21]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[22]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[23]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[24]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[25]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[26]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[27]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[28]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[29]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[30]} {ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tdata[31]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 16 [get_debug_ports u_ila_0/probe5]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
#connect_debug_port u_ila_0/probe5 [get_nets [list {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][0]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][1]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][2]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][3]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][4]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][5]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][6]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][7]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][8]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][9]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][10]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][11]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][12]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][13]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][14]} {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq][data][q][15]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe6]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
#connect_debug_port u_ila_0/probe6 [get_nets [list {ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_protocol[iq_vld]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe7]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
#connect_debug_port u_ila_0/probe7 [get_nets [list ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/converter_to_marshaller_rdy ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe8]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
#connect_debug_port u_ila_0/probe8 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_pro[iq_vld]} ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe9]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
#connect_debug_port u_ila_0/probe9 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_0_demarshaller_to_ctl_tx_0_converter_rdy ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe10]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
#connect_debug_port u_ila_0/probe10 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tready ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe11]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
#connect_debug_port u_ila_0/probe11 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/ctl_tx_0_converter_to_tx_0_cdc_tvalid ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe12]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
#connect_debug_port u_ila_0/probe12 [get_nets [list ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tready ]]
#create_debug_port u_ila_0 probe
#set_property port_width 1 [get_debug_ports u_ila_0/probe13]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
#connect_debug_port u_ila_0/probe13 [get_nets [list ftop/fs_div_4_tx_i/assy/fs_div_4_generator/rv/worker/generator_to_converter_tvalid ]]
#set_property port_width 32 [get_debug_ports u_ila_1/probe0]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
#connect_debug_port u_ila_1/probe0 [get_nets [list {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[0]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[1]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[2]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[3]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[4]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[5]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[6]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[7]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[8]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[9]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[10]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[11]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[12]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[13]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[14]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[15]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[16]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[17]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[18]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[19]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[20]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[21]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[22]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[23]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[24]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[25]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[26]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[27]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[28]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[29]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[30]} {ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tdata[31]} ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe1]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
#connect_debug_port u_ila_1/probe1 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tready ]]
#create_debug_port u_ila_1 probe
#set_property port_width 1 [get_debug_ports u_ila_1/probe2]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
#connect_debug_port u_ila_1/probe2 [get_nets [list ftop/pfconfig_i/rfdc_i/worker/tx_0_cdc_to_rfdc_prim_tvalid ]]
