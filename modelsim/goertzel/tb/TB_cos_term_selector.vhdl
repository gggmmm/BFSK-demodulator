library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_cos_term_selector is
end entity TB_cos_term_selector;

architecture TB_cos_term_selector_ARCH of TB_cos_term_selector is
    component cos_term_selector is
        port(
            input   : in std_logic_vector(5 downto 0);
            output  : out complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"))
        );
    end component cos_term_selector;
    
    signal input  : std_logic_vector (5 downto 0);
    signal output : complex12 := (c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"));
begin
    cts : cos_term_selector port map(input=> input, output=> output);

    process
    begin
	    for i in 0 to 63 loop
	        input <= std_logic_vector(to_unsigned(i,input'length));
            wait for 50 ns;
        end loop;    
        
        wait;
    end process;

end TB_cos_term_selector_ARCH;
