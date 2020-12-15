library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_goertzel3 is
end entity tb_goertzel3;

architecture tb_goertzel3_arch of tb_goertzel3 is
    component GOERTZEL is
        port(
            clock   : in std_logic;
            reset   : in std_logic;
            input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
            xn      : in complex12;
            start   : in std_logic;
            output  : out complex12 := COMPLEX_ZERO12;
            done    : out std_logic := '0'
        );
    end component GOERTZEL;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal input  : std_logic_vector (5 downto 0) := "000000";
    signal xn     : complex12 := COMPLEX_ZERO12;
    signal start  : std_logic := '0';
    signal output : complex12 := COMPLEX_ZERO12;
    signal done   : std_logic := '0';
    type op_type is array (0 to 7) of complex12;
    signal op : op_type;
begin
    dut : GOERTZEL
    port map (clock  => clock,
              reset  => reset,
              input  => input,
              xn     => xn,
              start  => start,
              output => output,
              done   => done);
    
    clock <= not clock after 10 ns;

    process
	    file stimuli : text;
	    file results : text;
	    
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
	    variable index1, index2 : std_logic_vector(5 downto 0) := (others => '0');
	    variable i,j            : integer := 0;
    begin
    
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "/home/giovanni/Desktop/matlab/STIMULI_TB_GOERTZEL3.txt", read_mode);
        file_open(results, "/home/giovanni/Desktop/matlab/RESULTS_TB_GOERTZEL3.txt", write_mode);
        
        while not endfile(stimuli) loop
            
            for i in 0 to 7 loop
                readline(stimuli, rdline);
                read(rdline, realpt);
                
                readline(stimuli, rdline);
                read(rdline, imagpt);

                op(i).c     <= '0';
                op(i).l.s   <= realpt(12);
                op(i).l.m   <= realpt(11 downto 0);
                op(i).r.s   <= imagpt(12);
                op(i).r.m   <= imagpt(11 downto 0);
            end loop;
                
            for j in 0 to 63 loop
                input <= std_logic_vector(to_unsigned(j,6));
                
                start <= '1';
                wait for 20 ns;
                start <= '0';
                
                for i in 0 to 7 loop
                    xn.c    <= op(i).c;
                    xn.l.s  <= op(i).l.s;
                    xn.l.m  <= op(i).l.m;
                    xn.r.s  <= op(i).r.s;
                    xn.r.m  <= op(i).r.m;
                    
                    wait for 40 ns;
	            end loop;
	            		        
	            wait until done='1';
	            wait for 1 ns;
	            
                write(wrline, output.l.s & output.l.m); -- real
                writeline(results, wrline);
                write(wrline, output.r.s & output.r.m); -- imag
                writeline(results, wrline);
                
                wait for 29 ns;
            end loop;
		end loop;
	
	    file_close(stimuli);
        file_close(results);
        
        report "END OF FILE";
        
        wait;
    end process;

end tb_goertzel3_arch;
