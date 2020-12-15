library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity pd_data_acquisition is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        new_sample  : in std_logic;
        sample      : in complex12;
        enable      : in std_logic;
        
        start_preamble_detector : out std_logic;
        
        output      : out output_pd_data_acquisition;
        done        : out std_logic := '0'
    );
end entity pd_data_acquisition;

architecture pd_data_acquisition_arch of pd_data_acquisition is
    constant FSM_size : natural := 3;
    
    constant S_IDLE             : std_logic_vector(FSM_size-1 downto 0) := "000";
    constant S_PLACE            : std_logic_vector(FSM_size-1 downto 0) := "001";
    constant S_WAIT_SAMPLE      : std_logic_vector(FSM_size-1 downto 0) := "010";
    constant S_INCR_i           : std_logic_vector(FSM_size-1 downto 0) := "011";
    constant S_SPECIAL_SHIFT    : std_logic_vector(FSM_size-1 downto 0) := "100";
    constant S_INCR_j           : std_logic_vector(FSM_size-1 downto 0) := "101";
    
    signal counter_i : std_logic_vector(2 downto 0) := (others => '0');
    signal counter_j : std_logic_vector(3 downto 0) := (others => '0');
    
    type array_15xcomplex12 is array (0 to 14) of complex12;
    signal samples_container : array_15xcomplex12;
    
    signal place_index : std_logic_vector(3 downto 0) := (others => '0');
    
    signal cs, ns, ps : std_logic_vector(FSM_size-1 downto 0) := S_IDLE;
begin
    done <= '1' when cs=S_IDLE and ps=S_INCR_j else '0';
    
    start_preamble_detector <= '1' when cs=S_INCR_i and ps=S_PLACE else '0';
        
    output_mux : process(samples_container, counter_i, cs, ps)
    begin
        if cs=S_INCR_i and ps=S_PLACE then
            case counter_i is
                when "000" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i).c;
                        output(i).l.s <= samples_container(i).l.s;
                        output(i).l.m <= samples_container(i).l.m;
                        output(i).r.s <= samples_container(i).r.s;
                        output(i).r.m <= samples_container(i).r.m;
                    end loop;
                when "001" =>
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+1).c;
                        output(i).l.s <= samples_container(i+1).l.s;
                        output(i).l.m <= samples_container(i+1).l.m;
                        output(i).r.s <= samples_container(i+1).r.s;
                        output(i).r.m <= samples_container(i+1).r.m;
                    end loop;
                when "010" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+2).c;
                        output(i).l.s <= samples_container(i+2).l.s;
                        output(i).l.m <= samples_container(i+2).l.m;
                        output(i).r.s <= samples_container(i+2).r.s;
                        output(i).r.m <= samples_container(i+2).r.m;
                    end loop;
                when "011" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+3).c;
                        output(i).l.s <= samples_container(i+3).l.s;
                        output(i).l.m <= samples_container(i+3).l.m;
                        output(i).r.s <= samples_container(i+3).r.s;
                        output(i).r.m <= samples_container(i+3).r.m;
                    end loop;
                when "100" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+4).c;
                        output(i).l.s <= samples_container(i+4).l.s;
                        output(i).l.m <= samples_container(i+4).l.m;
                        output(i).r.s <= samples_container(i+4).r.s;
                        output(i).r.m <= samples_container(i+4).r.m;
                    end loop;
                when "101" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+5).c;
                        output(i).l.s <= samples_container(i+5).l.s;
                        output(i).l.m <= samples_container(i+5).l.m;
                        output(i).r.s <= samples_container(i+5).r.s;
                        output(i).r.m <= samples_container(i+5).r.m;
                    end loop;
                when "110" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+6).c;
                        output(i).l.s <= samples_container(i+6).l.s;
                        output(i).l.m <= samples_container(i+6).l.m;
                        output(i).r.s <= samples_container(i+6).r.s;
                        output(i).r.m <= samples_container(i+6).r.m;
                    end loop;
                when "111" => 
                    for i in 0 to 7 loop
                        output(i).c <= samples_container(i+7).c;
                        output(i).l.s <= samples_container(i+7).l.s;
                        output(i).l.m <= samples_container(i+7).l.m;
                        output(i).r.s <= samples_container(i+7).r.s;
                        output(i).r.m <= samples_container(i+7).r.m;
                    end loop;
                when others =>
                        for i in 0 to 7 loop
                            output(i).c <= samples_container(i).c;
                            output(i).l.s <= samples_container(i).l.s;
                            output(i).l.m <= samples_container(i).l.m;
                            output(i).r.s <= samples_container(i).r.s;
                            output(i).r.m <= samples_container(i).r.m;
                        end loop;
            end case;
        else
            for i in 0 to 7 loop
                output(i).c <= samples_container(i).c;
                output(i).l.s <= samples_container(i).l.s;
                output(i).l.m <= samples_container(i).l.m;
                output(i).r.s <= samples_container(i).r.s;
                output(i).r.m <= samples_container(i).r.m;
            end loop;          
        end if;
    end process;

    counter_increment : process(clock, reset, cs, ps, counter_i, counter_j)
    begin
        if rising_edge(clock) then
            if reset='1' or (cs=S_IDLE and ps=S_INCR_j) then
                counter_i <= (others => '0');
                counter_j <= (others => '0');
            else
                case cs is
                    when S_INCR_i =>        counter_i <= std_logic_vector( unsigned(counter_i) +1);
                    when S_SPECIAL_SHIFT => counter_i <= (others => '0');
                    when S_INCR_j =>        counter_j <= std_logic_vector( unsigned(counter_j) +1);
                    when others => null;
                end case;
            end if;
        end if;    
    end process;
    
    samples_container_manager : process(clock, reset, cs, sample, place_index)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to 14 loop
                    samples_container(i) <= COMPLEX_ZERO12;
                end loop;
            else
                if cs=S_PLACE then
                    samples_container(to_integer(unsigned(place_index))) <= sample;
                end if;
                
                if cs=S_SPECIAL_SHIFT then
                    samples_container(0) <= samples_container(8);
                    samples_container(1) <= samples_container(9);
                    samples_container(2) <= samples_container(10);
                    samples_container(3) <= samples_container(11);
                    samples_container(4) <= samples_container(12);
                    samples_container(5) <= samples_container(13);
                    samples_container(6) <= samples_container(14);
                end if;
            end if;
        end if;
    end process;
    
    update_place_index : process(clock, reset, cs, ps, place_index)
    begin
        if rising_edge(clock) then
            if reset='1' or (cs=S_IDLE and ps=S_INCR_j) then
                place_index <= (others => '0');
            else
                if cs=S_WAIT_SAMPLE and (ps=S_PLACE or ps=S_INCR_i or ps=S_INCR_j) then
                    place_index <= std_logic_vector(unsigned(place_index) +1);
                end if;
                    
                if cs=S_SPECIAL_SHIFT then
                    place_index <= "0110"; -- it should be 7, but because it will move to wait_sample, it will also increment by 1 there.
                end if;
            end if;
        end if;
    end process;

    update_cs : process(clock, reset, ns, cs)
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
    
    next_state : process(new_sample, cs, place_index, counter_i, counter_j, enable)
    begin
        ns <= cs;
        case cs is
            when S_IDLE => 
                        if new_sample='1' and enable='1' then
                            ns <= S_PLACE;
                        end if;
            when S_PLACE => 
                        if place_index >= "0111" then
                            ns <= S_INCR_i;
                        else
                            ns <= S_WAIT_SAMPLE;
                        end if;
            when S_INCR_i =>
                        if counter_i="111" then
                            ns <= S_SPECIAL_SHIFT;
                        else
                            ns <= S_WAIT_SAMPLE;
                        end if;
            when S_INCR_j =>
                        if counter_j="1101" then
                            ns <= S_IDLE;
                        else
                            ns <= S_WAIT_SAMPLE;
                        end if;
            when S_SPECIAL_SHIFT => ns <= S_INCR_j;
            when S_WAIT_SAMPLE =>
                        if new_sample='1' then
                            ns <= S_PLACE;
                        end if;
            when others => null;
        end case;
    end process;
    
end pd_data_acquisition_arch;
