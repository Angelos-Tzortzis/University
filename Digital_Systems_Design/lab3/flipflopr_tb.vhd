library ieee;
use ieee.std_logic_1164.all;

entity flipflopr_tb is
end flipflopr_tb;

architecture test_bench of flipflopr_tb is
signal D1, CLK1, Q1, Rstn1: bit;
component flipflop_reset port(
  D: in bit;
  CLK: in bit;
  Rstn: in bit;
  Q: out bit);
end component;

begin
  M1: flipflop_reset port map (
    D => D1, CLK => CLK1, Q => Q1, Rstn => Rstn1
  );
  process begin
    Rstn1 <= '1';
    D1 <= '0'; CLK1 <= '0'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 200 ns;
    D1 <= '1'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '0'; Rstn1 <= '0'; wait for 300 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 200 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '1'; CLK1 <= '0'; Rstn1 <= '1'; wait for 300 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '0'; Rstn1 <= '0'; wait for 100 ns;
    D1 <= '1'; CLK1 <= '0'; Rstn1 <= '0'; wait for 200 ns;
    D1 <= '0'; CLK1 <= '0'; wait for 100 ns;
    D1 <= '0'; CLK1 <= '1'; wait for 50 ns;
    D1 <= '1'; CLK1 <= '1'; wait for 50 ns;
  end process;
end test_bench;
