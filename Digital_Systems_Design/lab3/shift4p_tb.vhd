library ieee;
use ieee.std_logic_1164.all;

entity shift4p_tb is
end shift4p_tb;

architecture test_bench of shift4p_tb is
signal D1, Q1: std_logic_vector(3 downto 0);
signal Enable1, Sin1, Clock1, Load1: std_logic;
component shift4p port(
  D: in std_logic_vector (3 downto 0);
  Enable: in std_logic;
  Load: in std_logic;
  Sin: in std_logic;
  Clock: in std_logic;
  Q: out std_logic_vector(3 downto 0)
);
end component;

begin
  M1: shift4p port map (
    D => D1,
    Enable => Enable1,
    Load => Load1,
    Sin => Sin1,
    Clock => Clock1,
    Q => Q1);
  process begin
    D1 <= "1001"; Clock1 <= '0'; Load1 <= '1'; wait for 10 ns;
    D1 <= "1001"; Clock1 <= '1'; Load1 <= '1'; wait for 10 ns;
    D1 <= "1001"; Clock1 <= '0'; Load1 <= '0'; wait for 10 ns;
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
