library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity fft is
    generic(
        N : natural := 32; -- >= 2
        enable_registers : boolean := true
    );
    port(
        clock, reset : in std_logic;
        input : in io_fft;
        output : out io_fft
    );
end entity;

architecture fft_arch of fft is
    component stage_fft
        generic(
            N : natural; -- >= 2
            stage_number : natural -- >= 1
        );
        port (input  : in io_fft;
              output : out io_fft);
    end component;
    
    component bank_of_registers is
        generic(
            N : natural -- number of registers
        );
        port(
            clock, reset : in std_logic;
            input        : in io_fft;
            output       : out io_fft
        );
    end component;
    
    constant num_of_stages : natural := integer(LOG2(Real(N)));
    
    type arr_io_fft is array(0 to num_of_stages-1) of io_fft;
    signal stage_out    : arr_io_fft;
    signal bor_out      : arr_io_fft;
begin
    -- ================ STAGE 1 ==================
    STAGE1 : stage_fft
        generic map(
            N => N,
            stage_number => 2
        )
        port map(
            input  => input,
            output => output
        );
        
--    BOR1 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(0),
--            output => output
--        );
--        
--    -- ================ STAGE 2 ==================
--    STAGE2 : stage_fft
--        generic map(
--            N => N,
--            stage_number => 2
--        )
--        port map(
--            input  => stage_out(0),
--            output => stage_out(1)
--        );
--        
--    BOR2 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(1),
--            output => bor_out(1)
--        );
--        
--    -- ================ STAGE 3 ==================
--    STAGE3 : stage_fft
--        generic map(
--            N => N,
--            stage_number => 3
--        )
--        port map(
--            input  => stage_out(1),
--            output => stage_out(2)
--        );
--        
--    BOR3 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(2),
--            output => bor_out(2)
--        );
--        
    -- ================ STAGE 4 ==================
--    STAGE4 : stage_fft
--        generic map(
--            N => N,
--            stage_number => 4
--        )
--        port map(
--            input  => input,
--            output => stage_out(3)
--        );
--        
--    BOR4 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(3),
--            output => bor_out(3)
--        );
        
    -- ================ STAGE 5 ==================
--    STAGE5 : stage_fft
--        generic map(
--            N => N,
--            stage_number => 5
--        )
--        port map(
--            input  => input,
--            output => stage_out(4)
--        );
--        
--    BOR5 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(4),
--            output => bor_out(4)
--        );
        
    -- ================ STAGE 6 ==================
--    STAGE6 : stage_fft
--        generic map(
--            N => N,
--            stage_number => 6
--        )
--        port map(
--            input  => input,
--            output => stage_out(5)
--        );
--        
--    BOR6 : bank_of_registers
--        generic map(
--            N => N
--        )
--        port map(
--            clock => clock,
--            reset => reset,
--            input => stage_out(5),
--            output => output
--        );
end;
