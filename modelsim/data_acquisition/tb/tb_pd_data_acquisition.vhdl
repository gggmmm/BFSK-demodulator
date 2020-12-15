library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_pd_data_acquisition is
end entity tb_pd_data_acquisition;

architecture tb_pd_data_acquisition_arch of tb_pd_data_acquisition is
    component pd_data_acquisition
        port (clock      : in std_logic;
              reset      : in std_logic;
              new_sample : in std_logic;
              sample     : in complex12;
              enable      : in std_logic;
              start_preamble_detector : out std_logic;
              output     : out output_pd_data_acquisition;
              done       : out std_logic);
    end component;

    signal clock      : std_logic := '0';
    signal reset      : std_logic := '0';
    signal new_sample : std_logic := '0';
    signal start_preamble_detector : std_logic := '0';
    signal sample     : complex12;
    signal output     : output_pd_data_acquisition;
    signal done       : std_logic := '0';
    signal enable     : std_logic;
    
    file stimuli : text;
	file results : text;
	
	constant ADC_WAITING_TIME : time := 1 us;
begin
    dut : pd_data_acquisition
    port map (clock      => clock,
              reset      => reset,
              new_sample => new_sample,
              sample     => sample,
              start_preamble_detector => start_preamble_detector,
              output     => output,
              done       => done,
              enable     => enable);

    clock <= not clock after 10 ns;

    reading_process : process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
        enable <= '1';
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/home/giovanni/Desktop/matlab/STIMULI_TB_PD_DATA_ACQUISITION.txt", read_mode);
        
        while not endfile(stimuli) loop
            for i in 1 to 119 loop
                -- READING STIMULI
                readline(stimuli, rdline);
                read(rdline, realpt);
                readline(stimuli, rdline);
                read(rdline, imagpt);

                sample.c   <= '0';
                sample.l.s <= realpt(12);
                sample.l.m <= realpt(11 downto 0);
                sample.r.s <= imagpt(12);
                sample.r.m <= imagpt(11 downto 0);
                
                new_sample <= '1';                
                wait for 20 ns;
                new_sample <= '0';
                
                wait for ADC_WAITING_TIME;  
            end loop; -- i loop
	    end loop;
	    
	    report "END OF FILE";
	
	    file_close(stimuli);
        
        wait;
    end process;
    
    writing_process : process(clock, start_preamble_detector)
        variable wrline : line;
	    file results    : text;
	    variable flag : boolean := false;
    begin
        if rising_edge(clock) then
            if start_preamble_detector='1' then
                if flag=false then
                    file_open(results, "/home/giovanni/Desktop/matlab/RESULTS_TB_PD_DATA_ACQUISITION.txt", write_mode);
                    flag := true;
                else
                    file_open(results, "/home/giovanni/Desktop/matlab/RESULTS_TB_PD_DATA_ACQUISITION.txt", append_mode);
                end if;
                
                for j in 0 to 7 loop
                    write(wrline, output(j).l.s & output(j).l.m); -- real
                    writeline(results, wrline);
                    write(wrline, output(j).r.s & output(j).r.m); -- imag
                    writeline(results, wrline);
                end loop;
                
                file_close(results);
            end if;
        end if;        
    end process;

end tb_pd_data_acquisition_arch;
