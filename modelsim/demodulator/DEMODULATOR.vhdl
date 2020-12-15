library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity DEMODULATOR is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        sample      : in complex12;
        
        packet_completed    : out std_logic;
        bit_stream          : out std_logic;
        new_bit             : out std_logic
    );
end entity;

architecture DEMODULATOR_arch of DEMODULATOR is
    component data_acquisition
        port (clock                   : in std_logic;
              reset                   : in std_logic;
              new_sample              : in std_logic;
              sample                  : in complex12;
              delaysel                : in std_logic_vector (2 downto 0);
              
              start_preamble_detector : out std_logic;
              output_pd               : out output_pd_data_acquisition;
              start_data_detection    : out std_logic;
              output_dd               : out output_dd_data_acquisition);
    end component;

    signal new_sample              : std_logic;
    signal start_preamble_detector : std_logic;
    signal output_pd               : output_pd_data_acquisition;
    signal start_data_detection    : std_logic;
    signal output_dd               : output_dd_data_acquisition;

    component PREAMBLE_DETECTOR is
        port(
            clock       : in std_logic;
            reset       : in std_logic;
            start       : in std_logic;
            input       : in input_PREAMBLE_DETECTOR;
            input_data_ready : in std_logic;
            
            done        : out std_logic := '0';
            delaysel    : out std_logic_vector(2 downto 0);
            binHigh     : out std_logic_vector(5 downto 0);
            binLow      : out std_logic_vector(5 downto 0);
            
            waiting_for_data : out std_logic -- '1' idicates that the module is ready to accept the next 8 complex input
        );
    end component;

    signal input_data_ready         : std_logic := '0';
    signal waiting_for_data         : std_logic := '0';
    signal input_preamble_detector  : input_preamble_detector;
    signal done_preamble_detector   : std_logic := '0';
    
    signal out_delaysel             : std_logic_vector (2 downto 0) := (others => '0');
    signal out_binHigh              : std_logic_vector (5 downto 0) := (others => '0');
    signal out_binLow               : std_logic_vector (5 downto 0) := (others => '0');
    
    signal REG_delaysel             : std_logic_vector (2 downto 0) := (others => '0');
    signal REG_binHigh              : std_logic_vector (5 downto 0) := (others => '0');
    signal REG_binLow               : std_logic_vector (5 downto 0) := (others => '0');
    
    component data_detection
        port (clock   : in std_logic;
              reset   : in std_logic;
              start   : in std_logic;
              input   : in input_data_detection;
              binHigh : in std_logic_vector (5 downto 0);
              binLow  : in std_logic_vector (5 downto 0);
              output  : out std_logic;
              done    : out std_logic);
    end component;

    signal input_data_detection   : input_data_detection;
    signal output_data_detection  : std_logic := '0';
    signal done_data_detection    : std_logic := '0';
    
    signal counter : std_logic_vector(8 downto 0) := (others => '0');
begin

    data_acquisition_unit : data_acquisition
    port map (clock                   => clock,
              reset                   => reset,
              new_sample              => new_sample,
              sample                  => sample,
              delaysel                => REG_delaysel,
              
              start_preamble_detector => start_preamble_detector,
              output_pd               => output_pd,
              start_data_detection    => start_data_detection,
              output_dd               => output_dd);

    process(output_pd, input_preamble_detector) 
    begin
        for i in 0 to output_pd'length-1 loop
            input_preamble_detector(i) <= output_pd(i);
        end loop;
    end process;

    preamble_detector_unit : PREAMBLE_DETECTOR
    port map (clock             => clock,
              reset             => reset,
              start             => start_preamble_detector,
              input             => input_preamble_detector,
              input_data_ready  => start_preamble_detector,
              waiting_for_data  => waiting_for_data,
              
              done              => done_preamble_detector,
              delaysel          => out_delaysel,
              binHigh           => out_binHigh,
              binLow            => out_binLow);
    
    process(output_dd, input_data_detection) 
    begin
        for i in 0 to output_dd'length-1 loop
            input_data_detection(i) <= output_dd(i);
        end loop;
    end process;
    
    data_detection_unit : data_detection
    port map (clock   => clock,
              reset   => reset,
              start   => start_data_detection,
              input   => input_data_detection,
              binHigh => REG_binHigh,
              binLow  => REG_binLow,
              
              output  => bit_stream,
              done    => new_bit);
              
    new_sample <= '1' when counter="000001010" else '0';
    
    process(clock, reset, counter)
    begin
        if rising_edge(clock) then
            if reset='1' or counter="000100011" then -- 35
                counter <= (others => '0');
            else
                counter <= std_logic_vector(unsigned(counter) +1);
            end if;
        end if;
    end process;
    
    process(clock, reset, out_delaysel, out_binHigh, out_binLow, done_preamble_detector)
    begin
        if rising_edge(clock) then
            if reset='1' then
                REG_delaysel <= (others => '0');
                REG_binHigh <= (others => '0');
                REG_binLow <= (others => '0');
            else
                if done_preamble_detector='1' then
                    REG_delaysel <= out_delaysel;
                    REG_binHigh <= out_binHigh;
                    REG_binLow <= out_binLow;
                end if;
            end if;
        end if;
    end process;
end;
