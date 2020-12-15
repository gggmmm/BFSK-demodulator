library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity COS_TERM_SELECTOR is
    port(
        input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
        output  : out complex12 := COMPLEX_ZERO12
    );
end entity COS_TERM_SELECTOR;

architecture COS_TERM_SELECTOR_ARCH of COS_TERM_SELECTOR is
    constant COS_TERM0 : complex12 := ( c => '0', l => (s => '0', m => "100000000000"), r => (s => '0', m => "000000000000"));
    constant COS_TERM1 : complex12 := ( c => '0', l => (s => '0', m => "011111110110"), r => (s => '0', m => "000000000000"));
    constant COS_TERM2 : complex12 := ( c => '0', l => (s => '0', m => "011111011000"), r => (s => '0', m => "000000000000"));
    constant COS_TERM3 : complex12 := ( c => '0', l => (s => '0', m => "011110100111"), r => (s => '0', m => "000000000000"));
    constant COS_TERM4 : complex12 := ( c => '0', l => (s => '0', m => "011101100100"), r => (s => '0', m => "000000000000"));
    constant COS_TERM5 : complex12 := ( c => '0', l => (s => '0', m => "011100001110"), r => (s => '0', m => "000000000000"));
    constant COS_TERM6 : complex12 := ( c => '0', l => (s => '0', m => "011010100110"), r => (s => '0', m => "000000000000"));
    constant COS_TERM7 : complex12 := ( c => '0', l => (s => '0', m => "011000101111"), r => (s => '0', m => "000000000000"));

    constant COS_TERM8 : complex12 := ( c => '0', l => (s => '0', m => "010110101000"), r => (s => '0', m => "000000000000"));
    constant COS_TERM9 : complex12 := ( c => '0', l => (s => '0', m => "010100010011"), r => (s => '0', m => "000000000000"));
    constant COS_TERM10 : complex12 := ( c => '0', l => (s => '0', m => "010001110001"), r => (s => '0', m => "000000000000"));
    constant COS_TERM11 : complex12 := ( c => '0', l => (s => '0', m => "001111000101"), r => (s => '0', m => "000000000000"));
    constant COS_TERM12 : complex12 := ( c => '0', l => (s => '0', m => "001100001111"), r => (s => '0', m => "000000000000"));
    constant COS_TERM13 : complex12 := ( c => '0', l => (s => '0', m => "001001010010"), r => (s => '0', m => "000000000000"));
    constant COS_TERM14 : complex12 := ( c => '0', l => (s => '0', m => "000110001111"), r => (s => '0', m => "000000000000"));
    constant COS_TERM15 : complex12 := ( c => '0', l => (s => '0', m => "000011001000"), r => (s => '0', m => "000000000000"));

    constant COS_TERM16 : complex12 := COMPLEX_ZERO12;
    constant COS_TERM17 : complex12 := COS_TERM15;
    constant COS_TERM18 : complex12 := COS_TERM14;
    constant COS_TERM19 : complex12 := COS_TERM13;
    constant COS_TERM20 : complex12 := COS_TERM12;
    constant COS_TERM21 : complex12 := COS_TERM11;
    constant COS_TERM22 : complex12 := COS_TERM10;
    constant COS_TERM23 : complex12 := COS_TERM9;

    constant COS_TERM24 : complex12 := COS_TERM8;
    constant COS_TERM25 : complex12 := COS_TERM7;
    constant COS_TERM26 : complex12 := COS_TERM6;
    constant COS_TERM27 : complex12 := COS_TERM5;
    constant COS_TERM28 : complex12 := COS_TERM4;
    constant COS_TERM29 : complex12 := COS_TERM3;
    constant COS_TERM30 : complex12 := COS_TERM2;
    constant COS_TERM31 : complex12 := COS_TERM1;

    constant COS_TERM32 : complex12 := COS_TERM0;
    constant COS_TERM33 : complex12 := COS_TERM1;
    constant COS_TERM34 : complex12 := COS_TERM2;
    constant COS_TERM35 : complex12 := COS_TERM3;
    constant COS_TERM36 : complex12 := COS_TERM4;
    constant COS_TERM37 : complex12 := COS_TERM5;
    constant COS_TERM38 : complex12 := COS_TERM6;
    constant COS_TERM39 : complex12 := COS_TERM7;

    constant COS_TERM40 : complex12 := COS_TERM8;
    constant COS_TERM41 : complex12 := COS_TERM9;
    constant COS_TERM42 : complex12 := COS_TERM10;
    constant COS_TERM43 : complex12 := COS_TERM11;
    constant COS_TERM44 : complex12 := COS_TERM12;
    constant COS_TERM45 : complex12 := COS_TERM13;
    constant COS_TERM46 : complex12 := COS_TERM14;
    constant COS_TERM47 : complex12 := COS_TERM15;

    constant COS_TERM48 : complex12 := COS_TERM16;
    constant COS_TERM49 : complex12 := COS_TERM15;
    constant COS_TERM50 : complex12 := COS_TERM14;
    constant COS_TERM51 : complex12 := COS_TERM13;
    constant COS_TERM52 : complex12 := COS_TERM12;
    constant COS_TERM53 : complex12 := COS_TERM11;
    constant COS_TERM54 : complex12 := COS_TERM10;
    constant COS_TERM55 : complex12 := COS_TERM9;

    constant COS_TERM56 : complex12 := COS_TERM8;
    constant COS_TERM57 : complex12 := COS_TERM7;
    constant COS_TERM58 : complex12 := COS_TERM6;
    constant COS_TERM59 : complex12 := COS_TERM5;
    constant COS_TERM60 : complex12 := COS_TERM4;
    constant COS_TERM61 : complex12 := COS_TERM3;
    constant COS_TERM62 : complex12 := COS_TERM2;
    constant COS_TERM63 : complex12 := COS_TERM1;
    
    signal tmp : complex12;
begin
    output <= tmp;

    process(input)
    begin    
        case input is
            when "000000" => tmp <= COS_TERM0;
            when "000001" => tmp <= COS_TERM1;
            when "000010" => tmp <= COS_TERM2;
            when "000011" => tmp <= COS_TERM3;
            when "000100" => tmp <= COS_TERM4;
            when "000101" => tmp <= COS_TERM5;
            when "000110" => tmp <= COS_TERM6;
            when "000111" => tmp <= COS_TERM7;

            when "001000" => tmp <= COS_TERM8;
            when "001001" => tmp <= COS_TERM9;
            when "001010" => tmp <= COS_TERM10;
            when "001011" => tmp <= COS_TERM11;
            when "001100" => tmp <= COS_TERM12;
            when "001101" => tmp <= COS_TERM13;
            when "001110" => tmp <= COS_TERM14;
            when "001111" => tmp <= COS_TERM15;

            when "010000" => tmp <= COS_TERM16;
            when "010001" => tmp <= COS_TERM17;
            when "010010" => tmp <= COS_TERM18;
            when "010011" => tmp <= COS_TERM19;
            when "010100" => tmp <= COS_TERM20;
            when "010101" => tmp <= COS_TERM21;
            when "010110" => tmp <= COS_TERM22;
            when "010111" => tmp <= COS_TERM23;

            when "011000" => tmp <= COS_TERM24;
            when "011001" => tmp <= COS_TERM25;
            when "011010" => tmp <= COS_TERM26;
            when "011011" => tmp <= COS_TERM27;
            when "011100" => tmp <= COS_TERM28;
            when "011101" => tmp <= COS_TERM29;
            when "011110" => tmp <= COS_TERM30;
            when "011111" => tmp <= COS_TERM31;

            when "100000" => tmp <= COS_TERM32;
            when "100001" => tmp <= COS_TERM33;
            when "100010" => tmp <= COS_TERM34;
            when "100011" => tmp <= COS_TERM35;
            when "100100" => tmp <= COS_TERM36;
            when "100101" => tmp <= COS_TERM37;
            when "100110" => tmp <= COS_TERM38;
            when "100111" => tmp <= COS_TERM39;

            when "101000" => tmp <= COS_TERM40;
            when "101001" => tmp <= COS_TERM41;
            when "101010" => tmp <= COS_TERM42;
            when "101011" => tmp <= COS_TERM43;
            when "101100" => tmp <= COS_TERM44;
            when "101101" => tmp <= COS_TERM45;
            when "101110" => tmp <= COS_TERM46;
            when "101111" => tmp <= COS_TERM47;

            when "110000" => tmp <= COS_TERM48;
            when "110001" => tmp <= COS_TERM49;
            when "110010" => tmp <= COS_TERM50;
            when "110011" => tmp <= COS_TERM51;
            when "110100" => tmp <= COS_TERM52;
            when "110101" => tmp <= COS_TERM53;
            when "110110" => tmp <= COS_TERM54;
            when "110111" => tmp <= COS_TERM55;

            when "111000" => tmp <= COS_TERM56;
            when "111001" => tmp <= COS_TERM57;
            when "111010" => tmp <= COS_TERM58;
            when "111011" => tmp <= COS_TERM59;
            when "111100" => tmp <= COS_TERM60;
            when "111101" => tmp <= COS_TERM61;
            when "111110" => tmp <= COS_TERM62;
            when "111111" => tmp <= COS_TERM63;
            when others => report "YOU SHOULD NOT BE HERE";
        end case;
        
        if input(5)='1' xor input(4)='1' then
            tmp.l.s <= '1';
        else
            tmp.l.s <= '0';
        end if;
    end process;
end COS_TERM_SELECTOR_ARCH;
