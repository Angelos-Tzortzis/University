library ieee;
use ieee.std_logic_1164.all;

entity shift4_tb is
end shift4_tb;

architecture test_bench of shift4_tb is
signal D1, Q1: std_logic_vector(3 downto 0);
signal Enable1, Sin1, Clock1: std_logic;
component shift4 port(
  D: in std_logic_vector (3 downto 0);
  Enable: in std_logic;
  Sin: in std_logic;
  Clock: in std_logic;
  Q: out std_logic_vector(3 downto 0)
);
end component;

begin
  M1: shift4 port map (
    D => D1,
    Enable => Enable1,
    Sin => Sin1,
    Clock => Clock1,
    Q => Q1);
  process begin
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '0'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '0'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '0'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    Clock1 <= '1'; Sin1 <= '1'; Enable1 <= '1'; wait for 10 ns;
    
  end process;
end test_bench;
