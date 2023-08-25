LIBRARY ieee ;
USE ieee.std_logic_1164.all;

entity register4 is port (
  D: in std_logic_vector(3 downto 0);
  CLK: in std_logic;
  CLR: in std_logic;
  Q: out std_logic_vector(3 downto 0)
);
end register4;

architecture behavioral of register4 is
begin
myregister: process(CLK)
  begin
  if (CLK'EVENT and CLK = '1') then
    if CLR = '1' then
      Q <= "0000";
    else
      Q <= D;
    end if;
  end if;
end process;
end behavioral;