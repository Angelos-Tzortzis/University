library ieee;
use ieee.std_logic_1164.all;

entity flipflop_tb is
end flipflop_tb;

architecture test_bench of flipflop_tb is
signal D1, CLK1, Q1: bit;
component flipflop port(
  D: in bit;
  CLK: in bit;
  Q: out bit);
end component;

begin
  M1: flipflop port map (
    D => D1, CLK => CLK1, Q => Q1
  );
  process begin
    D1 <= '0'; CLK1 <= '0'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 200 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 300 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 200 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 300 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 200 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 50 ns;
  end process;
end test_bench;
