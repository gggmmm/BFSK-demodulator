-- this module is basically used only to instantiate the 64 magnitude computers.
-- the storing of the results is left to the caller.

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity bank_of_magnitude is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in input_bank_of_magnitude;
        start   : in std_logic;
        output  : out output_bank_of_magnitude;
        done    : out std_logic := '0'
    );
end entity bank_of_magnitude;

architecture bank_of_magnitude_arch of bank_of_magnitude is
    component magnitude
        port (clock  : in std_logic;
              reset  : in std_logic;
              input  : in complex12;
              start  : in std_logic;
              output : out std_logic_vector (5 downto 0) := (others => '0');
              done   : out std_logic);
    end component;
    
    -- WIRES
    type done_wires is array (0 to 63) of std_logic;
    signal in_done : done_wires;
begin
    gen_magnitude : for i in 0 to 63 generate
        magnitudeu : magnitude port map(
                        clock => clock, 
                        reset => reset, 
                        input => input(i), 
                        start => start, 
                        output => output(i), 
                        done => in_done(i)
                );
    end generate gen_magnitude;
    
    -- OUTPUT
    done <= in_done(0);
end bank_of_magnitude_arch;
