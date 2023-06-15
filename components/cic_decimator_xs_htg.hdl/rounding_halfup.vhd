-- HDL Implementation of a half up rounder.
--
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

-- Halfup rounder implementation.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rounding_halfup is
  generic (
    input_width_g   : integer := 32;
    output_width_g  : integer := 16;
    saturation_en_g : boolean := false
    );
  port (
    clk                    : in  std_logic;
    reset                  : in  std_logic;
    clk_en                 : in  std_logic;
    status_overflow_sticky : out std_logic;
    data_in                : in  signed(input_width_g - 1 downto 0);
    data_valid_in          : in  std_logic;
    binary_point           : in  integer range 0 to input_width_g - 1;
    data_out               : out signed(output_width_g - 1 downto 0);
    data_valid_out         : out std_logic
    );
end rounding_halfup;

architecture rtl of rounding_halfup is
  signal zeros : std_logic_vector(data_in'length-output_width_g-1 downto 0) := (others => '0');
  signal ones  : std_logic_vector(data_in'length-output_width_g-1 downto 0) := (others => '1');
begin

  assert binary_point < input_width_g report "binary point must be less than input_width_g" severity failure;

  halfup_rounder_p : process(clk)
    variable halfup : signed(data_in'length-1 downto 0);
    variable data   : signed(output_width_g - 1 downto 0);
  begin

    if rising_edge(clk) then
      if (reset = '1') then
        data_out <= (others => '0');
        status_overflow_sticky <= '0';
      elsif (clk_en = '1') then
        halfup := data_in;
        if binary_point = 0 then
          -- Output data_out'length least significant bits
          data := halfup(data'length-1 downto 0);
        else
          halfup := SHIFT_RIGHT(halfup, binary_point-1);
          halfup := halfup + 1;         -- Add 0.5
          halfup := SHIFT_RIGHT(halfup, 1);
          -- Truncate data to desired output width
          data   := halfup(data'length-1 downto 0);
          if unsigned(halfup(halfup'length-1 downto data'length)) /=
              unsigned(zeros) then
            if unsigned(halfup(halfup'length-1 downto data'length)) /=
                unsigned(ones) then
              status_overflow_sticky <= '1';
            end if;
          end if;
        end if;

        if saturation_en_g then
          -- Test if the top sample has changed, this is a good sign
          -- that there has been a saturation event
          if data(data'high) /= data_in(data_in'high) and data /= 0 then
            if data(data'high) = '1' then
              data(output_width_g-1)          := '0';
              data(output_width_g-2 downto 0) := (others => '1');
            else
              data(output_width_g-1)          := '1';
              data(output_width_g-2 downto 0) := (others => '0');
            end if;
          end if;
        end if;

        data_out <= data;

      end if;
    end if;
  end process;

  round_valid_p : process(clk)
  begin
    if rising_edge(clk) then
      if (reset = '1') then
        data_valid_out <= '0';
      elsif (clk_en = '1') then
        data_valid_out <= data_valid_in;
      end if;
    end if;
  end process;

end rtl;
