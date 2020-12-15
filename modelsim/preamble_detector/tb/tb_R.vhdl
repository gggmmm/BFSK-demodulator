library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_R is
end entity tb_R;

architecture tb_R_arch of tb_R is
    component R
        port (clock              : in std_logic;
              reset              : in std_logic;
              start              : in std_logic;
              max_val_odd        : in std_logic_vector (7 downto 0);
              max_val_even       : in std_logic_vector (7 downto 0);
              val_even_index_odd : in std_logic_vector (7 downto 0);
              val_odd_index_even : in std_logic_vector (7 downto 0);
              index_max_odd      : in std_logic_vector (5 downto 0);
              index_max_even     : in std_logic_vector (5 downto 0);
              done               : out std_logic;
              result             : out std_logic_vector (7 downto 0));
    end component;

    signal clock              : std_logic := '0';
    signal reset              : std_logic := '0';
    signal start              : std_logic := '0';
    signal max_val_odd        : std_logic_vector (7 downto 0) := (others => '0');
    signal max_val_even       : std_logic_vector (7 downto 0) := (others => '0');
    signal val_even_index_odd : std_logic_vector (7 downto 0) := (others => '0');
    signal val_odd_index_even : std_logic_vector (7 downto 0) := (others => '0');
    signal index_max_odd      : std_logic_vector (5 downto 0) := (others => '0');
    signal index_max_even     : std_logic_vector (5 downto 0) := (others => '0');
    signal done               : std_logic := '0';
    signal result             : std_logic_vector (7 downto 0) := (others => '0');

begin

    dut : R
    port map (clock              => clock,
              reset              => reset,
              start              => start,
              max_val_odd        => max_val_odd,
              max_val_even       => max_val_even,
              val_even_index_odd => val_even_index_odd,
              val_odd_index_even => val_odd_index_even,
              index_max_odd      => index_max_odd,
              index_max_even     => index_max_even,
              done               => done,
              result             => result);

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
        max_val_odd         <= std_logic_vector(to_unsigned( 7,  max_val_odd'length ));
        max_val_even        <= std_logic_vector(to_unsigned( 15, max_val_even'length ));
        val_even_index_odd  <= std_logic_vector(to_unsigned( 5,  val_even_index_odd'length ));
        val_odd_index_even  <= std_logic_vector(to_unsigned( 2,  val_odd_index_even'length ));
        
        wait for 20 ns;
        
        if result=std_logic_vector(to_unsigned( 15, result'length )) then
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;        
                
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_R_arch;
