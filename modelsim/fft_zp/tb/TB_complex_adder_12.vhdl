library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_COMPLEX_ADDER_12 is
end entity TB_COMPLEX_ADDER_12;

architecture TB_COMPLEX_ADDER_12_ARCH of TB_COMPLEX_ADDER_12 is
    component COMPLEX_ADDER_12 is
        port(
            add_sub : in std_logic;
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_ADDER_12;
    
    signal add_sub : std_logic;
    signal op1 : complex12;
    signal op2 : complex12;
    signal res : complex12;
begin
    A: COMPLEX_ADDER_12 port map(add_sub => add_sub, op1 => op1, op2 => op2, res => res);

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    op1.c <= '0';
	op2.c <= '0';
	add_sub <= '0';
	
	-- ===== TEST 1 ===== (3+6i)+(1+4i) = 4+10i	
    op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(3, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(6, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(1, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(4, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(10, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 2 ===== (-2+6i)+(8+0i) = 6+6i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(2, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(6, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(8, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(6, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(6, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 2";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 3 ===== (-8-7i)+(4+4i) = -4-3i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(8, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(7, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(4, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(3, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 3";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 4 ===== (-5-0i)+(-8+4i) = -13+4i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(5, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(8, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(13, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(4, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 4";
	end if;
	total := total +1;
    wait for 50 ns;
	
	-- ===== TEST 5 ===== (-11-8i)+(-4-2i) = -15-10i
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(11, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(8, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op2.r.s <= '1';
    op2.r.m <= std_logic_vector(to_unsigned(2, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(15, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(10, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 5";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 6 ===== (0+0i)+(-4+55i) = -4+55i
	op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(4, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(55, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 6";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 7 ===== (-4+55i)+(0+0i) = -4+55i
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(0, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(4, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(55, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 7";
	end if;
	total := total +1;
    wait for 50 ns;
	
	-- SUBTRACTIONS
	-- ===== TEST 8 ===== (-4+55i)-(7+60i) = -11-5i
	add_sub <= '1';
	
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(7, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(60, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(11, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(5, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 8";
	end if;
	total := total +1;
    wait for 50 ns;
	
	-- ===== TEST 9 ===== (15+10i)-(-9-18i) = 24+28i
	op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(15, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(10, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(9, op1.l.m'length));
    op2.r.s <= '1';
    op2.r.m <= std_logic_vector(to_unsigned(18, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(24, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(28, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 9";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- COMPLEXITIES
	-- ===== TEST 10 ===== (-4i+55)+(7+60i) = 62+56i
	add_sub <= '0';
    op1.c <= '1';
	op2.c <= '0';
	
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(7, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(60, op1.l.m'length));
    wait for 50 ns;
	if      res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(62, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(56, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 10";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 11 ===== (-4i+55)+(7i+60) = 115+3i
	add_sub <= '0';
    op1.c <= '1';
	op2.c <= '1';
	
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(7, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(60, op1.l.m'length));
    wait for 50 ns;
	if      res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(115, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(3, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 11";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 12 ===== (-4+55i)+(7i+60) = 56+62i
	add_sub <= '0';
    op1.c <= '0';
	op2.c <= '1';
	
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(7, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(60, op1.l.m'length));
    wait for 50 ns;
	if      res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(56, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(62, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 12";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 13 ===== (-4+55i)+(7i+60) = 56+62i
	add_sub <= '0';
    op1.c <= '0';
	op2.c <= '0';
	
	op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(1, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(5, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(2, op1.l.m'length));
    op2.r.s <= '1';
    op2.r.m <= std_logic_vector(to_unsigned(5, op1.l.m'length));
    wait for 50 ns;
	if      res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(1, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(10, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 12";
	end if;
	total := total +1;
    wait for 50 ns;
    
	-- ========== PRINT RESULTS ==========
	report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end TB_COMPLEX_ADDER_12_ARCH;
