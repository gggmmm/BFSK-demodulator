library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_bank_of_adders is
end entity tb_bank_of_adders;

architecture tb_bank_of_adders_arch of tb_bank_of_adders is
    component bank_of_adders
        port (clock  : in std_logic;
              reset  : in std_logic;
              input1 : in input_bank_of_adders;
              input2 : in input_bank_of_adders;
              start  : in std_logic;
              done   : out std_logic;
              output : out output_bank_of_adders);
    end component;

    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal input1 : input_bank_of_adders;
    signal input2 : input_bank_of_adders;
    signal start  : std_logic := '0';
    signal done   : std_logic := '0';
    signal output : output_bank_of_adders;
begin

    clock <= not clock after 10 ns;

    dut : bank_of_adders
    port map (clock  => clock,
              reset  => reset,
              input1 => input1,
              input2 => input2,
              start  => start,
              done   => done,
              output => output);
              
    process
        variable i : integer := 0;
        variable test : integer := 0;
    	variable total : integer := 0;
    begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
                
        -- ===== TEST1 =====
        -- ODD
        for j in 0 to 63 loop
            input1(j) <= std_logic_vector(to_unsigned(j,input1(j)'length));
            input2(j) <= std_logic_vector(to_unsigned(2*j,input2(j)'length));
        end loop;
        
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        if  output(50)=std_logic_vector(to_unsigned(150, output(50)'length)) then
            
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;
        
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_bank_of_adders_arch;
