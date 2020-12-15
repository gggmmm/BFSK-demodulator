-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 12.9.2018 09:26:09 GMT

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_stage_fft is
end tb_stage_fft;

architecture tb_stage of tb_stage_fft is

    component stage_fft
        generic(
            N : natural;
            stage_number : natural -- >= 1
        );
        port (input  : in io_fft;
              output : out io_fft);
    end component;

    signal input  : io_fft;
    signal output : io_fft;

begin

    dut : stage_fft
    generic map(
        N => 64,
        stage_number => 1
    )
    port map (input  => input,
              output => output);

    stimuli : process
    begin
        for i in 0 to 63 loop
            input(i).c <= '0';
            input(i).l.s <= '0';
            input(i).r.s <= '0';
            input(i).l.m <= std_logic_vector(to_unsigned(i*32,12));
            input(i).r.m <= std_logic_vector(to_unsigned(i*32,12));
        end loop;
        
        wait;
    end process;

end tb_stage;

configuration cfg_tb_stage of tb_stage_fft is
    for tb_stage
        for dut: stage_fft use entity work.stage_fft(stage_fft_arch);
        end for;
    end for;
end cfg_tb_stage;
