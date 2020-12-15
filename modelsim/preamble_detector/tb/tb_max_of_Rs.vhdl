library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_max_of_Rs is
end entity tb_max_of_Rs;

architecture tb_max_of_Rs_arch of tb_max_of_Rs is
    component max_of_Rs is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        
        R0  : in std_logic_vector(11 downto 0);
        R1  : in std_logic_vector(11 downto 0);
        R2  : in std_logic_vector(11 downto 0);
        R3  : in std_logic_vector(11 downto 0);
        R4  : in std_logic_vector(11 downto 0);
        R5  : in std_logic_vector(11 downto 0);
        R6  : in std_logic_vector(11 downto 0);
        R7  : in std_logic_vector(11 downto 0);
        
        done        : out std_logic := '0';
        result      : out std_logic_vector(2 downto 0)
    );
    end component max_of_Rs;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal start  : std_logic := '0';
    signal R0     : std_logic_vector (11 downto 0);
    signal R1     : std_logic_vector (11 downto 0);
    signal R2     : std_logic_vector (11 downto 0);
    signal R3     : std_logic_vector (11 downto 0);
    signal R4     : std_logic_vector (11 downto 0);
    signal R5     : std_logic_vector (11 downto 0);
    signal R6     : std_logic_vector (11 downto 0);
    signal R7     : std_logic_vector (11 downto 0);
    signal done   : std_logic := '0';
    signal result : std_logic_vector (2 downto 0);

begin

    dut : max_of_Rs
    port map (clock  => clock,
              reset  => reset,
              start  => start,
              R0     => R0,
              R1     => R1,
              R2     => R2,
              R3     => R3,
              R4     => R4,
              R5     => R5,
              R6     => R6,
              R7     => R7,
              done   => done,
              result => result);

    clock <= not clock after 10 ns;
              
    process
        variable i      : integer := 0;
        variable test   : integer := 0;
    	variable total  : integer := 0;
    begin
        reset <= '1';        
        wait for 40 ns;
        reset <= '0';
        
        -- ===== TEST1 =====
        R0 <= std_logic_vector(to_unsigned(5, R0'length));
        R1 <= std_logic_vector(to_unsigned(8, R1'length));
        R2 <= std_logic_vector(to_unsigned(1, R2'length));
        R3 <= std_logic_vector(to_unsigned(2, R3'length));
        R4 <= std_logic_vector(to_unsigned(9, R3'length));
        R5 <= std_logic_vector(to_unsigned(54, R3'length));
        R6 <= std_logic_vector(to_unsigned(3, R3'length));
        R7 <= std_logic_vector(to_unsigned(46, R3'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 1 ns;
        
        if result="101" then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;    
	    
	    wait for 19 ns;    
                
        -- ===== TEST2 =====
        R0 <= std_logic_vector(to_unsigned(10, R0'length));
        R1 <= std_logic_vector(to_unsigned(0, R1'length));
        R2 <= std_logic_vector(to_unsigned(0, R2'length));
        R3 <= std_logic_vector(to_unsigned(0, R3'length));
        R4 <= std_logic_vector(to_unsigned(0, R3'length));
        R5 <= std_logic_vector(to_unsigned(0, R3'length));
        R6 <= std_logic_vector(to_unsigned(0, R3'length));
        R7 <= std_logic_vector(to_unsigned(0, R3'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 1 ns;
        
        if result="000" then
            test := test +1;
        else
            report "TEST 2 FAILED";
        end if;
	    total := total +1;    
	    
	    wait for 19 ns;
	    
	    -- ===== TEST3 =====
        R0 <= std_logic_vector(to_unsigned(1, R0'length));
        R1 <= std_logic_vector(to_unsigned(1, R1'length));
        R2 <= std_logic_vector(to_unsigned(1, R2'length));
        R3 <= std_logic_vector(to_unsigned(1, R3'length));
        R4 <= std_logic_vector(to_unsigned(1, R3'length));
        R5 <= std_logic_vector(to_unsigned(1, R3'length));
        R6 <= std_logic_vector(to_unsigned(1, R3'length));
        R7 <= std_logic_vector(to_unsigned(1, R3'length));
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 1 ns;
        
        if result="111" then
            test := test +1;
        else
            report "TEST 3 FAILED";
        end if;
	    total := total +1;    
	    
	    wait for 19 ns;
	    
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_max_of_Rs_arch;
