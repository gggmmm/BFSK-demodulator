library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;

entity butterfly is
    generic(
        index	: in natural := 21; -- 0 <= index <= N-1
		  S		: in natural := 1; --  1 <= S <= log2(N)
		  N 	: in natural := 64 -- power of two and N >= 2
    );
    port (
        in1, in2    : in complex12;        
        o1, o2      : out complex12
    );
end entity;

architecture butterfly_arch of butterfly is
    function sign_function(val : in real) return std_logic is
    begin
        if val >= 0.0 then
            return '0';
        else
            return '1';
        end if;
    end sign_function;
    
    constant ARG    : real := 2.0*MATH_PI*Real(index)*(2.0**Real(S-1))/Real(N);
    constant COEFF  : real := 2.0**12.0-1.0;
    
    constant tw_r   : real :=       FLOOR(COEFF*COS(ARG)); -- magnitude real part
    constant tw_im  : real := -1.0* FLOOR(COEFF*SIN(ARG)); -- magnitude imaginary part
    
    constant twiddle_factor_r_mag   : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_r)), 12));
    constant twiddle_factor_im_mag  : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_im)), 12));
    
    constant twiddle_factor_r_s     : std_logic := sign_function(tw_r);
    constant twiddle_factor_im_s    : std_logic := sign_function(tw_im);
    
    constant Lin : integer := 12;
    constant Hin : integer := 23;
    
    signal twiddle_factor : complex12 := COMPLEX_ZERO12;
    
    -- ==========================  COMPONENTS ===========================
    
    component SIGN_INVERTER_12 is
        port(
            Cin : in complex12;
            Cout : out complex12
        );
    end component SIGN_INVERTER_12;
    
    component COMPLEXITY_INVERTER_12 is
        port(
            Cin : in complex12;
            Cout : out complex12
        );
    end component COMPLEXITY_INVERTER_12;
    
    component COMPLEXITY_AND_SIGN_INVERTER_12 is
        port(
            Cin : in complex12;
            Cout : out complex12
        );
    end component COMPLEXITY_AND_SIGN_INVERTER_12;
    
    component COMPLEX_ADDER_12 is
        port(
            add_sub : in std_logic := '0'; -- 0 add/ 1 sub
            op1 : in complex12;
            op2 : in complex12;
            res : out complex12
        );
    end component COMPLEX_ADDER_12;
    
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
    
    signal  inv_out,
            add1_out : complex12 := COMPLEX_ZERO12;
begin
    C_ADD0 : COMPLEX_ADDER_12 port map( add_sub => '0', 
                                        op1 => in1,      
                                        op2 => in2, 
                                        res => o1);
                                        
    INV : SIGN_INVERTER_12 port map(    Cin => in2, 
                                        Cout => inv_out);
    
    C_ADD1 : COMPLEX_ADDER_12 port map( add_sub => '0', 
                                        op1 => in1,      
                                        op2 => inv_out, 
                                        res => add1_out);
    
    -- if not last stage, do twiddle factor multiplication
    GEN_IF: if integer(2.0**Real(S)) /= N generate
        GEN_IF_I0 : if index=0 generate
            -- NOTHING TO DO, MULTIPLICATION BY 1  
            o2 <= add1_out;
        end generate GEN_IF_I0;
        
        GEN_IF_IN4 : if index*integer(2.0**real(S-1))*4=N generate
            -- MULTIPLICATION BY -j
            MINUS_J : COMPLEXITY_AND_SIGN_INVERTER_12
                        port map(
                            Cin => add1_out,
                            Cout => o2
                        );
        end generate GEN_IF_IN4;
        
        GEN_IF_IN2 : if index*integer(2.0**real(S-1))*2=N generate
            -- MULTIPLICATION BY -1
            INV : SIGN_INVERTER_12 
                        port map(    
                            Cin => add1_out, 
                            Cout => o2
                        );
        end generate GEN_IF_IN2;
        
        GEN_IF_I3N4 : if index*integer(2.0**real(S-1))*4=3*N generate
            -- MULTIPLICATION BY j
            -- just invert complexity
            J : COMPLEXITY_INVERTER_12 
                        port map(    
                            Cin => add1_out, 
                            Cout => o2
                        );            
        end generate GEN_IF_I3N4;
            
        --all the previous cases don't apply
        GEN_ELSE : if   index /= 0      and 
                        index*integer(2.0**real(S-1))*4 /= N    and 
                        index*integer(2.0**real(S-1))*2 /= N    and 
                        index*integer(2.0**real(S-1))*4 /= 3*N  generate
                        
            C_MUL : COMPLEX_MULTIPLIER_12   generic map( L => Lin, H => Hin) 
                                            port map(   op1 => twiddle_factor, 
                                                        op2 => add1_out, 
                                                        res => o2);
        end generate GEN_ELSE;
        
    end generate GEN_IF;
    
    -- in the last stage there is no need to carry out the multiplication
    GEN_ELSE: if integer(2.0**Real(S)) = N generate
        o2 <= add1_out;
    end generate GEN_ELSE;

    twiddle_factor.c    <= '0';
    twiddle_factor.l.s  <= twiddle_factor_r_s;
    twiddle_factor.r.s  <= twiddle_factor_im_s;
    twiddle_factor.l.m  <= twiddle_factor_r_mag;
    twiddle_factor.r.m  <= twiddle_factor_im_mag;    
end;
