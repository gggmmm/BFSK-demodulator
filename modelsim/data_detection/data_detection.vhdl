-- receives as input complex12 from goertzel module
-- their FP representation is 5|7
-- the output is given with FP representation 1|6

library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity data_detection is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        
        start   : in std_logic;
        input   : in input_data_detection;
        binHigh : in std_logic_vector(5 downto 0);
        binLow  : in std_logic_vector(5 downto 0);
        
        output  : out std_logic;
        done    : out std_logic
    );
end entity data_detection;

architecture data_detection_arch of data_detection is
    component GOERTZEL is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
        xn      : in complex12;
        start   : in std_logic;
        output  : out complex12 := COMPLEX_ZERO12;
        done    : out std_logic := '0'
    );
    end component GOERTZEL;
    
    signal output_grzH      : complex12 := COMPLEX_ZERO12;
    signal output_grzL      : complex12 := COMPLEX_ZERO12;
    signal xn               : complex12 := COMPLEX_ZERO12;
    signal done_grzH        : std_logic;
    signal done_grzL        : std_logic;
    
    --REGS
    signal REG_out_grzH : complex12 := COMPLEX_ZERO12;
    signal REG_out_grzL : complex12 := COMPLEX_ZERO12;
    
    component magnitude_grz is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in complex12;
        start   : in std_logic;
        output  : out std_logic_vector(5 downto 0) := (others => '0');
        done    : out std_logic := '0'
    );
    end component magnitude_grz;
    
    signal out_mag_grzH : std_logic_vector(5 downto 0);
    signal out_mag_grzL : std_logic_vector(5 downto 0);
    signal REG_mag_grzH : std_logic_vector(5 downto 0);
    signal REG_mag_grzL : std_logic_vector(5 downto 0);
    signal done_mag0    : std_logic;
    signal done_mag1    : std_logic;
    signal counter : std_logic_vector(2 downto 0);
        
    -- FSM
    signal ps, cs, ns : std_logic_vector(2 downto 0) := (others => '0');
    
    constant S_IDLE         : std_logic_vector(cs'range) := "000";
    constant S_FEED_GRZ     : std_logic_vector(cs'range) := "001";
    constant S_FEED_GRZ_W   : std_logic_vector(cs'range) := "010"; -- this state is used just as a token
    constant S_GOERTZEL     : std_logic_vector(cs'range) := "011";
    constant S_MAGNITUDE    : std_logic_vector(cs'range) := "100";
    constant S_COMPARE      : std_logic_vector(cs'range) := "101";
    
    -- control signals
    signal start_GRZ, start_MAG : std_logic;
begin
    grzH : GOERTZEL port map(clock=> clock, reset=> reset, input=> binHigh, xn=> xn, start=> start_GRZ, output=> output_grzH, done=> done_grzH);
    grzL : GOERTZEL port map(clock=> clock, reset=> reset, input=> binLow,  xn=> xn, start=> start_GRZ, output=> output_grzL, done=> done_grzL);

    mag_grzH : magnitude_grz
    port map (clock  => clock,
              reset  => reset,
              input  => REG_out_grzH,
              start  => start_MAG,
              output => out_mag_grzH,
              done   => done_mag0);
              
    mag_grzL : magnitude_grz
    port map (clock  => clock,
              reset  => reset,
              input  => REG_out_grzL,
              start  => start_MAG,
              output => out_mag_grzL,
              done   => done_mag1);
              
    start_GRZ   <= '1' when cs=S_IDLE and ns=S_FEED_GRZ else '0';
    start_MAG   <= '1' when cs=S_MAGNITUDE and ps=S_GOERTZEL else '0';
              
    -- GOERTZEL FEEDER
    -- this process has to pass 1 sample at a time to the goertzel module, for 8 times
    -- each sample is maintained for 2 successive cycles
    -- the first is taken the cycle succesive to the start signal
    process(clock, reset, cs, input, counter)
    begin
        if rising_edge(clock) then
            if reset='1' or cs=S_GOERTZEL then
                counter <= (others => '0');
            else
                if cs=S_FEED_GRZ then
                    counter <= std_logic_vector(unsigned(counter) +1);                    
                end if;
            end if;
        end if;
    end process;
    
    xn <= input( to_integer(unsigned(counter)) ) when cs=S_FEED_GRZ or cs=S_FEED_GRZ_W else COMPLEX_ZERO12;
    
    -- REGS
    process(clock, reset, done_grzH, done_mag0, output_grzH, output_grzL, out_mag_grzH, out_mag_grzL, start, binLow, binHigh)
    begin
        if rising_edge(clock) then
            if reset='1' then
                REG_out_grzH <= COMPLEX_ZERO12;
                REG_out_grzL <= COMPLEX_ZERO12;
                REG_mag_grzH <= (others => '0');
                REG_mag_grzL <= (others => '0');
            else                
                if done_grzH='1' then
                    REG_out_grzH <= output_grzH;
                    REG_out_grzL <= output_grzL;
                end if;
                
                if done_mag0='1' then
                    REG_mag_grzH <= out_mag_grzH;
                    REG_mag_grzL <= out_mag_grzL;
                end if;
            end if;
        end if;
    end process;
    
    -- OUTPUT
    process(cs, REG_mag_grzH, REG_mag_grzL)
    begin
        if cs=S_COMPARE then
            if unsigned(REG_mag_grzL) > unsigned(REG_mag_grzH) then
               output <= '0';
            else
                output <= '1'; 
            end if;
        else
            output <= '0';
        end if;
    end process;
    
    done <= '1' when cs=S_COMPARE else '0';
              
    -- CONTROLLER
    next_state : process(cs, start, done_grzH, done_mag0, counter)
    begin
        ns <= cs;
        case cs is
            when S_IDLE =>
                if start='1' then
                    ns <= S_FEED_GRZ;
                end if;
            when S_FEED_GRZ =>
                if counter="111" then
                    ns <= S_GOERTZEL;
                else
                    ns <= S_FEED_GRZ_W;
                end if;
            when S_FEED_GRZ_W =>
                ns <= S_FEED_GRZ;
            when S_GOERTZEL =>
                if done_grzH='1' then
                    ns <= S_MAGNITUDE;
                end if;
            when S_MAGNITUDE =>
                if done_mag0='1' then
                    ns <= S_COMPARE;
                end if;
            when S_COMPARE =>
                ns <= S_IDLE;
            when others => null;
        end case;
    end process;
    
    current_state : process(clock, reset, cs, ns)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= (others => '0');
                ps <= (others => '0');
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process;
    
end data_detection_arch;
