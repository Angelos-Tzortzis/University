library ieee;
use ieee.std_logic_1164.all;

entity reg8_tb is
end reg8_tb;

architecture test_bench of reg8_tb is
signal D1, Q1: std_logic_vector(3 downto 0);
signal Resetn1, Clock1: std_logic;
component reg8 port (
  D: in std_logic_vector(3 downto 0);
  Resetn, Clock: in std_logic;
  Q: out std_logic_vector(3 downto 0)
);
end component;

begin
  M1: reg8 port map (D => D1, Q => Q1, Resetn => Resetn1, Clock => Clock1);
  process begin
    Clock1 <= '0'; D1 <= "0010"; Resetn1 <= '1'; wait for 10 ps;
    Clock1 <= '1'; D1 <= "0010"; Resetn1 <= '1'; wait for 10 ps;
    Clock1 <= '0'; D1 <= "1110"; Resetn1 <= '1'; wait for 10 ps;
    Clock1 <= '1'; D1 <= "1110"; Resetn1 <= '1'; wait for 10 ps;
    Clock1 <= '0'; D1 <= "1010"; Resetn1 <= '1'; wait for 10 ps;
    Clock1 <= '1'; D1 <= "1010"; Resetn1 <= '1'; wait for 10 ps;
  end process;
end test_bench;
