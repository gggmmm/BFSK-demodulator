library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity SIGNED_MULT_12 is
    generic(    L : integer := 7;
                H : integer := 18
    );
    port(
        op1 : in real12;
        op2 : in real12;
        res : out real12
    );
end entity SIGNED_MULT_12;

architecture SIGNED_MULT_12_ARCH of SIGNED_MULT_12 is
    component mult12 is
	    port
	    (
		    dataa		: in std_logic_vector (11 downto 0);
		    datab		: in std_logic_vector (11 downto 0);
		    result		: out std_logic_vector (23 downto 0)
	    );
    end component mult12;
    signal r : std_logic_vector(23 downto 0) := (others => '0');
begin
    M : mult12 port map(dataa => op1.m, datab => op2.m, result => r);
    res.s <= op1.s xor op2.s;
    res.m <= r(H downto L);
end SIGNED_MULT_12_ARCH;
