----------------------------------------------------------------------------------
-- 
-- uart_tx_char.vhd
--
-- don't forget to finish the header 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx_char is
    generic (
        f_clk_ref : positive := 100e6;    -- ref clock frequency
        baud_rate : positive := 9600   
    );
    port(
        reset   : in std_logic;
        clk_ref : in std_logic;         
        char    : in character;    
        load    : in std_logic;           -- load the character
        ready   : out std_logic;          -- system is ready for a new char
        uart_tx : out std_logic       
    );
end uart_tx_char;

architecture arch of uart_tx_char is

constant clk_ratio   : natural := f_clk_ref / baud_rate;

constant start_bit   : std_logic := '0'; 
constant stop_bit    : std_logic := '1'; 
constant n_data_bits : positive  := 8;   

signal buffer_register : std_logic_vector(n_data_bits downto 0); -- register with the char data bits and the start bit

type state_type is (waiting, transmitting);
signal state : state_type := waiting;
begin
    process(all)
    variable count_bits : natural range 0 to buffer_register'length;
    variable count_clk  : natural range 0 to clk_ratio - 1;
    begin
        if reset = '1' then
            state <= waiting;
        elsif rising_edge(clk_ref) then
            case state is
                when waiting =>
                    if load = '1' then
                        count_bits := buffer_register'length;
                        buffer_register <= std_logic_vector(to_unsigned(character'pos(char), 8)) & start_bit;
                        state <= transmitting;
                        count_clk := clk_ratio - 1;
                    end if;
                when transmitting =>
                    if count_clk = 0 then
                        count_clk := clk_ratio - 1;
                        buffer_register <= stop_bit & buffer_register(8 downto 1);
                        if count_bits = 0 then
                            state <= waiting;
                        else
                            count_bits := count_bits - 1;
                        end if;
                    else
                        count_clk := count_clk - 1;
                    end if;
            end case;
        end if;
    end process;

    ready <= '1' when state = waiting else '0';
    uart_tx <= stop_bit when state = waiting else buffer_register(0);

end arch;
