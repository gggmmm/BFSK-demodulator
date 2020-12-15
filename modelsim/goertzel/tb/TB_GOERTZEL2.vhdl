library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity tb_goertzel2 is
end entity tb_goertzel2;

architecture tb_goertzel2_arch of tb_goertzel2 is
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
    
    constant CLOCK_PERIOD : time := 350 ns;
begin
    dut : GOERTZEL
    port map (clock  => clock,
              reset  => reset,
              input  => input,
              xn     => xn,
              start  => start,
              output => output,
              done   => done);
    
    clock <= not clock after CLOCK_PERIOD/2;

    process
	    file stimuli : text;
	    file results : text;
	    
	    variable rdline, wrline : line;
	    variable realpt, imagpt : std_logic_vector(12 downto 0) := (others => '0');
	    variable index1, index2 : std_logic_vector(5 downto 0) := (others => '0');
	    variable i,j            : integer := 0;
	    variable r : integer := 0;
    begin
    
        reset <= '1';
        wait for 2*CLOCK_PERIOD;
        reset <= '0';
	
	    -- ===== test 1 with file =====
        
        file_open(stimuli, "./STIMULI_TB_GOERTZEL2.txt", read_mode);
        file_open(results, "./RESULTS_TB_GOERTZEL2.txt", write_mode);
        
        while not endfile(stimuli) loop
            
            readline(stimuli, rdline);
            read(rdline, index1);
            
            readline(stimuli, rdline);
            read(rdline, index2);
            
            for k in 1 to 1024-18 loop -- THIS VAL IS LengthDataPckt-18
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
                
	            for j in 0 to 1 loop
	                
	                if j=0 then
	                    input <= index1;
	                else
	                    input <= index2;
	                end if;
	                
	                start <= '1';
	                wait for CLOCK_PERIOD;
	                start <= '0';
	                
	                for i in 0 to 7 loop
	                    xn.c    <= op(i).c;
	                    xn.l.s  <= op(i).l.s;
	                    xn.l.m  <= op(i).l.m;
	                    xn.r.s  <= op(i).r.s;
	                    xn.r.m  <= op(i).r.m;
	                    
	                    wait for 2*CLOCK_PERIOD;
		            end loop;
		            		        
		            wait until done='1';
		            wait for 1 ns;
		            
		            if output.c='0' then
                        write(wrline, output.l.s & output.l.m); -- real
                        writeline(results, wrline);
                        write(wrline, output.r.s & output.r.m); -- imag
                        writeline(results, wrline);
                    else
                        write(wrline, output.r.s & output.r.m); -- real
                        writeline(results, wrline);
                        write(wrline, output.l.s & output.l.m); -- imag
                        writeline(results, wrline);
                    end if;
                    
                    wait for 29 ns;
	            end loop;
	        end loop;
	        
	        r := r+1;
	        report "R: " & integer'image(r);
		end loop;
		
		report "END OF FILE";
	
	    file_close(stimuli);
        file_close(results);
        
        wait;
    end process;

end tb_goertzel2_arch;

configuration cfg_grz of tb_goertzel2 is
    for tb_goertzel2_arch
        for dut: goertzel use entity work.goertzel(structure);
        end for;
    end for;
end cfg_grz;
