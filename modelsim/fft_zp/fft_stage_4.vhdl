library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity fft_stage_4 is
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
end entity fft_stage_4;

architecture fft_stage_4_arch of fft_stage_4 is
    component butterfly_2_n is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            op0 : in complex12;
            op1 : in complex12;
            res0 : out complex12;
            res1 : out complex12
        );
    end component butterfly_2_n;

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
begin
    B0 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op0,   op1=>op1,
                                res0=>res0, res1=>res32);
                                
    B1 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op2,   op1=>op3,
                                    res0=>res16, res1=>res48);
                                    
    B2 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op4,   op1=>op5,
                                res0=>res8, res1=>res40);
                                
    B3 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op6,   op1=>op7,
                                    res0=>res24, res1=>res56);
                                    
    B4 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op8,   op1=>op9,
                                res0=>res4, res1=>res36);
                                
    B5 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op10,   op1=>op11,
                                    res0=>res20, res1=>res52);
                                    
    B6 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op12,   op1=>op13,
                                res0=>res12, res1=>res44);
                                
    B7 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op14,   op1=>op15,
                                    res0=>res28, res1=>res60);
                                    
    B8 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op16,   op1=>op17,
                                res0=>res2, res1=>res34);
                                
    B9 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op18,   op1=>op19,
                                    res0=>res18, res1=>res50);
                                    
    B10 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op20,   op1=>op21,
                                res0=>res10, res1=>res42);
                                
    B11 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op22,   op1=>op23,
                                    res0=>res26, res1=>res58);
                                    
    B12 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op24,   op1=>op25,
                                res0=>res6, res1=>res38);
                                
    B13 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op26,   op1=>op27,
                                    res0=>res22, res1=>res54);
                                    
    B14 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op28,   op1=>op29,
                                res0=>res14, res1=>res46);
                                
    B15 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op30,   op1=>op31,
                                    res0=>res30, res1=>res62);
                                    
    B16 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op32,   op1=>op33,
                                res0=>res1, res1=>res33);
                                
    B17 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op34,   op1=>op35,
                                    res0=>res17, res1=>res49);
                                    
    B18 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op36,   op1=>op37,
                                res0=>res9, res1=>res41);
                                
    B19 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op38,   op1=>op39,
                                    res0=>res25, res1=>res57);
                                    
    B20 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op40,   op1=>op41,
                                res0=>res5, res1=>res37);
                                
    B21 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op42,   op1=>op43,
                                    res0=>res21, res1=>res53);
                                    
    B22 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op44,   op1=>op45,
                                res0=>res13, res1=>res45);
                                
    B23 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op46,   op1=>op47,
                                    res0=>res29, res1=>res61);
                                    
    B24 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op48,   op1=>op49,
                                res0=>res3, res1=>res35);
                                
    B25 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op50,   op1=>op51,
                                    res0=>res19, res1=>res51);
                                    
    B26 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op52,   op1=>op53,
                                res0=>res11, res1=>res43);
                                
    B27 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op54,   op1=>op55,
                                    res0=>res27, res1=>res59);
                                    
    B28 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op56,   op1=>op57,
                                res0=>res7, res1=>res39);
                                
    B29 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op58,   op1=>op59,
                                    res0=>res23, res1=>res55);
                                    
    B30 : butterfly_2_n port map(clock=>clock, reset=>reset, start=>start,
                                op0=>op60,   op1=>op61,
                                res0=>res15, res1=>res47);
                                
    B31 : butterfly_2_tw port map(   clock=>clock, reset=>reset, start=>start, start2=>start2,
                                    op0=>op62,   op1=>op63,
                                    res0=>res31, res1=>res63);
                                    
    
end fft_stage_4_arch;
