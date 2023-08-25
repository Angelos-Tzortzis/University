library ieee;
use ieee.std_logic_1164.all;

entity latch_testbench is
end latch_testbench;

architecture test_bench of latch_testbench is
signal D1, EN1, Q1: bit;
component latch port(
  D: in bit;
  EN: in bit;
  Q: out bit);
end component;

begin
  M1: latch port map (
    D => D1, EN => EN1, Q => Q1
  );
  process begin
    D1 <= '0'; EN1 <= '0'; wait for 125 ns;
    D1 <= '1'; EN1 <= '0'; wait for 125 ns;
    D1 <= '1'; EN1 <= '1'; wait for 150 ns;
    D1 <= '1'; EN1 <= '0'; wait for 100 ns;
    D1 <= '0'; EN1 <= '0'; wait for 150 ns;
    D1 <= '0'; EN1 <= '1'; wait for 150 ns;
    D1 <= '0'; EN1 <= '0'; wait for 100 ns;
    D1 <= '1'; EN1 <= '0'; wait for 150 ns;
    D1 <= '1'; EN1 <= '1'; wait for 75 ns;
    D1 <= '0'; EN1 <= '1'; wait for 75 ns;
    D1 <= '0'; EN1 <= '0'; wait for 100 ns;
    D1 <= '1'; EN1 <= '0'; wait for 50 ns;
    D1 <= '0'; EN1 <= '0'; wait for 100 ns;
    D1 <= '0'; EN1 <= '1'; wait for 75 ns;
    D1 <= '1'; EN1 <= '1'; wait for 75 ns;
  end process;
end test_bench;
