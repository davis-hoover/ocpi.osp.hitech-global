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

-- TODO write a hdl testbench for this...

library ieee; use ieee.std_logic_1164.all, ieee.numeric_std.all;

entity axis_combiner is
  port(
    s_axis_0_tdata  : in  std_logic_vector(16-1 downto 0);
    s_axis_0_tvalid : in  std_logic;
    s_axis_0_tready : out std_logic;
    s_axis_1_tdata  : in  std_logic_vector(16-1 downto 0);
    s_axis_1_tvalid : in  std_logic;
    s_axis_1_tready : out std_logic;
    m_axis_tdata    : out std_logic_vector(32-1 downto 0);
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic);
end entity;
architecture rtl of axis_combiner is
  signal allow_0 : std_logic := '0';
  signal allow_1 : std_logic := '0';
begin

  m_axis_tdata <= s_axis_1_tdata & s_axis_0_tdata;
  m_axis_tvalid <= s_axis_0_tvalid and s_axis_1_tvalid;
  allow_0 <= s_axis_1_tvalid or (not s_axis_0_tvalid);
  allow_1 <= s_axis_0_tvalid or (not s_axis_1_tvalid);
  s_axis_0_tready <= m_axis_tready and allow_0;
  s_axis_1_tready <= m_axis_tready and allow_1;

end rtl;
