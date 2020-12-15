-- This module receives as input 64 11bit unsigned values.

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity max_finder64 is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        start   : in std_logic;
        input   : in input_max_finder64;
        
        max_index   : out std_logic_vector(5 downto 0) := (others => '0');
        max_value   : out std_logic_vector(8 downto 0) := (others => '0');
        done        : out std_logic := '0'
    );
end entity max_finder64;

architecture max_finder64_arch of max_finder64 is
    signal tmp_max_value, tmv : std_logic_vector(8 downto 0); -- := (others => '0');
    signal tmp_max_index, tmi : std_logic_vector(5 downto 0); -- := (others => '0');
    
    -- FSM
    signal cs, ns : std_logic_vector(1 downto 0) := "00";
begin
    next_state : process(start, cs) begin
        ns <= cs;
        case cs is
            when "00" =>
                if start = '1' then
                    ns <= "01";
                end if;
            when "01" => ns <= "10";
            when "10" => ns <= "00";
            when others => null;
        end case;
    end process;
    
    current_state : process(clock, reset, ns) begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= "00";             
            else
                cs <= ns;           
            end if;
        end if;
    end process;
    
    process(input, cs) --, tmv, tmi)
      variable tmvi : std_logic_vector(8 downto 0);
      variable tmii : std_logic_vector(5 downto 0);
    begin
        if cs="01" then
            tmvi := (others => '0');
            tmii := (others => '0');
            for i in 0 to 63 loop
                if unsigned(input(i)) > unsigned(tmvi) then
                    tmvi := input(i);
                    tmii := std_logic_vector(to_unsigned(i, tmii'length));
                end if;
            end loop;
        else
            tmvi := (others => '0');
            tmii := (others => '0');
        end if;
        tmv <= tmvi;
        tmi <= tmii;
    end process;
    
    process(clock, reset, cs, tmv, tmi, tmp_max_value, tmp_max_index)
    begin
        if rising_edge(clock) then
            if reset='1' or cs="10" then
                tmp_max_value <= (others => '0');
                tmp_max_index <= (others => '0');
            else
                if cs="01" then
                    tmp_max_value <= tmv;
                    tmp_max_index <= tmi;
                end if;
            end if;
        end if;
    end process;
    
    done <= '1' when cs ="10" else '0';
    
    max_index <= tmp_max_index;
    max_value <= tmp_max_value;

end max_finder64_arch;
