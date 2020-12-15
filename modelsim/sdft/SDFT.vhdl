library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;
use ieee.math_real.all;

entity SDFT is
    generic(
        N : natural := 64;
        M : natural := 8
    );
    port(
        clock, reset    : in std_logic;
        new_sample      : in std_logic;           
        input           : in complex12;
        output          : out output_fft_zp
    );
end entity;

architecture SDFT_arch of SDFT is
    component sdft_resonator is
    generic(
        wl  : natural := 12;     -- word length
        k   : natural := 0;     -- resonator index, between 0 and N-1
        N   : natural := 64;    -- DFT points
        M   : natural := 8      -- non-zero samples
    );
    port(
        clock, reset    : in std_logic;
        input           : in complex12;
        bufferM         : in complex12;
        new_sample      : in std_logic;   
        output          : out complex12
    );
    end component;
    
    type type_bufferM is array (0 to M-1) of complex12;
    signal bufferM : type_bufferM;
begin
    GEN1: for j in 0 to N-1 generate
        dut : sdft_resonator
        generic map (   wl => 12,
                        k => j,
                        N => N,
                        M => M)
        port map (clock      => clock,
                  reset      => reset,
                  new_sample => new_sample,
                  bufferM    => bufferM(M-1), 
                  input      => input,
                  output     => output(j));
    end generate GEN1;
    
    SHIFT_BUFFERM: process(clock, reset, new_sample, bufferM, input)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                for i in 0 to M-1 loop
                    bufferM(i)  <= COMPLEX_ZERO12;
                end loop;
            else
                if new_sample = '1' then
                    for i in M-1 downto 1 loop
                        bufferM(i) <= bufferM(i-1);                    
                    end loop;
                    bufferM(0)  <= input;
                end if;
            end if;
        end if;
    end process;
end;
