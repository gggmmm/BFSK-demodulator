library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity GOERTZEL is
    port(
        clock   : in std_logic;
        reset   : in std_logic;
        input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
        xn      : in complex12;
        start   : in std_logic;
        output  : out complex12 := COMPLEX_ZERO12;
        done    : out std_logic := '0'
    );
end entity GOERTZEL;

architecture GOERTZEL_ARCH of GOERTZEL is
    component COMPLEX_MULTIPLIER_12 is
        generic(    L : integer := 12;
                    H : integer := 23
        );
        port(
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_MULTIPLIER_12;
    
    component COMPLEX_ADDER_12 is
        port(
            add_sub : in std_logic := '0'; -- 0 add/ 1 sub
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_ADDER_12;
    
    component COS_TERM_SELECTOR is
        port(
            input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
            output  : out complex12 := COMPLEX_ZERO12
        );
    end component COS_TERM_SELECTOR;
    
    component WKN_SELECTOR is
        port(
            input   : in std_logic_vector(5 downto 0); -- the index of the bin that I want to compute
            output  : out complex12 := COMPLEX_ZERO12
        );
    end component WKN_SELECTOR;
    
    component FACTOR_SELECTOR is
        port(
            input   : in std_logic_vector(2 downto 0); -- the index of the bin that I want to compute
            output  : out complex12 := COMPLEX_ZERO12
        );
    end component FACTOR_SELECTOR;
    
    signal res, s0, s1, s2 : complex12 := COMPLEX_ZERO12;
    
    signal add_sub          : std_logic := '0';
    
    signal adder_op1, adder_op2, resa   : complex12 := COMPLEX_ZERO12;
    signal mul_op1, mul_op2, resm       : complex12 := COMPLEX_ZERO12;
        
    signal ps, cs, ns : std_logic_vector(2 downto 0) := "000";
    
    constant IDLE   : std_logic_vector := "000";
    constant SM1    : std_logic_vector := "001";
    constant SHIFT  : std_logic_vector := "010";
    constant MUL1   : std_logic_vector := "011";
    constant SUB1   : std_logic_vector := "100";
    constant SUB2   : std_logic_vector := "101";
    constant MUL2   : std_logic_vector := "110";
    
    signal out_wkns, reg_wkns   : complex12 := COMPLEX_ZERO12;
    signal out_ct, reg_ct       : complex12 := COMPLEX_ZERO12;
    signal out_fac, reg_fac     : complex12 := COMPLEX_ZERO12;
    signal res_ctm              : complex12 := COMPLEX_ZERO12;
    
    signal counter : std_logic_vector(2 downto 0) := "000";
begin
    wkns    : WKN_SELECTOR port map(input=> input, output=>out_wkns );
    cts     : COS_TERM_SELECTOR port map(input=> input, output=>out_ct );
    facs    : FACTOR_SELECTOR port map(input=> input(2 downto 0), output=>out_fac );
    
    m0 : COMPLEX_MULTIPLIER_12              generic map(L=> 11, H=>22) port map(op1 => mul_op1, op2 => mul_op2, res => resm);
    cos_term_mult : COMPLEX_MULTIPLIER_12   generic map(L=> 10, H=>21) port map(op1 => s1,      op2 => reg_ct,  res => res_ctm);
    
    a0 : COMPLEX_ADDER_12       port map(add_sub => add_sub, op1 => adder_op1, op2 => adder_op2, res => resa);
    
    process(clock, reset, counter, cs)
    begin
        if rising_edge(clock) then
            if reset='1' or cs=MUL1 then
                counter <= "000";
            elsif cs=SHIFT and ns=SM1 then
                counter <= std_logic_vector(unsigned(counter)+1);
            end if;
        end if;
    end process;
    
    -- REGISTERS UPDATE
    process(reset, clock, start, cs, ns, resa, res_ctm, s1)
    begin
        if rising_edge(clock) then
            if reset='1' or (cs=IDLE and ns=SM1) then
                s0 <= COMPLEX_ZERO12;
                s1 <= COMPLEX_ZERO12;
                s2 <= COMPLEX_ZERO12;
            else
                case cs is
                    when SM1 =>
                        s0 <= resa;
                        s2 <= res_ctm;
                    when SHIFT =>
                        s0 <= resa;
                        s1 <= resa;
                        s2 <= s1;
                    when MUL1 =>
                        s0 <= res_ctm;
                        s1 <= resm;
                    when SUB1 =>
                        s2 <= resa;
                    when SUB2 =>
                        s2 <= resa;
                    when MUL2 =>
                        s2 <= resm;
                    when others => null;
                end case;
            end if;
        end if;    
    end process;
    
    add_sub <= '0' when cs=SHIFT            else '1';
    done    <= '1' when cs=IDLE and ps=MUL2 else '0';
    output  <= s2  when cs=IDLE and ps=MUL2 else COMPLEX_ZERO12;
    
    
    -- this process save into registers the values coming from the three muxes
    process(clock, reset, start, out_wkns, out_ct, out_fac)
    begin
        if rising_edge(clock) then
            if reset='1' or cs=MUL2 then
                reg_wkns    <= COMPLEX_ZERO12;
                reg_ct      <= COMPLEX_ZERO12;
                reg_fac     <= COMPLEX_ZERO12;
            elsif start='1' then
                reg_wkns    <= out_wkns;
                reg_ct      <= out_ct;
                reg_fac     <= out_fac;
            end if;
        end if;
    end process;

    -- MUX complex multiplier m0 input
    process(s1, s2, reg_wkns, reg_fac, cs)
    begin
        case cs is
            when MUL1 =>
                mul_op1 <= reg_wkns;
                mul_op2 <= s1;
            when MUL2 =>
                mul_op1 <= reg_fac;
                mul_op2 <= s2;
            when others =>
                mul_op1 <= COMPLEX_ZERO12;
                mul_op2 <= COMPLEX_ZERO12;
        end case;
    end process;
        
    -- MUX adder input
    process(xn, s2, s1, s0, cs)
    begin
        case cs is
            when SM1 =>
                adder_op1 <= xn;
                adder_op2 <= s2;
            when SHIFT =>
                adder_op1 <= s0;
                adder_op2 <= s2;
            when SUB1 =>
                adder_op1 <= s0;
                adder_op2 <= s2;
            when SUB2 =>
                adder_op1 <= s2;
                adder_op2 <= s1;
            when others =>
                adder_op1 <= COMPLEX_ZERO12;
                adder_op2 <= COMPLEX_ZERO12;
        end case;
    end process;
    
    -- CURRENT STATE UPDATE
    process(clock, reset, ns, cs)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= IDLE;
                ps <= IDLE;
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process;
    
    -- NEXT STATE UPDATE
    process(cs, start, counter)
    begin
        ns <= cs;
        case cs is
            when IDLE =>
                if start='1' then
                    ns <= SM1;
                end if;
            when SM1 => ns <= SHIFT;
            when SHIFT => 
                if counter="111" then
                    ns <= MUL1;
                else
                    ns <= SM1;
                end if;
            when MUL1 => ns <= SUB1;
            when SUB1 => ns <= SUB2;
            when SUB2 => ns <= MUL2;
            when MUL2 => ns <= IDLE;
            when others => report "FORBIDDEN STATE";
        end case;
    end process;
end GOERTZEL_ARCH;
