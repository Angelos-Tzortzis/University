library ieee;
use ieee.std_logic_1164.all;

entity dec_2to4_tb is
end dec_2to4_tb;

architecture test_bench of dec_2to4_tb is
signal A1: std_logic_vector(1 downto 0);
signal D1: std_logic_vector(3 downto 0);
component dec_2to4 port (
  a: in std_logic_vector(1 downto 0);
  d: out std_logic_vector(3 downto 0)
);
end component;

begin
  M1: dec_2to4 port map (a => A1, d => D1);
  process begin
    A1 <= "00"; wait for 10 ps;
    A1 <= "01"; wait for 10 ps;
    A1 <= "10"; wait for 10 ps;
    A1 <= "11"; wait for 10 ps;
  end process;
end test_bench;
