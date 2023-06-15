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

$(if $(realpath $(OCPI_CDK_DIR)),,\
  $(error The OCPI_CDK_DIR environment variable is not set correctly.))
# IMPORTANT - a version of build.tcl, modified per
#             assembly/config/container combo, is required for every assembly
#             built for the zrf8_48dr platform due to RF data converter IP (XCI)
#             requirements
# TODO - investigate having OpenCPI properly account for the XCI functionality herein
export HdlPreOptHook=../build.tcl
include $(OCPI_CDK_DIR)/include/hdl/hdl-assembly.mk
