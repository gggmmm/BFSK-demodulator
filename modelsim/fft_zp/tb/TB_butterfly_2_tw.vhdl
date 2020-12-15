library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_BUTTERFLY_2_TW is
end entity TB_BUTTERFLY_2_TW;

architecture TB_BUTTERFLY_2_TW_ARCH of TB_BUTTERFLY_2_TW is
    component butterfly_2_tw is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            start2 : in std_logic;
            op0 : in complex12;
            op1 : in complex12;
            res0 : out complex12;
            res1 : out complex12
        );
    end component butterfly_2_tw;
    
    signal clock : std_logic := '0';
    signal reset : std_logic;
    signal start : std_logic;
    signal start2 : std_logic;
    signal op0 : complex12;
    signal op1 : complex12;
    signal res0 : complex12;
    signal res1 : complex12;
begin
    B: butterfly_2_tw port map(
        clock => clock,
        reset => reset,
        start => start,
        start2 => start2,
        op0 => op0,
        op1 => op1,
        res0 => res0,
        res1 => res1
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
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(1,op0.l.m'length)); op0.r.s <= '0'; op0.r.m <= std_logic_vector(to_unsigned(0,op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(2,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(1, res0.l.m'length)) and res0.r.s='1' and res0.r.m=std_logic_vector(to_unsigned(2, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(1, res1.l.m'length)) and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(2, res1.r.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 2 =====
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(1,op0.l.m'length)); op0.r.s <= '1'; op0.r.m <= std_logic_vector(to_unsigned(5,op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(2,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(5,op1.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(6, res0.l.m'length)) and res0.r.s='1' and res0.r.m=std_logic_vector(to_unsigned(7, res0.r.m'length)) and
	        res1.l.s='1' and res1.l.m=std_logic_vector(to_unsigned(4, res1.l.m'length)) and res1.r.s='1' and res1.r.m=std_logic_vector(to_unsigned(3, res1.r.m'length)) then
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

end TB_BUTTERFLY_2_TW_ARCH;
