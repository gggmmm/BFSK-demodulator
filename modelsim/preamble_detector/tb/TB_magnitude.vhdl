library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity tb_magnitude is
end entity tb_magnitude;

architecture tb_magnitude_arch of tb_magnitude is
    component magnitude is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in complex12;
        start   : in std_logic;
        output  : out std_logic_vector(9 downto 0) := (others => '0');
        done    : out std_logic := '0'
    );
    end component magnitude;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal input  : complex12 := COMPLEX_ZERO12;
    signal start  : std_logic := '0';
    signal output : std_logic_vector (9 downto 0) := (others => '0');
    signal done   : std_logic := '0';
begin

    clock <= not clock after 10 ns;

    dut : magnitude
    port map (clock  => clock,
              reset  => reset,
              input  => input,
              start  => start,
              output => output,
              done   => done);
              
    process
        variable i : integer := 0;
        variable result : complex12 := COMPLEX_ZERO12;
        variable test : integer := 0;
    	variable total : integer := 0;
    begin
        reset <= '1';        
        wait for 40 ns;
        reset <= '0';
        
        -- ===== TEST1 =====
        input.c <= '0'; input.l.s <= '0'; input.l.m <= std_logic_vector(to_unsigned(3*128,input.l.m'length)); input.r.s <= '0'; input.r.m <= std_logic_vector(to_unsigned(4*128,input.r.m'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait until done='1';
        wait for 1 ns;
        
        if output=std_logic_vector(to_unsigned(5*32, output'length)) then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;        
        
        wait for 99 ns;
        
        -- ===== TEST2 =====
        input.c <= '0'; input.l.s <= '0'; input.l.m <= std_logic_vector(to_unsigned(466,input.l.m'length)); input.r.s <= '0'; input.r.m <= std_logic_vector(to_unsigned(1165,input.r.m'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait until done='1';
        wait for 1 ns;
        
        if output=std_logic_vector(to_unsigned(313, output'length)) then
            test := test +1;
        else
            report "TEST 2 FAILED";
        end if;
	    total := total +1;        
        
        wait for 99 ns;
        
        -- ===== TEST3 =====
        input.c <= '0'; input.l.s <= '0'; input.l.m <= std_logic_vector(to_unsigned(779,input.l.m'length)); input.r.s <= '0'; input.r.m <= std_logic_vector(to_unsigned(2322,input.r.m'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait until done='1';
        wait for 1 ns;
        
        if output=std_logic_vector(to_unsigned(612, output'length)) then
            test := test +1;
        else
            report "TEST 3 FAILED";
        end if;
	    total := total +1;        
                
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_magnitude_arch;
