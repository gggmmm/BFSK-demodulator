library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_maxs is
end entity tb_maxs;

architecture tb_maxs_arch of tb_maxs is
    component maxs
    port (clock      : in std_logic;
        reset      : in std_logic;
        input_odd  : in output_bank_of_adders;
        input_even : in output_bank_of_adders;
        start      : in std_logic;
        done       : out std_logic;
        index_odd  : out std_logic_vector (5 downto 0);
        index_even : out std_logic_vector (5 downto 0);
        val_odd    : out std_logic_vector (7 downto 0);
        val_even   : out std_logic_vector (7 downto 0);
        val_odd_index_even    : out std_logic_vector(7 downto 0);
        val_even_index_odd    : out std_logic_vector(7 downto 0)
    );
    end component;

    signal clock      : std_logic := '0';
    signal reset      : std_logic := '0';
    signal input_odd  : output_bank_of_adders;
    signal input_even : output_bank_of_adders;
    signal start      : std_logic := '0';
    signal done       : std_logic := '0';
    signal index_odd  : std_logic_vector (5 downto 0) := (others=> '0');
    signal index_even : std_logic_vector (5 downto 0) := (others=> '0');
    signal val_odd    : std_logic_vector (7 downto 0) := (others=> '0');
    signal val_even   : std_logic_vector (7 downto 0) := (others=> '0');
begin

    clock <= not clock after 10 ns;
    
    dut : maxs
    port map (clock      => clock,
              reset      => reset,
              input_odd  => input_odd,
              input_even => input_even,
              start      => start,
              done       => done,
              index_odd  => index_odd,
              index_even => index_even,
              val_odd    => val_odd,
              val_even   => val_even,
              val_odd_index_even => open,
              val_even_index_odd => open);
    
    process
        variable i      : integer := 0;
        variable test   : integer := 0;
    	variable total  : integer := 0;
    begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        
        -- ===== TEST1 =====
        for j in 0 to 63 loop
            input_odd(j) <= std_logic_vector(to_unsigned(j, input_odd(j)'length));
        end loop;
        
        for j in 0 to 63 loop
            input_even(j) <= std_logic_vector(to_unsigned(5, input_even(j)'length));
        end loop;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
                
        wait until done='1';
        wait for 1 ns;
        
        if  val_odd=std_logic_vector(to_unsigned(63, val_odd'length)) and index_odd=std_logic_vector(to_unsigned(63, index_even'length)) and
            val_even=std_logic_vector(to_unsigned(5, val_even'length)) and index_even=std_logic_vector(to_unsigned(63, index_even'length)) then
            
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;
        
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_maxs_arch;
