library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_tb is
end mux4to1_tb;

architecture test_bench of mux4to1_tb is
signal A1: std_logic_vector(3 downto 0);
signal S1: std_logic_vector(1 downto 0);
signal D1: std_logic;
component mux4to1 port (
  a: in std_logic_vector(3 downto 0);
  s: in std_logic_vector(1 downto 0);
  d: out std_logic
);
end component;

begin
  M1: mux4to1 port map (
    a => A1, s => S1, d => D1
  );
  process begin
    A1 <= "0000"; S1 <= "00"; wait for 10 ps;
    A1 <= "0101"; S1 <= "01"; wait for 10 ps;
    A1 <= "1010"; S1 <= "10"; wait for 10 ps;
    A1 <= "1100"; S1 <= "11"; wait for 10 ps;
  end process;
end test_bench;
