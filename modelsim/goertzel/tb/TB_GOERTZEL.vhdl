library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_GOERTZEL is
end entity TB_GOERTZEL;

architecture TB_GOERTZEL_ARCH of TB_GOERTZEL is
    component GOERTZEL is
        port(
            clock   : in std_logic;
            reset   : in std_logic;
            input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
            xn      : in complex12;
            start   : in std_logic;
            output  : out complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"));
            done    : out std_logic := '0'
        );
    end component GOERTZEL;
    
    signal input        : std_logic_vector (5 downto 0);
    signal output, xn   : complex12 := (c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"));
    signal clock, reset, start, done : std_logic := '0';
begin
    dut : GOERTZEL port map(clock=> clock, reset=> reset, input=> input, xn=> xn, start=> start, output=> output, done=> done);
    
    clock <= not clock after 10 ns;
    
    process
        variable i : integer := 0;
        variable result : complex12 := COMPLEX_ZERO12;
        variable test : integer := 0;
    	variable total : integer := 0;
    begin
        reset <= '1';        
        input <= "000000";
        wait for 40 ns;
        reset <= '0';
        
        -- ===== TEST1 =====
        input <= "000001";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        xn.l.m <= "000011100000", "000000000000" after 20 ns;
        wait until done='1';
        wait for 1 ns;
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(7*32, output.l.m'length)) and output.r.s='0' and output.r.m=std_logic_vector(to_unsigned(0, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;        
        
        wait for 490 ns;
        
        -- ===== TEST2 =====
        input <= "000000";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        xn.l.m <= std_logic_vector(to_unsigned(1*32, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(2*64, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(0, xn.l.m'length));
        
        wait until done='1';
        wait for 1 ns;
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(5*32, output.l.m'length)) and output.r.s='0' and output.r.m=std_logic_vector(to_unsigned(0, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 2 FAILED";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST3 =====
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        xn.l.m <= std_logic_vector(to_unsigned(1*64, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(2*64, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(3*64, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(4*64, xn.l.m'length));
        wait for 40 ns;
        xn.l.m <= std_logic_vector(to_unsigned(0, xn.l.m'length));
        
        wait until done='1';
        wait for 1 ns;
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(10*64, output.l.m'length)) and output.r.s='0' and output.r.m=std_logic_vector(to_unsigned(0, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 3 FAILED";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST4 =====
        start <= '1';
        wait for 20 ns;
        start <= '0';
        for i in 1 to 8 loop
            xn.l.m <= std_logic_vector(to_unsigned(i*16, xn.l.m'length));
            wait for 40 ns;
        end loop;
                
        wait until done='1';
        wait for 1 ns;
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(36*16, output.l.m'length)) and output.r.s='0' and output.r.m=std_logic_vector(to_unsigned(0, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 4 FAILED";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST5 =====
        start <= '1';
        wait for 20 ns;
        start <= '0';
        for i in 1 to 8 loop
            xn.l.m <= std_logic_vector(to_unsigned(i*16, xn.l.m'length));
            xn.r.m <= std_logic_vector(to_unsigned((9-i)*16, xn.r.m'length));
            xn.r.s <= '1';
            wait for 40 ns;
        end loop;
        
        xn <= COMPLEX_ZERO12;
        
        wait until done='1';
        wait for 1 ns;
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(36*16, output.l.m'length)) and output.r.s='1' and output.r.m=std_logic_vector(to_unsigned(36*16, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 5 FAILED";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST6 =====
        input <= "000001";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        xn.l.m <= "000010000000", "000000000000" after 20 ns;
        
        
        wait until done='1';
        wait for 1 ns;
        
        input <= "000000";
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(2*64, output.l.m'length)) and output.r.s='0' and output.r.m=std_logic_vector(to_unsigned(0, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 6 FAILED (ROUNDING ERROR, CHECK MANUALLY)";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST7 =====
        input <= "000000";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        for i in 1 to 8 loop
            xn.l.m <= std_logic_vector(to_unsigned(i*16, xn.l.m'length));
            xn.r.m <= std_logic_vector(to_unsigned((9-i)*16, xn.r.m'length));
            xn.r.s <= '1';
            wait for 40 ns;
        end loop;
        
        xn <= COMPLEX_ZERO12;
        
        wait until done='1';
        wait for 1 ns;
                
        input <= "000000";
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(22*16, output.l.m'length)) and output.r.s='1' and output.r.m=std_logic_vector(to_unsigned(45*16, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 7 FAILED (ROUNDING ERROR, CHECK MANUALLY)";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST8 =====
        input <= "001010";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        for i in 1 to 8 loop
            xn.l.m <= std_logic_vector(to_unsigned(i*16, xn.l.m'length));
            xn.r.m <= std_logic_vector(to_unsigned((9-i)*16, xn.r.m'length));
            xn.r.s <= '1';
            wait for 40 ns;
        end loop;
        
        xn <= COMPLEX_ZERO12;
        
        wait until done='1';
        wait for 1 ns;
                
        input <= "000000";
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(22*16, output.l.m'length)) and output.r.s='1' and output.r.m=std_logic_vector(to_unsigned(45*16, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 8 FAILED (ROUNDING ERROR, CHECK MANUALLY)";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ===== TEST9 =====
        input <= "001010";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        xn.c <= '0';
            
            xn.l.s <= '0';
            xn.l.m <= std_logic_vector(to_unsigned(56, xn.l.m'length));
            xn.r.s <= '1';
            xn.r.m <= std_logic_vector(to_unsigned(50, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '0';
            xn.l.m <= std_logic_vector(to_unsigned(34, xn.l.m'length));
            xn.r.s <= '1';
            xn.r.m <= std_logic_vector(to_unsigned(60, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '0';
            xn.l.m <= std_logic_vector(to_unsigned(24, xn.l.m'length));
            xn.r.s <= '1';
            xn.r.m <= std_logic_vector(to_unsigned(54, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '1';
            xn.l.m <= std_logic_vector(to_unsigned(48, xn.l.m'length));
            xn.r.s <= '1';
            xn.r.m <= std_logic_vector(to_unsigned(48, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '1';
            xn.l.m <= std_logic_vector(to_unsigned(102, xn.l.m'length));
            xn.r.s <= '1';
            xn.r.m <= std_logic_vector(to_unsigned(62, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '1';
            xn.l.m <= std_logic_vector(to_unsigned(12, xn.l.m'length));
            xn.r.s <= '0';
            xn.r.m <= std_logic_vector(to_unsigned(24, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '1';
            xn.l.m <= std_logic_vector(to_unsigned(80, xn.l.m'length));
            xn.r.s <= '0';
            xn.r.m <= std_logic_vector(to_unsigned(10, xn.l.m'length));
            wait for 40 ns;
            xn.l.s <= '1';
            xn.l.m <= std_logic_vector(to_unsigned(60, xn.l.m'length));
            xn.r.s <= '0';
            xn.r.m <= std_logic_vector(to_unsigned(34, xn.l.m'length));
            wait for 40 ns;
            
        
        xn <= COMPLEX_ZERO12;
        
        wait until done='1';
        wait for 1 ns;
                
        input <= "000000";
        
        if output.l.s='0' and output.l.m=std_logic_vector(to_unsigned(22*16, output.l.m'length)) and output.r.s='1' and output.r.m=std_logic_vector(to_unsigned(45*16, output.r.m'length)) then
            test := test +1;
        else
            report "TEST 9 FAILED (ROUNDING ERROR, CHECK MANUALLY)";
        end if;
	    total := total +1;
        
        wait for 50 ns;
        
        -- ========== PRINT RESULTS ==========
        report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;
end TB_GOERTZEL_ARCH;
