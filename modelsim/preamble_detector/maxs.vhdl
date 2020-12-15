library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity maxs is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        input_odd   : in output_bank_of_adders;
        input_even  : in output_bank_of_adders;
        start       : in std_logic;
        
        done        : out std_logic := '0';
        val_odd     : out std_logic_vector(8 downto 0);
        val_even    : out std_logic_vector(8 downto 0);        
        max_index_odd   : out std_logic_vector(5 downto 0);
        max_index_even  : out std_logic_vector(5 downto 0);
        val_odd_index_even    : out std_logic_vector(8 downto 0);
        val_even_index_odd    : out std_logic_vector(8 downto 0)
    );
end entity maxs;

architecture maxs_arch of maxs is 
    component max_finder64
    port (clock     : in std_logic;
          reset     : in std_logic;
          start     : in std_logic;
          input     : in input_max_finder64;
          max_index : out std_logic_vector (5 downto 0) := (others => '0');
          max_value : out std_logic_vector (8 downto 0) := (others => '0');
          done      : out std_logic);
    end component;
    
    -- WIRES
    signal iinput_odd    : input_max_finder64;
    signal iinput_even   : input_max_finder64;
    
    signal imax_index_odd   : std_logic_vector (5 downto 0) := (others => '0');
    signal max_value_odd    : std_logic_vector (8 downto 0) := (others => '0');
    signal done_odd         : std_logic;
    
    signal imax_index_even  : std_logic_vector (5 downto 0) := (others => '0');
    signal max_value_even   : std_logic_vector (8 downto 0) := (others => '0');
    signal done_even        : std_logic;
begin
    max_odd : max_finder64
    port map (clock     => clock,
              reset     => reset,
              start     => start,
              
              input     => iinput_odd,
              max_index => imax_index_odd,
              max_value => max_value_odd,
              done      => done_odd);
              
    max_even : max_finder64
    port map (clock     => clock,
              reset     => reset,
              start     => start,
              
              input     => iinput_even,
              max_index => imax_index_even,
              max_value => max_value_even,
              done      => done_even);
              
    process(input_odd, input_even)
    begin
        for i in 0 to 63 loop
            iinput_odd(i)   <= input_odd(i);
            iinput_even(i)  <= input_even(i);
        end loop;
    end process;
        
    -- OUTPUT
    done        <= done_even;
    val_odd     <= max_value_odd;
    val_even    <= max_value_even;
    
    max_index_odd   <= imax_index_odd;
    max_index_even  <= imax_index_even;

    val_odd_index_even <= input_odd( to_integer(unsigned( imax_index_even )));
    val_even_index_odd <= input_even( to_integer(unsigned( imax_index_odd )));
     
end maxs_arch;
