library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_even_odd_accumulator is
end entity tb_even_odd_accumulator;

architecture tb_even_odd_accumulator_arch of tb_even_odd_accumulator is
    component even_odd_accumulator
        port (clock       : in std_logic;
              reset       : in std_logic;
              input       : in input_fft_zp;
              start       : in std_logic;
              dest_reg    : in std_logic_vector (2 downto 0);
              odd_or_even : in std_logic;
              clear_regs  : in std_logic;
                output_0e, output_0o  : out output_bank_of_adders;
                output_1e, output_1o  : out output_bank_of_adders;
                output_2e, output_2o  : out output_bank_of_adders;
                output_3e, output_3o  : out output_bank_of_adders;
                output_4e, output_4o  : out output_bank_of_adders;
                output_5e, output_5o  : out output_bank_of_adders;
                output_6e, output_6o  : out output_bank_of_adders;
                output_7e, output_7o  : out output_bank_of_adders;
              done        : out std_logic);
    end component;

    signal clock       : std_logic := '0';
    signal reset       : std_logic := '0';
    signal input       : input_fft_zp;
    signal start       : std_logic := '0';
    signal dest_reg    : std_logic_vector (2 downto 0);
    signal odd_or_even : std_logic := '0';
    signal clear_regs : std_logic := '0';
    signal output_0e   : output_bank_of_adders;
    signal output_0o   : output_bank_of_adders;
    signal output_1e   : output_bank_of_adders;
    signal output_1o   : output_bank_of_adders;
    signal output_2e   : output_bank_of_adders;
    signal output_2o   : output_bank_of_adders;
    signal output_3e   : output_bank_of_adders;
    signal output_3o   : output_bank_of_adders;
    signal output_4e   : output_bank_of_adders;
    signal output_4o   : output_bank_of_adders;
    signal output_5e   : output_bank_of_adders;
    signal output_5o   : output_bank_of_adders;
    signal output_6e   : output_bank_of_adders;
    signal output_6o   : output_bank_of_adders;
    signal output_7e   : output_bank_of_adders;
    signal output_7o   : output_bank_of_adders;
    signal done        : std_logic := '0';
begin

    clock <= not clock after 10 ns;

    dut : even_odd_accumulator
    port map (clock       => clock,
              reset       => reset,
              input       => input,
              start       => start,
              dest_reg    => dest_reg,
              odd_or_even => odd_or_even,
              clear_regs  => clear_regs,
              output_0e   => output_0e,
              output_0o   => output_0o,
              output_1e   => output_1e,
              output_1o   => output_1o,
              output_2e   => output_2e,
              output_2o   => output_2o,
              output_3e   => output_3e,
              output_3o   => output_3o,
              output_4e   => output_4e,
              output_4o   => output_4o,
              output_5e   => output_5e,
              output_5o   => output_5o,
              output_6e   => output_6e,
              output_6o   => output_6o,
              output_7e   => output_7e,
              output_7o   => output_7o,
              done        => done);
              
    process
        variable i      : integer := 0;
        variable test   : integer := 0;
    	variable total  : integer := 0;
    begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
                
        -- ===== TEST1 =====
        for j in 0 to 7 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(j*32,input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0,input(j).r.m'length));
        end loop;
        
        dest_reg <= "000";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 20 ns;
        -- =========== 00 even
        
        for j in 0 to 7 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(2*j*32,input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0,input(j).r.m'length));
        end loop;
        
        dest_reg <= "001";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 20 ns;
        
        for j in 0 to 7 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(j*32,input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0,input(j).r.m'length));
        end loop;
        
        dest_reg <= "010";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 20 ns;
        
        for j in 0 to 7 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(128,input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0,input(j).r.m'length));
        end loop;
        
        dest_reg <= "011";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 20 ns;
        
        for j in 0 to 7 loop
            input(j).c      <= '0';
            input(j).l.s    <= '0';
            input(j).l.m    <= std_logic_vector(to_unsigned(128,input(j).l.m'length));
            input(j).r.s    <= '0';
            input(j).r.m    <= std_logic_vector(to_unsigned(0,input(j).r.m'length));
        end loop;
        
        dest_reg <= "011";
        start <= '1';
        wait for 20 ns;
        start <= '0';
        
        wait until done='1';
        wait for 20 ns;
        
        if  false then            
            test := test +1;
        else
            report "TEST 1 FAILED";
        end if;
	    total := total +1;
        
        -- ========== PRINT RESULTS ==========
	    report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end tb_even_odd_accumulator_arch;
