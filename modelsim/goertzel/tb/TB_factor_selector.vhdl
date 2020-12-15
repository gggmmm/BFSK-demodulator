library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_factor_selector is
end entity tb_factor_selector;

architecture tb_factor_selector_arch of tb_factor_selector is
    component factor_selector is
        port(
            input   : in std_logic_vector(2 downto 0);
            output  : out complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"))
        );
    end component factor_selector;
    
    signal input  : std_logic_vector (2 downto 0);
    signal output : complex12 := (c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"));
begin
    ws : factor_selector port map(input=> input, output=> output);

    process
    begin
	    for i in 0 to 7 loop
	        input <= std_logic_vector(to_unsigned(i,input'length));
            wait for 50 ns;
        end loop;    
        
        wait;
    end process;

end tb_factor_selector_arch;
