library ieee;
use ieee.std_logic_1164.all;


entity shift4 is port (
  D: in std_logic_vector (3 downto 0);
  Enable: in std_logic;
  Sin: in std_logic;
  Clock: in std_logic;
  Q: out std_logic_vector(3 downto 0)
);
end shift4;

architecture behavioral of shift4 is
  signal M: std_logic_vector(3 downto 0);
begin
  process (Clock)
    begin
      if rising_edge(Clock) then
        if enable = '1' then
          M(0) <= M(1);
          M(1) <= M(2);
          M(2) <= M(3);
          M(3) <= Sin;
        end if;
      end if;
    end process;
    Q <= M;
  end behavioral;
  