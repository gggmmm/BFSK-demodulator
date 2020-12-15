-- this module receives as input 6|1 values and produces as output
-- 2x64 values each 7|1. one group of 64 is for the odd, the other for the even.

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity bank_of_adders is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input1  : in input_bank_of_adders;
        input2  : in input_bank_of_adders;
        start   : in std_logic;
        
        done        : out std_logic := '0';
        output      : out output_bank_of_adders
    );
end entity bank_of_adders;

architecture bank_of_adders_arch of bank_of_adders is            
    -- FSM
    signal cs, ns, ps : std_logic := '0';
begin
    done <= '1' when cs='0' and ps='1' else '0';
    
    process(cs, start)
    begin
        ns <= cs;
        case cs is
            when '0' =>
                if start='1' then
                    ns <= '1';
                end if;
            when '1' => ns <= '0';
            when others => null;
        end case;
    end process;
    
    process(clock, reset, ns)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= '0';
                ps <= '0';
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process;
    
    -- output
    process(input1, input2, cs, ps)
    begin
        if cs='0' and ps='1' then
            for i in 0 to 63 loop
                output(i) <= std_logic_vector(unsigned(input1(i)) + unsigned(input2(i)));
            end loop;
        else
            for i in 0 to 63 loop
                output(i) <= (others => '0');
            end loop;
        end if;
    end process;
    
end bank_of_adders_arch;
