library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity SIGN_INVERTER_12 is
    port(
        Cin : in complex12;
        Cout : out complex12
    );
end entity SIGN_INVERTER_12;

architecture SIGN_INVERTER_12_ARCH of SIGN_INVERTER_12 is
begin
    Cout.l.s <= not Cin.l.s;
    Cout.r.s <= not Cin.r.s;
    Cout.l.m <= Cin.l.m;
    Cout.r.m <= Cin.r.m;
    Cout.c <= Cin.c;
end SIGN_INVERTER_12_ARCH;
