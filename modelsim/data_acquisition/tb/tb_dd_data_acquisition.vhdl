library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_dd_data_acquisition is
end entity tb_dd_data_acquisition;

architecture tb_dd_data_acquisition_arch of tb_dd_data_acquisition is
    component dd_data_acquisition
        port(
            clock       : in std_logic;
            reset       : in std_logic;
            new_sample  : in std_logic;
            sample      : in complex12;
            delaysel    : in std_logic_vector(2 downto 0);
            enable      : in std_logic;
            
            start_data_detection    : out std_logic;
            output                  : out output_dd_data_acquisition;
            done                    : out std_logic
        );
    end component;

    signal clock      : std_logic := '0';
    signal reset      : std_logic := '0';
    signal new_sample : std_logic := '0';
    signal enable     : std_logic := '0';
    signal sample     : complex12;
    signal output     : output_dd_data_acquisition;
    signal done       : std_logic := '0';
    signal delaysel   : std_logic_vector(2 downto 0) := (others => '0');
    signal start_data_detection : std_logic := '0';
    
    file stimuli : text;
	file results : text;
	
	constant ADC_WAITING_TIME : time := 1 us;
begin
    dut : dd_data_acquisition
    port map (clock                 => clock,
              reset                 => reset,
              new_sample            => new_sample,
              enable                => enable,
              sample                => sample,
              delaysel              => delaysel,
              start_data_detection  => start_data_detection,
              output                => output,
              done                  => done);

    clock <= not clock after 10 ns;

    reading_process : process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
        delaysel <= "101";
        reset <= '1';
        enable <= '1';
        wait for 40 ns;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/home/giovanni/Desktop/matlab/STIMULI_TB_DD_DATA_ACQUISITION.txt", read_mode);
        
        --while not endfile(stimuli) loop
            for q in 1 to 20 loop
                for j in 1 to 14 loop
                    for i in 1 to 9+to_integer(unsigned(delaysel)) loop
                        -- READING STIMULI
                        -- REAL
                        readline(stimuli, rdline);
                        read(rdline, realpt);
                        -- IMAG
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
                    end loop;
                    
                    for i in 1 to 32-16-2 loop -- DataPacketLength-Preamble
                        for k in 1 to 8 loop
                            -- READING STIMULI
                            -- REAL
                            readline(stimuli, rdline);
                            read(rdline, realpt);
                            -- IMAG
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
                        end loop; -- k
                    end loop; --i
                end loop; -- j
            end loop; -- q
	    --end loop;
	    
	    enable <= '0';
	    report "END OF FILE";
	
	    file_close(stimuli);
        
        wait;
    end process;
    
    writing_process : process(clock, start_data_detection)
        variable wrline : line;
	    file results    : text;
	    variable flag : boolean := false;
    begin
        if rising_edge(clock) then
            if start_data_detection='1' then
                if flag=false then
                    file_open(results, "/home/giovanni/Desktop/matlab/RESULTS_TB_DD_DATA_ACQUISITION.txt", write_mode);
                    flag := true;
                else
                    file_open(results, "/home/giovanni/Desktop/matlab/RESULTS_TB_DD_DATA_ACQUISITION.txt", append_mode);
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

end tb_dd_data_acquisition_arch;
