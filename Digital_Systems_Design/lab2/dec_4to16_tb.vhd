library ieee;
use ieee.std_logic_1164.all;

entity dec_4to16_tb is
end dec_4to16_tb;

architecture test_bench of dec_4to16_tb is
signal A1: std_logic_vector(4 downto 1);
signal D1: std_logic_vector(16 downto 1);
component dec_4to16 port (
  ain: in std_logic_vector(4 downto 1);
  dout: out std_logic_vector(16 downto 1)
);
end component;

begin
  M1: dec_4to16 port map (ain => A1, dout => D1);
  process begin
    A1 <= "0000"; wait for 8 ps;
    A1 <= "0001"; wait for 8 ps;
    A1 <= "0010"; wait for 8 ps;
    A1 <= "0011"; wait for 8 ps;
    A1 <= "0100"; wait for 8 ps;
    A1 <= "0101"; wait for 8 ps;
    A1 <= "0110"; wait for 8 ps;
    A1 <= "0111"; wait for 8 ps;
    A1 <= "1000"; wait for 8 ps;
    A1 <= "1001"; wait for 8 ps;
    A1 <= "1010"; wait for 8 ps;
    A1 <= "1011"; wait for 8 ps;
    A1 <= "1100"; wait for 8 ps;
    A1 <= "1101"; wait for 8 ps;
    A1 <= "1110"; wait for 8 ps;
    A1 <= "1111"; wait for 8 ps;
  end process;
end test_bench;
