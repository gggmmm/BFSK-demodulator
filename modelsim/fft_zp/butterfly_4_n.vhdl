library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity butterfly_4_n is
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
end entity butterfly_4_n;

architecture butterfly_4_n_arch of butterfly_4_n is
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

    signal out_inv3, out_inv4 : complex12;
    signal reg_inv3, reg_inv4 : complex12;
begin    
    -- SUBMODULE INSTANTIATION
        -- INVERTERS
        i3 : SIGN_INVERTER_12 port map(Cin => op3, Cout => out_inv3);
        i4 : SIGN_INVERTER_12 port map(Cin => op4, Cout => out_inv4);
        
        update_reg1 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_inv3.c <= '0'; reg_inv3.l.s <= '0'; reg_inv3.r.s <= '0'; reg_inv3.l.m <= (others => '0'); reg_inv3.r.m <= (others => '0');
                    reg_inv4.c <= '0'; reg_inv4.l.s <= '0'; reg_inv4.r.s <= '0'; reg_inv4.l.m <= (others => '0'); reg_inv4.r.m <= (others => '0');
                elsif start='1' then
                    reg_inv3 <= out_inv3;
                    reg_inv4 <= out_inv4;
                end if;
            end if;
        end process update_reg1;
    
        -- ADDERS
        a1 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op1, op2 => op3, res => res1);
        a2 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op2, op2 => op4, res => res2);
        a3 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op1, op2 => reg_inv3, res => res3);
        a4 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op2, op2 => reg_inv4, res => res4);

end butterfly_4_n_arch;
