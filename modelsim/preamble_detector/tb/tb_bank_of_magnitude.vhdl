library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_bank_of_magnitude is
end entity tb_bank_of_magnitude;

architecture tb_bank_of_magnitude_arch of tb_bank_of_magnitude is
    component bank_of_magnitude
        port (clock  : in std_logic;
              reset  : in std_logic;
              input  : in input_bank_of_magnitude;
              start  : in std_logic;
              output : out output_bank_of_magnitude;
              done   : out std_logic);
    end component;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal input  : input_bank_of_magnitude;
    signal start  : std_logic := '0';
    signal output : output_bank_of_magnitude;
    signal done   : std_logic := '0';
begin

    clock <= not clock after 10 ns;

    dut : bank_of_magnitude
    port map (clock  => clock,
              reset  => reset,
              input  => input,
              start  => start,
              output => output,
              done   => done);
              
    process
        variable i : integer := 0;
        variable test : integer := 0;
    	variable total : integer := 0;
    begin
        for j in 0 to 63 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(0, input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0, input(j).r.m'length));
        end loop;
        
        reset <= '1';        
        wait for 40 ns;
        reset <= '0';
        wait for 20 ns;
        
        -- ===== TEST1 =====
        for j in 0 to 63 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(j*32, input(j).l.m'length)); --0.25
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(j*16, input(j).r.m'length)); --0.125
        end loop;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';        
        wait until done='1';
        wait for 1 ns;
        
        if output(63)=std_logic_vector(to_unsigned(563, output(63)'length)) then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;        
	    
	    wait for 100 ns;
	    
        -- ===== TEST2 =====  
        input(63).c      <= '0';
        input(63).l.s    <= '0';
        input(63).l.m    <= std_logic_vector(to_unsigned(3*128, input(63).l.m'length));
        input(63).r.s    <= '0';
        input(63).r.m    <= std_logic_vector(to_unsigned(4*128, input(63).r.m'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';        
        wait until done='1';
        wait for 1 ns;
        
        if output(63)=std_logic_vector(to_unsigned(5*32, output(63)'length)) then
            test := test +1;
        else
            report "TEST 2 FAILED";
        end if;
	    total := total +1;
                
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
	    
        wait;
    end process;

end tb_bank_of_magnitude_arch;
