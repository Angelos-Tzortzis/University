library ieee;
use ieee.std_logic_1164.all;

entity ha_tb is
end ha_tb;

architecture test_bench of ha_tb is
signal A1, B1, C1, S1: bit;
component ha port(
  a, b: in bit;
  s, c: out bit
);
end component;

begin
  M1: ha port map(a => A1, b => B1, c => C1, s => S1);
  process begin
    A1 <= '0'; B1 <='0'; wait for 10 ps;
    A1 <= '0'; B1 <='1'; wait for 10 ps;
    A1 <= '1'; B1 <='0'; wait for 10 ps;
    A1 <= '1'; B1 <='1'; wait for 10 ps;
  end process;
end test_bench;
