library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;
use ieee.math_real.all;

entity tb_fft is
end tb_fft;

architecture tb of tb_fft is

    component fft
        generic (
            N : natural;
            enable_registers : boolean
        );
        port (clock  : in std_logic;
              reset  : in std_logic;
              input  : in io_fft;
              output : out io_fft);
    end component;

    signal clock  : std_logic := '0';
    signal reset  : std_logic;
    signal input  : io_fft;
    signal output : io_fft;
    
    constant N : natural := 64;
    
    file stimuli : text;
    file results : text;
    
    constant PERIOD : time := 350 ns;
    constant HPERIOD : time := PERIOD/2;
begin

    dut : fft
    generic map (
        N => N,
        enable_registers => true        
    )
    port map (clock  => clock,
              reset  => reset,
              input  => input,
              output => output);
              
    clock <= not clock after HPERIOD;

    process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
        for k in 0 to N-1 loop	
	        input(k).c   <= '0';
	        input(k).l.s <= '0';
	        input(k).l.m <= (others => '0');
	        input(k).r.s <= '0';
	        input(k).r.m <= (others => '0');
	    end loop;
    
        reset <= '1';
        wait for 10*PERIOD;
        reset <= '0';
        
        wait for 10*PERIOD;
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/caes/home/s1873164/fft/STIMULI_TB_FFT.txt", read_mode);
        --file_open(results, "/caes/home/s1873164/fft/RESULTS_TB_FFT.txt", write_mode);
        
        while not endfile(stimuli) loop
            for k in 0 to N-1 loop
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
		    		
            wait for integer(LOG2(real(N))+2.0)*PERIOD;
            
            --for j in 0 to N-1 loop
              --  write(wrline, output(j).l.s & output(j).l.m); -- real
              --  writeline(results, wrline);
              --  write(wrline, output(j).r.s & output(j).r.m); -- imag
              --  writeline(results, wrline);
            --end loop;
	    end loop;
	    
	    report "END OF FILE";
	
	    file_close(stimuli);
        --file_close(results);
        
        wait;
    end process;
end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fft of tb_fft is
    for tb
        for dut: fft use entity work.fft(structure);
        end for;
    end for;
end cfg_tb_fft;
