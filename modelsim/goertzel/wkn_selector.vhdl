library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity WKN_SELECTOR is
    port(
        input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
        output  : out complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"))
    );
end entity WKN_SELECTOR;

architecture WKN_SELECTOR_ARCH of WKN_SELECTOR is
    constant WKN0: complex12 := ( c => '0', l => (s => '0', m => "100000000000"), r => (s => '0', m => "000000000000"));
    constant WKN1: complex12 := ( c => '0', l => (s => '0', m => "011111110110"), r => (s => '1', m => "000011001000"));
    constant WKN2: complex12 := ( c => '0', l => (s => '0', m => "011111011000"), r => (s => '1', m => "000110001111"));
    constant WKN3: complex12 := ( c => '0', l => (s => '0', m => "011110100111"), r => (s => '1', m => "001001010010"));
    constant WKN4: complex12 := ( c => '0', l => (s => '0', m => "011101100100"), r => (s => '1', m => "001100001111"));
    constant WKN5: complex12 := ( c => '0', l => (s => '0', m => "011100001110"), r => (s => '1', m => "001111000101"));
    constant WKN6: complex12 := ( c => '0', l => (s => '0', m => "011010100110"), r => (s => '1', m => "010001110001"));
    constant WKN7: complex12 := ( c => '0', l => (s => '0', m => "011000101111"), r => (s => '1', m => "010100010011"));

    constant WKN8: complex12 := ( c => '0', l => (s => '0', m => "010110101000"), r => (s => '1', m => "010110101000"));
    constant WKN9: complex12 := ( c => '0', l => (s => '0', m => "010100010011"), r => (s => '1', m => "011000101111"));
    constant WKN10: complex12 := ( c => '0', l => (s => '0', m => "010001110001"), r => (s => '1', m => "011010100110"));
    constant WKN11: complex12 := ( c => '0', l => (s => '0', m => "001111000101"), r => (s => '1', m => "011100001110"));
    constant WKN12: complex12 := ( c => '0', l => (s => '0', m => "001100001111"), r => (s => '1', m => "011101100100"));
    constant WKN13: complex12 := ( c => '0', l => (s => '0', m => "001001010010"), r => (s => '1', m => "011110100111"));
    constant WKN14: complex12 := ( c => '0', l => (s => '0', m => "000110001111"), r => (s => '1', m => "011111011000"));
    constant WKN15: complex12 := ( c => '0', l => (s => '0', m => "000011001000"), r => (s => '1', m => "011111110110"));

    constant WKN16: complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '1', m => "100000000000"));
    constant WKN17: complex12 := ( c => '0', l => (s => '1', m => "000011001000"), r => (s => '1', m => "011111110110"));
    constant WKN18: complex12 := ( c => '0', l => (s => '1', m => "000110001111"), r => (s => '1', m => "011111011000"));
    constant WKN19: complex12 := ( c => '0', l => (s => '1', m => "001001010010"), r => (s => '1', m => "011110100111"));
    constant WKN20: complex12 := ( c => '0', l => (s => '1', m => "001100001111"), r => (s => '1', m => "011101100100"));
    constant WKN21: complex12 := ( c => '0', l => (s => '1', m => "001111000101"), r => (s => '1', m => "011100001110"));
    constant WKN22: complex12 := ( c => '0', l => (s => '1', m => "010001110001"), r => (s => '1', m => "011010100110"));
    constant WKN23: complex12 := ( c => '0', l => (s => '1', m => "010100010011"), r => (s => '1', m => "011000101111"));

    constant WKN24: complex12 := ( c => '0', l => (s => '1', m => "010110101000"), r => (s => '1', m => "010110101000"));
    constant WKN25: complex12 := ( c => '0', l => (s => '1', m => "011000101111"), r => (s => '1', m => "010100010011"));
    constant WKN26: complex12 := ( c => '0', l => (s => '1', m => "011010100110"), r => (s => '1', m => "010001110001"));
    constant WKN27: complex12 := ( c => '0', l => (s => '1', m => "011100001110"), r => (s => '1', m => "001111000101"));
    constant WKN28: complex12 := ( c => '0', l => (s => '1', m => "011101100100"), r => (s => '1', m => "001100001111"));
    constant WKN29: complex12 := ( c => '0', l => (s => '1', m => "011110100111"), r => (s => '1', m => "001001010010"));
    constant WKN30: complex12 := ( c => '0', l => (s => '1', m => "011111011000"), r => (s => '1', m => "000110001111"));
    constant WKN31: complex12 := ( c => '0', l => (s => '1', m => "011111110110"), r => (s => '1', m => "000011001000"));

    constant WKN32: complex12 := ( c => '0', l => (s => '1', m => "100000000000"), r => (s => '0', m => "000000000000"));
    constant WKN33: complex12 := ( c => '0', l => (s => '1', m => "011111110110"), r => (s => '0', m => "000011001000"));
    constant WKN34: complex12 := ( c => '0', l => (s => '1', m => "011111011000"), r => (s => '0', m => "000110001111"));
    constant WKN35: complex12 := ( c => '0', l => (s => '1', m => "011110100111"), r => (s => '0', m => "001001010010"));
    constant WKN36: complex12 := ( c => '0', l => (s => '1', m => "011101100100"), r => (s => '0', m => "001100001111"));
    constant WKN37: complex12 := ( c => '0', l => (s => '1', m => "011100001110"), r => (s => '0', m => "001111000101"));
    constant WKN38: complex12 := ( c => '0', l => (s => '1', m => "011010100110"), r => (s => '0', m => "010001110001"));
    constant WKN39: complex12 := ( c => '0', l => (s => '1', m => "011000101111"), r => (s => '0', m => "010100010011"));

    constant WKN40: complex12 := ( c => '0', l => (s => '1', m => "010110101000"), r => (s => '0', m => "010110101000"));
    constant WKN41: complex12 := ( c => '0', l => (s => '1', m => "010100010011"), r => (s => '0', m => "011000101111"));
    constant WKN42: complex12 := ( c => '0', l => (s => '1', m => "010001110001"), r => (s => '0', m => "011010100110"));
    constant WKN43: complex12 := ( c => '0', l => (s => '1', m => "001111000101"), r => (s => '0', m => "011100001110"));
    constant WKN44: complex12 := ( c => '0', l => (s => '1', m => "001100001111"), r => (s => '0', m => "011101100100"));
    constant WKN45: complex12 := ( c => '0', l => (s => '1', m => "001001010010"), r => (s => '0', m => "011110100111"));
    constant WKN46: complex12 := ( c => '0', l => (s => '1', m => "000110001111"), r => (s => '0', m => "011111011000"));
    constant WKN47: complex12 := ( c => '0', l => (s => '1', m => "000011001000"), r => (s => '0', m => "011111110110"));

    constant WKN48: complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "100000000000"));
    constant WKN49: complex12 := ( c => '0', l => (s => '0', m => "000011001000"), r => (s => '0', m => "011111110110"));
    constant WKN50: complex12 := ( c => '0', l => (s => '0', m => "000110001111"), r => (s => '0', m => "011111011000"));
    constant WKN51: complex12 := ( c => '0', l => (s => '0', m => "001001010010"), r => (s => '0', m => "011110100111"));
    constant WKN52: complex12 := ( c => '0', l => (s => '0', m => "001100001111"), r => (s => '0', m => "011101100100"));
    constant WKN53: complex12 := ( c => '0', l => (s => '0', m => "001111000101"), r => (s => '0', m => "011100001110"));
    constant WKN54: complex12 := ( c => '0', l => (s => '0', m => "010001110001"), r => (s => '0', m => "011010100110"));
    constant WKN55: complex12 := ( c => '0', l => (s => '0', m => "010100010011"), r => (s => '0', m => "011000101111"));

    constant WKN56: complex12 := ( c => '0', l => (s => '0', m => "010110101000"), r => (s => '0', m => "010110101000"));
    constant WKN57: complex12 := ( c => '0', l => (s => '0', m => "011000101111"), r => (s => '0', m => "010100010011"));
    constant WKN58: complex12 := ( c => '0', l => (s => '0', m => "011010100110"), r => (s => '0', m => "010001110001"));
    constant WKN59: complex12 := ( c => '0', l => (s => '0', m => "011100001110"), r => (s => '0', m => "001111000101"));
    constant WKN60: complex12 := ( c => '0', l => (s => '0', m => "011101100100"), r => (s => '0', m => "001100001111"));
    constant WKN61: complex12 := ( c => '0', l => (s => '0', m => "011110100111"), r => (s => '0', m => "001001010010"));
    constant WKN62: complex12 := ( c => '0', l => (s => '0', m => "011111011000"), r => (s => '0', m => "000110001111"));
    constant WKN63: complex12 := ( c => '0', l => (s => '0', m => "011111110110"), r => (s => '0', m => "000011001000"));
begin
    process(input)
    begin
        case input is
            when "000000" => output <= WKN0;
            when "000001" => output <= WKN1;
            when "000010" => output <= WKN2;
            when "000011" => output <= WKN3;
            when "000100" => output <= WKN4;
            when "000101" => output <= WKN5;
            when "000110" => output <= WKN6;
            when "000111" => output <= WKN7;

            when "001000" => output <= WKN8;
            when "001001" => output <= WKN9;
            when "001010" => output <= WKN10;
            when "001011" => output <= WKN11;
            when "001100" => output <= WKN12;
            when "001101" => output <= WKN13;
            when "001110" => output <= WKN14;
            when "001111" => output <= WKN15;

            when "010000" => output <= WKN16;
            when "010001" => output <= WKN17;
            when "010010" => output <= WKN18;
            when "010011" => output <= WKN19;
            when "010100" => output <= WKN20;
            when "010101" => output <= WKN21;
            when "010110" => output <= WKN22;
            when "010111" => output <= WKN23;

            when "011000" => output <= WKN24;
            when "011001" => output <= WKN25;
            when "011010" => output <= WKN26;
            when "011011" => output <= WKN27;
            when "011100" => output <= WKN28;
            when "011101" => output <= WKN29;
            when "011110" => output <= WKN30;
            when "011111" => output <= WKN31;

            when "100000" => output <= WKN32;
            when "100001" => output <= WKN33;
            when "100010" => output <= WKN34;
            when "100011" => output <= WKN35;
            when "100100" => output <= WKN36;
            when "100101" => output <= WKN37;
            when "100110" => output <= WKN38;
            when "100111" => output <= WKN39;

            when "101000" => output <= WKN40;
            when "101001" => output <= WKN41;
            when "101010" => output <= WKN42;
            when "101011" => output <= WKN43;
            when "101100" => output <= WKN44;
            when "101101" => output <= WKN45;
            when "101110" => output <= WKN46;
            when "101111" => output <= WKN47;

            when "110000" => output <= WKN48;
            when "110001" => output <= WKN49;
            when "110010" => output <= WKN50;
            when "110011" => output <= WKN51;
            when "110100" => output <= WKN52;
            when "110101" => output <= WKN53;
            when "110110" => output <= WKN54;
            when "110111" => output <= WKN55;

            when "111000" => output <= WKN56;
            when "111001" => output <= WKN57;
            when "111010" => output <= WKN58;
            when "111011" => output <= WKN59;
            when "111100" => output <= WKN60;
            when "111101" => output <= WKN61;
            when "111110" => output <= WKN62;
            when "111111" => output <= WKN63;
            when others => report "YOU SHOULD NOT BE HERE";
        end case;
    end process;
end WKN_SELECTOR_ARCH;
