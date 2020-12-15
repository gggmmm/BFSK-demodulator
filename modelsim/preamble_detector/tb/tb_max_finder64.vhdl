library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_max_finder64 is
end entity tb_max_finder64;

architecture tb_max_finder64_arch of tb_max_finder64 is
    component max_finder64 is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        start   : in std_logic;
        input   : in input_max_finder64;
        
        max_index   : out std_logic_vector(5 downto 0) := (others => '0');
        max_value   : out std_logic_vector(11 downto 0) := (others => '0');
        done        : out std_logic := '0'
    );
    end component;

    signal clock     : std_logic := '0';
    signal reset     : std_logic := '0';
    signal start     : std_logic := '0';
    signal input     : input_max_finder64;
    signal max_index : std_logic_vector (5 downto 0) := (others => '0');
    signal max_value : std_logic_vector (11 downto 0) := (others => '0');
    signal done      : std_logic := '0';
begin
    dut : max_finder64
    port map (clock     => clock,
              reset     => reset,
              start     => start,
              input     => input,
              max_index => max_index,
              max_value => max_value,
              done      => done);
              
    clock <= not clock after 10 ns;
              
    process
        variable i : integer := 0;
        variable test : integer := 0;
    	variable total : integer := 0;
    begin        
        -- ===== TEST1 =====
        for j in 0 to 63 loop
            input(j) <= std_logic_vector(to_unsigned(j,input(j)'length));
        end loop;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
                
        wait until done='1';
        wait for 1 ns;
        
        if max_index=std_logic_vector(to_unsigned(63, max_index'length)) and max_value=std_logic_vector(to_unsigned(63, max_value'length)) then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;
	    
	    wait for 69 ns;
	    
	    -- ===== TEST2 =====
	    for j in 0 to 63 loop
            if j=20 then
                input(20) <= std_logic_vector(to_unsigned(200,input(20)'length));
            else
                input(j) <= std_logic_vector(to_unsigned(j+20,input(j)'length));
            end if;
        end loop;
        
	    start <= '1';
        wait for 20 ns;
        start <= '0';
                
        wait until done='1';
        wait for 1 ns;
        
        if max_index=std_logic_vector(to_unsigned(20, max_index'length)) and max_value=std_logic_vector(to_unsigned(200, max_value'length)) then
            test := test +1;
        else
            report "TEST 2 FAILED";
        end if;
	    total := total +1;
	    
	    wait for 69 ns;
	    
	    -- ===== TEST3 =====	    
        for j in 0 to 63 loop
            input(j) <= std_logic_vector(to_unsigned(1,input(j)'length));
        end loop;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';        
        
        wait until done='1';
        wait for 1 ns;
        
        if max_index=std_logic_vector(to_unsigned(63, max_index'length)) and max_value=std_logic_vector(to_unsigned(1, max_value'length)) then
            test := test +1;
        else
            report "TEST 3 FAILED";
        end if;
	    total := total +1;
	    
	    wait for 69 ns;
                
        -- ========== PRINT RESULTS ==========
        report ""; report ""; report "";
        report "========== RESULTS ==========";
	    report integer'image(test) & "/" & integer'image(total);
                        
        wait;
    end process;

end tb_max_finder64_arch;

configuration cfg_mf64 of tb_max_finder64 is
    for tb_max_finder64_arch
        for dut: max_finder64 use entity work.max_finder64(structure);
        end for;
    end for;
end cfg_mf64;
