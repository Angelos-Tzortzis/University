library ieee;
use ieee.std_logic_1164.all;

entity register_tb is
end register_tb;

architecture test_bench of register_tb is
signal CLK1, CLEAR1: std_logic;
signal D1, Q1: std_logic_vector(3 downto 0);
component register4 port(
  D: in std_logic_vector(3 downto 0);
  CLK: in std_logic;
  CLR: in std_logic;
  Q: out std_logic_vector(3 downto 0));
end component;

begin
  M1: register4 port map (
    D => D1, CLK => CLK1, CLR => CLEAR1, Q => Q1
  );
  process begin
    D1 <= "1010"; CLK1 <= '1'; CLEAR1 <='1'; wait for 10 ns;
    D1 <= "1010"; CLK1 <= '0'; CLEAR1 <='0'; wait for 10 ns;
    D1 <= "1010"; CLK1 <= '1'; CLEAR1 <='0'; wait for 10 ns;
    D1 <= "1010"; CLK1 <= '0'; CLEAR1 <='1'; wait for 10 ns;
    D1 <= "1010"; CLK1 <= '1'; CLEAR1 <='1'; wait for 10 ns;
  end process;
end test_bench;
