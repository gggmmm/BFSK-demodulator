library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_BUTTERFLY_4_N is
end entity TB_BUTTERFLY_4_N;

architecture TB_BUTTERFLY_4_N_ARCH of TB_BUTTERFLY_4_N is
    component butterfly_4_n is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            op1 : in complex12;
            op2 : in complex12;
            op3 : in complex12;
            op4 : in complex12;
            res1 : out complex12;
            res2 : out complex12;
            res3 : out complex12;
            res4 : out complex12
        );
    end component butterfly_4_n;
    
    signal clock : std_logic := '0';
    signal reset : std_logic;
    signal start : std_logic;
    signal op1 : complex12;
    signal op2 : complex12;
    signal op3 : complex12;
    signal op4 : complex12;
    signal res1 : complex12;
    signal res2 : complex12;
    signal res3 : complex12;
    signal res4 : complex12;
begin
    B: butterfly_4_n port map(
        clock => clock,
        reset => reset,
        start => start,
        op1 => op1,
        op2 => op2,
        op3 => op3,
        op4 => op4,
        res1 => res1,
        res2 => res2,
        res3 => res3,
        res4 => res4
    );
    
    clock <= not clock after 10 ns;

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    
    start <= '0';
    reset <= '1';
    wait for 50 ns;
    reset <= '0';
	
	-- ===== TEST 1 =====
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(1,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(2,op2.l.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(3,op3.l.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '0'; op4.l.m <= std_logic_vector(to_unsigned(4,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(0,op4.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	
    wait for 70 ns;
	if      res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(4, res1.l.m'length)) and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(0, res1.r.m'length)) and
	        res2.l.s='0' and res2.l.m=std_logic_vector(to_unsigned(6, res2.l.m'length)) and res2.r.s='0' and res2.r.m=std_logic_vector(to_unsigned(0, res2.r.m'length)) and
	        res3.l.s='1' and res3.l.m=std_logic_vector(to_unsigned(2, res3.l.m'length)) and res3.r.s='0' and res3.r.m=std_logic_vector(to_unsigned(0, res3.r.m'length)) and
	        res4.l.s='1' and res4.l.m=std_logic_vector(to_unsigned(2, res4.l.m'length)) and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(0, res4.r.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 2 =====
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(1,op1.l.m'length)); op1.r.s <= '1'; op1.r.m <= std_logic_vector(to_unsigned(5,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(2,op2.l.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(5,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(3,op3.l.m'length)); op3.r.s <= '1'; op3.r.m <= std_logic_vector(to_unsigned(2,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '0'; op4.l.m <= std_logic_vector(to_unsigned(4,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(1,op4.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	
    wait for 70 ns;
	if      res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(4, res1.l.m'length)) and res1.r.s='1' and res1.r.m=std_logic_vector(to_unsigned(7, res1.r.m'length)) and
	        res2.l.s='0' and res2.l.m=std_logic_vector(to_unsigned(6, res2.l.m'length)) and res2.r.s='0' and res2.r.m=std_logic_vector(to_unsigned(6, res2.r.m'length)) and
	        res3.l.s='1' and res3.l.m=std_logic_vector(to_unsigned(2, res3.l.m'length)) and res3.r.s='1' and res3.r.m=std_logic_vector(to_unsigned(3, res3.r.m'length)) and
	        res4.l.s='1' and res4.l.m=std_logic_vector(to_unsigned(2, res4.l.m'length)) and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(4, res4.r.m'length)) then
		test := test +1;
	else
		report "FAILED 2";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ========== PRINT RESULTS ==========
	report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end TB_BUTTERFLY_4_N_ARCH;
