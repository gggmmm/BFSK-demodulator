library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

-- this is basically like multiplying the complex value input with -j
entity COMPLEXITY_INVERTER_12 is
    port(
        Cin : in complex12;
        Cout : out complex12
    );
end entity COMPLEXITY_INVERTER_12;

architecture COMPLEXITY_INVERTER_12_ARCH of COMPLEXITY_INVERTER_12 is
begin
    Cout.c <= not Cin.c;
    Cout.r.s <= (not Cin.c and not Cin.l.s) or (Cin.c and Cin.l.s);
    Cout.l.s <= (not Cin.c and Cin.r.s) or (Cin.c and not Cin.r.s);
    Cout.l.m <= Cin.l.m;
    Cout.r.m <= Cin.r.m;
end COMPLEXITY_INVERTER_12_ARCH;
