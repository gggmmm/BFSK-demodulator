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
        bor0, bor1, bor2, bor3 : out io_fft;        
        s0, s1, s2, s3, s4 : out io_fft;
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
    GEN_LAB : for I in 0 to num_of_stages-1 generate
        IF_FIRST_STAGE : if I=0 generate        
            STAGE : stage_fft
                generic map(
                    N => N,
                    stage_number => I+1
                )
                port map(
                    input  => input,
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
                        input => stage_out(I),
                        output => bor_out(I)
                    );
            end generate GEN_BOR;
        end generate IF_FIRST_STAGE;
        
        IF_ITERM_STAGE : if 0<I and I<num_of_stages-1 generate
            GEN_1 : if enable_registers=true generate                
                STAGE : stage_fft
                    generic map(
                        N => N,
                        stage_number => I+1
                    )
                    port map(
                        input  => bor_out(I-1),
                        output => stage_out(I)
                    );
                    
                BOR : bank_of_registers
                    generic map(
                        N => N
                    )
                    port map(
                        clock => clock,
                        reset => reset,
                        input => stage_out(I),
                        output => bor_out(I)
                    );                
            end generate GEN_1;
            
            GEN_2 : if enable_registers=false generate                
                STAGE : stage_fft
                    generic map(
                        N => N,
                        stage_number => I+1
                    )
                    port map(
                        input  => stage_out(I-1),
                        output => stage_out(I)
                    );
            end generate GEN_2;            
        end generate IF_ITERM_STAGE;
        
        IF_LAST_STAGE : if I=num_of_stages-1 generate
            GEN_1 : if enable_registers=true generate                
                STAGE : stage_fft
                    generic map(
                        N => N,
                        stage_number => I+1
                    )
                    port map(
                        input  => bor_out(I-1),
                        output => stage_out(I)
                    );
                    
                BOR : bank_of_registers
                    generic map(
                        N => N
                    )
                    port map(
                        clock => clock,
                        reset => reset,
                        input => stage_out(I),
                        output => output
                    );
            end generate GEN_1;
            
            GEN_2 : if enable_registers=false generate                
                STAGE : stage_fft
                    generic map(
                        N => N,
                        stage_number => I+1
                    )
                    port map(
                        input  => stage_out(I-1),
                        output => output
                    );
            end generate GEN_2;  
        end generate IF_LAST_STAGE;        
    end generate GEN_LAB;
    
    bor0 <= bor_out(0);            
    bor1 <= bor_out(1);
    bor2 <= bor_out(2);
    bor3 <= bor_out(3);
    s0 <= stage_out(0);
    s1 <= stage_out(1);
    s2 <= stage_out(2);
    s3 <= stage_out(3);    
    s4 <= stage_out(4);  
end;
