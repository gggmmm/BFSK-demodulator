library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity fft_stage_3 is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        start2 : in std_logic;

        op0,  op1,  op2,  op3,  op4,  op5,  op6,  op7  : in complex12;
        op8,  op9,  op10, op11, op12, op13, op14, op15 : in complex12;
        op16, op17, op18, op19, op20, op21, op22, op23 : in complex12;
        op24, op25, op26, op27, op28, op29, op30, op31 : in complex12;
        
        op32, op33, op34, op35, op36, op37, op38, op39 : in complex12;
        op40, op41, op42, op43, op44, op45, op46, op47 : in complex12;
        op48, op49, op50, op51, op52, op53, op54, op55 : in complex12;
        op56, op57, op58, op59, op60, op61, op62, op63 : in complex12;
        
        res0,  res1,  res2,  res3,  res4,  res5,  res6,  res7  : out complex12;
        res8,  res9,  res10, res11, res12, res13, res14, res15 : out complex12;
        res16, res17, res18, res19, res20, res21, res22, res23 : out complex12;
        res24, res25, res26, res27, res28, res29, res30, res31 : out complex12;
        
        res32, res33, res34, res35, res36, res37, res38, res39 : out complex12;
        res40, res41, res42, res43, res44, res45, res46, res47 : out complex12;
        res48, res49, res50, res51, res52, res53, res54, res55 : out complex12;
        res56, res57, res58, res59, res60, res61, res62, res63 : out complex12
    );
end entity fft_stage_3;

architecture fft_stage_3_arch of fft_stage_3 is
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

    component butterfly_4_tw is
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
    end component butterfly_4_tw;
begin
    B0 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op0,   op2=>op1,   op3=>op2,   op4=>op3,
                                res1=>res0, res2=>res1, res3=>res2, res4=>res3);
                                
    B1 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op4,   op1=>op5,   op2=>op6,   op3=>op7,
                                    res0=>res4, res1=>res5, res2=>res6, res3=>res7);
                                    
    B2 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op8,   op2=>op9,   op3=>op10,   op4=>op11,
                                res1=>res8, res2=>res9, res3=>res10, res4=>res11);
                                
    B3 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op12,   op1=>op13,   op2=>op14,   op3=>op15,
                                    res0=>res12, res1=>res13, res2=>res14, res3=>res15);
    
    B4 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op16,   op2=>op17,   op3=>op18,   op4=>op19,
                                res1=>res16, res2=>res17, res3=>res18, res4=>res19);
                                
    B5 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op20,   op1=>op21,   op2=>op22,   op3=>op23,
                                    res0=>res20, res1=>res21, res2=>res22, res3=>res23);
                                    
    B6 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op24,   op2=>op25,   op3=>op26,   op4=>op27,
                                res1=>res24, res2=>res25, res3=>res26, res4=>res27);
                                
    B7 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op28,   op1=>op29,   op2=>op30,   op3=>op31,
                                    res0=>res28, res1=>res29, res2=>res30, res3=>res31);
                                
    B8 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op32,   op2=>op33,   op3=>op34,   op4=>op35,
                                res1=>res32, res2=>res33, res3=>res34, res4=>res35);   
                                
    B9 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op36,   op1=>op37,   op2=>op38,   op3=>op39,
                                    res0=>res36, res1=>res37, res2=>res38, res3=>res39);
                                    
    B10 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op40,   op2=>op41,   op3=>op42,   op4=>op43,
                                res1=>res40, res2=>res41, res3=>res42, res4=>res43);   
                                
    B11 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op44,   op1=>op45,   op2=>op46,   op3=>op47,
                                    res0=>res44, res1=>res45, res2=>res46, res3=>res47);
                                    
    B12 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op48,   op2=>op49,   op3=>op50,   op4=>op51,
                                res1=>res48, res2=>res49, res3=>res50, res4=>res51);   
                                
    B13 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op52,   op1=>op53,   op2=>op54,   op3=>op55,
                                    res0=>res52, res1=>res53, res2=>res54, res3=>res55);
                                    
    B14 : butterfly_4_n port map(clock=>clock, reset=>reset, start=>start,
                                op1=>op56,   op2=>op57,   op3=>op58,   op4=>op59,
                                res1=>res56, res2=>res57, res3=>res58, res4=>res59);   
                                
    B15 : butterfly_4_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op60,   op1=>op61,   op2=>op62,   op3=>op63,
                                    res0=>res60, res1=>res61, res2=>res62, res3=>res63);
end fft_stage_3_arch;
