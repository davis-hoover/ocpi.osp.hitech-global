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

# OpenCPI additions to the above, which is unmodified from the original

create_clock -name clk_fpga_0 -period 10.000 [get_pins -hier * -filter {NAME =~ /ps/U0/U0/inst/PS8_i/PLCLK[0]}]
set_property DONT_TOUCH true [get_cells "ftop/pfconfig_i/zrf8_48dr_i/worker/ps/U0/U0/inst/PS8_i"]
