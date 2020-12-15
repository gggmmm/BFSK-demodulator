library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;
use ieee.math_real.all;

entity sdft_resonator is
    generic(
        wl  : natural := 12;     -- word length
        k   : natural := 0;     -- resonator index, between 0 and N-1
        N   : natural := 64;    -- DFT points
        M   : natural := 8      -- non-zero samples
    );
    port(
        clock, reset    : in std_logic;
        new_sample      : in std_logic;
        input           : in complex12;
        bufferM         : in complex12;
        output          : out complex12
    );
end entity;

architecture sdft_resonator_arch of sdft_resonator is
    function sign_function(val : in real) return std_logic is
    begin
        if val >= 0.0 then
            return '0';
        else
            return '1';
        end if;
    end sign_function;
    
    -- TWIDDLE FACTOR LEFT
    constant ARG_L    : real := 2.0*MATH_PI*Real(k)*Real(M)/Real(N);
    constant COEFF_L  : real := 2.0**(12.0-1.0);
    
    constant tw_r_L   : real :=       FLOOR(COEFF_L*COS(ARG_L)); -- magnitude real part
    constant tw_im_L  : real := -1.0* FLOOR(COEFF_L*SIN(ARG_L)); -- magnitude imaginary part
    
    constant twiddle_factor_r_mag_L   : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_r_L)), 12));
    constant twiddle_factor_im_mag_L  : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_im_L)), 12));
    
    constant twiddle_factor_r_s_L     : std_logic := sign_function(tw_r_L);
    constant twiddle_factor_im_s_L    : std_logic := sign_function(tw_im_L);
    
    -- TWIDDLE FACTOR RIGHT
    constant ARG_R    : real := 2.0*MATH_PI*Real(k)/Real(N);
    constant COEFF_R  : real := 2.0**(12.0-1.0);
    
    constant tw_r_R   : real :=       FLOOR(COEFF_R*COS(ARG_R)); -- magnitude real part
    constant tw_im_R  : real :=       FLOOR(COEFF_R*SIN(ARG_R)); -- magnitude imaginary part
    
    constant twiddle_factor_r_mag_R   : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_r_R)), 12));
    constant twiddle_factor_im_mag_R  : std_logic_vector(11 downto 0) := std_logic_vector(to_unsigned(integer(abs(tw_im_R)), 12));
    
    constant twiddle_factor_r_s_R     : std_logic := sign_function(tw_r_R);
    constant twiddle_factor_im_s_R    : std_logic := sign_function(tw_im_R);
    ------------------------------------------------------------------------
    
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
    
    --type type_bufferM is array (0 to M-1) of complex12;
    --signal bufferM : type_bufferM;
    signal result  : complex12 := COMPLEX_ZERO12;
    
    signal twiddle_factor_L,
           twiddle_factor_R,
           outMulLeft,
           outMulRight,
           outAddLeft,
           outAddRight : complex12 := COMPLEX_ZERO12;
    
    constant Lin : integer := 11;
    constant Hin : integer := 22;
    
begin
    -- SUB LEFT
    C_ADD_LEFT : COMPLEX_ADDER_12 port map( add_sub => '1', 
                                            op1 => bufferM,      
                                            op2 => outMulLeft, 
                                            res => outAddLeft);
                                        
    -- ADD RIGHT
    C_ADD_RIGHT : COMPLEX_ADDER_12 port map( add_sub => '0', 
                                             op1 => outAddLeft,      
                                             op2 => result, 
                                             res => outAddRight);
                                        
    -- MUL LEFT
    C_MUL_LEFT : COMPLEX_MULTIPLIER_12  generic map( L => Lin, H => Hin) 
                                        port map(   op1 => twiddle_factor_L, 
                                                    op2 => input, 
                                                    res => outMulLeft);
                                                
    -- MUL RIGHT
    C_MUL_RIGHT : COMPLEX_MULTIPLIER_12  generic map( L => Lin, H => Hin) 
                                         port map(   op1 => twiddle_factor_R, 
                                                     op2 => outAddRight, 
                                                     res => outMulRight);
                                        
    SHIFT_BUFFERM: process(clock, reset, new_sample, --bufferM, input, 
                           outMulRight)
    begin
        if rising_edge(clock) then
            if reset = '1' then
                for i in 0 to M-1 loop
                    --bufferM(i)  <= COMPLEX_ZERO12;
                    result      <= COMPLEX_ZERO12;
                end loop;
            else
                if new_sample = '1' then
                    --for i in M-1 downto 1 loop
                    --    bufferM(i) <= bufferM(i-1);                    
                    --end loop;
                    --bufferM(0)  <= input;
                    result      <= outMulRight;
                end if;
            end if;
        end if;
    end process;
    
    output <= result;
    
    twiddle_factor_L.c    <= '0';
    twiddle_factor_L.l.s  <= twiddle_factor_r_s_L;
    twiddle_factor_L.r.s  <= twiddle_factor_im_s_L;
    twiddle_factor_L.l.m  <= twiddle_factor_r_mag_L;
    twiddle_factor_L.r.m  <= twiddle_factor_im_mag_L;
    
    twiddle_factor_R.c    <= '0';
    twiddle_factor_R.l.s  <= twiddle_factor_r_s_R;
    twiddle_factor_R.r.s  <= twiddle_factor_im_s_R;
    twiddle_factor_R.l.m  <= twiddle_factor_r_mag_R;
    twiddle_factor_R.r.m  <= twiddle_factor_im_mag_R;
end architecture;
