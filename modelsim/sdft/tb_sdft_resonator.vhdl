library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;
use ieee.math_real.all;

entity tb_sdft_resonator is
end tb_sdft_resonator;

architecture tb_sdft_resonator_arch of tb_sdft_resonator is

    component sdft_resonator
        generic(
            wl  : natural := 12;     -- word length
            k   : natural := 0;     -- resonator index, between 0 and N-1
            N   : natural := 64;    -- DFT points
            M   : natural := 8      -- non-zero samples
        );
        port (clock  : in std_logic;
              reset  : in std_logic;
              new_sample      : in std_logic;
              input  : in complex12;
              output : out complex12);
    end component;

    signal clock  : std_logic;
    signal reset  : std_logic;    
    signal new_sample      : std_logic;
    signal input  : complex12;
    signal output : complex12;

    constant TbPeriod : time := 50 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : sdft_resonator
    generic map (   wl => 12,
                    k => 0,
                    N => 64,
                    M => 8)
    port map (clock  => clock,
              reset  => reset,
              new_sample => new_sample,
              input  => input,
              output => output);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clock is really your main clock signal
    clock <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        input <= COMPLEX_ZERO12;

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        
        for i in 1 to 8 loop
            input.c <= '0';
            input.l.s <= '0';
            input.r.s <= '0';
            input.l.m <= std_logic_vector(to_unsigned(i*64,12));
            input.r.m <= std_logic_vector(to_unsigned(0,12));
            wait for TbPeriod;
        end loop;
        
        wait for TbPeriod;
        
        reset <= '1';
        wait for 5*TbPeriod;
        reset <= '0';
        
        for i in 1 to 8 loop
            input.c <= '0';
            input.l.s <= '0';
            input.r.s <= '0';
            input.l.m <= std_logic_vector(to_unsigned(i*64,12));
            input.r.m <= std_logic_vector(to_unsigned(i*32,12));
            wait for TbPeriod;
        end loop;
        
        reset <= '1';
        wait for 5*TbPeriod;
        reset <= '0';
        
        for i in 1 to 16 loop
            input.c <= '0';
            input.l.s <= '0';
            input.r.s <= '0';
            input.l.m <= std_logic_vector(to_unsigned(i*64,12));
            input.r.m <= std_logic_vector(to_unsigned(5-i*32,12));
            wait for TbPeriod;
        end loop;
        
        wait for 2*TbPeriod;
        
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb_sdft_resonator_arch;
