library ieee;

use ieee.std_logic_1164.all;

--  --- ---- ------------ ---- ------------
-- | c | sl |     pl     | sr |     pr     |
--  --- ---- ------------ ---- ------------
-- if c=0, pl is the real part, if c=1, pr is the real part.
-- the imaginary parts follow automatically from this.
-- sl and sr are respectively the sign of the left part and of the right part
package my_package is
    -- naming convection: complexN, N stands for the size of the two parts
    type real12 is record
        s : std_logic; -- sign
        m : std_logic_vector(11 downto 0); -- magnitude
    end record;
    
    type complex12 is record -- used in fft
        c : std_logic;
        l : real12;
        r : real12;
    end record;
    
    constant COMPLEX_ZERO12 : complex12 := ( c => '0', l => (s => '0', m => "000000000000"), r => (s => '0', m => "000000000000"));
    
    constant REAL_ZERO12 : real12 := ( s=>'0', m=>"000000000000");
        
    type input_bank_of_magnitude is array (0 to 63) of complex12;
    type output_bank_of_magnitude is array (0 to 63) of std_logic_vector(9 downto 0);
    
    type input_bank_of_adders is array (0 to 63) of std_logic_vector(11 downto 0);
    type output_bank_of_adders is array (0 to 63) of std_logic_vector(11 downto 0);
        
    type input_max_finder64 is array (0 to 63) of std_logic_vector(11 downto 0);
    
    type input_PREAMBLE_DETECTOR is array (0 to 7) of complex12;
    
    type input_fft_zp is array (0 to 7) of complex12;
    type output_fft_zp is array (0 to 63) of complex12;
    
    type input_data_detection is array (0 to 7) of complex12;
    
    type output_pd_data_acquisition is array (0 to 7) of complex12;
    
    type output_dd_data_acquisition is array (0 to 7) of complex12;
    
    type io_fft is array(0 to 63) of complex12;
end my_package;
