library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_COMPLEX_MULTIPLIER_12 is
end entity TB_COMPLEX_MULTIPLIER_12;

architecture TB_COMPLEX_MULTIPLIER_12_ARCH of TB_COMPLEX_MULTIPLIER_12 is
    component COMPLEX_MULTIPLIER_12 is
        port(
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_MULTIPLIER_12;
    
    signal op1 : complex12;
    signal op2 : complex12;
    signal res : complex12;
begin
    A: COMPLEX_MULTIPLIER_12 port map(op1 => op1, op2 => op2, res => res);

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    op1.c <= '0';
	op2.c <= '0';
	
	-- ===== TEST 1 ===== (3+6i)*(1+4i) = -21+18i	
    op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(3*128, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(6*128, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(1*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(21*128, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(18*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 2 ===== (-2+6i)*(8+0i) = -16+48i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(2*128, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(6*128, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(8*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(16*128, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(48*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 2";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 3 ===== (-4-7i)*(4+2i) = -2-36i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(7*128, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(2*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(2*128, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(36*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 3";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 4 ===== (-5-0i)*(-8+4i) = 40-20i
    op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(5*128, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(8*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(40*128, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(20*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 4";
	end if;
	total := total +1;
    wait for 50 ns;
	
	-- ===== TEST 5 ===== (-5-7i)*(-4-2i) = 6+38i
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(5*128, op1.l.m'length));
    op1.r.s <= '1';
    op1.r.m <= std_logic_vector(to_unsigned(7*128, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    op2.r.s <= '1';
    op2.r.m <= std_logic_vector(to_unsigned(2*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(6*128, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(38*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 5";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 6 ===== (0+0i)*(-4+55i) = 0+0i
	op1.l.s <= '0';
    op1.l.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    
    op2.l.s <= '1';
    op2.l.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(55*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(0*128, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(0*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 6";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 7 ===== (-4+55i)*(0+0i) = 0+0i
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(4*128, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(55*128, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(0*128, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(0*128, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(0*128, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 7";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 8 ===== (-0,3515625+0,34375i)*(0,28125+1,75i) = -0.700439453125000 - 0.518554687500000i
    op1.c <= '0';
	op2.c <= '0';
    
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(45, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(44, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(36, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(224, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(89, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(66, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 8";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- COMPLEXITIES
    -- ===== TEST 9 ===== (-0,3515625i+0,34375)*(0,28125+1,75i) = -0.71191 +    0.50269i
    op1.c <= '1';
	op2.c <= '0';
    
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(45, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(44, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(36, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(224, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(90, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(65, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 9";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 10 ===== (-0,3515625+0,34375i)*(0,28125i+1,75) = -0.71191 +    0.50269i
    op1.c <= '0';
	op2.c <= '1';
    
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(45, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(44, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(36, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(224, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='1' and res.l.m=std_logic_vector(to_unsigned(90, res.l.m'length))
	    and res.r.s='0' and res.r.m=std_logic_vector(to_unsigned(65, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 10";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 11 ===== (-0,3515625i+0,34375)*(0,28125i+1,75) = 0.70044 -    0.51855i
    op1.c <= '1';
	op2.c <= '1';
    
	op1.l.s <= '1';
    op1.l.m <= std_logic_vector(to_unsigned(45, op1.l.m'length));
    op1.r.s <= '0';
    op1.r.m <= std_logic_vector(to_unsigned(44, op1.l.m'length));
    
    op2.l.s <= '0';
    op2.l.m <= std_logic_vector(to_unsigned(36, op1.l.m'length));
    op2.r.s <= '0';
    op2.r.m <= std_logic_vector(to_unsigned(224, op1.l.m'length));
    wait for 50 ns;
	if res.l.s='0' and res.l.m=std_logic_vector(to_unsigned(89, res.l.m'length))
	    and res.r.s='1' and res.r.m=std_logic_vector(to_unsigned(66, res.l.m'length)) then
		test := test +1;
	else
		report "FAILED 11";
	end if;
	total := total +1;
    wait for 50 ns;
    

	-- ========== PRINT RESULTS ==========
	report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end TB_COMPLEX_MULTIPLIER_12_ARCH;
