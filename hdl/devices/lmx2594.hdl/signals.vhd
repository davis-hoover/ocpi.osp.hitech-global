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

library IEEE; use IEEE.std_logic_1164.all, ieee.numeric_std.all;
library platform; use platform.platform_pkg.all;

entity signals is
  port (
    i_cs_n     : in  std_logic;
    i_sclk     : in  std_logic;
    i_sdi      : in  std_logic;
    o_sdo      : out std_logic;
    o_buf_cs_n : out std_logic;
    o_buf_sclk : out std_logic;
    o_buf_sdi  : out std_logic;
    i_buf_sdo  : in  std_logic);
end entity signals;

architecture rtl of signals is

begin

  buf_cs_n : BUFFER_OUT_1
    generic map(DIFFERENTIAL => false)
    port map(I => i_cs_n,
             O => o_buf_cs_n);

  buf_sclk : BUFFER_OUT_1
    generic map(DIFFERENTIAL => false)
    port map(I => i_sclk,
             O => o_buf_sclk);

  buf_sdi : BUFFER_OUT_1
    generic map(DIFFERENTIAL => false)
    port map(I => i_sdi,
             O => o_buf_sdi);

  buf_sdo : BUFFER_IN_1
    generic map(DIFFERENTIAL => false)
    port map(I => i_buf_sdo,
             O => o_sdo);
end rtl;

