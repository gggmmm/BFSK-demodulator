library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity R is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        
        max_val_odd         : in std_logic_vector(8 downto 0);
        max_val_even        : in std_logic_vector(8 downto 0);
        val_even_index_odd  : in std_logic_vector(8 downto 0);
        val_odd_index_even  : in std_logic_vector(8 downto 0);
        
        done        : out std_logic := '0';
        result      : out std_logic_vector(8 downto 0)
    );
end entity R;

architecture R_arch of R is
    signal o, e : std_logic_vector(8 downto 0);
    signal REG_result : std_logic_vector(8 downto 0);
    signal cs, ns, ps : std_logic := '0';
begin
    process(clock, reset, ns, cs)
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
    
    process(start, cs)
    begin
        ns <= cs;
        case cs is
            when '0' => if start='1' then
                            ns <= '1';
                        end if;
            when '1' => ns <= '0';
            when others => null;
        end case;
    end process;
    
    process(clock, reset, o, e, cs)
    begin
        if rising_edge(clock) then
            if reset ='1' then
                REG_result <= (others => '0');
            elsif cs='1' then
                REG_result <= std_logic_vector( unsigned(o) + unsigned(e) );
            end if;
        end if;
    end process;

    o <= std_logic_vector( unsigned(max_val_odd) - unsigned(val_odd_index_even) );
    e <= std_logic_vector( unsigned(max_val_even) - unsigned(val_even_index_odd) );
    result <= REG_result;
    
    done <= '1' when cs='0' and ps='1' else '0';
end R_arch;
