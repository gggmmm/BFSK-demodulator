library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity FACTOR_SELECTOR is
    port(
        input   : in std_logic_vector(2 downto 0); -- the index of the bin that I want to compute
        output  : out complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"))
    );
end entity FACTOR_SELECTOR;

architecture FACTOR_SELECTOR_ARCH of FACTOR_SELECTOR is
    constant FACTOR0: complex12 := ( c => '0', l => (s => '0', m => "100000000000"), r => (s => '0', m => "000000000000"));
    constant FACTOR1: complex12 := ( c => '0', l => (s => '0', m => "010110101000"), r => (s => '1', m => "010110101000"));
    constant FACTOR2: complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '1', m => "100000000000"));
    constant FACTOR3: complex12 := ( c => '0', l => (s => '1', m => "010110101000"), r => (s => '1', m => "010110101000"));
    constant FACTOR4: complex12 := ( c => '0', l => (s => '1', m => "100000000000"), r => (s => '0', m => "000000000000"));
    constant FACTOR5: complex12 := ( c => '0', l => (s => '1', m => "010110101000"), r => (s => '0', m => "010110101000"));
    constant FACTOR6: complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "100000000000"));
    constant FACTOR7: complex12 := ( c => '0', l => (s => '0', m => "010110101000"), r => (s => '0', m => "010110101000"));
begin
    process(input)
    begin
        case input is
            when "000" => output <= FACTOR0;
            when "001" => output <= FACTOR1;
            when "010" => output <= FACTOR2;
            when "011" => output <= FACTOR3;
            when "100" => output <= FACTOR4;
            when "101" => output <= FACTOR5;
            when "110" => output <= FACTOR6;
            when "111" => output <= FACTOR7;
            when others => report "YOU SHOULD NOT BE HERE";
        end case;
    end process;
end FACTOR_SELECTOR_ARCH;
