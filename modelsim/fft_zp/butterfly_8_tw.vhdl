library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity butterfly_8_tw is
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
end entity butterfly_8_tw;

architecture butterfly_8_tw_arch of butterfly_8_tw is
    component SIGN_INVERTER_12 is
        port(
            Cin : in complex12;
            Cout : out complex12
        );
    end component SIGN_INVERTER_12;
    
    component COMPLEX_ADDER_12 is
        port(
            add_sub : in std_logic := '0'; -- 0 add/ 1 sub
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_ADDER_12;
    
    component COMPLEX_MULTIPLIER_12 is
        generic(    L : integer := 12;
                    H : integer := 23
        );
        port(
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_MULTIPLIER_12;
    
    component COMPLEXITY_AND_SIGN_INVERTER_12 is
        port(
            Cin : in complex12;
            Cout : out complex12
        );
    end component COMPLEXITY_AND_SIGN_INVERTER_12;

    signal out_inv4, out_inv5, out_inv6, out_inv7 : complex12;
    signal reg_inv4, reg_inv5, reg_inv6, reg_inv7 : complex12;
    
    signal out_mul0, out_mul1, out_mul2, out_mul3, out_mul4, out_mul5, out_mul6, out_mul7 : complex12;
    signal reg_mul1, reg_mul2, reg_mul3, reg_mul4, reg_mul5, reg_mul6, reg_mul7 : complex12;
    
    -- NOTE: the five highermost bits in the magnitudes are always zero, so I do not have to carry this information
    -- some of these TW are also repeated
    constant W1N4 : complex12 := ( c => '0', l => (s => '0', m => "111011001000"), r => (s => '1', m => "011000011111")); -- W(1,64/4) 
    constant W2N4 : complex12 := ( c => '0', l => (s => '0', m => "101101010000"), r => (s => '1', m => "101101010000")); -- W(2,64/4)
    constant W3N4 : complex12 := ( c => '0', l => (s => '0', m => "011000011111"), r => (s => '1', m => "111011001000")); -- W(3,64/4)
    constant W5N4 : complex12 := ( c => '0', l => (s => '1', m => "011000011111"), r => (s => '1', m => "111011001000")); -- W(5,64/4)
    constant W6N4 : complex12 := ( c => '0', l => (s => '1', m => "101101010000"), r => (s => '1', m => "101101010000")); -- W(6,64/4)
    constant W7N4 : complex12 := ( c => '0', l => (s => '1', m => "111011001000"), r => (s => '1', m => "011000011111")); -- W(7,64/4)
    
    constant Lin : integer := 12;
    constant Hin : integer := 23;
begin
    -- SUBMODULE INSTANTIATION
        -- MULTIPLIERS
        m1 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op1, op2 => W1N4, res => out_mul1);
        m2 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op2, op2 => W2N4, res => out_mul2);
        m3 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op3, op2 => W3N4, res => out_mul3);
              
        csi : COMPLEXITY_AND_SIGN_INVERTER_12 port map(Cin => op4, Cout => out_mul4);
        
        m5 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op5, op2 => W5N4, res => out_mul5);
        m6 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op6, op2 => W6N4, res => out_mul6);
        m7 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op7, op2 => W7N4, res => out_mul7);
        
        update_reg1 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    --reg_mul0.c <= '0'; reg_mul0.l.s <= '0'; reg_mul0.r.s <= '0'; reg_mul0.l.m <= (others => '0'); reg_mul0.r.m <= (others => '0');
                    reg_mul1.c <= '0'; reg_mul1.l.s <= '0'; reg_mul1.r.s <= '0'; reg_mul1.l.m <= (others => '0'); reg_mul1.r.m <= (others => '0');
                    reg_mul2.c <= '0'; reg_mul2.l.s <= '0'; reg_mul2.r.s <= '0'; reg_mul2.l.m <= (others => '0'); reg_mul2.r.m <= (others => '0');
                    reg_mul3.c <= '0'; reg_mul3.l.s <= '0'; reg_mul3.r.s <= '0'; reg_mul3.l.m <= (others => '0'); reg_mul3.r.m <= (others => '0');
                    reg_mul4.c <= '0'; reg_mul4.l.s <= '0'; reg_mul4.r.s <= '0'; reg_mul4.l.m <= (others => '0'); reg_mul4.r.m <= (others => '0');
                    reg_mul5.c <= '0'; reg_mul5.l.s <= '0'; reg_mul5.r.s <= '0'; reg_mul5.l.m <= (others => '0'); reg_mul5.r.m <= (others => '0');
                    reg_mul6.c <= '0'; reg_mul6.l.s <= '0'; reg_mul6.r.s <= '0'; reg_mul6.l.m <= (others => '0'); reg_mul6.r.m <= (others => '0');
                    reg_mul7.c <= '0'; reg_mul7.l.s <= '0'; reg_mul7.r.s <= '0'; reg_mul7.l.m <= (others => '0'); reg_mul7.r.m <= (others => '0');
                elsif start='1' then
                    --reg_mul0 <= op0; -- special case, register not needed
                    reg_mul1 <= out_mul1;
                    reg_mul2 <= out_mul2;
                    reg_mul3 <= out_mul3;
                    reg_mul4 <= out_mul4;
                    reg_mul5 <= out_mul5;
                    reg_mul6 <= out_mul6;
                    reg_mul7 <= out_mul7;
                end if;
            end if;
        end process update_reg1;
        
        -- INVERTERS
        i4 : SIGN_INVERTER_12 port map(Cin => reg_mul4, Cout => out_inv4);
        i5 : SIGN_INVERTER_12 port map(Cin => reg_mul5, Cout => out_inv5);
        i6 : SIGN_INVERTER_12 port map(Cin => reg_mul6, Cout => out_inv6);
        i7 : SIGN_INVERTER_12 port map(Cin => reg_mul7, Cout => out_inv7);
        
        update_reg2 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_inv4.c <= '0'; reg_inv4.l.s <= '0'; reg_inv4.r.s <= '0'; reg_inv4.l.m <= (others => '0'); reg_inv4.r.m <= (others => '0');
                    reg_inv5.c <= '0'; reg_inv5.l.s <= '0'; reg_inv5.r.s <= '0'; reg_inv5.l.m <= (others => '0'); reg_inv5.r.m <= (others => '0');
                    reg_inv6.c <= '0'; reg_inv6.l.s <= '0'; reg_inv6.r.s <= '0'; reg_inv6.l.m <= (others => '0'); reg_inv6.r.m <= (others => '0');
                    reg_inv7.c <= '0'; reg_inv7.l.s <= '0'; reg_inv7.r.s <= '0'; reg_inv7.l.m <= (others => '0'); reg_inv7.r.m <= (others => '0');
                elsif start2='1' then
                    reg_inv4 <= out_inv4;
                    reg_inv5 <= out_inv5;
                    reg_inv6 <= out_inv6;
                    reg_inv7 <= out_inv7;
                end if;
            end if;
        end process update_reg2;
    
        -- ADDERS
        a0 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0,      op2 => reg_mul4, res => res0);
        a1 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul1, op2 => reg_mul5, res => res1);
        a2 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul2, op2 => reg_mul6, res => res2);
        a3 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul3, op2 => reg_mul7, res => res3);
        a4 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0,      op2 => reg_inv4, res => res4);
        a5 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul1, op2 => reg_inv5, res => res5);
        a6 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul2, op2 => reg_inv6, res => res6);
        a7 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul3, op2 => reg_inv7, res => res7);

end butterfly_8_tw_arch;
