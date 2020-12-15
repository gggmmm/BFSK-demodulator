library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_butterfly is
end tb_butterfly;

architecture tb of tb_butterfly is

    component butterfly is
    generic(
        index	: in natural := 21; -- 0 <= index <= N-1
        S	    : in natural := 1; --  1 <= S <= log2(N)
        N 	    : in natural := 64 -- power of two and N >= 2
    );
    port (
        in1, in2    : in complex12;        
        o1, o2      : out complex12
    );
	end component;

    signal in1 : complex12;
    signal in2 : complex12;
    signal o1  : complex12;
    signal o2  : complex12;

begin

    dut : butterfly
    generic map (
        index   => 21, -- between 0 and N/2-1
        S       => 1,
        N       => 64
    )
    port map (in1 => in1,
              in2 => in2,
              o1  => o1,
              o2  => o2);

    stimuli : process
    begin        
        in1.c <= '0';
        in1.l.s <= '0';
        in1.r.s <= '0';
        in1.l.m <= std_logic_vector(to_unsigned(3,12));
        in1.r.m <= std_logic_vector(to_unsigned(0,12));
        
        in2.c <= '0';
        in2.l.s <= '0';
        in2.r.s <= '0';
        in2.l.m <= std_logic_vector(to_unsigned(9,12));
        in2.r.m <= std_logic_vector(to_unsigned(0,12));
        
        wait for 100 ns;
        
        in1.c <= '0';
        in1.l.s <= '1';
        in1.r.s <= '0';
        in1.l.m <= std_logic_vector(to_unsigned(50,12));
        in1.r.m <= std_logic_vector(to_unsigned(33,12));
        
        in2.c <= '0';
        in2.l.s <= '0';
        in2.r.s <= '1';
        in2.l.m <= std_logic_vector(to_unsigned(12,12));
        in2.r.m <= std_logic_vector(to_unsigned(60,12));
        
        wait for 100 ns;
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_butterfly of tb_butterfly is
    for tb
	for dut: butterfly use entity work.butterfly(structure);
	end for;
    end for;
end cfg_tb_butterfly;
