LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity flipflop is port(
  D: in bit;
  CLK: in bit;
  Q: out bit
);
end flipflop;

architecture behavioral of flipflop is
begin
myflipflop: process(CLK)
  begin
    if (CLK'event and CLK = '1') then
      Q <= D;
    end if;
  end process;
end behavioral;
