library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity max_of_Rs is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        
        R0  : in std_logic_vector(8 downto 0);
        R1  : in std_logic_vector(8 downto 0);
        R2  : in std_logic_vector(8 downto 0);
        R3  : in std_logic_vector(8 downto 0);
        R4  : in std_logic_vector(8 downto 0);
        R5  : in std_logic_vector(8 downto 0);
        R6  : in std_logic_vector(8 downto 0);
        R7  : in std_logic_vector(8 downto 0);
        
        done        : out std_logic := '0';
        result      : out std_logic_vector(2 downto 0)
    );
end entity max_of_Rs;

architecture max_of_Rs_arch of max_of_Rs is
    signal cs, ns, ps   : std_logic_vector(1 downto 0) := (others => '0');
    
    type array_8_slv_12 is array (0 to 7) of std_logic_vector(8 downto 0);
    signal input_array : array_8_slv_12;
        
    signal tmp_max_value, tmv : std_logic_vector(8 downto 0) := (others => '0');
    signal tmp_max_index, tmi : std_logic_vector(2 downto 0) := (others => '0');
begin
    process(R0, R1, R2, R3, R4, R5, R6, R7)
    begin
        input_array(0) <= R0;
        input_array(1) <= R1;
        input_array(2) <= R2;
        input_array(3) <= R3;
        input_array(4) <= R4;
        input_array(5) <= R5;
        input_array(6) <= R6;
        input_array(7) <= R7;
    end process;

    --process(input_array, cs, tmv, tmi)
    --begin
    --    if cs="01" then
    --        for i in 0 to 7 loop
    --            if unsigned(input_array(i)) > unsigned(tmv) then
    --                tmv <= input_array(i);
    --                tmi <= std_logic_vector(to_unsigned(i, tmi'length));
    --            end if;
    --        end loop;
    --    else
    --        tmv <= (others => '0');
    --        tmi <= (others => '0');
    --   end if;
    --end process;
    
    process(input_array, cs)
      variable tmvi : std_logic_vector(8 downto 0);
      variable tmii : std_logic_vector(2 downto 0);
    begin
        if cs="01" then
            tmvi := (others => '0');
            tmii := (others => '0');
            for i in 0 to 7 loop
                if unsigned(input_array(i)) > unsigned(tmvi) then
                    tmvi := input_array(i);
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
    
    result <= tmp_max_index;
    
end max_of_Rs_arch;
