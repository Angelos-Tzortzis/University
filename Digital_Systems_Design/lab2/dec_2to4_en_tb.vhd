library ieee;
use ieee.std_logic_1164.all;

entity dec_2to4_en_tb is
end dec_2to4_en_tb;

architecture test_bench of dec_2to4_en_tb is
signal A1: std_logic_vector(1 downto 0);
signal EN1: std_logic;
signal D1: std_logic_vector(3 downto 0);
component dec_2to4_en port (
  a: in std_logic_vector(1 downto 0);
  en: in std_logic;
  d: out std_logic_vector(3 downto 0)
);
end component;

signal ENA1: std_logic_vector(2 downto 0);

begin
  M1: dec_2to4_en port map (a => A1, d => D1, en => EN1);
  ENA1 <= EN1 & A1;
  process begin
    A1 <= "00"; EN1 <= '0'; wait for 10 ps;
    A1 <= "01"; EN1 <= '0'; wait for 10 ps;
    A1 <= "10"; EN1 <= '0'; wait for 10 ps;
    A1 <= "11"; EN1 <= '0'; wait for 10 ps;
    A1 <= "00"; EN1 <= '1'; wait for 10 ps;
    A1 <= "01"; EN1 <= '1'; wait for 10 ps;
    A1 <= "10"; EN1 <= '1'; wait for 10 ps;
    A1 <= "11"; EN1 <= '1'; wait for 10 ps;
  end process;
end test_bench;
