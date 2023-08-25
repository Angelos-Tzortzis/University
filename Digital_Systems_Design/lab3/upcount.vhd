library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity upcount is port (
  Clear, Clock: in std_logic;
  Q : OUT std_logic_vector(1 downto 0)) ;
end upcount;

architecture behavioral of upcount is
signal Count: std_logic_vector(1 downto 0);
begin
upcount: process (Clock)
begin
  if rising_edge(Clock) then
    if Clear = '1' then
      Count <= "00" ;
    else
      Count <= Count + 1 ;
    end if;
  end if;
end process;
Q <= Count;
end behavioral;
