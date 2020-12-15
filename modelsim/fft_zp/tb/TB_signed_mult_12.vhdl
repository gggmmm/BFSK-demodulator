library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_SIGNED_MULT_12 is
end entity TB_SIGNED_MULT_12;

architecture TB_SIGNED_MULT_12_ARCH of TB_SIGNED_MULT_12 is
    component SIGNED_MULT_12 is
        generic(    L : integer := 7;
                    H : integer := 18
        );
        port(
            op1 : in real12;
            op2 : in real12;
            res : out real12
        );
    end component SIGNED_MULT_12;
    
    signal op1 : real12;
    signal op2 : real12;
    signal res : real12;
begin
    A: SIGNED_MULT_12 port map(op1 => op1, op2 => op2, res => res);

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
	-- ===== TEST 1 =====
    op1.s <= '0';
    op1.m <= std_logic_vector(to_unsigned(5*128, op1.m'length));
    
    op2.s <= '0';
    op2.m <= std_logic_vector(to_unsigned(12*128, op1.m'length));
    wait for 50 ns;
	if res.s='0' and res.m=std_logic_vector(to_unsigned(60*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 2 =====
    op1.s <= '0';
    op1.m <= std_logic_vector(to_unsigned(3*128, op1.m'length));
    
    op2.s <= '1';
    op2.m <= std_logic_vector(to_unsigned(4*128, op1.m'length));
    wait for 50 ns;
	if res.s='1' and res.m=std_logic_vector(to_unsigned(12*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 2";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 3 =====
    op1.s <= '1';
    op1.m <= std_logic_vector(to_unsigned(7*128, op1.m'length));
    
    op2.s <= '0';
    op2.m <= std_logic_vector(to_unsigned(8*128, op1.m'length));
    wait for 50 ns;
	if res.s='1' and res.m=std_logic_vector(to_unsigned(56*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 3";
	end if;
	total := total +1;
    wait for 50 ns;
        
	-- ===== TEST 4 =====
    op1.s <= '1';
    op1.m <= std_logic_vector(to_unsigned(63*128, op1.m'length));
    
    op2.s <= '1';
    op2.m <= std_logic_vector(to_unsigned(1*128, op1.m'length));
	wait for 50 ns;
	if res.s='0' and res.m=std_logic_vector(to_unsigned(63*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 4";
	end if;
	total := total +1;
    wait for 50 ns;
	
	-- ===== TEST 5 =====
	op1.s <= '0';
    op1.m <= std_logic_vector(to_unsigned(0*128, op1.m'length));
    
    op2.s <= '1';
    op2.m <= std_logic_vector(to_unsigned(5*128, op1.m'length));
	wait for 50 ns;
	if res.s='1' and res.m=std_logic_vector(to_unsigned(0*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 5";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 6 =====
	op1.s <= '1';
    op1.m <= std_logic_vector(to_unsigned(0*128, op1.m'length));
    
    op2.s <= '1';
    op2.m <= std_logic_vector(to_unsigned(9*128, op1.m'length));
	wait for 50 ns;
	if res.s='0' and res.m=std_logic_vector(to_unsigned(0*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 6";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ===== TEST 7 =====
	op1.s <= '1';
    op1.m <= std_logic_vector(to_unsigned(0*128, op1.m'length));
    
    op2.s <= '0';
    op2.m <= std_logic_vector(to_unsigned(32*128, op1.m'length));
	wait for 50 ns;
	if res.s='1' and res.m=std_logic_vector(to_unsigned(0*128, res.m'length)) then
		test := test +1;
	else
		report "FAILED 7";
	end if;
	total := total +1;
    wait for 50 ns;

	-- ========== PRINT RESULTS ==========
	report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end TB_SIGNED_MULT_12_ARCH;
