library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity stage_fft is
    generic(
        N : natural := 64;
        stage_number : natural := 1 -- >= 1
    );
    port(
        input : in io_fft;
        output : out io_fft
    );
end entity;

architecture stage_fft_arch of stage_fft is
    component butterfly
        generic (
            index, S, N : in natural
        );
        port (in1 : in complex12;
              in2 : in complex12;
              o1  : out complex12;
              o2  : out complex12);
    end component;

    constant MAX_J : natural := natural(2.0**real(stage_number-1))-1;
    constant MAX_I : natural := N/natural(2.0**real(stage_number))-1;
begin
    GEN_LAB1 : for J in 0 to MAX_J generate
        GEN_LAB1 : for I in 0 to MAX_I generate
            BTFLY : butterfly
                generic map(
                    index => I,
                    S => stage_number,
                    N => N
                )
                port map(
                    in1 => input( J*N/natural(2.0**real(stage_number-1)) + I ),
                    in2 => input( J*N/natural(2.0**real(stage_number-1)) + I + N/natural(2.0**real(stage_number)) ),
                    o1 => output( J*N/natural(2.0**real(stage_number-1)) + I ),
                    o2 => output( J*N/natural(2.0**real(stage_number-1)) + I + N/natural(2.0**real(stage_number)) )
                );
        end generate GEN_LAB1;
    end generate GEN_LAB1;
end;
