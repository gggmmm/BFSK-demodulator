library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_fft_stage_1 is
end entity TB_fft_stage_1;

architecture TB_fft_stage_1_ARCH of TB_fft_stage_1 is
    component fft_stage_1 is
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
            res7 : out complex12;
            
            resA : out complex12;
            resB : out complex12;
            resC : out complex12;
            resD : out complex12;
            resE : out complex12;
            resF : out complex12;
            resG : out complex12;
            resH : out complex12;
            
            resI : out complex12;
            resJ : out complex12;
            resK : out complex12;
            resL : out complex12;
            resM : out complex12;
            resN : out complex12;
            resO : out complex12;
            resP : out complex12;
            
            resQ : out complex12;
            resR : out complex12;
            resS : out complex12;
            resT : out complex12;
            resU : out complex12;
            resV : out complex12;
            resW : out complex12;
            resX : out complex12
        );
    end component fft_stage_1;
    
    signal clock : std_logic := '0';
    signal reset : std_logic;
    signal start : std_logic := '0';
    signal start2 : std_logic := '0';
    
    signal op0,  op1,  op2,  op3,  op4,  op5,  op6,  op7  : complex12;
    signal res0, res1, res2, res3, res4, res5, res6, res7 : complex12;
    signal resA, resB, resC, resD, resE, resF, resG, resH : complex12; 
    signal resI, resJ, resK, resL, resM, resN, resO, resP : complex12; 
    signal resQ, resR, resS, resT, resU, resV, resW, resX : complex12;
begin
    B: fft_stage_1 port map(
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
        res7 => res7,
        
        resA => resA,
        resB => resB,
        resC => resC,
        resD => resD,
        resE => resE,
        resF => resF,
        resG => resG,
        resH => resH,
        
        resI => resI,
        resJ => resJ,
        resK => resK,
        resL => resL,
        resM => resM,
        resN => resN,
        resO => resO,
        resP => resP,
        
        resQ => resQ,
        resR => resR,
        resS => resS,
        resT => resT,
        resU => resU,
        resV => resV,
        resW => resW,
        resX => resX
    );
    
    clock <= not clock after 10 ns;

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    
    reset <= '1';
    wait for 50 ns;
    reset <= '0';
	
	-- ===== TEST 1 =====
	start <= '1';
	start2 <= '0';
	
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(8*128,op0.l.m'length)); op0.r.s <= '0'; op0.r.m <= std_logic_vector(to_unsigned(0,op0.r.m'length));	
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(1*128,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(2*128,op2.l.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(3*128,op3.l.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '0'; op4.l.m <= std_logic_vector(to_unsigned(4*128,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(0,op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '0'; op5.l.m <= std_logic_vector(to_unsigned(5*128,op5.l.m'length)); op5.r.s <= '0'; op5.r.m <= std_logic_vector(to_unsigned(0,op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '0'; op6.l.m <= std_logic_vector(to_unsigned(6*128,op6.l.m'length)); op6.r.s <= '0'; op6.r.m <= std_logic_vector(to_unsigned(0,op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '0'; op7.l.m <= std_logic_vector(to_unsigned(7*128,op7.l.m'length)); op7.r.s <= '0'; op7.r.m <= std_logic_vector(to_unsigned(0,op7.r.m'length));
	
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	wait for 20 ns;
	
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(1024, res0.l.m'length)) and res0.r.s='0' and res0.r.m=std_logic_vector(to_unsigned(0, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(128, res1.l.m'length)) and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(0, res1.r.m'length)) and
	        res2.l.s='0' and res2.l.m=std_logic_vector(to_unsigned(256, res2.l.m'length)) and res2.r.s='0' and res2.r.m=std_logic_vector(to_unsigned(0, res2.r.m'length)) and
	        res3.l.s='0' and res3.l.m=std_logic_vector(to_unsigned(384, res3.l.m'length)) and res3.r.s='0' and res3.r.m=std_logic_vector(to_unsigned(0, res3.r.m'length)) and
	        res4.l.s='0' and res4.l.m=std_logic_vector(to_unsigned(512, res4.l.m'length)) and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(0, res4.r.m'length)) and
	        res5.l.s='0' and res5.l.m=std_logic_vector(to_unsigned(640, res5.l.m'length)) and res5.r.s='0' and res5.r.m=std_logic_vector(to_unsigned(0, res5.r.m'length)) and
	        res6.l.s='0' and res6.l.m=std_logic_vector(to_unsigned(768, res6.l.m'length)) and res6.r.s='0' and res6.r.m=std_logic_vector(to_unsigned(0, res6.r.m'length)) and
	        res7.l.s='0' and res7.l.m=std_logic_vector(to_unsigned(896, res7.l.m'length)) and res7.r.s='0' and res7.r.m=std_logic_vector(to_unsigned(0, res7.r.m'length)) and
	        
	        resA.l.s='0' and resA.l.m=std_logic_vector(to_unsigned(1024, resA.l.m'length)) and resA.r.s='0' and resA.r.m=std_logic_vector(to_unsigned(0, resA.r.m'length)) and
	        resB.l.s='0' and resB.l.m=std_logic_vector(to_unsigned(125, resB.l.m'length)) and resB.r.s='1' and resB.r.m=std_logic_vector(to_unsigned(24, resB.r.m'length)) and
	        resC.l.s='0' and resC.l.m=std_logic_vector(to_unsigned(236, resC.l.m'length)) and resC.r.s='1' and resC.r.m=std_logic_vector(to_unsigned(97, resC.r.m'length)) and
	        resD.l.s='0' and resD.l.m=std_logic_vector(to_unsigned(319, resD.l.m'length)) and resD.r.s='1' and resD.r.m=std_logic_vector(to_unsigned(213, resD.r.m'length)) and
	        resE.l.s='0' and resE.l.m=std_logic_vector(to_unsigned(362, resE.l.m'length)) and resE.r.s='1' and resE.r.m=std_logic_vector(to_unsigned(362, resE.r.m'length)) and
	        resF.l.s='0' and resF.l.m=std_logic_vector(to_unsigned(355, resF.l.m'length)) and resF.r.s='1' and resF.r.m=std_logic_vector(to_unsigned(532, resF.r.m'length)) and
	        resG.l.s='0' and resG.l.m=std_logic_vector(to_unsigned(293, resG.l.m'length)) and resG.r.s='1' and resG.r.m=std_logic_vector(to_unsigned(709, resG.r.m'length)) and
	        resH.l.s='0' and resH.l.m=std_logic_vector(to_unsigned(174, resH.l.m'length)) and resH.r.s='1' and resH.r.m=std_logic_vector(to_unsigned(878, resH.r.m'length)) and
	        
	        resI.l.s='0' and resI.l.m=std_logic_vector(to_unsigned(1024, resI.l.m'length)) and resI.r.s='0' and resI.r.m=std_logic_vector(to_unsigned(0, resI.r.m'length)) and
	        resJ.l.s='0' and resJ.l.m=std_logic_vector(to_unsigned(127, resJ.l.m'length)) and resJ.r.s='1' and resJ.r.m=std_logic_vector(to_unsigned(12, resJ.r.m'length)) and
	        resK.l.s='0' and resK.l.m=std_logic_vector(to_unsigned(251, resK.l.m'length)) and resK.r.s='1' and resK.r.m=std_logic_vector(to_unsigned(49, resK.r.m'length)) and
	        resL.l.s='0' and resL.l.m=std_logic_vector(to_unsigned(367, resL.l.m'length)) and resL.r.s='1' and resL.r.m=std_logic_vector(to_unsigned(111, resL.r.m'length)) and
	        resM.l.s='0' and resM.l.m=std_logic_vector(to_unsigned(473, resM.l.m'length)) and resM.r.s='1' and resM.r.m=std_logic_vector(to_unsigned(195, resM.r.m'length)) and
	        resN.l.s='0' and resN.l.m=std_logic_vector(to_unsigned(564, resN.l.m'length)) and resN.r.s='1' and resN.r.m=std_logic_vector(to_unsigned(301, resN.r.m'length)) and
	        resO.l.s='0' and resO.l.m=std_logic_vector(to_unsigned(638, resO.l.m'length)) and resO.r.s='1' and resO.r.m=std_logic_vector(to_unsigned(426, resO.r.m'length)) and
	        resP.l.s='0' and resP.l.m=std_logic_vector(to_unsigned(692, resP.l.m'length)) and resP.r.s='1' and resP.r.m=std_logic_vector(to_unsigned(568, resP.r.m'length)) and
	        
	        resQ.l.s='0' and resQ.l.m=std_logic_vector(to_unsigned(1024, resQ.l.m'length)) and resQ.r.s='0' and resQ.r.m=std_logic_vector(to_unsigned(0, resQ.r.m'length)) and
	        resR.l.s='0' and resR.l.m=std_logic_vector(to_unsigned(122, resR.l.m'length)) and resR.r.s='1' and resR.r.m=std_logic_vector(to_unsigned(35, resR.r.m'length)) and
	        resS.l.s='0' and resS.l.m=std_logic_vector(to_unsigned(213, resS.l.m'length)) and resS.r.s='1' and resS.r.m=std_logic_vector(to_unsigned(141, resS.r.m'length)) and
	        resT.l.s='0' and resT.l.m=std_logic_vector(to_unsigned(244, resT.l.m'length)) and resT.r.s='1' and resT.r.m=std_logic_vector(to_unsigned(295, resT.r.m'length)) and
	        resU.l.s='0' and resU.l.m=std_logic_vector(to_unsigned(197, resU.l.m'length)) and resU.r.s='1' and resU.r.m=std_logic_vector(to_unsigned(471, resU.r.m'length)) and
	        resV.l.s='0' and resV.l.m=std_logic_vector(to_unsigned(63 , resV.l.m'length)) and resV.r.s='1' and resV.r.m=std_logic_vector(to_unsigned(635, resV.r.m'length)) and
	        resW.l.s='1' and resW.l.m=std_logic_vector(to_unsigned(149, resW.l.m'length)) and resW.r.s='1' and resW.r.m=std_logic_vector(to_unsigned(751, resW.r.m'length)) and
	        resX.l.s='1' and resX.l.m=std_logic_vector(to_unsigned(423, resX.l.m'length)) and resX.r.s='1' and resX.r.m=std_logic_vector(to_unsigned(788, resX.r.m'length)) then
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
    
    -- ===== TEST 2 =====
	start <= '1';
	start2 <= '0';
	
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(59,op0.l.m'length)); op0.r.s <= '1'; op0.r.m <= std_logic_vector(to_unsigned(136,op0.r.m'length));	
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(15,op1.l.m'length)); op1.r.s <= '1'; op1.r.m <= std_logic_vector(to_unsigned(37,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '1'; op2.l.m <= std_logic_vector(to_unsigned(28,op2.l.m'length)); op2.r.s <= '1'; op2.r.m <= std_logic_vector(to_unsigned(147,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '1'; op3.l.m <= std_logic_vector(to_unsigned(87,op3.l.m'length)); op3.r.s <= '1'; op3.r.m <= std_logic_vector(to_unsigned(103,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '1'; op4.l.m <= std_logic_vector(to_unsigned(107,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(12,op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '0'; op5.l.m <= std_logic_vector(to_unsigned(56,op5.l.m'length)); op5.r.s <= '0'; op5.r.m <= std_logic_vector(to_unsigned(131,op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '0'; op6.l.m <= std_logic_vector(to_unsigned(111,op6.l.m'length)); op6.r.s <= '1'; op6.r.m <= std_logic_vector(to_unsigned(51,op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '0'; op7.l.m <= std_logic_vector(to_unsigned(23,op7.l.m'length)); op7.r.s <= '1'; op7.r.m <= std_logic_vector(to_unsigned(88,op7.r.m'length));
	
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	wait for 20 ns;
	
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(59 , res0.l.m'length)) and res0.r.s='1' and res0.r.m=std_logic_vector(to_unsigned(136, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(15 , res1.l.m'length)) and res1.r.s='1' and res1.r.m=std_logic_vector(to_unsigned(37, res1.r.m'length)) and
	        res2.l.s='1' and res2.l.m=std_logic_vector(to_unsigned(28 , res2.l.m'length)) and res2.r.s='1' and res2.r.m=std_logic_vector(to_unsigned(147, res2.r.m'length)) and
	        res3.l.s='1' and res3.l.m=std_logic_vector(to_unsigned(87 , res3.l.m'length)) and res3.r.s='1' and res3.r.m=std_logic_vector(to_unsigned(103, res3.r.m'length)) and
	        res4.l.s='1' and res4.l.m=std_logic_vector(to_unsigned(107, res4.l.m'length)) and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(12, res4.r.m'length)) and
	        res5.l.s='0' and res5.l.m=std_logic_vector(to_unsigned(56 , res5.l.m'length)) and res5.r.s='0' and res5.r.m=std_logic_vector(to_unsigned(131, res5.r.m'length)) and
	        res6.l.s='0' and res6.l.m=std_logic_vector(to_unsigned(111, res6.l.m'length)) and res6.r.s='1' and res6.r.m=std_logic_vector(to_unsigned(51, res6.r.m'length)) and
	        res7.l.s='0' and res7.l.m=std_logic_vector(to_unsigned(23 , res7.l.m'length)) and res7.r.s='1' and res7.r.m=std_logic_vector(to_unsigned(88, res7.r.m'length)) and
	        
	        resA.l.s='0' and resA.l.m=std_logic_vector(to_unsigned(59 , resA.l.m'length)) and resA.r.s='1' and resA.r.m=std_logic_vector(to_unsigned(136, resA.r.m'length)) and
	        resB.l.s='0' and resB.l.m=std_logic_vector(to_unsigned(7  , resB.l.m'length)) and resB.r.s='1' and resB.r.m=std_logic_vector(to_unsigned(38, resB.r.m'length)) and
	        resC.l.s='1' and resC.l.m=std_logic_vector(to_unsigned(81 , resC.l.m'length)) and resC.r.s='1' and resC.r.m=std_logic_vector(to_unsigned(125, resC.r.m'length)) and
	        resD.l.s='1' and resD.l.m=std_logic_vector(to_unsigned(129, resD.l.m'length)) and resD.r.s='1' and resD.r.m=std_logic_vector(to_unsigned(37, resD.r.m'length)) and
	        resE.l.s='1' and resE.l.m=std_logic_vector(to_unsigned(67 , resE.l.m'length)) and resE.r.s='0' and resE.r.m=std_logic_vector(to_unsigned(83, resE.r.m'length)) and
	        resF.l.s='0' and resF.l.m=std_logic_vector(to_unsigned(139, resF.l.m'length)) and resF.r.s='0' and resF.r.m=std_logic_vector(to_unsigned(26, resF.r.m'length)) and
	        resG.l.s='1' and resG.l.m=std_logic_vector(to_unsigned(5  , resG.l.m'length)) and resG.r.s='1' and resG.r.m=std_logic_vector(to_unsigned(121, resG.r.m'length)) and
	        resH.l.s='1' and resH.l.m=std_logic_vector(to_unsigned(82 , resH.l.m'length)) and resH.r.s='1' and resH.r.m=std_logic_vector(to_unsigned(39, resH.r.m'length)) and
	        
	        resI.l.s='0' and resI.l.m=std_logic_vector(to_unsigned(59 , resI.l.m'length)) and resI.r.s='1' and resI.r.m=std_logic_vector(to_unsigned(136, resI.r.m'length)) and
	        resJ.l.s='0' and resJ.l.m=std_logic_vector(to_unsigned(11 , resJ.l.m'length)) and resJ.r.s='1' and resJ.r.m=std_logic_vector(to_unsigned(37, resJ.r.m'length)) and
	        resK.l.s='1' and resK.l.m=std_logic_vector(to_unsigned(55 , resK.l.m'length)) and resK.r.s='1' and resK.r.m=std_logic_vector(to_unsigned(139, resK.r.m'length)) and
	        resL.l.s='1' and resL.l.m=std_logic_vector(to_unsigned(112, resL.l.m'length)) and resL.r.s='1' and resL.r.m=std_logic_vector(to_unsigned(73, resL.r.m'length)) and
	        resM.l.s='1' and resM.l.m=std_logic_vector(to_unsigned(94 , resM.l.m'length)) and resM.r.s='0' and resM.r.m=std_logic_vector(to_unsigned(51, resM.r.m'length)) and
	        resN.l.s='0' and resN.l.m=std_logic_vector(to_unsigned(110, resN.l.m'length)) and resN.r.s='0' and resN.r.m=std_logic_vector(to_unsigned(89, resN.r.m'length)) and
	        resO.l.s='0' and resO.l.m=std_logic_vector(to_unsigned(64 , resO.l.m'length)) and resO.r.s='1' and resO.r.m=std_logic_vector(to_unsigned(103, resO.r.m'length)) and
	        resP.l.s='1' and resP.l.m=std_logic_vector(to_unsigned(38 , resP.l.m'length)) and resP.r.s='1' and resP.r.m=std_logic_vector(to_unsigned(82, resP.r.m'length)) and
	        
	        resQ.l.s='0' and resQ.l.m=std_logic_vector(to_unsigned(59 , resQ.l.m'length)) and resQ.r.s='1' and resQ.r.m=std_logic_vector(to_unsigned(136, resQ.r.m'length)) and
	        resR.l.s='0' and resR.l.m=std_logic_vector(to_unsigned(3  , resR.l.m'length)) and resR.r.s='1' and resR.r.m=std_logic_vector(to_unsigned(38, resR.r.m'length)) and
	        resS.l.s='1' and resS.l.m=std_logic_vector(to_unsigned(103, resS.l.m'length)) and resS.r.s='1' and resS.r.m=std_logic_vector(to_unsigned(107, resS.r.m'length)) and
	        resT.l.s='1' and resT.l.m=std_logic_vector(to_unsigned(133, resT.l.m'length)) and resT.r.s='0' and resT.r.m=std_logic_vector(to_unsigned(2, resT.r.m'length)) and
	        resU.l.s='1' and resU.l.m=std_logic_vector(to_unsigned(30 , resU.l.m'length)) and resU.r.s='0' and resU.r.m=std_logic_vector(to_unsigned(102, resU.r.m'length)) and
	        resV.l.s='0' and resV.l.m=std_logic_vector(to_unsigned(134, resV.l.m'length)) and resV.r.s='1' and resV.r.m=std_logic_vector(to_unsigned(42, resV.r.m'length)) and
	        resW.l.s='1' and resW.l.m=std_logic_vector(to_unsigned(71 , resW.l.m'length)) and resW.r.s='1' and resW.r.m=std_logic_vector(to_unsigned(98, resW.r.m'length)) and
	        resX.l.s='1' and resX.l.m=std_logic_vector(to_unsigned(87 , resX.l.m'length)) and resX.r.s='0' and resX.r.m=std_logic_vector(to_unsigned(22, resX.r.m'length)) then
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

end TB_fft_stage_1_ARCH;
