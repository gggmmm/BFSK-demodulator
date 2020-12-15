library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity COMPLEX_ADDER_12 is
    port(
        add_sub : in std_logic := '0'; -- 0 add/ 1 sub
        op1 : in complex12;
        op2 : in complex12;
        res : out complex12
    );
end entity COMPLEX_ADDER_12;

architecture COMPLEX_ADDER_12_ARCH of COMPLEX_ADDER_12 is
    component signed_adder_12 is
    port(
        add_sub : in std_logic;
        op1 : in real12;
        op2 : in real12;
        res : out real12
    );
    end component signed_adder_12;
    
    signal op1real : real12;
    signal op1imag : real12;
    signal op2real : real12;
    signal op2imag : real12;
begin
    AR : signed_adder_12 port map(add_sub => add_sub, op1 => op1real, op2 => op2real, res => res.l);
    AI : signed_adder_12 port map(add_sub => add_sub, op1 => op1imag, op2 => op2imag, res => res.r);
    
    op1real <= op1.l when op1.c='0' else op1.r;
    op1imag <= op1.l when op1.c='1' else op1.r;
    
    op2real <= op2.l when op2.c='0' else op2.r;
    op2imag <= op2.l when op2.c='1' else op2.r;
    
    res.c <= '0';
end COMPLEX_ADDER_12_ARCH;
