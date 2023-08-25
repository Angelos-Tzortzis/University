library ieee;
use ieee.std_logic_1164.all;

entity fa_tb is
end fa_tb;

architecture test_bench of fa_tb is
signal A1, B1, CIN1, COUT1, S1: bit;
component fa port(
  a, b, cin: in bit;
  s, cout: out bit
);
end component;

begin
  M1: fa port map(a => A1, b => B1, cin => CIN1, cout => COUT1, s => S1);
  process begin
    A1 <= '0'; B1 <='0'; CIN1 <= '0'; wait for 10 ps;
    A1 <= '0'; B1 <='0'; CIN1 <= '1'; wait for 10 ps;
    A1 <= '0'; B1 <='1'; CIN1 <= '0'; wait for 10 ps;
    A1 <= '0'; B1 <='1'; CIN1 <= '1'; wait for 10 ps;
    A1 <= '1'; B1 <='0'; CIN1 <= '0'; wait for 10 ps;
    A1 <= '1'; B1 <='0'; CIN1 <= '1'; wait for 10 ps;
    A1 <= '1'; B1 <='1'; CIN1 <= '0'; wait for 10 ps;
    A1 <= '1'; B1 <='1'; CIN1 <= '1'; wait for 10 ps;
  end process;
end test_bench;
