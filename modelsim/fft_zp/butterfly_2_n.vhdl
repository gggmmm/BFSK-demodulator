library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity butterfly_2_n is
    port(
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        op0 : in complex12;
        op1 : in complex12;
        res0 : out complex12;
        res1 : out complex12
    );
end entity butterfly_2_n;

architecture butterfly_2_n_arch of butterfly_2_n is
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

    signal out_inv1 : complex12;
    signal reg_inv1 : complex12;
begin    
    -- SUBMODULE INSTANTIATION
        -- INVERTERS
        i1 : SIGN_INVERTER_12 port map(Cin => op1, Cout => out_inv1);
        
        update_reg1 : process(clock, reset)
        begin
            if rising_edge(clock) then
                if reset='1' then
                    reg_inv1.c <= '0'; reg_inv1.l.s <= '0'; reg_inv1.r.s <= '0'; reg_inv1.l.m <= (others => '0'); reg_inv1.r.m <= (others => '0');
                elsif start='1' then
                    reg_inv1 <= out_inv1;
                end if;
            end if;
        end process update_reg1;
    
        -- ADDERS
        a0 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0, op2 => op1,      res => res0);
        a1 : COMPLEX_ADDER_12 port map(add_sub => '0', op1 => op0, op2 => reg_inv1, res => res1);

end butterfly_2_n_arch;
