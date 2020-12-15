library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity fft_stage_2 is
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
        
        opA : in complex12;
        opB : in complex12;
        opC : in complex12;
        opD : in complex12;
        opE : in complex12;
        opF : in complex12;
        opG : in complex12;
        opH : in complex12;
        
        opI : in complex12;
        opJ : in complex12;
        opK : in complex12;
        opL : in complex12;
        opM : in complex12;
        opN : in complex12;
        opO : in complex12;
        opP : in complex12;
        
        opQ : in complex12;
        opR : in complex12;
        opS : in complex12;
        opT : in complex12;
        opU : in complex12;
        opV : in complex12;
        opW : in complex12;
        opX : in complex12;
        
        res0,  res1,  res2,  res3,  res4,  res5,  res6,  res7  : out complex12;
        res8,  res9,  res10, res11, res12, res13, res14, res15 : out complex12;
        res16, res17, res18, res19, res20, res21, res22, res23 : out complex12;
        res24, res25, res26, res27, res28, res29, res30, res31 : out complex12;
        
        res32, res33, res34, res35, res36, res37, res38, res39 : out complex12;
        res40, res41, res42, res43, res44, res45, res46, res47 : out complex12;
        res48, res49, res50, res51, res52, res53, res54, res55 : out complex12;
        res56, res57, res58, res59, res60, res61, res62, res63 : out complex12
    );
end entity fft_stage_2;

architecture fft_stage_2_arch of fft_stage_2 is
    component COMPLEX_MULTIPLIER_12 is
        generic(    L : integer := 7;
                    H : integer := 18
        );
        port(
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_MULTIPLIER_12;
    
    component butterfly_8_n is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            op1 : in complex12;
            op2 : in complex12;
            op3 : in complex12;
            op4 : in complex12;
            op5 : in complex12;
            op6 : in complex12;
            op7 : in complex12;
            op8 : in complex12;
            res1 : out complex12;
            res2 : out complex12;
            res3 : out complex12;
            res4 : out complex12;
            res5 : out complex12;
            res6 : out complex12;
            res7 : out complex12;
            res8 : out complex12
        );
    end component butterfly_8_n;
    
    component butterfly_8_tw is
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
    end component butterfly_8_tw;
begin
    B0 : butterfly_8_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op0,   op2=>op1,   op3=>op2,   op4=>op3,   op5=>op4,   op6=>op5,   op7=>op6,   op8=>op7,
                                res1=>res0, res2=>res1, res3=>res2, res4=>res3, res5=>res4, res6=>res5, res7=>res6, res8=>res7);
                                
    B1 : butterfly_8_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op0,   op1=>op1,   op2=>op2,   op3=>op3,   op4=>op4,   op5=>op5,   op6=>op6,   op7=>op7,
                                    res0=>res8, res1=>res9, res2=>res10, res3=>res11, res4=>res12, res5=>res13, res6=>res14, res7=>res15);
    
    B2 : butterfly_8_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>opA,   op2=>opB,   op3=>opC,   op4=>opD,   op5=>opE,   op6=>opF,   op7=>opG,   op8=>opH,
                                res1=>res16, res2=>res17, res3=>res18, res4=>res19, res5=>res20, res6=>res21, res7=>res22, res8=>res23);
                                
    B3 : butterfly_8_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>opA,   op1=>opB,   op2=>opC,   op3=>opD,   op4=>opE,   op5=>opF,   op6=>opG,   op7=>opH,
                                    res0=>res24, res1=>res25, res2=>res26, res3=>res27, res4=>res28, res5=>res29, res6=>res30, res7=>res31);
                                    
    B4 : butterfly_8_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>opI,   op2=>opJ,   op3=>opK,   op4=>opL,   op5=>opM,   op6=>opN,   op7=>opO,   op8=>opP,
                                res1=>res32, res2=>res33, res3=>res34, res4=>res35, res5=>res36, res6=>res37, res7=>res38, res8=>res39);
                                
    B5 : butterfly_8_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>opI,   op1=>opJ,   op2=>opK,   op3=>opL,   op4=>opM,   op5=>opN,   op6=>opO,   op7=>opP,
                                    res0=>res40, res1=>res41, res2=>res42, res3=>res43, res4=>res44, res5=>res45, res6=>res46, res7=>res47);
                                    
    B6 : butterfly_8_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>opQ,   op2=>opR,   op3=>opS,   op4=>opT,   op5=>opU,   op6=>opV,   op7=>opW,   op8=>opX,
                                res1=>res48, res2=>res49, res3=>res50, res4=>res51, res5=>res52, res6=>res53, res7=>res54, res8=>res55);
                                
    B7 : butterfly_8_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>opQ,   op1=>opR,   op2=>opS,   op3=>opT,   op4=>opU,   op5=>opV,   op6=>opW,   op7=>opX,
                                    res0=>res56, res1=>res57, res2=>res58, res3=>res59, res4=>res60, res5=>res61, res6=>res62, res7=>res63);

end fft_stage_2_arch;
