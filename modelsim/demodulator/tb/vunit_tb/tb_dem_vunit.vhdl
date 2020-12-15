library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_dem_vunit is
    generic(
        runner_cfg  : string;
        packet_num  : natural := 1;
        ebn_num     : natural := 1;
        string_size : natural := 82 -- true only if both q and j are single digit numbers
    );
end entity tb_dem_vunit;

architecture tb_dem_vunit_arch of tb_dem_vunit is
    component DEMODULATOR
        port (clock            : in std_logic;
              reset            : in std_logic;
              sample           : in complex12;
              
              packet_completed : out std_logic;
              bit_stream       : out std_logic;
              new_bit          : out std_logic
        );
    end component;

    signal clock            : std_logic := '0';
    signal reset            : std_logic := '0';
    signal sample           : complex12 := COMPLEX_ZERO12;
    signal packet_completed : std_logic := '0';
    signal bit_stream       : std_logic := '0';
    signal new_bit          : std_logic := '0';
    
    file stimuli : text;
	file results : text;
	
	constant ADC_WAITING_TIME : time := 10 us;
begin

    dut : DEMODULATOR
    port map (clock            => clock,
              reset            => reset,
              sample           => sample,
              packet_completed => packet_completed,
              bit_stream       => bit_stream,
              new_bit          => new_bit);

    clock <= not clock after 10 ns;

    reading_process : process
	    variable rdline, wrline     : line;
	    variable realpt, imagpt     : std_logic_vector(12 downto 0) := (others => '0');
	    variable filename_to_open   : string (1 to string_size);
    begin
        test_runner_setup(runner, runner_cfg);
        while test_suite loop
            if run("Test 1") then
                reset <= '1';
                wait for 40 ns;
                reset <= '0';
	                
                filename_to_open := "/local/home/s1873164/modelsim/vunit_tb_demodultor/stimuli/STIMULI_TB_COMPLETE_SYS_q" & integer'image(packet_num) & "j" & integer'image(ebn_num) & ".txt";
                file_open(stimuli, filename_to_open, read_mode);
                
                for i in 1 to 128-2 loop -- packet size
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
                        
                        wait for ADC_WAITING_TIME;
                    end loop; -- k
                end loop; --i
	            
	            report "END OF FILE";
	
	            file_close(stimuli);
	        end if;
	    end loop;
        
        test_runner_cleanup(runner); -- Simulation ends here
        wait;
    end process;
    
    writing_process : process(clock, bit_stream, new_bit)
        variable wrline : line;
	    file results    : text;
	    variable flag : boolean := false;
	    variable filename_to_write  : string (1 to string_size);
    begin
        if rising_edge(clock) then
            if new_bit='1' then
                
                
                filename_to_write := "/local/home/s1873164/modelsim/vunit_tb_demodultor/results/RESULTS_TB_COMPLETE_SYS_q" & integer'image(packet_num) & "j" & integer'image(ebn_num) & ".txt";
                
                if flag=false then
                    file_open(results, filename_to_write, write_mode);
                    flag := true;
                else
                    file_open(results, filename_to_write, append_mode);
                end if;
                
                write(wrline, bit_stream);
                writeline(results, wrline);
                
                file_close(results);
            end if;
        end if;
    end process;

end tb_dem_vunit_arch;

configuration cfg_dem of tb_dem_vunit is
    for tb_dem_vunit_arch
        for dut: DEMODULATOR use entity work.DEMODULATOR(structure);
        end for;
    end for;
end cfg_dem;
