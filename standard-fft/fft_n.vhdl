library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity fft is
    generic(
        N : natural := 64; -- >= 2
        enable_registers : boolean := false
    );
    port(
        clock, reset : in std_logic;
        input : in io_fft;
        bor0, bor1, bor2, bor3, bor4, bor5 : out complex12;
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
    
    constant num_of_stages : natural := integer(LOG2(Real(N))); -- >= 1
    
    type arr_io_fft is array(0 to num_of_stages-1) of io_fft;
    signal stage_out    : arr_io_fft;
    signal stage_in     : arr_io_fft;
    signal bor_out      : arr_io_fft;
    signal bor_in       : arr_io_fft;
begin
    GEN_LAB : for I in 0 to num_of_stages-1 generate
        STAGE : stage_fft
            generic map(
                N => N,
                stage_number => I+1
            )
            port map(
                input  => stage_in(I),
                output => stage_out(I)
            );
            
        GEN_BOR : if enable_registers=true generate
            BOR : bank_of_registers
                generic map(
                    N => N
                )
                port map(
                    clock => clock,
                    reset => reset,
                    input => bor_in(I),
                    output => bor_out(I)
                );
                
            bor_in(I) <= stage_out(I);
        end generate GEN_BOR;
        
        NO_BOR : if enable_registers=false and I>0 generate
            stage_in(I) <= stage_out(I-1);
        end generate NO_BOR;
    end generate GEN_LAB;
    
    stage_in(0) <= input;
    
    NO_BOR : if enable_registers=false generate                
        output <= stage_out(stage_out'right);
    end generate NO_BOR;
    
    BOR : if enable_registers=true generate                
        output <= bor_out(bor_out'right);
    end generate BOR;
        
    bor0 <= bor_out(0)(5);            
    bor1 <= bor_out(1)(18);
    bor2 <= bor_out(2)(28);
    bor3 <= bor_out(3)(12);
    bor4 <= bor_out(4)(10);
    bor5 <= bor_out(4)(10);
end;
