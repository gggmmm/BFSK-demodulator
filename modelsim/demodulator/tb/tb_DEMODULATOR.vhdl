library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_DEMODULATOR is
end entity tb_DEMODULATOR;

architecture tb_DEMODULATOR_arch of tb_DEMODULATOR is
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
	
	constant ADC_WAITING_TIME : time := 1440 ns;
	constant CLOCK_PERIOD     : time := 40 ns;
	signal sample_counter : unsigned(13 downto 0) := (others => '0');
	signal finished : std_logic := '0';
begin

    dut : DEMODULATOR
    port map (clock            => clock,
              reset            => reset,
              sample           => sample,
              packet_completed => packet_completed,
              bit_stream       => bit_stream,
              new_bit          => new_bit);

    clock <= not clock after CLOCK_PERIOD/2 when finished='0' else '0';

    reading_process : process
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
    begin
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/caes/home/s1873164/modelsim/demodulator/tb/STIMULI_TB_COMPLETE_SYS.txt", read_mode);
        
        --while not endfile(stimuli) loop
            for q in 1 to 500 loop -- packets
                for j in 1 to 1 loop -- EBN
                
                    report "q " & integer'image(q) & " j " & integer'image(j);
                    
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
                            
                            sample_counter <= sample_counter + to_unsigned(1, sample_counter'length);
                                                        
                            wait for ADC_WAITING_TIME;
                        end loop; -- k
                    end loop; --i
                end loop; -- j
            end loop; -- q
	    --end loop;
	    
	    report "END OF FILE";
		wait for 1 us;
		finished <= '1';
	
	    file_close(stimuli);
        
        wait;
    end process;
    
    writing_process : process(clock, bit_stream, new_bit, finished)
        variable wrline : line;
	    file results    : text;
	    variable flag : boolean := false;
    begin
        if rising_edge(clock) then
            if new_bit='1' and finished='0' then
                if flag=false then
                    file_open(results, "/caes/home/s1873164/modelsim/demodulator/tb/RESULTS_TB_COMPLETE_SYS.txt", write_mode);
                    flag := true;
                else
                    file_open(results, "/caes/home/s1873164/modelsim/demodulator/tb/RESULTS_TB_COMPLETE_SYS.txt", append_mode);
                end if;
                
                write(wrline, bit_stream);
                writeline(results, wrline);
                
                file_close(results);
            end if;
        end if;        
    end process;

end tb_DEMODULATOR_arch;

configuration cfg_dem of tb_DEMODULATOR is
   for tb_DEMODULATOR_arch
       for dut: DEMODULATOR use entity work.DEMODULATOR(DEMODULATOR_arch);
        end for;
    end for;
end cfg_dem;
