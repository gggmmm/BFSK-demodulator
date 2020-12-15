library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_fft_zp is
end entity tb_fft_zp;

architecture tb_fft_zp_arch of tb_fft_zp is
    component FFT_ZP
        port (clock  : in std_logic;
              reset  : in std_logic;
              start  : in std_logic;
              input  : in input_fft_zp;
              done   : out std_logic;
              output : out output_fft_zp);
    end component;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal start  : std_logic := '0';
    signal input  : input_fft_zp;
    signal done   : std_logic := '0';
    signal output : output_fft_zp;
       
	file stimuli : text;
	file results : text;
	signal i : integer := 1;
	constant CLOCK_PERIOD : time := 350 ns;
begin
    dut : fft_zp
    port map (  clock   => clock,
                reset   => reset,
                start   => start,
                done    => done,
                input   => input,
                output  => output);
    
    clock <= not clock after CLOCK_PERIOD/2;

    process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
	    variable i : integer := 0;
    begin
    
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "./STIMULI_TB_FFT_ZP.txt", read_mode);
        file_open(results, "./RESULTS_TB_FFT_ZP.txt", write_mode);
        
	    --readline(stimuli, rdline); -- removing first line
        while i<112*10 loop --not endfile(stimuli) loop
            for k in 0 to 7 loop
		        readline(stimuli, rdline);
		        read(rdline, realpt);
		        readline(stimuli, rdline);
		        read(rdline, imagpt);
		
		        input(k).c   <= '0';
		        input(k).l.s <= realpt(12);
		        input(k).l.m <= realpt(11 downto 0);
		        input(k).r.s <= imagpt(12);
		        input(k).r.m <= imagpt(11 downto 0);
		    end loop;
		    		
		    start <= '1';
            wait for CLOCK_PERIOD;
            start <= '0';
            wait for CLOCK_PERIOD*25;
            
            for j in 0 to 63 loop
                write(wrline, output(j).l.s & output(j).l.m); -- real
                writeline(results, wrline);
                write(wrline, output(j).r.s & output(j).r.m); -- imag
                writeline(results, wrline);
            end loop;
            
            i := i+1;
            report "I: " & integer'image(i);
	    end loop;
	    
	    report "END OF FILE";
	
	    file_close(stimuli);
        file_close(results);
        
        wait;
    end process;

end tb_fft_zp_arch;

configuration cfg_fft of tb_fft_zp is
    for tb_fft_zp_arch
        for dut: fft_zp use entity work.fft_zp(structure);
        end for;
    end for;
end cfg_fft;
