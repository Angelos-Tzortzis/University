LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity flipflop_reset is port (
  D: in bit;
  CLK: in bit;
  Rstn: in bit;
  Q: out bit
);
end flipflop_reset;

architecture behavioral of flipflop_reset is
begin
myflipflopreset: process(CLK, RSTN)
  begin
    if (RSTN = '0') then
      Q <= '0';
    elsif (CLK'EVENT and CLK ='1') then
      Q <= D;
    end if;
  end process;
end behavioral;
