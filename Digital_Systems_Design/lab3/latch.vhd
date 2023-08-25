library ieee;
use ieee.std_logic_1164.all;

entity latch is port (
  D: in bit;
  EN: in bit;
  Q: out bit
);
end latch;

architecture behavioral of latch is
begin
mylatch: process(EN, D)
  begin
    if (EN = '1') then
      Q <= D;
    end if;
  end process;
end behavioral;
