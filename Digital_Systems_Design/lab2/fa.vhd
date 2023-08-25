library ieee;
use ieee.std_logic_1164.all;

entity fa is port (
  a, b, cin: in bit;
  s, cout: out bit
);
end fa;

architecture dataflow of fa is
begin
  s <= (a xor b) xor cin;
  cout <= ((a xor b) and cin) or (a and b);
end dataflow;
