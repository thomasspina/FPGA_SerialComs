----------------------------------------------------------------------------------
-- 
-- top.vhd
--
-- don't forget to finish header
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Port (
        clk  : in std_logic;
        sw   : in std_logic;
        led  : out std_logic;
        RsRx : in std_logic;
        RsTx : out std_logic
    );
end top;

architecture arch of top is

signal reset : std_logic;


begin


process(sw) is 
begin
    if (sw = '1') then
        led <= '1';
    else
        led <= '0';
    end if;
end process;

end arch;
