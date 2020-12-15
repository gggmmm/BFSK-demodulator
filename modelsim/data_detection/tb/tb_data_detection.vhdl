library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_data_detection is
end entity tb_data_detection;

architecture tb_data_detection_arch of tb_data_detection is
    component data_detection
        port (clock   : in std_logic;
              reset   : in std_logic;
              start   : in std_logic;
              input   : in input_data_detection;
              binHigh : in std_logic_vector (5 downto 0);
              binLow  : in std_logic_vector (5 downto 0);
              output  : out std_logic;
              done    : out std_logic);
    end component;

    signal clock   : std_logic := '0';
    signal reset   : std_logic := '0';
    signal start   : std_logic := '0';
    signal input   : input_data_detection;
    signal binHigh : std_logic_vector (5 downto 0) := (others => '0');
    signal binLow  : std_logic_vector (5 downto 0) := (others => '0');
    signal output  : std_logic := '0';
    signal done    : std_logic := '0';
begin

    clock <= not clock after 10 ns;

    dut : data_detection
    port map (clock   => clock,
              reset   => reset,
              start   => start,
              input   => input,
              binHigh => binHigh,
              binLow  => binLow,
              output  => output,
              done    => done);

    process
	    file stimuli : text;
	    file results : text;
	    
	    variable rdline, wrline         : line;
	    variable realpt, imagpt         : std_logic_vector(12 downto 0) := (others => '0');
	    variable f_binHigh, f_binLow    : std_logic_vector(5 downto 0) := (others => '0');
	    variable counter : integer := 0;
    begin
    
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/caes/home/s1873164/modelsim/data_detection/tb/STIMULI_TB_DATA_DETECTION.txt", read_mode);
        file_open(results, "/caes/home/s1873164/modelsim/data_detection/tb/RESULTS_TB_DATA_DETECTION.txt", write_mode);
        
        while not endfile(stimuli) loop
            for j in 1 to 14 loop -- JMAX
                readline(stimuli, rdline);
                read(rdline, f_binHigh);            
                readline(stimuli, rdline);
                read(rdline, f_binLow);
                
                binHigh <= f_binHigh;
                binLow <= f_binLow;
                
                for i in 1 to 1024-18 loop -- IMAX LengthDataPckt-2-PreambleLength = LengthDataPckt-18                    
                    for l in 0 to 7 loop
                        readline(stimuli, rdline);
                        read(rdline, realpt);
                        
                        readline(stimuli, rdline);
                        read(rdline, imagpt);
                    
                        input(l).c     <= '0';
                        input(l).l.s   <= realpt(12);
                        input(l).l.m   <= realpt(11 downto 0);
                        input(l).r.s   <= imagpt(12);
                        input(l).r.m   <= imagpt(11 downto 0);
                    end loop;
                                
                    start <= '1';
                    wait for 20 ns;
                    start <= '0';
                    		        
                    wait until done='1';
                    wait for 1 ns;
                    
                    write(wrline, output);
                    writeline(results, wrline);
                    
                    wait for 29 ns;
                end loop;
            end loop;
            
            counter := counter +1;
            report "Counter: " & integer'image(counter);
		end loop;
	
	    file_close(stimuli);
        file_close(results);
        
        report "END OF FILE";
        
        wait;
    end process;

end tb_data_detection_arch;
