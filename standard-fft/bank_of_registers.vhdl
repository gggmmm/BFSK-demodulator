library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity bank_of_registers is
    generic(
        N : natural -- number of registers
    );
    port(
        clock, reset : in std_logic;
        input        : in io_fft;
        output       : out io_fft
    );
end entity;

architecture bor_arch of bank_of_registers is
    signal bor : io_fft;
begin
    process(clock, reset, input)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to N-1 loop
                    bor(i) <= COMPLEX_ZERO12;
                end loop;
            else
                bor <= input;                
            end if;
        end if;
    end process;
    
    process(bor)
    begin
        for i in 0 to N-1 loop
            output(i) <= bor(i);
        end loop;
    end process;
end;
