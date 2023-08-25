library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity adder4 is port (
  cin: in std_logic;
  a, b: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(3 downto 0);
  cout: out std_logic
);
end adder4;

architecture dataflow of adder4 is
signal sum: std_logic_vector(4 downto 0);
begin
  sum <= ('0' & a) + b + cin;
  s <= sum(3 downto 0);
  cout <= sum(4);
end dataflow;
