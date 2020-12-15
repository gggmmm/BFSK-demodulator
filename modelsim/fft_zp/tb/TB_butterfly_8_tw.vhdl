library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity TB_BUTTERFLY_8_TW is
end entity TB_BUTTERFLY_8_TW;

architecture TB_BUTTERFLY_8_TW_ARCH of TB_BUTTERFLY_8_TW is
    component butterfly_8_TW is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            start2 : in std_logic;
            op0 : in complex12;
            op1 : in complex12;
            op2 : in complex12;
            op3 : in complex12;
            op4 : in complex12;
            op5 : in complex12;
            op6 : in complex12;
            op7 : in complex12;
            res0 : out complex12;
            res1 : out complex12;
            res2 : out complex12;
            res3 : out complex12;
            res4 : out complex12;
            res5 : out complex12;
            res6 : out complex12;
            res7 : out complex12
        );
    end component butterfly_8_TW;
    
    signal clock : std_logic := '0';
    signal reset : std_logic;
    signal start : std_logic;
    signal start2 : std_logic;
    signal op0 : complex12;
    signal op1 : complex12;
    signal op2 : complex12;
    signal op3 : complex12;
    signal op4 : complex12;
    signal op5 : complex12;
    signal op6 : complex12;
    signal op7 : complex12;
    signal res0 : complex12;
    signal res1 : complex12;
    signal res2 : complex12;
    signal res3 : complex12;
    signal res4 : complex12;
    signal res5 : complex12;
    signal res6 : complex12;
    signal res7 : complex12;
begin
    B: butterfly_8_tw port map(
        clock => clock,
        reset => reset,
        start => start,
        start2 => start2,
        op0 => op0,
        op1 => op1,
        op2 => op2,
        op3 => op3,
        op4 => op4,
        op5 => op5,
        op6 => op6,
        op7 => op7,
        res0 => res0,
        res1 => res1,
        res2 => res2,
        res3 => res3,
        res4 => res4,
        res5 => res5,
        res6 => res6,
        res7 => res7
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
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(128,op0.r.m'length)); op0.r.s <= '0'; op0.r.m <= std_logic_vector(to_unsigned(0,op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(256,op0.r.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(384,op0.r.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(512,op0.r.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '0'; op4.l.m <= std_logic_vector(to_unsigned(640,op0.r.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(0,op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '0'; op5.l.m <= std_logic_vector(to_unsigned(768,op0.r.m'length)); op5.r.s <= '0'; op5.r.m <= std_logic_vector(to_unsigned(0,op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '0'; op6.l.m <= std_logic_vector(to_unsigned(896,op0.r.m'length)); op6.r.s <= '0'; op6.r.m <= std_logic_vector(to_unsigned(0,op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '0'; op7.l.m <= std_logic_vector(to_unsigned(1024,op0.r.m'length)); op7.r.s <= '0'; op7.r.m <= std_logic_vector(to_unsigned(0,op7.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m= std_logic_vector(to_unsigned(128,op0.r.m'length)) and res0.r.s='1' and res0.r.m= std_logic_vector(to_unsigned(640,op0.r.m'length)) and
	        res1.l.s='1' and res1.l.m= std_logic_vector(to_unsigned(57,op0.r.m'length)) and res1.r.s='1' and res1.r.m= std_logic_vector(to_unsigned(806,op0.r.m'length)) and
	        res2.l.s='1' and res2.l.m= std_logic_vector(to_unsigned(362,op0.r.m'length)) and res2.r.s='1' and res2.r.m= std_logic_vector(to_unsigned(904,op0.r.m'length)) and
	        res3.l.s='1' and res3.l.m= std_logic_vector(to_unsigned(751,op0.r.m'length)) and res3.r.s='1' and res3.r.m= std_logic_vector(to_unsigned(864,op0.r.m'length)) and
	        res4.l.s='0' and res4.l.m= std_logic_vector(to_unsigned(128,op0.r.m'length)) and res4.r.s='0' and res4.r.m= std_logic_vector(to_unsigned(640,op0.r.m'length)) and
	        res5.l.s='0' and res5.l.m= std_logic_vector(to_unsigned(529,op0.r.m'length)) and res5.r.s='0' and res5.r.m= std_logic_vector(to_unsigned(612,op0.r.m'length)) and
	        res6.l.s='0' and res6.l.m= std_logic_vector(to_unsigned(904,op0.r.m'length)) and res6.r.s='0' and res6.r.m= std_logic_vector(to_unsigned(362,op0.r.m'length)) and
	        res7.l.s='0' and res7.l.m= std_logic_vector(to_unsigned(1141,op0.r.m'length)) and res7.r.s='1' and res7.r.m= std_logic_vector(to_unsigned(82,op0.r.m'length)) then
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
    -- -0.880887556599902 + 0.167419467753168i
    -- -1.48067623408917  + 0.845272067101903i
    -- -0.127630875472146 + 0.600136118643648i
    --  0.679817053124255 + 0.906310375643243i
    
    --  93  + 128 i
    --  116 -  84 i
    -- -84  -  90 i
    -- -170 -  56 i
    -- -112 +  21 i
    -- -189 + 108 i
    -- -16  +  76 i
    --  87  + 116 i
    
    -- ===== OUTPUT =====
    --  0.89567 + 1.8848 i
    --  1.9366  + 0.086409 i
    -- -0.45323 - 0.37002 i
    -- -1.1973  - 0.035376 i
    --  0.56083 + 0.12303 i
    -- -0.75852 - 2.0026 i
    -- -1.4824  + 0.2982 i
    -- -0.63481 + 2.1596 i
    
    --  112 +        240i
    --  244 +         12i
    -- -58  -         46i
    -- -150 -          4i
    --  72  +         16i
    -- -94  -        252i
    -- -186 +         38i
    -- -78  +        274i
    
	op0.c <= '0'; op0.l.s <= '0'; op0.r.s <= '0'; 
	op0.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.728250001826079*128)),op0.r.m'length)); op0.r.m <= std_logic_vector(to_unsigned(Integer(floor(1.00391836847305*128)),op0.r.m'length));
	op1.c <= '0'; op1.l.s <= '0'; op1.r.s <= '1'; 
	op1.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.910846857843460*128)),op1.r.m'length)); op1.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.659739961761865*128)),op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '1'; op2.r.s <= '1'; 
	op2.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.658975755475809*128)),op2.r.m'length)); op2.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.709758034785561*128)),op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '1'; op3.r.s <= '1'; 
	op3.l.m <= std_logic_vector(to_unsigned(Integer(floor(1.33181094914586*128)),op3.r.m'length)); op3.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.439874977626711*128)),op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '1'; op4.r.s <= '0'; 
	op4.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.880887556599902*128)),op4.r.m'length)); op4.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.167419467753168*128)),op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '1'; op5.r.s <= '0'; 
	op5.l.m <= std_logic_vector(to_unsigned(Integer(floor(1.48067623408917*128)),op5.r.m'length)); op5.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.845272067101903*128)),op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '1'; op6.r.s <= '0'; 
	op6.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.127630875472146*128)),op6.r.m'length)); op6.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.600136118643648*128)),op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '0'; op7.r.s <= '0'; 
	op7.l.m <= std_logic_vector(to_unsigned(Integer(floor(0.679817053124255*128)),op7.r.m'length)); op7.r.m <= std_logic_vector(to_unsigned(Integer(floor(0.906310375643243*128)),op7.r.m'length));
	
	start <= '1';
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	
    wait for 70 ns;
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(114, res0.l.m'length))  and res0.r.s='0' and res0.r.m=std_logic_vector(to_unsigned(240, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(246, res1.l.m'length))  and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(12, res1.r.m'length)) and
	        res2.l.s='1' and res2.l.m=std_logic_vector(to_unsigned(58, res2.l.m'length))   and res2.r.s='1' and res2.r.m=std_logic_vector(to_unsigned(46, res2.r.m'length)) and
	        res3.l.s='1' and res3.l.m=std_logic_vector(to_unsigned(152, res3.l.m'length))  and res3.r.s='1' and res3.r.m=std_logic_vector(to_unsigned(4, res3.r.m'length)) and
	        res4.l.s='0' and res4.l.m=std_logic_vector(to_unsigned(72, res4.l.m'length))   and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(16, res4.r.m'length)) and
	        res5.l.s='1' and res5.l.m=std_logic_vector(to_unsigned(96, res5.l.m'length))   and res5.r.s='1' and res5.r.m=std_logic_vector(to_unsigned(254, res5.r.m'length)) and
	        res6.l.s='1' and res6.l.m=std_logic_vector(to_unsigned(186, res6.l.m'length))  and res6.r.s='0' and res6.r.m=std_logic_vector(to_unsigned(38, res6.r.m'length)) and
	        res7.l.s='1' and res7.l.m=std_logic_vector(to_unsigned(80, res7.l.m'length))   and res7.r.s='0' and res7.r.m=std_logic_vector(to_unsigned(276, res7.r.m'length)) then
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

end TB_BUTTERFLY_8_TW_ARCH;
