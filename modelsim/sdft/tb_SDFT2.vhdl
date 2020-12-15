library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_SDFT2 is
end entity tb_SDFT2;

architecture tb_SDFT2_arch of tb_SDFT2 is
    component SDFT is
        generic(
            N : natural := 64
        );
        port(
            clock, reset    : in std_logic;
            new_sample      : in std_logic;
            input           : in complex12;
            output          : out output_fft_zp
        );
    end component;

    signal clock    : std_logic := '0';
    signal reset    : std_logic := '0';
    signal new_sample    : std_logic := '0';
    signal input    : complex12 := COMPLEX_ZERO12;
    signal output   : output_fft_zp;
    constant L : natural := 16;
    constant N : natural := 16;
    constant M : natural := 8;
    
    file stimuli : text;
	file results : text;
	
	constant CLOCK_PERIOD     : time := 40 ns;
begin
    dut : SDFT
    generic map(
                N => N
            )
    port map (clock  => clock,
              reset  => reset,
              new_sample => new_sample,
              input  => input,
              output => output);

    clock <= not clock after CLOCK_PERIOD/2;

    process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
    
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';	
        
	    for k in 0 to L-1 loop	
	        input.c <= '0';
            input.l.s <= '0';
            input.r.s <= '0';
            input.l.m <= std_logic_vector(to_unsigned(k*16,12));
            input.r.m <= std_logic_vector(to_unsigned(k*16,12));
	        
	        if k<L-1 then
            		wait for CLOCK_PERIOD;
        	end if;
	    end loop;
	    
	    report "END TEST";
        
        wait;
    end process;

end tb_SDFT2_arch;
