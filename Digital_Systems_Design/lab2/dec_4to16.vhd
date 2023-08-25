library ieee;
use ieee.std_logic_1164.all;

entity dec_4to16 is port (
  ain: in std_logic_vector(3 downto 0);
  dout: out std_logic_vector(15 downto 0)
  );
end dec_4to16;

architecture structural of dec_4to16 is
component dec_2to4_en port (
  a: in std_logic_vector(1 downto 0);
  en: in std_logic;
  d: out std_logic_vector(3 downto 0)
  );
end component;

signal enbl: std_logic_vector(3 downto 0);

begin
  m0: dec_2to4_en port map(a => ain(3 downto 2), en => '1', d => enbl);
  m1: dec_2to4_en port map(a => ain(1 downto 0), en => enbl(0), d => dout(3 downto 0));
  m2: dec_2to4_en port map(a => ain(1 downto 0), en => enbl(1), d => dout(7 downto 4));
  m3: dec_2to4_en port map(a => ain(1 downto 0), en => enbl(2), d => dout(11 downto 8));
  m4: dec_2to4_en port map(a => ain(1 downto 0), en => enbl(3), d => dout(15 downto 12));
end structural;
