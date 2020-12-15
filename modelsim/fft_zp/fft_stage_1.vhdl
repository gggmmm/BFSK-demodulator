library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity fft_stage_1 is
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
end entity fft_stage_1;

architecture fft_stage_1_arch of fft_stage_1 is
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
    
    constant W1N2 : complex12 := ( c => '0', l => (s => '0', m => "111110110001"), r => (s => '1', m => "001100011111")); -- W(1,64/2)
    constant W2N2 : complex12 := ( c => '0', l => (s => '0', m => "111011001000"), r => (s => '1', m => "011000011111")); -- W(2,64/2)
    constant W3N2 : complex12 := ( c => '0', l => (s => '0', m => "110101001101"), r => (s => '1', m => "100011100011")); -- W(3,64/2)
    constant W4N2 : complex12 := ( c => '0', l => (s => '0', m => "101101010000"), r => (s => '1', m => "101101010000")); -- W(4,64/2)
    constant W5N2 : complex12 := ( c => '0', l => (s => '0', m => "100011100011"), r => (s => '1', m => "110101001101")); -- W(5,64/2)
    constant W6N2 : complex12 := ( c => '0', l => (s => '0', m => "011000011111"), r => (s => '1', m => "111011001000")); -- W(6,64/2)
    constant W7N2 : complex12 := ( c => '0', l => (s => '0', m => "001100011111"), r => (s => '1', m => "111110110001")); -- W(7,64/2)
    
    constant W1N1 : complex12 := ( c => '0', l => (s => '0', m => "111111101100"), r => (s => '1', m => "000110010001")); -- W(1,64/1)
    constant W2N1 : complex12 := ( c => '0', l => (s => '0', m => "111110110001"), r => (s => '1', m => "001100011111")); -- W(2,64/1)
    constant W3N1 : complex12 := ( c => '0', l => (s => '0', m => "111101001111"), r => (s => '1', m => "010010100101")); -- W(3,64/1)
    constant W4N1 : complex12 := ( c => '0', l => (s => '0', m => "111011001000"), r => (s => '1', m => "011000011111")); -- W(4,64/1)
    constant W5N1 : complex12 := ( c => '0', l => (s => '0', m => "111000011100"), r => (s => '1', m => "011110001010")); -- W(5,64/1)
    constant W6N1 : complex12 := ( c => '0', l => (s => '0', m => "110101001101"), r => (s => '1', m => "100011100011")); -- W(6,64/1)
    constant W7N1 : complex12 := ( c => '0', l => (s => '0', m => "110001011110"), r => (s => '1', m => "101000100110")); -- W(7,64/1)
    
    constant Lin : integer := 12;
    constant Hin : integer := 23;
    
    signal out_mul1, out_mul2, out_mul3, out_mul4, out_mul5, out_mul6, out_mul7 : complex12;
    signal reg_mul1, reg_mul2, reg_mul3, reg_mul4, reg_mul5, reg_mul6, reg_mul7 : complex12;
    
    signal out_mulB, out_mulC, out_mulD, out_mulE, out_mulF, out_mulG, out_mulH : complex12;
    signal reg_mulB, reg_mulC, reg_mulD, reg_mulE, reg_mulF, reg_mulG, reg_mulH : complex12;
    
    signal out_mulJ, out_mulK, out_mulL, out_mulM, out_mulN, out_mulO, out_mulP : complex12;
    signal reg_mulJ, reg_mulK, reg_mulL, reg_mulM, reg_mulN, reg_mulO, reg_mulP : complex12;
    
    signal out_mulR, out_mulS, out_mulT, out_mulU, out_mulV, out_mulW, out_mulX : complex12;
    signal reg_mulR, reg_mulS, reg_mulT, reg_mulU, reg_mulV, reg_mulW, reg_mulX : complex12;
begin
    -- ===== FIRST EIGHT =====
    res0 <= op0;
    res1 <= op1;
    res2 <= op2;
    res3 <= op3;
    res4 <= op4;
    res5 <= op5;
    res6 <= op6;
    res7 <= op7;
    
    -- ===== SECOND EIGHT =====
    mB : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op1, op2 => W1N2, res => out_mulB);
    mC : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op2, op2 => W2N2, res => out_mulC);
    mD : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op3, op2 => W3N2, res => out_mulD);
    mE : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op4, op2 => W4N2, res => out_mulE);
    mF : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op5, op2 => W5N2, res => out_mulF);
    mG : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op6, op2 => W6N2, res => out_mulG);
    mH : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op7, op2 => W7N2, res => out_mulH);
    
    update_reg1 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                reg_mulB.c <= '0'; reg_mulB.l.s <= '0'; reg_mulB.r.s <= '0'; reg_mulB.l.m <= (others => '0'); reg_mulB.r.m <= (others => '0');
                reg_mulC.c <= '0'; reg_mulC.l.s <= '0'; reg_mulC.r.s <= '0'; reg_mulC.l.m <= (others => '0'); reg_mulC.r.m <= (others => '0');
                reg_mulD.c <= '0'; reg_mulD.l.s <= '0'; reg_mulD.r.s <= '0'; reg_mulD.l.m <= (others => '0'); reg_mulD.r.m <= (others => '0');
                reg_mulE.c <= '0'; reg_mulE.l.s <= '0'; reg_mulE.r.s <= '0'; reg_mulE.l.m <= (others => '0'); reg_mulE.r.m <= (others => '0');
                reg_mulF.c <= '0'; reg_mulF.l.s <= '0'; reg_mulF.r.s <= '0'; reg_mulF.l.m <= (others => '0'); reg_mulF.r.m <= (others => '0');
                reg_mulG.c <= '0'; reg_mulG.l.s <= '0'; reg_mulG.r.s <= '0'; reg_mulG.l.m <= (others => '0'); reg_mulG.r.m <= (others => '0');
                reg_mulH.c <= '0'; reg_mulH.l.s <= '0'; reg_mulH.r.s <= '0'; reg_mulH.l.m <= (others => '0'); reg_mulH.r.m <= (others => '0');
            elsif start='1' then
                reg_mulB <= out_mulB;
                reg_mulC <= out_mulC;
                reg_mulD <= out_mulD;
                reg_mulE <= out_mulE;
                reg_mulF <= out_mulF;
                reg_mulG <= out_mulG;
                reg_mulH <= out_mulH;
            end if;
        end if;
    end process update_reg1;

    resA <= op0;
    resB <= reg_mulB;
    resC <= reg_mulC;
    resD <= reg_mulD;
    resE <= reg_mulE;
    resF <= reg_mulF;
    resG <= reg_mulG;
    resH <= reg_mulH;
    
    -- ===== THIRD EIGHT =====
    mJ : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op1, op2 => W1N1, res => out_mulJ);
    mK : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op2, op2 => W2N1, res => out_mulK);
    mL : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op3, op2 => W3N1, res => out_mulL);
    mM : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op4, op2 => W4N1, res => out_mulM);
    mN : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op5, op2 => W5N1, res => out_mulN);
    mO : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op6, op2 => W6N1, res => out_mulO);
    mP : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op7, op2 => W7N1, res => out_mulP);
    
    update_reg2 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                reg_mulJ.c <= '0'; reg_mulJ.l.s <= '0'; reg_mulJ.r.s <= '0'; reg_mulJ.l.m <= (others => '0'); reg_mulJ.r.m <= (others => '0');
                reg_mulK.c <= '0'; reg_mulK.l.s <= '0'; reg_mulK.r.s <= '0'; reg_mulK.l.m <= (others => '0'); reg_mulK.r.m <= (others => '0');
                reg_mulL.c <= '0'; reg_mulL.l.s <= '0'; reg_mulL.r.s <= '0'; reg_mulL.l.m <= (others => '0'); reg_mulL.r.m <= (others => '0');
                reg_mulM.c <= '0'; reg_mulM.l.s <= '0'; reg_mulM.r.s <= '0'; reg_mulM.l.m <= (others => '0'); reg_mulM.r.m <= (others => '0');
                reg_mulN.c <= '0'; reg_mulN.l.s <= '0'; reg_mulN.r.s <= '0'; reg_mulN.l.m <= (others => '0'); reg_mulN.r.m <= (others => '0');
                reg_mulO.c <= '0'; reg_mulO.l.s <= '0'; reg_mulO.r.s <= '0'; reg_mulO.l.m <= (others => '0'); reg_mulO.r.m <= (others => '0');
                reg_mulP.c <= '0'; reg_mulP.l.s <= '0'; reg_mulP.r.s <= '0'; reg_mulP.l.m <= (others => '0'); reg_mulP.r.m <= (others => '0');
            elsif start='1' then
                reg_mulJ <= out_mulJ;
                reg_mulK <= out_mulK;
                reg_mulL <= out_mulL;
                reg_mulM <= out_mulM;
                reg_mulN <= out_mulN;
                reg_mulO <= out_mulO;
                reg_mulP <= out_mulP;
            end if;
        end if;
    end process update_reg2;

    resI <= op0;
    resJ <= reg_mulJ;
    resK <= reg_mulK;
    resL <= reg_mulL;
    resM <= reg_mulM;
    resN <= reg_mulN;
    resO <= reg_mulO;
    resP <= reg_mulP;
    
    -- ===== THIRD EIGHT =====
    mR : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulJ, op2 => W1N2, res => out_mulR);
    mS : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulK, op2 => W2N2, res => out_mulS);
    mT : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulL, op2 => W3N2, res => out_mulT);
    mU : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulM, op2 => W4N2, res => out_mulU);
    mV : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulN, op2 => W5N2, res => out_mulV);
    mW : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulO, op2 => W6N2, res => out_mulW);
    mX : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => reg_mulP, op2 => W7N2, res => out_mulX);
    
    update_reg3 : process(clock, reset)
    begin
        if rising_edge(clock) then
            if reset='1' then
                reg_mulR.c <= '0'; reg_mulR.l.s <= '0'; reg_mulR.r.s <= '0'; reg_mulR.l.m <= (others => '0'); reg_mulR.r.m <= (others => '0');
                reg_mulS.c <= '0'; reg_mulS.l.s <= '0'; reg_mulS.r.s <= '0'; reg_mulS.l.m <= (others => '0'); reg_mulS.r.m <= (others => '0');
                reg_mulT.c <= '0'; reg_mulT.l.s <= '0'; reg_mulT.r.s <= '0'; reg_mulT.l.m <= (others => '0'); reg_mulT.r.m <= (others => '0');
                reg_mulU.c <= '0'; reg_mulU.l.s <= '0'; reg_mulU.r.s <= '0'; reg_mulU.l.m <= (others => '0'); reg_mulU.r.m <= (others => '0');
                reg_mulV.c <= '0'; reg_mulV.l.s <= '0'; reg_mulV.r.s <= '0'; reg_mulV.l.m <= (others => '0'); reg_mulV.r.m <= (others => '0');
                reg_mulW.c <= '0'; reg_mulW.l.s <= '0'; reg_mulW.r.s <= '0'; reg_mulW.l.m <= (others => '0'); reg_mulW.r.m <= (others => '0');
                reg_mulX.c <= '0'; reg_mulX.l.s <= '0'; reg_mulX.r.s <= '0'; reg_mulX.l.m <= (others => '0'); reg_mulX.r.m <= (others => '0');
            elsif start2='1' then
                reg_mulR <= out_mulR;
                reg_mulS <= out_mulS;
                reg_mulT <= out_mulT;
                reg_mulU <= out_mulU;
                reg_mulV <= out_mulV;
                reg_mulW <= out_mulW;
                reg_mulX <= out_mulX;
            end if;
        end if;
    end process update_reg3;

    resQ <= op0;
    resR <= reg_mulR;
    resS <= reg_mulS;
    resT <= reg_mulT;
    resU <= reg_mulU;
    resV <= reg_mulV;
    resW <= reg_mulW;
    resX <= reg_mulX;
    
            

end fft_stage_1_arch;
