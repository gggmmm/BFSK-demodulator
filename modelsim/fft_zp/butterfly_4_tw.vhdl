library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity butterfly_4_tw is
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
end entity butterfly_4_tw;

architecture butterfly_4_tw_arch of butterfly_4_tw is
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

    signal out_inv2, out_inv3 : complex12;
    signal reg_inv2, reg_inv3 : complex12;
    
    signal out_mul1, out_mul2, out_mul3 : complex12;
    signal reg_mul1, reg_mul2, reg_mul3 : complex12;
    
    -- NOTE: the five highermost bits in the magnitudes are always zero, so I do not have to carry this information
    -- some of these TW are also repeated
    constant W1N8 : complex12 := ( c => '0', l => (s => '0', m => "101101010000"), r => (s => '1', m => "101101010000")); -- W(1,64/8)
    constant W3N8 : complex12 := ( c => '0', l => (s => '1', m => "101101010000"), r => (s => '1', m => "101101010000")); -- W(3,64/8)
    
    constant Lin : integer := 12;
    constant Hin : integer := 23;
begin    
    -- SUBMODULE INSTANTIATION
        -- MULTIPLIERS
        csi : COMPLEXITY_AND_SIGN_INVERTER_12 port map(Cin => op2, Cout => out_mul2);
        m1 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op1, op2 => W1N8, res => out_mul1);
        m3 : COMPLEX_MULTIPLIER_12 generic map( L => Lin, H => Hin) port map(op1 => op3, op2 => W3N8, res => out_mul3);
        
        update_reg1 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_mul1.c <= '0'; reg_mul1.l.s <= '0'; reg_mul1.r.s <= '0'; reg_mul1.l.m <= (others => '0'); reg_mul1.r.m <= (others => '0');
                    reg_mul2.c <= '0'; reg_mul2.l.s <= '0'; reg_mul2.r.s <= '0'; reg_mul2.l.m <= (others => '0'); reg_mul2.r.m <= (others => '0');
                    reg_mul3.c <= '0'; reg_mul3.l.s <= '0'; reg_mul3.r.s <= '0'; reg_mul3.l.m <= (others => '0'); reg_mul3.r.m <= (others => '0');
                elsif start='1' then
                    reg_mul1 <= out_mul1;
                    reg_mul2 <= out_mul2;
                    reg_mul3 <= out_mul3;
                end if;
            end if;
        end process update_reg1;
        
        -- INVERTERS
        i2 : SIGN_INVERTER_12 port map(Cin => reg_mul2, Cout => out_inv2);
        i3 : SIGN_INVERTER_12 port map(Cin => reg_mul3, Cout => out_inv3);
        
        update_reg2 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_inv2.c <= '0'; reg_inv2.l.s <= '0'; reg_inv2.r.s <= '0'; reg_inv2.l.m <= (others => '0'); reg_inv2.r.m <= (others => '0');
                    reg_inv3.c <= '0'; reg_inv3.l.s <= '0'; reg_inv3.r.s <= '0'; reg_inv3.l.m <= (others => '0'); reg_inv3.r.m <= (others => '0');
                elsif start2='1' then
                    reg_inv2 <= out_inv2;
                    reg_inv3 <= out_inv3;
                end if;
            end if;
        end process update_reg2;
    
        -- ADDERS
        a0 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0,      op2 => reg_mul2, res => res0);
        a1 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul1, op2 => reg_mul3, res => res1);
        a2 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0,      op2 => reg_inv2, res => res2);
        a3 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => reg_mul1, op2 => reg_inv3, res => res3);

end butterfly_4_tw_arch;
