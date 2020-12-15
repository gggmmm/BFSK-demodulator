library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity TB_BUTTERFLY_4_TW is
end entity TB_BUTTERFLY_4_TW;

architecture TB_BUTTERFLY_4_TW_ARCH of TB_BUTTERFLY_4_TW is
    component butterfly_4_TW is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            start2 : in std_logic;
            op0 : in complex12;
            op1 : in complex12;
            op2 : in complex12;
            op3 : in complex12;
            res0 : out complex12;
            res1 : out complex12;
            res2 : out complex12;
            res3 : out complex12
        );
    end component butterfly_4_TW;
    
    signal clock : std_logic := '0';
    signal reset : std_logic;
    signal start : std_logic;
    signal start2 : std_logic;
    signal op0 : complex12;
    signal op1 : complex12;
    signal op2 : complex12;
    signal op3 : complex12;
    signal res0 : complex12;
    signal res1 : complex12;
    signal res2 : complex12;
    signal res3 : complex12;
begin
    B: butterfly_4_tw port map(
        clock => clock,
        reset => reset,
        start => start,
        start2 => start2,
        op0 => op0,
        op1 => op1,
        op2 => op2,
        op3 => op3,
        res0 => res0,
        res1 => res1,
        res2 => res2,
        res3 => res3
    );
    
    clock <= not clock after 10 ns;

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    
    start <= '0';
    start2 <= '0';
    
    reset <= '1';
    wait for 50 ns;
    reset <= '0';
	
	-- ===== TEST 1 =====
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(1*128,op0.r.m'length)); op0.r.s <= '0'; op0.r.m <= std_logic_vector(to_unsigned(0,op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(2*128,op1.r.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(3*128,op2.r.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(4*128,op3.r.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m= std_logic_vector(to_unsigned(128,op0.r.m'length))    and res0.r.s='1' and res0.r.m= std_logic_vector(to_unsigned(384,op0.r.m'length)) and
	        res1.l.s='1' and res1.l.m= std_logic_vector(to_unsigned(181,op1.r.m'length))    and res1.r.s='1' and res1.r.m= std_logic_vector(to_unsigned(543,op1.r.m'length)) and
	        res2.l.s='0' and res2.l.m= std_logic_vector(to_unsigned(128,op2.r.m'length))    and res2.r.s='0' and res2.r.m= std_logic_vector(to_unsigned(384,op2.r.m'length)) and
	        res3.l.s='0' and res3.l.m= std_logic_vector(to_unsigned(543,op3.r.m'length))    and res3.r.s='0' and res3.r.m= std_logic_vector(to_unsigned(181,op3.r.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 2 =====
    
    -- ===== INPUT =====
    --  0.728250001826079 + 1.00391836847305i
    --  0.910846857843460 - 0.659739961761865i
    -- -0.658975755475809 - 0.709758034785561i
    -- -1.33181094914586  - 0.439874977626711i
    
    --  93  + 128 i
    --  116 -  84 i
    -- -84  -  90 i
    -- -170 -  56 i
    
    -- ===== OUTPUT =====
    --  0.89567 + 1.8848 i
    --  1.9366  + 0.086409 i
    -- -0.45323 - 0.37002 i
    -- -1.1973  - 0.035376 i
    
	op0.c <= '0'; op0.l.s <= '0'; op0.r.s <= '0'; 
	op0.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.728250001826079*128)),op0.r.m'length)); op0.r.m <= std_logic_vector(to_unsigned(Integer(floor(1.00391836847305*128)),op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.r.s <= '1'; 
	op1.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.910846857843460*128)),op1.r.m'length)); op1.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.659739961761865*128)),op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '1'; op2.r.s <= '1'; 
	op2.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.658975755475809*128)),op2.r.m'length)); op2.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.709758034785561*128)),op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '1'; op3.r.s <= '1'; 
	op3.l.m <= std_logic_vector(to_unsigned(Integer(floor(1.33181094914586*128)),op3.r.m'length)); op3.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.439874977626711*128)),op3.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(3, res0.l.m'length))     and res0.r.s='0' and res0.r.m=std_logic_vector(to_unsigned(212, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(104, res1.l.m'length))   and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(18, res1.r.m'length)) and
	        res2.l.s='0' and res2.l.m=std_logic_vector(to_unsigned(183, res2.l.m'length))   and res2.r.s='0' and res2.r.m=std_logic_vector(to_unsigned(44, res2.r.m'length)) and
	        res3.l.s='1' and res3.l.m=std_logic_vector(to_unsigned(58, res3.l.m'length))    and res3.r.s='1' and res3.r.m=std_logic_vector(to_unsigned(300, res3.r.m'length)) then
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

end TB_BUTTERFLY_4_TW_ARCH;
