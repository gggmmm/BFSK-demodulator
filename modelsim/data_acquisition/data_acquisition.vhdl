library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity data_acquisition is
    port(
        clock      : in std_logic := '0';
        reset      : in std_logic := '0';
        new_sample : in std_logic := '0';
        sample     : in complex12;
        delaysel   : in std_logic_vector(2 downto 0);
        
        start_preamble_detector : out std_logic;
        output_pd               : out output_pd_data_acquisition;
        
        start_data_detection    : out std_logic;
        output_dd               : out output_dd_data_acquisition
    );
end entity;

architecture data_acquisition_arch of data_acquisition is
    component pd_data_acquisition
        port (clock      : in std_logic;
              reset      : in std_logic;
              new_sample : in std_logic;
              enable     : in std_logic;
              sample     : in complex12;
              start_preamble_detector : out std_logic;
              output     : out output_pd_data_acquisition;
              done       : out std_logic);
    end component;

    signal enable_pd : std_logic := '0';
    signal done_pd   : std_logic := '0';

    component dd_data_acquisition
        port(
            clock       : in std_logic;
            reset       : in std_logic;
            new_sample  : in std_logic;
            sample      : in complex12;
            delaysel    : in std_logic_vector(2 downto 0);
            enable      : in std_logic;
            
            start_data_detection    : out std_logic;
            output                  : out output_dd_data_acquisition;
            done                    : out std_logic
        );
    end component;

    signal enable_dd  : std_logic := '0';
    signal done_dd    : std_logic := '0';
    
    -- FSM
    constant FSM_size : natural := 2;
    signal ps, cs, ns : std_logic_vector(FSM_size-1 downto 0) := (others => '0');
    
    constant S_IDLE : std_logic_vector(FSM_size-1 downto 0) := "00";
    constant S_PD : std_logic_vector(FSM_size-1 downto 0) := "01";
    constant S_DD : std_logic_vector(FSM_size-1 downto 0) := "10";
begin
    pd_da : pd_data_acquisition
    port map (clock      => clock,
              reset      => reset,
              new_sample => new_sample,
              enable     => enable_pd,
              sample     => sample,
              start_preamble_detector => start_preamble_detector,
              output     => output_pd,
              done       => done_pd);
              
    dd_da : dd_data_acquisition
    port map (clock                 => clock,
              reset                 => reset,
              new_sample            => new_sample,
              enable                => enable_dd,
              sample                => sample,
              delaysel              => delaysel,
              start_data_detection  => start_data_detection,
              output                => output_dd,
              done                  => done_dd);
              
    enable_pd <= '1' when (cs=S_IDLE and ns=S_PD) or (cs=S_PD) else '0';    
    enable_dd <= '1' when (cs=S_PD and ns=S_DD) or (cs=S_DD) else '0';
    
    next_state : process(cs, new_sample, done_pd, done_dd)
    begin
        ns <= cs;
        case cs is
           when S_IDLE =>
                if new_sample='1' then
                    ns <= S_PD;
                end if;
           when S_PD =>
                if done_pd='1' then
                    ns <= S_DD;
                end if;
           when S_DD =>
                if done_dd='1' then
                    ns <= S_IDLE;
                end if;
           when others => null;
       end case;
    end process;
    
    current_state : process(clock, reset, cs, ns)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= S_IDLE;
                ps <= S_IDLE;
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process;
end;
