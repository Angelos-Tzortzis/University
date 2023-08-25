library ieee;
use ieee.std_logic_1164.all;

entity dec_2to4_en is port (
  a: in std_logic_vector(1 downto 0);
  en: in std_logic;
  d: out std_logic_vector(3 downto 0)
);
end dec_2to4_en;

architecture dataflow of dec_2to4_en is
signal ena: std_logic_vector(2 downto 0);
begin
  ena <= en & a;
  with ena select
  d <= "0001" when "100",
  "0010" when "101",
  "0100" when "110",
  "1000" when "111",
  "0000" when others;
end dataflow;
