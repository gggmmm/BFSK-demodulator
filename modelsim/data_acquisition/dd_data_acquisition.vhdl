library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity dd_data_acquisition is
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
end entity;

architecture dd_data_acquisition_arch of dd_data_acquisition is
    constant FSM_size       : natural := 3;
    
    constant S_IDLE         : std_logic_vector(FSM_size-1 downto 0) := "000";
    constant S_PLACE        : std_logic_vector(FSM_size-1 downto 0) := "001";
    constant S_C8_INCR      : std_logic_vector(FSM_size-1 downto 0) := "010";
    constant S_C_SYMB_INCR  : std_logic_vector(FSM_size-1 downto 0) := "011";
    constant S_WAIT_SAMPLE  : std_logic_vector(FSM_size-1 downto 0) := "100";
    constant S_DELAYSEL_WAIT : std_logic_vector(FSM_size-1 downto 0) := "101";
    constant S_COUNTER_RED  : std_logic_vector(FSM_size-1 downto 0) := "110";
    
    signal ps, cs, ns : std_logic_vector(FSM_size-1 downto 0) := (others => '0');
        
    type arr_8_x_complex12 is array (0 to 7) of complex12;
    signal samples_container : arr_8_x_complex12;
    
    signal counter8         : std_logic_vector(2 downto 0) := (others => '0');
    signal counterSymbols   : std_logic_vector(9 downto 0) := (others => '0'); -- there are 1008-2 symbols
    signal delayselCounter  : std_logic_vector(3 downto 0) := (others => '0');
    signal REG_delaysel     : std_logic_vector(delaysel'left+1 downto 0) := (others => '0');
begin
    done <= '1' when cs=S_IDLE and ps=S_C_SYMB_INCR else '0';
    start_data_detection <= '1' when cs=S_C_SYMB_INCR and ps=S_C8_INCR else '0';
    
    process(samples_container)
    begin
        for i in 0 to 7 loop
            output(i) <= samples_container(i);
        end loop;
    end process; 

    next_state : process(cs, new_sample, counterSymbols, counter8, enable, delayselCounter)
    begin
        ns <= cs;
        case cs is
            when S_IDLE =>
                if new_sample='1' and enable='1' then
                    ns <= S_DELAYSEL_WAIT;
                end if;
            when S_PLACE =>
                    ns <= S_C8_INCR;
            when S_C8_INCR =>
                if counter8="111" then
                    ns <= S_C_SYMB_INCR;
                else
                    ns <= S_WAIT_SAMPLE;
                end if;
            when S_C_SYMB_INCR =>
                if counterSymbols="0001101101" then 
                -- 1024-16-2 -> (1006)  -> 1005 1111101101
                -- 128-16-2  -> (110)   -> 109  0001101101
                -- 64-16-2   -> (46)    -> 45   0000101101 
                -- 32-16-2   -> (14)    -> 13   0000001101
                    ns <= S_IDLE;
                else
                    ns <= S_WAIT_SAMPLE;
                end if;
            when S_WAIT_SAMPLE =>
                if new_sample='1' then
                    ns <= S_PLACE;
                end if;
            when S_DELAYSEL_WAIT =>
                if new_sample='1' then
                    if delayselCounter="0000" then
                        ns <= S_PLACE;
                    else
                        ns <= S_COUNTER_RED;
                    end if;
                end if;
            when S_COUNTER_RED =>
                ns <= S_DELAYSEL_WAIT;
            when others => null;
        end case;
    end process;

    current_state : process(clock, reset, ns, cs)
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
    
    process(clock, reset, ns, cs, ps, counter8, sample, counterSymbols, delayselCounter, delaysel, REG_delaysel)
    begin
        if rising_edge(clock) then
            if reset='1' or (cs=S_IDLE and ps=S_C_SYMB_INCR) then
                counter8        <= (others => '0');
                counterSymbols  <= (others => '0');
                REG_delaysel    <= (others => '0');
                
                for i in 0 to 7 loop
                    samples_container(i) <= COMPLEX_ZERO12;
                end loop;
            else
                if cs=S_IDLE and new_sample='1' then
                    REG_delaysel <= "0" & delaysel;
                end if;
            
                if cs=S_PLACE then
                    samples_container(to_integer(unsigned(counter8))) <= sample;
                end if;
                
                if cs=S_C8_INCR then
                    counter8 <= std_logic_vector( unsigned(counter8) +1);
                end if;
                
                if cs=S_C_SYMB_INCR then
                    counterSymbols <= std_logic_vector( unsigned(counterSymbols) +1);
                end if;
                
                if cs=S_COUNTER_RED then
                    delayselCounter <= std_logic_vector(unsigned(delayselCounter) -1);
                end if;
                
                if cs=S_DELAYSEL_WAIT and ps=S_IDLE then
                    delayselCounter <= std_logic_vector( unsigned(REG_delaysel) + to_unsigned(9-1, delayselCounter'length) );
                end if;
            end if;
        end if;
    end process;

end;
