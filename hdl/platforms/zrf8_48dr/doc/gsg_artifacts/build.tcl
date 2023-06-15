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

# IMPORTANT - a version of this file, modified per
#             assembly/config/container combo, is required for every assembly
#             built for the zrf8_48dr platform due to RF data converter IP (XCI)
#             requirements
# TODO - investigate having OpenCPI properly account for the XCI functionality herein
set xci_path "../../../../../../osps/ocpi.osp.hitech-global/hdl/primitives/rfdc/gen/tmp/managed_ip_project/managed_ip_project.srcs/sources_1/ip/usp_rf_data_converter_0/usp_rf_data_converter_0.xci"
add_files -norecurse "$xci_path"
export_ip_user_files -of_objects [get_files "$xci_path"] -force -quiet
set clk_xci_path "../../../../../../osps/ocpi.osp.hitech-global/hdl/primitives/rfdc/gen/tmp/managed_ip_project/managed_ip_project.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci"
add_files -norecurse "$clk_xci_path"
export_ip_user_files -of_objects [get_files "$clk_xci_path"] -force -quiet
# the below line is modified per assembly/config/container combo, and the format of the property value is <assembly_<platform>_<pfconfig>_<container> (remove trailing _<container> if default container is used)
set_property top testbias_zrf8_48dr_base [current_fileset]
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
