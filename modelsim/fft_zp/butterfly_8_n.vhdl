library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity butterfly_8_n is
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
end entity butterfly_8_n;

architecture butterfly_8_n_arch of butterfly_8_n is
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

    signal out_inv5, out_inv6, out_inv7, out_inv8 : complex12;
    signal reg_inv5, reg_inv6, reg_inv7, reg_inv8 : complex12;
begin    
    -- SUBMODULE INSTANTIATION
        -- INVERTERS
        i5 : SIGN_INVERTER_12 port map(Cin => op5, Cout => out_inv5);
        i6 : SIGN_INVERTER_12 port map(Cin => op6, Cout => out_inv6);
        i7 : SIGN_INVERTER_12 port map(Cin => op7, Cout => out_inv7);
        i8 : SIGN_INVERTER_12 port map(Cin => op8, Cout => out_inv8);
        
        update_reg1 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_inv5.c <= '0'; reg_inv5.l.s <= '0'; reg_inv5.r.s <= '0'; reg_inv5.l.m <= (others => '0'); reg_inv5.r.m <= (others => '0');
                    reg_inv6.c <= '0'; reg_inv6.l.s <= '0'; reg_inv6.r.s <= '0'; reg_inv6.l.m <= (others => '0'); reg_inv6.r.m <= (others => '0');
                    reg_inv7.c <= '0'; reg_inv7.l.s <= '0'; reg_inv7.r.s <= '0'; reg_inv7.l.m <= (others => '0'); reg_inv7.r.m <= (others => '0');
                    reg_inv8.c <= '0'; reg_inv8.l.s <= '0'; reg_inv8.r.s <= '0'; reg_inv8.l.m <= (others => '0'); reg_inv8.r.m <= (others => '0');
                elsif start='1' then
                    reg_inv5 <= out_inv5;
                    reg_inv6 <= out_inv6;
                    reg_inv7 <= out_inv7;
                    reg_inv8 <= out_inv8;
                end if;
            end if;
        end process update_reg1;
    
        -- ADDERS
        a1 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op1, op2 => op5, res => res1);
        a2 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op2, op2 => op6, res => res2);
        a3 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op3, op2 => op7, res => res3);
        a4 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op4, op2 => op8, res => res4);
        a5 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op1, op2 => reg_inv5, res => res5);
        a6 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op2, op2 => reg_inv6, res => res6);
        a7 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op3, op2 => reg_inv7, res => res7);
        a8 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op4, op2 => reg_inv8, res => res8);

end butterfly_8_n_arch;
