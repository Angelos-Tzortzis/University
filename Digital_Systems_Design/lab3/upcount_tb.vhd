library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test_upcount is
end test_upcount;

architecture test_b of test_upcount is
signal CLR1, CLK1: std_logic;
signal Q1: std_logic_vector(1 downto 0);
component upcount port (
Clear, Clock: in std_logic;
Q: out std_logic_vector(1 downto 0));
end component;

begin
M1: upcount port map(Clear => CLR1, Clock => CLK1, Q => Q1);
process
begin
  CLK1 <= '0'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '1'; CLR1 <= '1'; wait for 10 ns;
  CLK1 <= '0'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '1'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '0'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '1'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '0'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '1'; CLR1 <= '0'; wait for 10 ns;
  CLK1 <= '0'; CLR1 <= '1'; wait for 10 ns;
  CLK1 <= '1'; CLR1 <= '1'; wait for 10 ns;
end process;
end test_b;
