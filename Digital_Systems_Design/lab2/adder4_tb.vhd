library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder4_tb is
end adder4_tb;

architecture test_bench of adder4_tb is
signal CIN1, COUT1: std_logic;
signal A1, B1, S1: std_logic_vector(3 downto 0);
component adder4 port (
  cin: in std_logic;
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0);
  cout: out std_logic
);
end component;

begin
  M1: adder4 port map(a => A1, b => B1, cin => CIN1, cout => COUT1, s => S1);
  process begin
    A1 <= "0000"; B1 <= "0000"; CIN1 <= '0'; wait for 10 ps;
    A1 <= "1111"; B1 <= "1111"; CIN1 <= '0'; wait for 10 ps;
    A1 <= "1111"; B1 <= "1111"; CIN1 <= '1'; wait for 10 ps;
    A1 <= "0011"; B1 <= "0101"; CIN1 <= '0'; wait for 10 ps; -- 3+5
    A1 <= "1110"; B1 <= "0011"; CIN1 <= '0'; wait for 10 ps; -- -2+3
    A1 <= "1000"; B1 <= "0111"; CIN1 <= '0'; wait for 10 ps; -- -8+7
  end process;
end test_bench;