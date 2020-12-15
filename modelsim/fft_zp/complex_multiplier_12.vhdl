library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity COMPLEX_MULTIPLIER_12 is
    generic(    L : integer := 7;
                H : integer := 18
    );
    port(
        op1 : in complex12;
        op2 : in complex12;
        res : out complex12
    );
end entity COMPLEX_MULTIPLIER_12;

architecture COMPLEX_MULTIPLIER_12_ARCH of COMPLEX_MULTIPLIER_12 is
    component signed_mult_12 is
        generic(    L : integer := 7;
                    H : integer := 18
        );
        port(
            op1 : in real12;
            op2 : in real12;
            res : out real12
        );
    end component signed_mult_12;
    
    component signed_adder_12 is
    port(
        add_sub : std_logic;
        op1 : in real12;
        op2 : in real12;
        res : out real12
    );
    end component signed_adder_12;
    
    signal op1real : real12;
    signal op1imag : real12;
    signal op2real : real12;
    signal op2imag : real12;
    
    signal mul1res : real12;
    signal mul2res : real12;
    signal mul2resAdj : real12;
    signal mul3res : real12;
    signal mul4res : real12;
    
    signal add1res : real12;
    signal add2res : real12;
begin    
    op1real <= op1.l when op1.c='0' else op1.r;
    op1imag <= op1.l when op1.c='1' else op1.r;
    
    op2real <= op2.l when op2.c='0' else op2.r;
    op2imag <= op2.l when op2.c='1' else op2.r;

    m1 : signed_mult_12 generic map( L => L, H => H) port map(op1 => op1real, op2 => op2real, res => mul1res);
    m2 : signed_mult_12 generic map( L => L, H => H) port map(op1 => op1imag, op2 => op2imag, res => mul2res); -- multiplication of the imaginary parts, need to take into account the imaginary units that produces a -1. problem addressed in the next line
    mul2resAdj.s <= not mul2res.s;
    mul2resAdj.m <= mul2res.m;
    
    a1 : signed_adder_12 port map(add_sub => '0', op1 => mul1res, op2 => mul2resAdj, res => add1res); -- subtraction
    
    m3 : signed_mult_12 generic map( L => L, H => H) port map(op1 => op1real, op2 => op2imag, res => mul3res);
    m4 : signed_mult_12 generic map( L => L, H => H) port map(op1 => op1imag, op2 => op2real, res => mul4res);
    
    a2 : signed_adder_12 port map(add_sub => '0', op1 => mul3res, op2 => mul4res, res => add2res);
        
    res.c <= '0';
    res.l <= add1res;
    res.r <= add2res;
end COMPLEX_MULTIPLIER_12_ARCH;
