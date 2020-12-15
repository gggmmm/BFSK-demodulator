-- This module receives as input a complex number with FP representation of both
-- real and imag as 5|7 (integer|fractionary). It returns its magnitude with FP
-- representation 5|5, therefore, when viewing the output in modelsim, the result 
-- (if expressed with unsigned), has to be divided by 32.

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity magnitude_grz is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in complex12;
        start   : in std_logic;
        output  : out std_logic_vector(5 downto 0) := (others => '0');
        done    : out std_logic := '0'
    );
end entity magnitude_grz;

architecture magnitude_grz_arch of magnitude_grz is
    component square12bit is port
	    (
		    dataa		: in std_logic_vector (11 downto 0);
		    result		: out std_logic_vector (23 downto 0)
	    );
    end component square12bit;
        
    component sqrt11 is
	port
	(
		radical		: in std_logic_vector (10 downto 0);
		q		    : out std_logic_vector (5 downto 0);
		remainder	: out std_logic_vector (6 downto 0)
	);
    end component sqrt11;
    
    -- WIRES    
    signal OUT_square1  : std_logic_vector(23 downto 0) := (others => '0');
    signal OUT_square2  : std_logic_vector(23 downto 0) := (others => '0');
    signal OUT_add      : std_logic_vector(19 downto 0) := (others => '0');
    signal OUT_sqrt     : std_logic_vector(5 downto 0)  := (others => '0');
    
    -- REGS
    signal REG_square1  : std_logic_vector(10 downto 0) := (others => '0');
    signal REG_square2  : std_logic_vector(10 downto 0) := (others => '0');
    signal REG_add      : std_logic_vector(10 downto 0) := (others => '0');
    signal REG_sqrt     : std_logic_vector(5 downto 0)  := (others => '0');
    
    -- FSM
    signal cs, ns, ps : std_logic_vector(1 downto 0) := "00";
    signal tmpAdd : std_logic_vector(10 downto 0);
begin
    square1 : square12bit port map( dataa => input.l.m, result => OUT_square1 );
    square2 : square12bit port map( dataa => input.r.m, result => OUT_square2 );
    sqrt    : sqrt11   port map( radical => REG_add, q => OUT_sqrt, remainder => open);
    
    -- OUTPUT
    done <= '1' when cs="00" and ps="11" else '0';
    output <= REG_sqrt when cs="00" and ps="11" else (others => '0');

    next_state : process(start, cs) begin
        ns <= cs;
        case cs is
            when "00" =>
                if start = '1' then
                    ns <= "01";
                end if;
            when "01" => ns <= "10";
            when "10" => ns <= "11";
            when "11" => ns <= "00";
            when others => null;
        end case;
    end process;
    
    current_state : process(clock, reset, ns, cs) begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= "00";  
                ps <= "00";             
            else
                cs <= ns;
                ps <= cs;             
            end if;
        end if;
    end process;
    
    tmpAdd <= std_logic_vector(unsigned(REG_square1)+unsigned(REG_square2));
    
    -- registers update
    process(clock, reset, OUT_square1, OUT_square2, OUT_add, OUT_sqrt, cs) begin
        if rising_edge(clock) then
            if reset='1' then
                REG_square1 <= (others => '0');
                REG_square2 <= (others => '0');
                REG_add <= (others => '0');
                REG_sqrt <= (others => '0');
            else
                if cs="01" then
                    REG_square1 <= OUT_square1(18 downto 8);
                    REG_square2 <= OUT_square2(18 downto 8);
                elsif cs="10" then
                    REG_add <= tmpAdd;
                elsif cs="11" then
                    REG_sqrt <= OUT_sqrt;
                end if;
            end if;
        end if;
    end process;
    
end magnitude_grz_arch;
