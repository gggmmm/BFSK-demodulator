library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_SDFT is
end entity tb_SDFT;

architecture tb_SDFT_arch of tb_SDFT is
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

    signal clock        : std_logic := '0';
    signal reset        : std_logic := '0';
    signal new_sample   : std_logic := '0';
    signal input        : complex12 := COMPLEX_ZERO12;
    signal output       : output_fft_zp;
    
    constant L : natural := 119;
    constant N : natural := 64;
    constant M : natural := 8;
    
    file stimuli : text;
	file results : text;
	
	constant CLOCK_PERIOD     : time := 350 ns;
begin

    dut : SDFT
    generic map(
                N => N
            )
    port map (clock      => clock,
              reset      => reset,
              new_sample => new_sample,
              input      => input,
              output     => output);

    clock <= not clock after CLOCK_PERIOD/2;

    process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
    
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/caes/home/s1873164/modelsim/sdft/STIMULI_TB_SDFT_RESONATOR.txt", read_mode);
        file_open(results, "/caes/home/s1873164/modelsim/sdft/RESULTS_TB_SDFT_RESONATOR.txt", write_mode);
        	    
	    for k in 0 to L-1 loop
	        readline(stimuli, rdline);
	        read(rdline, realpt);
	        readline(stimuli, rdline);
	        read(rdline, imagpt);
	
	        input.c   <= '0';
	        input.l.s <= realpt(12);
	        input.l.m <= realpt(11 downto 0);
	        input.r.s <= imagpt(12);
	        input.r.m <= imagpt(11 downto 0);
	        new_sample <= '1', '0' after CLOCK_PERIOD+2 ns;
	        
	        if k<L-1 then
            		wait for 2*CLOCK_PERIOD;
        	end if;
	    end loop;
		
        wait for 5*CLOCK_PERIOD;
        
        for j in 0 to N-1 loop
            write(wrline, output(j).l.s & output(j).l.m); -- real
            writeline(results, wrline);
            write(wrline, output(j).r.s & output(j).r.m); -- imag
            writeline(results, wrline);
        end loop;
	    
	    report "END OF FILE";
	
	    file_close(stimuli);
        file_close(results);
        
        wait;
    end process;

end tb_SDFT_arch;

configuration cfg_dem of tb_SDFT is
   for tb_SDFT_arch
       for dut: SDFT use entity work.SDFT(structure); -- SDFT_arch // structure
        end for;
    end for;
end cfg_dem;
