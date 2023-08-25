library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is port (
  a: in std_logic_vector(3 downto 0);
  s: in std_logic_vector(1 downto 0);
  d: out std_logic
);
end mux4to1;

architecture behavioral of mux4to1 is
begin
  process (s)
  begin
    if (s = "00") then
      d <= a(0);
    elsif (s = "01") then
      d <= a(1);
    elsif (s = "10") then
      d <= a(2);
    elsif (s = "11") then
      d <= a(3);
    end if;
  end process;
end behavioral;
