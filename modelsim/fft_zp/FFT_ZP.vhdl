-- input is 5|7

library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity FFT_ZP is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        start   : in std_logic;
        input   : in input_fft_zp;
        done    : out std_logic;
        output  : out output_fft_zp
    );
end entity FFT_ZP;

architecture FFT_ZP_ARCH of FFT_ZP is
    -- ===== STAGE 1 =====
    component fft_stage_1
        port (clock  : in std_logic;
              reset  : in std_logic;
              start  : in std_logic;
              start2 : in std_logic;
              op0,  op1,  op2,  op3,  op4,  op5,  op6,  op7    : in complex12;
              res0, res1, res2, res3, res4, res5, res6, res7   : out complex12;
              resA, resB, resC, resD, resE, resF, resG, resH   : out complex12;
              resI, resJ, resK, resL, resM, resN, resO, resP   : out complex12;
              resQ, resR, resS, resT, resU, resV, resW, resX   : out complex12);
    end component;
    
    -- only for the first stage I need 32 registers because of the duplicates
    signal  s1_out0,  s1_out1,  s1_out2,  s1_out3,  s1_out4,  s1_out5,  s1_out6,  s1_out7,  
            s1_out8,  s1_out9,  s1_out10, s1_out11, s1_out12, s1_out13, s1_out14, s1_out15, 
            s1_out16, s1_out17, s1_out18, s1_out19, s1_out20, s1_out21, s1_out22, s1_out23, 
            s1_out24, s1_out25, s1_out26, s1_out27, s1_out28, s1_out29, s1_out30, s1_out31 : complex12;
            
    signal  s1_reg0,  s1_reg1,  s1_reg2,  s1_reg3,  s1_reg4,  s1_reg5,  s1_reg6,  s1_reg7,  
            s1_reg8,  s1_reg9,  s1_reg10, s1_reg11, s1_reg12, s1_reg13, s1_reg14, s1_reg15, 
            s1_reg16, s1_reg17, s1_reg18, s1_reg19, s1_reg20, s1_reg21, s1_reg22, s1_reg23, 
            s1_reg24, s1_reg25, s1_reg26, s1_reg27, s1_reg28, s1_reg29, s1_reg30, s1_reg31 : complex12;
    
    -- ===== STAGE 2 =====
    component fft_stage_2 is
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            start2 : in std_logic;

            op0, op1, op2, op3, op4, op5, op6, op7 : in complex12;
            opA, opB, opC, opD, opE, opF, opG, opH : in complex12;
            opI, opJ, opK, opL, opM, opN, opO, opP : in complex12;
            opQ, opR, opS, opT, opU, opV, opW, opX : in complex12;
            
            res0,  res1,  res2,  res3,  res4,  res5,  res6,  res7  : out complex12;
            res8,  res9,  res10, res11, res12, res13, res14, res15 : out complex12;
            res16, res17, res18, res19, res20, res21, res22, res23 : out complex12;
            res24, res25, res26, res27, res28, res29, res30, res31 : out complex12;
            
            res32, res33, res34, res35, res36, res37, res38, res39 : out complex12;
            res40, res41, res42, res43, res44, res45, res46, res47 : out complex12;
            res48, res49, res50, res51, res52, res53, res54, res55 : out complex12;
            res56, res57, res58, res59, res60, res61, res62, res63 : out complex12
        );
    end component fft_stage_2;
    
    signal  s2_out0,  s2_out1,  s2_out2,  s2_out3,  s2_out4,  s2_out5,  s2_out6,  s2_out7,  
            s2_out8,  s2_out9,  s2_out10, s2_out11, s2_out12, s2_out13, s2_out14, s2_out15, 
            s2_out16, s2_out17, s2_out18, s2_out19, s2_out20, s2_out21, s2_out22, s2_out23, 
            s2_out24, s2_out25, s2_out26, s2_out27, s2_out28, s2_out29, s2_out30, s2_out31, 
            s2_out32, s2_out33, s2_out34, s2_out35, s2_out36, s2_out37, s2_out38, s2_out39, 
            s2_out40, s2_out41, s2_out42, s2_out43, s2_out44, s2_out45, s2_out46, s2_out47, 
            s2_out48, s2_out49, s2_out50, s2_out51, s2_out52, s2_out53, s2_out54, s2_out55, 
            s2_out56, s2_out57, s2_out58, s2_out59, s2_out60, s2_out61, s2_out62, s2_out63 : complex12;
            
    signal  s2_reg0,  s2_reg1,  s2_reg2,  s2_reg3,  s2_reg4,  s2_reg5,  s2_reg6,  s2_reg7,  
            s2_reg8,  s2_reg9,  s2_reg10, s2_reg11, s2_reg12, s2_reg13, s2_reg14, s2_reg15, 
            s2_reg16, s2_reg17, s2_reg18, s2_reg19, s2_reg20, s2_reg21, s2_reg22, s2_reg23, 
            s2_reg24, s2_reg25, s2_reg26, s2_reg27, s2_reg28, s2_reg29, s2_reg30, s2_reg31, 
            s2_reg32, s2_reg33, s2_reg34, s2_reg35, s2_reg36, s2_reg37, s2_reg38, s2_reg39, 
            s2_reg40, s2_reg41, s2_reg42, s2_reg43, s2_reg44, s2_reg45, s2_reg46, s2_reg47, 
            s2_reg48, s2_reg49, s2_reg50, s2_reg51, s2_reg52, s2_reg53, s2_reg54, s2_reg55, 
            s2_reg56, s2_reg57, s2_reg58, s2_reg59, s2_reg60, s2_reg61, s2_reg62, s2_reg63 : complex12;
            
    -- ===== STAGE 3 =====
    component fft_stage_3 is
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
    end component fft_stage_3;
    
    signal  s3_out0,  s3_out1,  s3_out2,  s3_out3,  s3_out4,  s3_out5,  s3_out6,  s3_out7,  
            s3_out8,  s3_out9,  s3_out10, s3_out11, s3_out12, s3_out13, s3_out14, s3_out15, 
            s3_out16, s3_out17, s3_out18, s3_out19, s3_out20, s3_out21, s3_out22, s3_out23, 
            s3_out24, s3_out25, s3_out26, s3_out27, s3_out28, s3_out29, s3_out30, s3_out31, 
            s3_out32, s3_out33, s3_out34, s3_out35, s3_out36, s3_out37, s3_out38, s3_out39, 
            s3_out40, s3_out41, s3_out42, s3_out43, s3_out44, s3_out45, s3_out46, s3_out47, 
            s3_out48, s3_out49, s3_out50, s3_out51, s3_out52, s3_out53, s3_out54, s3_out55, 
            s3_out56, s3_out57, s3_out58, s3_out59, s3_out60, s3_out61, s3_out62, s3_out63 : complex12;
            
    signal  s3_reg0,  s3_reg1,  s3_reg2,  s3_reg3,  s3_reg4,  s3_reg5,  s3_reg6,  s3_reg7,  
            s3_reg8,  s3_reg9,  s3_reg10, s3_reg11, s3_reg12, s3_reg13, s3_reg14, s3_reg15, 
            s3_reg16, s3_reg17, s3_reg18, s3_reg19, s3_reg20, s3_reg21, s3_reg22, s3_reg23, 
            s3_reg24, s3_reg25, s3_reg26, s3_reg27, s3_reg28, s3_reg29, s3_reg30, s3_reg31, 
            s3_reg32, s3_reg33, s3_reg34, s3_reg35, s3_reg36, s3_reg37, s3_reg38, s3_reg39, 
            s3_reg40, s3_reg41, s3_reg42, s3_reg43, s3_reg44, s3_reg45, s3_reg46, s3_reg47, 
            s3_reg48, s3_reg49, s3_reg50, s3_reg51, s3_reg52, s3_reg53, s3_reg54, s3_reg55, 
            s3_reg56, s3_reg57, s3_reg58, s3_reg59, s3_reg60, s3_reg61, s3_reg62, s3_reg63 : complex12;
            
    -- ===== STAGE 4 =====
    component fft_stage_4 is
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
    end component fft_stage_4;
    
    signal s1_start, s1_start2 : std_logic;
    signal s2_start, s2_start2 : std_logic;
    signal s3_start, s3_start2 : std_logic;
    signal s4_start, s4_start2 : std_logic;
    signal save_stage1, save_stage2, save_stage3 : std_logic;
    
    signal ps, cs, ns : std_logic_vector(3 downto 0) := "0000";
begin
    -- ===== CONTROLLER (FSM) =====
    next_state : process(start, cs)
    begin
        ns <= cs;
        case cs is
            when "0000" => 
                if start='1' then
                    ns <= "0001";
                end if;
            when "0001" => ns <= "0010";
            when "0010" => ns <= "0011";
            when "0011" => ns <= "0100";
            when "0100" => ns <= "0101";
            when "0101" => ns <= "0110";
            when "0110" => ns <= "0111";
            when "0111" => ns <= "1000";
            when "1000" => ns <= "1001";
            when "1001" => ns <= "1010";
            when "1010" => ns <= "1011";
            when "1011" => ns <= "0000";
            when others => report "INVALID STATE FFT_ZP";
        end case;
    end process next_state;
    
    update_cs : process(clock, reset, ns)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= "0000";
                ps <= "0000";
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process update_cs;
    
    s1_start    <= '1' when cs="0001" else '0';
    s1_start2   <= '1' when cs="0010" else '0';
    save_stage1 <= '1' when cs="0011" else '0';
    s2_start    <= '1' when cs="0100" else '0';
    s2_start2   <= '1' when cs="0101" else '0';
    save_stage2 <= '1' when cs="0110" else '0';
    s3_start    <= '1' when cs="0111" else '0';
    s3_start2   <= '1' when cs="1000" else '0';
    save_stage3 <= '1' when cs="1001" else '0';
    s4_start    <= '1' when cs="1010" else '0';
    s4_start2   <= '1' when cs="1011" else '0';
    done        <= '1' when cs="0000" and ps="1011" else '0';

    -- =========================================== STAGE 1 ===========================================
    S1 : fft_stage_1 port map(
        clock => clock,
        reset => reset,
        start => s1_start,
        start2 => s1_start2,
        
        op0=>input(0),       op1=>input(1),       op2=>input(2),       op3=>input(3),       op4=>input(4),       op5=>input(5),       op6=>input(6),       op7=>input(7),
        res0=>s1_out0,  res1=>s1_out1,  res2=>s1_out2,  res3=>s1_out3,  res4=>s1_out4,  res5=>s1_out5,  res6=>s1_out6,  res7=>s1_out7, 
        resA=>s1_out8,  resB=>s1_out9,  resC=>s1_out10, resD=>s1_out11, resE=>s1_out12, resF=>s1_out13, resG=>s1_out14, resH=>s1_out15, 
        resI=>s1_out16, resJ=>s1_out17, resK=>s1_out18, resL=>s1_out19, resM=>s1_out20, resN=>s1_out21, resO=>s1_out22, resP=>s1_out23, 
        resQ=>s1_out24, resR=>s1_out25, resS=>s1_out26, resT=>s1_out27, resU=>s1_out28, resV=>s1_out29, resW=>s1_out30, resX=>s1_out31
    );
    
    update_stage1 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                s1_reg0.c <= '0'; s1_reg0.l.s <= '0'; s1_reg0.r.s <= '0'; s1_reg0.l.m <= (others => '0'); s1_reg0.r.m <= (others => '0');
                s1_reg1.c <= '0'; s1_reg1.l.s <= '0'; s1_reg1.r.s <= '0'; s1_reg1.l.m <= (others => '0'); s1_reg1.r.m <= (others => '0');
                s1_reg2.c <= '0'; s1_reg2.l.s <= '0'; s1_reg2.r.s <= '0'; s1_reg2.l.m <= (others => '0'); s1_reg2.r.m <= (others => '0');
                s1_reg3.c <= '0'; s1_reg3.l.s <= '0'; s1_reg3.r.s <= '0'; s1_reg3.l.m <= (others => '0'); s1_reg3.r.m <= (others => '0');
                s1_reg4.c <= '0'; s1_reg4.l.s <= '0'; s1_reg4.r.s <= '0'; s1_reg4.l.m <= (others => '0'); s1_reg4.r.m <= (others => '0');
                s1_reg5.c <= '0'; s1_reg5.l.s <= '0'; s1_reg5.r.s <= '0'; s1_reg5.l.m <= (others => '0'); s1_reg5.r.m <= (others => '0');
                s1_reg6.c <= '0'; s1_reg6.l.s <= '0'; s1_reg6.r.s <= '0'; s1_reg6.l.m <= (others => '0'); s1_reg6.r.m <= (others => '0');
                s1_reg7.c <= '0'; s1_reg7.l.s <= '0'; s1_reg7.r.s <= '0'; s1_reg7.l.m <= (others => '0'); s1_reg7.r.m <= (others => '0');

                s1_reg8.c <= '0'; s1_reg8.l.s <= '0'; s1_reg8.r.s <= '0'; s1_reg8.l.m <= (others => '0'); s1_reg8.r.m <= (others => '0');
                s1_reg9.c <= '0'; s1_reg9.l.s <= '0'; s1_reg9.r.s <= '0'; s1_reg9.l.m <= (others => '0'); s1_reg9.r.m <= (others => '0');
                s1_reg10.c <= '0'; s1_reg10.l.s <= '0'; s1_reg10.r.s <= '0'; s1_reg10.l.m <= (others => '0'); s1_reg10.r.m <= (others => '0');
                s1_reg11.c <= '0'; s1_reg11.l.s <= '0'; s1_reg11.r.s <= '0'; s1_reg11.l.m <= (others => '0'); s1_reg11.r.m <= (others => '0');
                s1_reg12.c <= '0'; s1_reg12.l.s <= '0'; s1_reg12.r.s <= '0'; s1_reg12.l.m <= (others => '0'); s1_reg12.r.m <= (others => '0');
                s1_reg13.c <= '0'; s1_reg13.l.s <= '0'; s1_reg13.r.s <= '0'; s1_reg13.l.m <= (others => '0'); s1_reg13.r.m <= (others => '0');
                s1_reg14.c <= '0'; s1_reg14.l.s <= '0'; s1_reg14.r.s <= '0'; s1_reg14.l.m <= (others => '0'); s1_reg14.r.m <= (others => '0');
                s1_reg15.c <= '0'; s1_reg15.l.s <= '0'; s1_reg15.r.s <= '0'; s1_reg15.l.m <= (others => '0'); s1_reg15.r.m <= (others => '0');

                s1_reg16.c <= '0'; s1_reg16.l.s <= '0'; s1_reg16.r.s <= '0'; s1_reg16.l.m <= (others => '0'); s1_reg16.r.m <= (others => '0');
                s1_reg17.c <= '0'; s1_reg17.l.s <= '0'; s1_reg17.r.s <= '0'; s1_reg17.l.m <= (others => '0'); s1_reg17.r.m <= (others => '0');
                s1_reg18.c <= '0'; s1_reg18.l.s <= '0'; s1_reg18.r.s <= '0'; s1_reg18.l.m <= (others => '0'); s1_reg18.r.m <= (others => '0');
                s1_reg19.c <= '0'; s1_reg19.l.s <= '0'; s1_reg19.r.s <= '0'; s1_reg19.l.m <= (others => '0'); s1_reg19.r.m <= (others => '0');
                s1_reg20.c <= '0'; s1_reg20.l.s <= '0'; s1_reg20.r.s <= '0'; s1_reg20.l.m <= (others => '0'); s1_reg20.r.m <= (others => '0');
                s1_reg21.c <= '0'; s1_reg21.l.s <= '0'; s1_reg21.r.s <= '0'; s1_reg21.l.m <= (others => '0'); s1_reg21.r.m <= (others => '0');
                s1_reg22.c <= '0'; s1_reg22.l.s <= '0'; s1_reg22.r.s <= '0'; s1_reg22.l.m <= (others => '0'); s1_reg22.r.m <= (others => '0');
                s1_reg23.c <= '0'; s1_reg23.l.s <= '0'; s1_reg23.r.s <= '0'; s1_reg23.l.m <= (others => '0'); s1_reg23.r.m <= (others => '0');

                s1_reg24.c <= '0'; s1_reg24.l.s <= '0'; s1_reg24.r.s <= '0'; s1_reg24.l.m <= (others => '0'); s1_reg24.r.m <= (others => '0');
                s1_reg25.c <= '0'; s1_reg25.l.s <= '0'; s1_reg25.r.s <= '0'; s1_reg25.l.m <= (others => '0'); s1_reg25.r.m <= (others => '0');
                s1_reg26.c <= '0'; s1_reg26.l.s <= '0'; s1_reg26.r.s <= '0'; s1_reg26.l.m <= (others => '0'); s1_reg26.r.m <= (others => '0');
                s1_reg27.c <= '0'; s1_reg27.l.s <= '0'; s1_reg27.r.s <= '0'; s1_reg27.l.m <= (others => '0'); s1_reg27.r.m <= (others => '0');
                s1_reg28.c <= '0'; s1_reg28.l.s <= '0'; s1_reg28.r.s <= '0'; s1_reg28.l.m <= (others => '0'); s1_reg28.r.m <= (others => '0');
                s1_reg29.c <= '0'; s1_reg29.l.s <= '0'; s1_reg29.r.s <= '0'; s1_reg29.l.m <= (others => '0'); s1_reg29.r.m <= (others => '0');
                s1_reg30.c <= '0'; s1_reg30.l.s <= '0'; s1_reg30.r.s <= '0'; s1_reg30.l.m <= (others => '0'); s1_reg30.r.m <= (others => '0');
                s1_reg31.c <= '0'; s1_reg31.l.s <= '0'; s1_reg31.r.s <= '0'; s1_reg31.l.m <= (others => '0'); s1_reg31.r.m <= (others => '0');
            elsif save_stage1='1' then
                s1_reg0<=s1_out0;   s1_reg1<=s1_out1;   s1_reg2<=s1_out2;   s1_reg3<=s1_out3;   s1_reg4<=s1_out4;   s1_reg5<=s1_out5;   s1_reg6<=s1_out6;   s1_reg7<=s1_out7; 
                s1_reg8<=s1_out8;   s1_reg9<=s1_out9;   s1_reg10<=s1_out10; s1_reg11<=s1_out11; s1_reg12<=s1_out12; s1_reg13<=s1_out13; s1_reg14<=s1_out14; s1_reg15<=s1_out15; 
                s1_reg16<=s1_out16; s1_reg17<=s1_out17; s1_reg18<=s1_out18; s1_reg19<=s1_out19; s1_reg20<=s1_out20; s1_reg21<=s1_out21; s1_reg22<=s1_out22; s1_reg23<=s1_out23; 
                s1_reg24<=s1_out24; s1_reg25<=s1_out25; s1_reg26<=s1_out26; s1_reg27<=s1_out27; s1_reg28<=s1_out28; s1_reg29<=s1_out29; s1_reg30<=s1_out30; s1_reg31<=s1_out31;
            end if;
        end if;
    end process update_stage1;
    
    -- =========================================== STAGE 2 ===========================================
    S2 : fft_stage_2
    port map (clock  => clock,
              reset  => reset,
              start  => s2_start,
              start2 => s2_start2,
              op0=>s1_reg0, op1=>s1_reg1, op2=>s1_reg2, op3=>s1_reg3, op4=>s1_reg4, op5=>s1_reg5, op6=>s1_reg6, op7=>s1_reg7, 
              opA=>s1_reg8, opB=>s1_reg9, opC=>s1_reg10, opD=>s1_reg11, opE=>s1_reg12, opF=>s1_reg13, opG=>s1_reg14, opH=>s1_reg15, 
              opI=>s1_reg16, opJ=>s1_reg17, opK=>s1_reg18, opL=>s1_reg19, opM=>s1_reg20, opN=>s1_reg21, opO=>s1_reg22, opP=>s1_reg23, 
              opQ=>s1_reg24, opR=>s1_reg25, opS=>s1_reg26, opT=>s1_reg27, opU=>s1_reg28, opV=>s1_reg29, opW=>s1_reg30, opX=>s1_reg31,
              
              res0=>s2_out0, res1=>s2_out1, res2=>s2_out2, res3=>s2_out3, res4=>s2_out4, res5=>s2_out5, res6=>s2_out6, res7=>s2_out7, 
              res8=>s2_out8, res9=>s2_out9, res10=>s2_out10, res11=>s2_out11, res12=>s2_out12, res13=>s2_out13, res14=>s2_out14, res15=>s2_out15, 
              res16=>s2_out16, res17=>s2_out17, res18=>s2_out18, res19=>s2_out19, res20=>s2_out20, res21=>s2_out21, res22=>s2_out22, res23=>s2_out23, 
              res24=>s2_out24, res25=>s2_out25, res26=>s2_out26, res27=>s2_out27, res28=>s2_out28, res29=>s2_out29, res30=>s2_out30, res31=>s2_out31, 
              res32=>s2_out32, res33=>s2_out33, res34=>s2_out34, res35=>s2_out35, res36=>s2_out36, res37=>s2_out37, res38=>s2_out38, res39=>s2_out39, 
              res40=>s2_out40, res41=>s2_out41, res42=>s2_out42, res43=>s2_out43, res44=>s2_out44, res45=>s2_out45, res46=>s2_out46, res47=>s2_out47, 
              res48=>s2_out48, res49=>s2_out49, res50=>s2_out50, res51=>s2_out51, res52=>s2_out52, res53=>s2_out53, res54=>s2_out54, res55=>s2_out55, 
              res56=>s2_out56, res57=>s2_out57, res58=>s2_out58, res59=>s2_out59, res60=>s2_out60, res61=>s2_out61, res62=>s2_out62, res63=>s2_out63
    );
    
    update_stage2 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                s2_reg0.c <= '0'; s2_reg0.l.s <= '0'; s2_reg0.r.s <= '0'; s2_reg0.l.m <= (others => '0'); s2_reg0.r.m <= (others => '0');
                s2_reg1.c <= '0'; s2_reg1.l.s <= '0'; s2_reg1.r.s <= '0'; s2_reg1.l.m <= (others => '0'); s2_reg1.r.m <= (others => '0');
                s2_reg2.c <= '0'; s2_reg2.l.s <= '0'; s2_reg2.r.s <= '0'; s2_reg2.l.m <= (others => '0'); s2_reg2.r.m <= (others => '0');
                s2_reg3.c <= '0'; s2_reg3.l.s <= '0'; s2_reg3.r.s <= '0'; s2_reg3.l.m <= (others => '0'); s2_reg3.r.m <= (others => '0');
                s2_reg4.c <= '0'; s2_reg4.l.s <= '0'; s2_reg4.r.s <= '0'; s2_reg4.l.m <= (others => '0'); s2_reg4.r.m <= (others => '0');
                s2_reg5.c <= '0'; s2_reg5.l.s <= '0'; s2_reg5.r.s <= '0'; s2_reg5.l.m <= (others => '0'); s2_reg5.r.m <= (others => '0');
                s2_reg6.c <= '0'; s2_reg6.l.s <= '0'; s2_reg6.r.s <= '0'; s2_reg6.l.m <= (others => '0'); s2_reg6.r.m <= (others => '0');
                s2_reg7.c <= '0'; s2_reg7.l.s <= '0'; s2_reg7.r.s <= '0'; s2_reg7.l.m <= (others => '0'); s2_reg7.r.m <= (others => '0');

                s2_reg8.c <= '0'; s2_reg8.l.s <= '0'; s2_reg8.r.s <= '0'; s2_reg8.l.m <= (others => '0'); s2_reg8.r.m <= (others => '0');
                s2_reg9.c <= '0'; s2_reg9.l.s <= '0'; s2_reg9.r.s <= '0'; s2_reg9.l.m <= (others => '0'); s2_reg9.r.m <= (others => '0');
                s2_reg10.c <= '0'; s2_reg10.l.s <= '0'; s2_reg10.r.s <= '0'; s2_reg10.l.m <= (others => '0'); s2_reg10.r.m <= (others => '0');
                s2_reg11.c <= '0'; s2_reg11.l.s <= '0'; s2_reg11.r.s <= '0'; s2_reg11.l.m <= (others => '0'); s2_reg11.r.m <= (others => '0');
                s2_reg12.c <= '0'; s2_reg12.l.s <= '0'; s2_reg12.r.s <= '0'; s2_reg12.l.m <= (others => '0'); s2_reg12.r.m <= (others => '0');
                s2_reg13.c <= '0'; s2_reg13.l.s <= '0'; s2_reg13.r.s <= '0'; s2_reg13.l.m <= (others => '0'); s2_reg13.r.m <= (others => '0');
                s2_reg14.c <= '0'; s2_reg14.l.s <= '0'; s2_reg14.r.s <= '0'; s2_reg14.l.m <= (others => '0'); s2_reg14.r.m <= (others => '0');
                s2_reg15.c <= '0'; s2_reg15.l.s <= '0'; s2_reg15.r.s <= '0'; s2_reg15.l.m <= (others => '0'); s2_reg15.r.m <= (others => '0');

                s2_reg16.c <= '0'; s2_reg16.l.s <= '0'; s2_reg16.r.s <= '0'; s2_reg16.l.m <= (others => '0'); s2_reg16.r.m <= (others => '0');
                s2_reg17.c <= '0'; s2_reg17.l.s <= '0'; s2_reg17.r.s <= '0'; s2_reg17.l.m <= (others => '0'); s2_reg17.r.m <= (others => '0');
                s2_reg18.c <= '0'; s2_reg18.l.s <= '0'; s2_reg18.r.s <= '0'; s2_reg18.l.m <= (others => '0'); s2_reg18.r.m <= (others => '0');
                s2_reg19.c <= '0'; s2_reg19.l.s <= '0'; s2_reg19.r.s <= '0'; s2_reg19.l.m <= (others => '0'); s2_reg19.r.m <= (others => '0');
                s2_reg20.c <= '0'; s2_reg20.l.s <= '0'; s2_reg20.r.s <= '0'; s2_reg20.l.m <= (others => '0'); s2_reg20.r.m <= (others => '0');
                s2_reg21.c <= '0'; s2_reg21.l.s <= '0'; s2_reg21.r.s <= '0'; s2_reg21.l.m <= (others => '0'); s2_reg21.r.m <= (others => '0');
                s2_reg22.c <= '0'; s2_reg22.l.s <= '0'; s2_reg22.r.s <= '0'; s2_reg22.l.m <= (others => '0'); s2_reg22.r.m <= (others => '0');
                s2_reg23.c <= '0'; s2_reg23.l.s <= '0'; s2_reg23.r.s <= '0'; s2_reg23.l.m <= (others => '0'); s2_reg23.r.m <= (others => '0');

                s2_reg24.c <= '0'; s2_reg24.l.s <= '0'; s2_reg24.r.s <= '0'; s2_reg24.l.m <= (others => '0'); s2_reg24.r.m <= (others => '0');
                s2_reg25.c <= '0'; s2_reg25.l.s <= '0'; s2_reg25.r.s <= '0'; s2_reg25.l.m <= (others => '0'); s2_reg25.r.m <= (others => '0');
                s2_reg26.c <= '0'; s2_reg26.l.s <= '0'; s2_reg26.r.s <= '0'; s2_reg26.l.m <= (others => '0'); s2_reg26.r.m <= (others => '0');
                s2_reg27.c <= '0'; s2_reg27.l.s <= '0'; s2_reg27.r.s <= '0'; s2_reg27.l.m <= (others => '0'); s2_reg27.r.m <= (others => '0');
                s2_reg28.c <= '0'; s2_reg28.l.s <= '0'; s2_reg28.r.s <= '0'; s2_reg28.l.m <= (others => '0'); s2_reg28.r.m <= (others => '0');
                s2_reg29.c <= '0'; s2_reg29.l.s <= '0'; s2_reg29.r.s <= '0'; s2_reg29.l.m <= (others => '0'); s2_reg29.r.m <= (others => '0');
                s2_reg30.c <= '0'; s2_reg30.l.s <= '0'; s2_reg30.r.s <= '0'; s2_reg30.l.m <= (others => '0'); s2_reg30.r.m <= (others => '0');
                s2_reg31.c <= '0'; s2_reg31.l.s <= '0'; s2_reg31.r.s <= '0'; s2_reg31.l.m <= (others => '0'); s2_reg31.r.m <= (others => '0');

                s2_reg32.c <= '0'; s2_reg32.l.s <= '0'; s2_reg32.r.s <= '0'; s2_reg32.l.m <= (others => '0'); s2_reg32.r.m <= (others => '0');
                s2_reg33.c <= '0'; s2_reg33.l.s <= '0'; s2_reg33.r.s <= '0'; s2_reg33.l.m <= (others => '0'); s2_reg33.r.m <= (others => '0');
                s2_reg34.c <= '0'; s2_reg34.l.s <= '0'; s2_reg34.r.s <= '0'; s2_reg34.l.m <= (others => '0'); s2_reg34.r.m <= (others => '0');
                s2_reg35.c <= '0'; s2_reg35.l.s <= '0'; s2_reg35.r.s <= '0'; s2_reg35.l.m <= (others => '0'); s2_reg35.r.m <= (others => '0');
                s2_reg36.c <= '0'; s2_reg36.l.s <= '0'; s2_reg36.r.s <= '0'; s2_reg36.l.m <= (others => '0'); s2_reg36.r.m <= (others => '0');
                s2_reg37.c <= '0'; s2_reg37.l.s <= '0'; s2_reg37.r.s <= '0'; s2_reg37.l.m <= (others => '0'); s2_reg37.r.m <= (others => '0');
                s2_reg38.c <= '0'; s2_reg38.l.s <= '0'; s2_reg38.r.s <= '0'; s2_reg38.l.m <= (others => '0'); s2_reg38.r.m <= (others => '0');
                s2_reg39.c <= '0'; s2_reg39.l.s <= '0'; s2_reg39.r.s <= '0'; s2_reg39.l.m <= (others => '0'); s2_reg39.r.m <= (others => '0');

                s2_reg40.c <= '0'; s2_reg40.l.s <= '0'; s2_reg40.r.s <= '0'; s2_reg40.l.m <= (others => '0'); s2_reg40.r.m <= (others => '0');
                s2_reg41.c <= '0'; s2_reg41.l.s <= '0'; s2_reg41.r.s <= '0'; s2_reg41.l.m <= (others => '0'); s2_reg41.r.m <= (others => '0');
                s2_reg42.c <= '0'; s2_reg42.l.s <= '0'; s2_reg42.r.s <= '0'; s2_reg42.l.m <= (others => '0'); s2_reg42.r.m <= (others => '0');
                s2_reg43.c <= '0'; s2_reg43.l.s <= '0'; s2_reg43.r.s <= '0'; s2_reg43.l.m <= (others => '0'); s2_reg43.r.m <= (others => '0');
                s2_reg44.c <= '0'; s2_reg44.l.s <= '0'; s2_reg44.r.s <= '0'; s2_reg44.l.m <= (others => '0'); s2_reg44.r.m <= (others => '0');
                s2_reg45.c <= '0'; s2_reg45.l.s <= '0'; s2_reg45.r.s <= '0'; s2_reg45.l.m <= (others => '0'); s2_reg45.r.m <= (others => '0');
                s2_reg46.c <= '0'; s2_reg46.l.s <= '0'; s2_reg46.r.s <= '0'; s2_reg46.l.m <= (others => '0'); s2_reg46.r.m <= (others => '0');
                s2_reg47.c <= '0'; s2_reg47.l.s <= '0'; s2_reg47.r.s <= '0'; s2_reg47.l.m <= (others => '0'); s2_reg47.r.m <= (others => '0');

                s2_reg48.c <= '0'; s2_reg48.l.s <= '0'; s2_reg48.r.s <= '0'; s2_reg48.l.m <= (others => '0'); s2_reg48.r.m <= (others => '0');
                s2_reg49.c <= '0'; s2_reg49.l.s <= '0'; s2_reg49.r.s <= '0'; s2_reg49.l.m <= (others => '0'); s2_reg49.r.m <= (others => '0');
                s2_reg50.c <= '0'; s2_reg50.l.s <= '0'; s2_reg50.r.s <= '0'; s2_reg50.l.m <= (others => '0'); s2_reg50.r.m <= (others => '0');
                s2_reg51.c <= '0'; s2_reg51.l.s <= '0'; s2_reg51.r.s <= '0'; s2_reg51.l.m <= (others => '0'); s2_reg51.r.m <= (others => '0');
                s2_reg52.c <= '0'; s2_reg52.l.s <= '0'; s2_reg52.r.s <= '0'; s2_reg52.l.m <= (others => '0'); s2_reg52.r.m <= (others => '0');
                s2_reg53.c <= '0'; s2_reg53.l.s <= '0'; s2_reg53.r.s <= '0'; s2_reg53.l.m <= (others => '0'); s2_reg53.r.m <= (others => '0');
                s2_reg54.c <= '0'; s2_reg54.l.s <= '0'; s2_reg54.r.s <= '0'; s2_reg54.l.m <= (others => '0'); s2_reg54.r.m <= (others => '0');
                s2_reg55.c <= '0'; s2_reg55.l.s <= '0'; s2_reg55.r.s <= '0'; s2_reg55.l.m <= (others => '0'); s2_reg55.r.m <= (others => '0');

                s2_reg56.c <= '0'; s2_reg56.l.s <= '0'; s2_reg56.r.s <= '0'; s2_reg56.l.m <= (others => '0'); s2_reg56.r.m <= (others => '0');
                s2_reg57.c <= '0'; s2_reg57.l.s <= '0'; s2_reg57.r.s <= '0'; s2_reg57.l.m <= (others => '0'); s2_reg57.r.m <= (others => '0');
                s2_reg58.c <= '0'; s2_reg58.l.s <= '0'; s2_reg58.r.s <= '0'; s2_reg58.l.m <= (others => '0'); s2_reg58.r.m <= (others => '0');
                s2_reg59.c <= '0'; s2_reg59.l.s <= '0'; s2_reg59.r.s <= '0'; s2_reg59.l.m <= (others => '0'); s2_reg59.r.m <= (others => '0');
                s2_reg60.c <= '0'; s2_reg60.l.s <= '0'; s2_reg60.r.s <= '0'; s2_reg60.l.m <= (others => '0'); s2_reg60.r.m <= (others => '0');
                s2_reg61.c <= '0'; s2_reg61.l.s <= '0'; s2_reg61.r.s <= '0'; s2_reg61.l.m <= (others => '0'); s2_reg61.r.m <= (others => '0');
                s2_reg62.c <= '0'; s2_reg62.l.s <= '0'; s2_reg62.r.s <= '0'; s2_reg62.l.m <= (others => '0'); s2_reg62.r.m <= (others => '0');
                s2_reg63.c <= '0'; s2_reg63.l.s <= '0'; s2_reg63.r.s <= '0'; s2_reg63.l.m <= (others => '0'); s2_reg63.r.m <= (others => '0');

            elsif save_stage2='1' then
                s2_reg0<=s2_out0; s2_reg1<=s2_out1; s2_reg2<=s2_out2; s2_reg3<=s2_out3; s2_reg4<=s2_out4; s2_reg5<=s2_out5; s2_reg6<=s2_out6; s2_reg7<=s2_out7; 
                s2_reg8<=s2_out8; s2_reg9<=s2_out9; s2_reg10<=s2_out10; s2_reg11<=s2_out11; s2_reg12<=s2_out12; s2_reg13<=s2_out13; s2_reg14<=s2_out14; s2_reg15<=s2_out15; 
                s2_reg16<=s2_out16; s2_reg17<=s2_out17; s2_reg18<=s2_out18; s2_reg19<=s2_out19; s2_reg20<=s2_out20; s2_reg21<=s2_out21; s2_reg22<=s2_out22; s2_reg23<=s2_out23; 
                s2_reg24<=s2_out24; s2_reg25<=s2_out25; s2_reg26<=s2_out26; s2_reg27<=s2_out27; s2_reg28<=s2_out28; s2_reg29<=s2_out29; s2_reg30<=s2_out30; s2_reg31<=s2_out31; 
                s2_reg32<=s2_out32; s2_reg33<=s2_out33; s2_reg34<=s2_out34; s2_reg35<=s2_out35; s2_reg36<=s2_out36; s2_reg37<=s2_out37; s2_reg38<=s2_out38; s2_reg39<=s2_out39; 
                s2_reg40<=s2_out40; s2_reg41<=s2_out41; s2_reg42<=s2_out42; s2_reg43<=s2_out43; s2_reg44<=s2_out44; s2_reg45<=s2_out45; s2_reg46<=s2_out46; s2_reg47<=s2_out47; 
                s2_reg48<=s2_out48; s2_reg49<=s2_out49; s2_reg50<=s2_out50; s2_reg51<=s2_out51; s2_reg52<=s2_out52; s2_reg53<=s2_out53; s2_reg54<=s2_out54; s2_reg55<=s2_out55; 
                s2_reg56<=s2_out56; s2_reg57<=s2_out57; s2_reg58<=s2_out58; s2_reg59<=s2_out59; s2_reg60<=s2_out60; s2_reg61<=s2_out61; s2_reg62<=s2_out62; s2_reg63<=s2_out63;
            end if;
        end if;
    end process update_stage2;
    
    -- =========================================== STAGE 3 ===========================================
    S3 : fft_stage_3
    port map (  clock  => clock,
                reset  => reset,
                start  => s3_start,
                start2 => s3_start2,
                
                op0=>s2_reg0, op1=>s2_reg1, op2=>s2_reg2, op3=>s2_reg3, op4=>s2_reg4, op5=>s2_reg5, op6=>s2_reg6, op7=>s2_reg7, 
                op8=>s2_reg8, op9=>s2_reg9, op10=>s2_reg10, op11=>s2_reg11, op12=>s2_reg12, op13=>s2_reg13, op14=>s2_reg14, op15=>s2_reg15, 
                op16=>s2_reg16, op17=>s2_reg17, op18=>s2_reg18, op19=>s2_reg19, op20=>s2_reg20, op21=>s2_reg21, op22=>s2_reg22, op23=>s2_reg23, 
                op24=>s2_reg24, op25=>s2_reg25, op26=>s2_reg26, op27=>s2_reg27, op28=>s2_reg28, op29=>s2_reg29, op30=>s2_reg30, op31=>s2_reg31, 
                op32=>s2_reg32, op33=>s2_reg33, op34=>s2_reg34, op35=>s2_reg35, op36=>s2_reg36, op37=>s2_reg37, op38=>s2_reg38, op39=>s2_reg39, 
                op40=>s2_reg40, op41=>s2_reg41, op42=>s2_reg42, op43=>s2_reg43, op44=>s2_reg44, op45=>s2_reg45, op46=>s2_reg46, op47=>s2_reg47, 
                op48=>s2_reg48, op49=>s2_reg49, op50=>s2_reg50, op51=>s2_reg51, op52=>s2_reg52, op53=>s2_reg53, op54=>s2_reg54, op55=>s2_reg55, 
                op56=>s2_reg56, op57=>s2_reg57, op58=>s2_reg58, op59=>s2_reg59, op60=>s2_reg60, op61=>s2_reg61, op62=>s2_reg62, op63=>s2_reg63,

                res0=>s3_out0, res1=>s3_out1, res2=>s3_out2, res3=>s3_out3, res4=>s3_out4, res5=>s3_out5, res6=>s3_out6, res7=>s3_out7, 
                res8=>s3_out8, res9=>s3_out9, res10=>s3_out10, res11=>s3_out11, res12=>s3_out12, res13=>s3_out13, res14=>s3_out14, res15=>s3_out15, 
                res16=>s3_out16, res17=>s3_out17, res18=>s3_out18, res19=>s3_out19, res20=>s3_out20, res21=>s3_out21, res22=>s3_out22, res23=>s3_out23, 
                res24=>s3_out24, res25=>s3_out25, res26=>s3_out26, res27=>s3_out27, res28=>s3_out28, res29=>s3_out29, res30=>s3_out30, res31=>s3_out31, 
                res32=>s3_out32, res33=>s3_out33, res34=>s3_out34, res35=>s3_out35, res36=>s3_out36, res37=>s3_out37, res38=>s3_out38, res39=>s3_out39, 
                res40=>s3_out40, res41=>s3_out41, res42=>s3_out42, res43=>s3_out43, res44=>s3_out44, res45=>s3_out45, res46=>s3_out46, res47=>s3_out47, 
                res48=>s3_out48, res49=>s3_out49, res50=>s3_out50, res51=>s3_out51, res52=>s3_out52, res53=>s3_out53, res54=>s3_out54, res55=>s3_out55, 
                res56=>s3_out56, res57=>s3_out57, res58=>s3_out58, res59=>s3_out59, res60=>s3_out60, res61=>s3_out61, res62=>s3_out62, res63=>s3_out63 
    );
    
    update_stage3 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                s3_reg0.c <= '0'; s3_reg0.l.s <= '0'; s3_reg0.r.s <= '0'; s3_reg0.l.m <= (others => '0'); s3_reg0.r.m <= (others => '0');
                s3_reg1.c <= '0'; s3_reg1.l.s <= '0'; s3_reg1.r.s <= '0'; s3_reg1.l.m <= (others => '0'); s3_reg1.r.m <= (others => '0');
                s3_reg2.c <= '0'; s3_reg2.l.s <= '0'; s3_reg2.r.s <= '0'; s3_reg2.l.m <= (others => '0'); s3_reg2.r.m <= (others => '0');
                s3_reg3.c <= '0'; s3_reg3.l.s <= '0'; s3_reg3.r.s <= '0'; s3_reg3.l.m <= (others => '0'); s3_reg3.r.m <= (others => '0');
                s3_reg4.c <= '0'; s3_reg4.l.s <= '0'; s3_reg4.r.s <= '0'; s3_reg4.l.m <= (others => '0'); s3_reg4.r.m <= (others => '0');
                s3_reg5.c <= '0'; s3_reg5.l.s <= '0'; s3_reg5.r.s <= '0'; s3_reg5.l.m <= (others => '0'); s3_reg5.r.m <= (others => '0');
                s3_reg6.c <= '0'; s3_reg6.l.s <= '0'; s3_reg6.r.s <= '0'; s3_reg6.l.m <= (others => '0'); s3_reg6.r.m <= (others => '0');
                s3_reg7.c <= '0'; s3_reg7.l.s <= '0'; s3_reg7.r.s <= '0'; s3_reg7.l.m <= (others => '0'); s3_reg7.r.m <= (others => '0');

                s3_reg8.c <= '0'; s3_reg8.l.s <= '0'; s3_reg8.r.s <= '0'; s3_reg8.l.m <= (others => '0'); s3_reg8.r.m <= (others => '0');
                s3_reg9.c <= '0'; s3_reg9.l.s <= '0'; s3_reg9.r.s <= '0'; s3_reg9.l.m <= (others => '0'); s3_reg9.r.m <= (others => '0');
                s3_reg10.c <= '0'; s3_reg10.l.s <= '0'; s3_reg10.r.s <= '0'; s3_reg10.l.m <= (others => '0'); s3_reg10.r.m <= (others => '0');
                s3_reg11.c <= '0'; s3_reg11.l.s <= '0'; s3_reg11.r.s <= '0'; s3_reg11.l.m <= (others => '0'); s3_reg11.r.m <= (others => '0');
                s3_reg12.c <= '0'; s3_reg12.l.s <= '0'; s3_reg12.r.s <= '0'; s3_reg12.l.m <= (others => '0'); s3_reg12.r.m <= (others => '0');
                s3_reg13.c <= '0'; s3_reg13.l.s <= '0'; s3_reg13.r.s <= '0'; s3_reg13.l.m <= (others => '0'); s3_reg13.r.m <= (others => '0');
                s3_reg14.c <= '0'; s3_reg14.l.s <= '0'; s3_reg14.r.s <= '0'; s3_reg14.l.m <= (others => '0'); s3_reg14.r.m <= (others => '0');
                s3_reg15.c <= '0'; s3_reg15.l.s <= '0'; s3_reg15.r.s <= '0'; s3_reg15.l.m <= (others => '0'); s3_reg15.r.m <= (others => '0');

                s3_reg16.c <= '0'; s3_reg16.l.s <= '0'; s3_reg16.r.s <= '0'; s3_reg16.l.m <= (others => '0'); s3_reg16.r.m <= (others => '0');
                s3_reg17.c <= '0'; s3_reg17.l.s <= '0'; s3_reg17.r.s <= '0'; s3_reg17.l.m <= (others => '0'); s3_reg17.r.m <= (others => '0');
                s3_reg18.c <= '0'; s3_reg18.l.s <= '0'; s3_reg18.r.s <= '0'; s3_reg18.l.m <= (others => '0'); s3_reg18.r.m <= (others => '0');
                s3_reg19.c <= '0'; s3_reg19.l.s <= '0'; s3_reg19.r.s <= '0'; s3_reg19.l.m <= (others => '0'); s3_reg19.r.m <= (others => '0');
                s3_reg20.c <= '0'; s3_reg20.l.s <= '0'; s3_reg20.r.s <= '0'; s3_reg20.l.m <= (others => '0'); s3_reg20.r.m <= (others => '0');
                s3_reg21.c <= '0'; s3_reg21.l.s <= '0'; s3_reg21.r.s <= '0'; s3_reg21.l.m <= (others => '0'); s3_reg21.r.m <= (others => '0');
                s3_reg22.c <= '0'; s3_reg22.l.s <= '0'; s3_reg22.r.s <= '0'; s3_reg22.l.m <= (others => '0'); s3_reg22.r.m <= (others => '0');
                s3_reg23.c <= '0'; s3_reg23.l.s <= '0'; s3_reg23.r.s <= '0'; s3_reg23.l.m <= (others => '0'); s3_reg23.r.m <= (others => '0');

                s3_reg24.c <= '0'; s3_reg24.l.s <= '0'; s3_reg24.r.s <= '0'; s3_reg24.l.m <= (others => '0'); s3_reg24.r.m <= (others => '0');
                s3_reg25.c <= '0'; s3_reg25.l.s <= '0'; s3_reg25.r.s <= '0'; s3_reg25.l.m <= (others => '0'); s3_reg25.r.m <= (others => '0');
                s3_reg26.c <= '0'; s3_reg26.l.s <= '0'; s3_reg26.r.s <= '0'; s3_reg26.l.m <= (others => '0'); s3_reg26.r.m <= (others => '0');
                s3_reg27.c <= '0'; s3_reg27.l.s <= '0'; s3_reg27.r.s <= '0'; s3_reg27.l.m <= (others => '0'); s3_reg27.r.m <= (others => '0');
                s3_reg28.c <= '0'; s3_reg28.l.s <= '0'; s3_reg28.r.s <= '0'; s3_reg28.l.m <= (others => '0'); s3_reg28.r.m <= (others => '0');
                s3_reg29.c <= '0'; s3_reg29.l.s <= '0'; s3_reg29.r.s <= '0'; s3_reg29.l.m <= (others => '0'); s3_reg29.r.m <= (others => '0');
                s3_reg30.c <= '0'; s3_reg30.l.s <= '0'; s3_reg30.r.s <= '0'; s3_reg30.l.m <= (others => '0'); s3_reg30.r.m <= (others => '0');
                s3_reg31.c <= '0'; s3_reg31.l.s <= '0'; s3_reg31.r.s <= '0'; s3_reg31.l.m <= (others => '0'); s3_reg31.r.m <= (others => '0');

                s3_reg32.c <= '0'; s3_reg32.l.s <= '0'; s3_reg32.r.s <= '0'; s3_reg32.l.m <= (others => '0'); s3_reg32.r.m <= (others => '0');
                s3_reg33.c <= '0'; s3_reg33.l.s <= '0'; s3_reg33.r.s <= '0'; s3_reg33.l.m <= (others => '0'); s3_reg33.r.m <= (others => '0');
                s3_reg34.c <= '0'; s3_reg34.l.s <= '0'; s3_reg34.r.s <= '0'; s3_reg34.l.m <= (others => '0'); s3_reg34.r.m <= (others => '0');
                s3_reg35.c <= '0'; s3_reg35.l.s <= '0'; s3_reg35.r.s <= '0'; s3_reg35.l.m <= (others => '0'); s3_reg35.r.m <= (others => '0');
                s3_reg36.c <= '0'; s3_reg36.l.s <= '0'; s3_reg36.r.s <= '0'; s3_reg36.l.m <= (others => '0'); s3_reg36.r.m <= (others => '0');
                s3_reg37.c <= '0'; s3_reg37.l.s <= '0'; s3_reg37.r.s <= '0'; s3_reg37.l.m <= (others => '0'); s3_reg37.r.m <= (others => '0');
                s3_reg38.c <= '0'; s3_reg38.l.s <= '0'; s3_reg38.r.s <= '0'; s3_reg38.l.m <= (others => '0'); s3_reg38.r.m <= (others => '0');
                s3_reg39.c <= '0'; s3_reg39.l.s <= '0'; s3_reg39.r.s <= '0'; s3_reg39.l.m <= (others => '0'); s3_reg39.r.m <= (others => '0');

                s3_reg40.c <= '0'; s3_reg40.l.s <= '0'; s3_reg40.r.s <= '0'; s3_reg40.l.m <= (others => '0'); s3_reg40.r.m <= (others => '0');
                s3_reg41.c <= '0'; s3_reg41.l.s <= '0'; s3_reg41.r.s <= '0'; s3_reg41.l.m <= (others => '0'); s3_reg41.r.m <= (others => '0');
                s3_reg42.c <= '0'; s3_reg42.l.s <= '0'; s3_reg42.r.s <= '0'; s3_reg42.l.m <= (others => '0'); s3_reg42.r.m <= (others => '0');
                s3_reg43.c <= '0'; s3_reg43.l.s <= '0'; s3_reg43.r.s <= '0'; s3_reg43.l.m <= (others => '0'); s3_reg43.r.m <= (others => '0');
                s3_reg44.c <= '0'; s3_reg44.l.s <= '0'; s3_reg44.r.s <= '0'; s3_reg44.l.m <= (others => '0'); s3_reg44.r.m <= (others => '0');
                s3_reg45.c <= '0'; s3_reg45.l.s <= '0'; s3_reg45.r.s <= '0'; s3_reg45.l.m <= (others => '0'); s3_reg45.r.m <= (others => '0');
                s3_reg46.c <= '0'; s3_reg46.l.s <= '0'; s3_reg46.r.s <= '0'; s3_reg46.l.m <= (others => '0'); s3_reg46.r.m <= (others => '0');
                s3_reg47.c <= '0'; s3_reg47.l.s <= '0'; s3_reg47.r.s <= '0'; s3_reg47.l.m <= (others => '0'); s3_reg47.r.m <= (others => '0');

                s3_reg48.c <= '0'; s3_reg48.l.s <= '0'; s3_reg48.r.s <= '0'; s3_reg48.l.m <= (others => '0'); s3_reg48.r.m <= (others => '0');
                s3_reg49.c <= '0'; s3_reg49.l.s <= '0'; s3_reg49.r.s <= '0'; s3_reg49.l.m <= (others => '0'); s3_reg49.r.m <= (others => '0');
                s3_reg50.c <= '0'; s3_reg50.l.s <= '0'; s3_reg50.r.s <= '0'; s3_reg50.l.m <= (others => '0'); s3_reg50.r.m <= (others => '0');
                s3_reg51.c <= '0'; s3_reg51.l.s <= '0'; s3_reg51.r.s <= '0'; s3_reg51.l.m <= (others => '0'); s3_reg51.r.m <= (others => '0');
                s3_reg52.c <= '0'; s3_reg52.l.s <= '0'; s3_reg52.r.s <= '0'; s3_reg52.l.m <= (others => '0'); s3_reg52.r.m <= (others => '0');
                s3_reg53.c <= '0'; s3_reg53.l.s <= '0'; s3_reg53.r.s <= '0'; s3_reg53.l.m <= (others => '0'); s3_reg53.r.m <= (others => '0');
                s3_reg54.c <= '0'; s3_reg54.l.s <= '0'; s3_reg54.r.s <= '0'; s3_reg54.l.m <= (others => '0'); s3_reg54.r.m <= (others => '0');
                s3_reg55.c <= '0'; s3_reg55.l.s <= '0'; s3_reg55.r.s <= '0'; s3_reg55.l.m <= (others => '0'); s3_reg55.r.m <= (others => '0');

                s3_reg56.c <= '0'; s3_reg56.l.s <= '0'; s3_reg56.r.s <= '0'; s3_reg56.l.m <= (others => '0'); s3_reg56.r.m <= (others => '0');
                s3_reg57.c <= '0'; s3_reg57.l.s <= '0'; s3_reg57.r.s <= '0'; s3_reg57.l.m <= (others => '0'); s3_reg57.r.m <= (others => '0');
                s3_reg58.c <= '0'; s3_reg58.l.s <= '0'; s3_reg58.r.s <= '0'; s3_reg58.l.m <= (others => '0'); s3_reg58.r.m <= (others => '0');
                s3_reg59.c <= '0'; s3_reg59.l.s <= '0'; s3_reg59.r.s <= '0'; s3_reg59.l.m <= (others => '0'); s3_reg59.r.m <= (others => '0');
                s3_reg60.c <= '0'; s3_reg60.l.s <= '0'; s3_reg60.r.s <= '0'; s3_reg60.l.m <= (others => '0'); s3_reg60.r.m <= (others => '0');
                s3_reg61.c <= '0'; s3_reg61.l.s <= '0'; s3_reg61.r.s <= '0'; s3_reg61.l.m <= (others => '0'); s3_reg61.r.m <= (others => '0');
                s3_reg62.c <= '0'; s3_reg62.l.s <= '0'; s3_reg62.r.s <= '0'; s3_reg62.l.m <= (others => '0'); s3_reg62.r.m <= (others => '0');
                s3_reg63.c <= '0'; s3_reg63.l.s <= '0'; s3_reg63.r.s <= '0'; s3_reg63.l.m <= (others => '0'); s3_reg63.r.m <= (others => '0');
            elsif save_stage3='1' then
                s3_reg0<=s3_out0; s3_reg1<=s3_out1; s3_reg2<=s3_out2; s3_reg3<=s3_out3; s3_reg4<=s3_out4; s3_reg5<=s3_out5; s3_reg6<=s3_out6; s3_reg7<=s3_out7; 
                s3_reg8<=s3_out8; s3_reg9<=s3_out9; s3_reg10<=s3_out10; s3_reg11<=s3_out11; s3_reg12<=s3_out12; s3_reg13<=s3_out13; s3_reg14<=s3_out14; s3_reg15<=s3_out15; 
                s3_reg16<=s3_out16; s3_reg17<=s3_out17; s3_reg18<=s3_out18; s3_reg19<=s3_out19; s3_reg20<=s3_out20; s3_reg21<=s3_out21; s3_reg22<=s3_out22; s3_reg23<=s3_out23; 
                s3_reg24<=s3_out24; s3_reg25<=s3_out25; s3_reg26<=s3_out26; s3_reg27<=s3_out27; s3_reg28<=s3_out28; s3_reg29<=s3_out29; s3_reg30<=s3_out30; s3_reg31<=s3_out31; 
                s3_reg32<=s3_out32; s3_reg33<=s3_out33; s3_reg34<=s3_out34; s3_reg35<=s3_out35; s3_reg36<=s3_out36; s3_reg37<=s3_out37; s3_reg38<=s3_out38; s3_reg39<=s3_out39; 
                s3_reg40<=s3_out40; s3_reg41<=s3_out41; s3_reg42<=s3_out42; s3_reg43<=s3_out43; s3_reg44<=s3_out44; s3_reg45<=s3_out45; s3_reg46<=s3_out46; s3_reg47<=s3_out47; 
                s3_reg48<=s3_out48; s3_reg49<=s3_out49; s3_reg50<=s3_out50; s3_reg51<=s3_out51; s3_reg52<=s3_out52; s3_reg53<=s3_out53; s3_reg54<=s3_out54; s3_reg55<=s3_out55; 
                s3_reg56<=s3_out56; s3_reg57<=s3_out57; s3_reg58<=s3_out58; s3_reg59<=s3_out59; s3_reg60<=s3_out60; s3_reg61<=s3_out61; s3_reg62<=s3_out62; s3_reg63<=s3_out63;
            end if;
        end if;
    end process update_stage3;
    
    -- =========================================== STAGE 4 ===========================================
    S4 : fft_stage_4
    port map (  clock  => clock,
                reset  => reset,
                start  => s4_start,
                start2 => s4_start2,
                
                op0=> s3_reg0, op1=> s3_reg1, op2=> s3_reg2, op3=> s3_reg3, op4=> s3_reg4, op5=> s3_reg5, op6=> s3_reg6, op7=> s3_reg7, 
                op8=> s3_reg8, op9=> s3_reg9, op10=> s3_reg10, op11=> s3_reg11, op12=> s3_reg12, op13=> s3_reg13, op14=> s3_reg14, op15=> s3_reg15, 
                op16=> s3_reg16, op17=> s3_reg17, op18=> s3_reg18, op19=> s3_reg19, op20=> s3_reg20, op21=> s3_reg21, op22=> s3_reg22, op23=> s3_reg23, 
                op24=> s3_reg24, op25=> s3_reg25, op26=> s3_reg26, op27=> s3_reg27, op28=> s3_reg28, op29=> s3_reg29, op30=> s3_reg30, op31=> s3_reg31, 
                op32=> s3_reg32, op33=> s3_reg33, op34=> s3_reg34, op35=> s3_reg35, op36=> s3_reg36, op37=> s3_reg37, op38=> s3_reg38, op39=> s3_reg39, 
                op40=> s3_reg40, op41=> s3_reg41, op42=> s3_reg42, op43=> s3_reg43, op44=> s3_reg44, op45=> s3_reg45, op46=> s3_reg46, op47=> s3_reg47, 
                op48=> s3_reg48, op49=> s3_reg49, op50=> s3_reg50, op51=> s3_reg51, op52=> s3_reg52, op53=> s3_reg53, op54=> s3_reg54, op55=> s3_reg55, 
                op56=> s3_reg56, op57=> s3_reg57, op58=> s3_reg58, op59=> s3_reg59, op60=> s3_reg60, op61=> s3_reg61, op62=> s3_reg62, op63=> s3_reg63,

                res0=>output(0),res1=>output(1),res2=>output(2),res3=>output(3),res4=>output(4),res5=>output(5),res6=>output(6),res7=>output(7),
                res8=>output(8),res9=>output(9),res10=>output(10),res11=>output(11),res12=>output(12),res13=>output(13),res14=>output(14),res15=>output(15),
                res16=>output(16),res17=>output(17),res18=>output(18),res19=>output(19),res20=>output(20),res21=>output(21),res22=>output(22),res23=>output(23),
                res24=>output(24),res25=>output(25),res26=>output(26),res27=>output(27),res28=>output(28),res29=>output(29),res30=>output(30),res31=>output(31),
                res32=>output(32),res33=>output(33),res34=>output(34),res35=>output(35),res36=>output(36),res37=>output(37),res38=>output(38),res39=>output(39),
                res40=>output(40),res41=>output(41),res42=>output(42),res43=>output(43),res44=>output(44),res45=>output(45),res46=>output(46),res47=>output(47),
                res48=>output(48),res49=>output(49),res50=>output(50),res51=>output(51),res52=>output(52),res53=>output(53),res54=>output(54),res55=>output(55),
                res56=>output(56),res57=>output(57),res58=>output(58),res59=>output(59),res60=>output(60),res61=>output(61),res62=>output(62),res63=>output(63)
    );
    end FFT_ZP_ARCH;
