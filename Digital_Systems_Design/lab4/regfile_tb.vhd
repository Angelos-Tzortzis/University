library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity regfile_tb is
generic (
  dw : natural := 4;
  size : natural := 4;
  adrw : natural := 2);
end regfile_tb;

architecture test_b of regfile_tb is
signal WE1, CLK1, RESET1: std_logic;
signal A1, C1, B1: std_logic_vector (dw-1 downto 0);
signal RADDR11, RADDR21, WADDR1: std_logic_vector (adrw-1 downto 0);
component regfile port (
  A : in std_logic_vector(dw-1 downto 0);
  rAddr1 : in std_logic_vector(adrw-1 downto 0);
  rAddr2 : in std_logic_vector(adrw-1 downto 0);
  wAddr : in std_logic_vector(adrw-1 downto 0);
  we : in std_logic;
  clk : in std_logic;
  reset: in std_logic;
  B: out std_logic_vector(dw-1 downto 0);
  C : out std_logic_vector(dw-1 downto 0)
);
end component;

begin
M1: regfile port map (
  A => A1,
  rAddr1 => RADDR11,
  rAddr2 => RADDR21,
  wAddr => WADDR1,
  we => WE1,
  clk => clk1,
  reset => RESET1,
  B => B1,
  C => C1);
process
begin
  reset1 <= '0'; clk1 <='1'; wait for 10 ns;
  reset1 <= '1'; clk1 <='0'; wait for 10 ns;
  reset1 <= '0'; wait for 10 ns;
  A1 <= "0101"; wAddr1 <= "00"; we1 <= '1'; clk1 <= '1'; wait for 10 ns;
  A1 <= "0101"; wAddr1 <= "00"; we1 <= '1'; clk1 <= '0'; wait for 10 ns;
  A1 <= "1010"; wAddr1 <= "01"; we1 <= '1'; clk1 <= '1'; wait for 10 ns;
  A1 <= "1010"; wAddr1 <= "01"; we1 <= '1'; clk1 <= '0'; wait for 10 ns;
  A1 <= "0000"; wAddr1 <= "10"; we1 <= '1'; clk1 <= '1'; wait for 10 ns;
  A1 <= "0000"; wAddr1 <= "10"; we1 <= '1'; clk1 <= '0'; wait for 10 ns;
  A1 <= "1111"; wAddr1 <= "11"; we1 <= '1'; clk1 <= '1'; wait for 10 ns;
  A1 <= "1111"; wAddr1 <= "11"; we1 <= '1'; clk1 <= '0'; wait for 10 ns;
  A1 <= "1100"; rAddr11 <= "00"; rAddr21 <= "10"; we1 <= '0'; clk1 <= '1'; wait for 10 ns;
  A1 <= "1100"; rAddr11 <= "00"; rAddr21 <= "10"; we1 <= '0'; clk1 <= '0'; wait for 10 ns;
  A1 <= "1100"; rAddr11 <= "01"; rAddr21 <= "11"; we1 <= '0'; clk1 <= '1'; wait for 10 ns;
  A1 <= "1100"; rAddr11 <= "01"; rAddr21 <= "11"; we1 <= '0'; clk1 <= '0'; wait for 10 ns;
end process;
end test_b;
