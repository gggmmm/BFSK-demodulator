library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_PREAMBLE_DETECTOR is
end entity tb_PREAMBLE_DETECTOR;

architecture tb_PREAMBLE_DETECTOR_arch of tb_PREAMBLE_DETECTOR is
    component PREAMBLE_DETECTOR is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        input       : in input_PREAMBLE_DETECTOR;
        input_data_ready : in std_logic;
        
        done        : out std_logic := '0';
        delaysel    : out std_logic_vector(2 downto 0);
        binHigh     : out std_logic_vector(5 downto 0);
        binLow      : out std_logic_vector(5 downto 0);
        
        waiting_for_data : out std_logic -- '1' idicates that the module is ready to accept the next 8 complex input
    );
    end component;

    signal clock    : std_logic := '0';
    signal reset    : std_logic := '0';
    signal start    : std_logic := '0';
    signal input_data_ready    : std_logic := '0';
    signal waiting_for_data    : std_logic := '0';
    signal input    : input_preamble_detector;
    signal done     : std_logic := '0';
    signal delaysel : std_logic_vector (2 downto 0) := (others => '0');
    signal binHigh  : std_logic_vector (5 downto 0) := (others => '0');
    signal binLow   : std_logic_vector (5 downto 0) := (others => '0');
    
    file stimuli : text;
	file results : text;
	
	constant ADC_WAITING_TIME : time := 12500 ns;
	constant CLOCK_PERIOD     : time := 350 ns;
begin
    dut : PREAMBLE_DETECTOR
    port map (clock             => clock,
              reset             => reset,
              start             => start,
              input             => input,
              input_data_ready  => input_data_ready,
              waiting_for_data  => waiting_for_data,
              done              => done,
              delaysel          => delaysel,
              binHigh           => binHigh,
              binLow            => binLow);

    clock <= not clock after CLOCK_PERIOD/2;

    process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
	    variable counter : integer :=0;
    begin
    
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/local/home/s1873164/modelsim/preamble_detector/tb/STIMULI_TB_PREAMBLE_DETECTOR.txt", read_mode);
        file_open(results, "/local/home/s1873164/modelsim/preamble_detector/tb/RESULTS_TB_PREAMBLE_DETECTOR.txt", write_mode);
        
        while not endfile(stimuli) loop
            for i in 1 to 112 loop -- NumOfdelays*(PreambleLength-2)
                for k in 0 to 7 loop
                    -- READING STIMULI
		            readline(stimuli, rdline);
		            read(rdline, realpt);
		            readline(stimuli, rdline);
		            read(rdline, imagpt);
		
		            input(k).c   <= '0';
		            input(k).l.s <= realpt(12);
		            input(k).l.m <= realpt(11 downto 0);
		            input(k).r.s <= imagpt(12);
		            input(k).r.m <= imagpt(11 downto 0);		            
		        end loop; -- k loop
		        		        
	            start <= '1';
                input_data_ready <= '1';
                
                wait for CLOCK_PERIOD;
                           
                start <= '0';
                input_data_ready <= '0';
                
                if i<112 then
                    wait until waiting_for_data='1';
                end if;                
            end loop; -- i loop
            
            wait until done='1';
            wait for 1 ns;

            -- WRITING RESULTS
            write(wrline, binLow);
            writeline(results, wrline);
            
            write(wrline, binHigh);
            writeline(results, wrline);
            
            write(wrline, delaysel);
            writeline(results, wrline);
                        
            wait  for (2*CLOCK_PERIOD)-1 ns;
            
            counter := counter +1;
            
            report "Num of rounds: " & integer'image(counter);
	    end loop;
	    
	    report "END OF FILE";
	
	    file_close(stimuli);
            file_close(results);
        
        wait;
    end process;
end tb_PREAMBLE_DETECTOR_arch;
    
configuration cfg_pd of tb_PREAMBLE_DETECTOR is
    for tb_PREAMBLE_DETECTOR_arch
        for dut: PREAMBLE_DETECTOR use entity work.PREAMBLE_DETECTOR(PREAMBLE_DETECTOR_arch);
        end for;
    end for;
end cfg_pd;
