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
library protocol; use protocol.iqstream.all;

-- TODO rename this to something more indicative of its function
entity oneshot_fifo is
  port(
    aclk          : in  std_logic;
    aresetn       : in  std_logic;
    bypass        : in  std_logic;
    s_axis_tdata  : in  std_logic_vector(32-1 downto 0);
    s_axis_tvalid : in  std_logic;
    s_axis_tready : out std_logic;
    m_axis_tdata  : out std_logic_vector(32-1 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in  std_logic);
end entity;
architecture rtl of oneshot_fifo is
  signal count : unsigned(30-1 downto 0) := (others => '0');
  signal tvalid : std_logic := '0'; -- only for mark_debug
  signal allow_passage : std_logic := '0';
  attribute mark_debug : string;
  attribute mark_debug of bypass : signal is "true";
  attribute mark_debug of count : signal is "true";
  attribute mark_debug of allow_passage : signal is "true";
  attribute mark_debug of tvalid : signal is "true";
begin

  s_axis_tready <= m_axis_tready;
  m_axis_tdata <= s_axis_tdata;
  tvalid <= s_axis_tvalid and allow_passage;
  m_axis_tvalid <= tvalid;
  -- the prevailing theory is that there is some known powerup/transient
  -- behavior where the rfdc rx path outputs erroneous data for the first tens
  -- of thousand of samples, so we simply drop the initial N samples on the
  -- floor
  allow_passage <= '0' when (count <= 65536*512) and (bypass = '0') else '1';
  
  process(aclk)
  begin
    if rising_edge(aclk) then
      if aresetn = '0' then
        count <= (others => '0');
      elsif allow_passage = '0' then
        count <= count + 1;
      end if;
    end if;
  end process;

end rtl;
