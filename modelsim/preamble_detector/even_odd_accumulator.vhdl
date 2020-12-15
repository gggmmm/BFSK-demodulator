library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.my_package.all;

entity even_odd_accumulator is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        input       : in input_fft_zp;
        start       : in std_logic;
        dest_reg    : in std_logic_vector(2 downto 0); -- 0=delay 0; 1=delay 1...
        odd_or_even : in std_logic; -- 1=odd; 0=even
        clear_regs  : in std_logic;
        
        output_0e, output_0o  : out output_bank_of_adders;
        output_1e, output_1o  : out output_bank_of_adders;
        output_2e, output_2o  : out output_bank_of_adders;
        output_3e, output_3o  : out output_bank_of_adders;
        output_4e, output_4o  : out output_bank_of_adders;
        output_5e, output_5o  : out output_bank_of_adders;
        output_6e, output_6o  : out output_bank_of_adders;
        output_7e, output_7o  : out output_bank_of_adders;
        
        done    : out std_logic := '0'
    );
end entity even_odd_accumulator;

architecture even_odd_accumulator_arch of even_odd_accumulator is
    -- ========== FFT ==========
    component FFT_ZP
        port (clock  : in std_logic;
              reset  : in std_logic;
              start  : in std_logic;
              input  : in input_fft_zp;
              done   : out std_logic;
              output : out output_fft_zp);
    end component;
    
    -- input and output for the FFT module
    signal output_FFT   : output_fft_zp;
    signal start_FFT    : std_logic := '0';
    signal done_FFT     : std_logic := '0';
    -- REGS fft
    signal REGS_fft : output_fft_zp;
	
	-- ========== BANK OF MAGNITUDE ==========
	component bank_of_magnitude
        port (clock  : in std_logic;
              reset  : in std_logic;
              input  : in input_bank_of_magnitude;
              start  : in std_logic;
              output : out output_bank_of_magnitude;
              done   : out std_logic);
    end component;
    
    signal input_BOM  : input_bank_of_magnitude;
    signal start_BOM  : std_logic := '0';
    signal output_BOM : output_bank_of_magnitude;
    signal done_BOM   : std_logic := '0';
    -- REGS
    signal REGS_BOM   : output_bank_of_magnitude;
    
    -- ========== BANK OF ADDERS ==========
    component bank_of_adders
        port (clock  : in std_logic;
              reset  : in std_logic;
              input1 : in input_bank_of_adders;
              input2 : in input_bank_of_adders;
              start  : in std_logic;
              done   : out std_logic;
              output : out output_bank_of_adders);
    end component;

    signal input1_BOA  : input_bank_of_adders;
    signal input2_BOA  : input_bank_of_adders;
    signal start_BOA   : std_logic := '0';
    signal done_BOA    : std_logic := '0';
    signal output_BOA  : output_bank_of_adders;
    -- REGS
    signal REGS_output_odd_BOA_i0  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i1  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i2  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i3  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i4  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i5  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i6  : output_bank_of_adders;
    signal REGS_output_odd_BOA_i7  : output_bank_of_adders;
    
    signal REGS_output_even_BOA_i0 : output_bank_of_adders;
    signal REGS_output_even_BOA_i1 : output_bank_of_adders;
    signal REGS_output_even_BOA_i2 : output_bank_of_adders;
    signal REGS_output_even_BOA_i3 : output_bank_of_adders;
    signal REGS_output_even_BOA_i4 : output_bank_of_adders;
    signal REGS_output_even_BOA_i5 : output_bank_of_adders;
    signal REGS_output_even_BOA_i6 : output_bank_of_adders;
    signal REGS_output_even_BOA_i7 : output_bank_of_adders;
    
    -- ====== CONTROLLER ======
    signal ps, cs, ns : std_logic_vector(1 downto 0);
begin
    -- ================================================== FFT ==================================================
    fft : fft_zp
    port map (  clock   => clock,
                reset   => reset,
                start   => start_FFT,
                done    => done_FFT,
                input   => input,
                output  => output_FFT);
                
    process(clock, reset, done_FFT, output_FFT)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to 63 loop
                    REGS_fft(i) <= COMPLEX_ZERO12;
                end loop;
            elsif done_FFT='1' then
                for i in 0 to 63 loop
                    REGS_fft(i) <= output_FFT(i);
                end loop;
            end if;
        end if;    
    end process;
    
    -- ======================================== BANK OF MAGNITUDE ========================================
    process(REGS_fft)
    begin
        for i in 0 to 63 loop
            input_BOM(i) <= REGS_fft(i);
        end loop;
    end process;
    
    BOM : bank_of_magnitude
    port map (clock  => clock,
              reset  => reset,
              input  => input_BOM,
              start  => start_BOM,
              output => output_BOM,
              done   => done_BOM);
    
    process(clock, reset, output_BOM, done_BOM)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to 63 loop
                    REGS_BOM(i) <= (others => '0');
                end loop;
            elsif done_BOM='1' then
                for i in 0 to 63 loop
                    REGS_BOM(i) <= output_BOM(i);
                end loop;
            end if;
        end if;    
    end process;
    
    -- ======================================== BANK OF ADDERS ========================================
    input_BOA : process(REGS_BOM, dest_reg, odd_or_even, 
                        REGS_output_odd_BOA_i0,
                        REGS_output_odd_BOA_i1,  
                        REGS_output_odd_BOA_i2,  
                        REGS_output_odd_BOA_i3,  
                        REGS_output_odd_BOA_i4,  
                        REGS_output_odd_BOA_i5,  
                        REGS_output_odd_BOA_i6,  
                        REGS_output_odd_BOA_i7,
                        
                        REGS_output_even_BOA_i0, 
                        REGS_output_even_BOA_i1, 
                        REGS_output_even_BOA_i2, 
                        REGS_output_even_BOA_i3, 
                        REGS_output_even_BOA_i4, 
                        REGS_output_even_BOA_i5, 
                        REGS_output_even_BOA_i6, 
                        REGS_output_even_BOA_i7
                        )
    begin
        for i in 0 to 63 loop
            input1_BOA(i) <= "000" & REGS_BOM(i);
        end loop;
        
        case dest_reg is
            when "000" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i0(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i0(i);
                    end loop;
                end if;
            when "001" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i1(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i1(i);
                    end loop;
                end if;
            when "010" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i2(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i2(i);
                    end loop;
                end if;
            when "011" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i3(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i3(i);
                    end loop;
                end if;
            when "100" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i4(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i4(i);
                    end loop;
                end if;
            when "101" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i5(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i5(i);
                    end loop;
                end if;
            when "110" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i6(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i6(i);
                    end loop;
                end if;
            when "111" => 
                if odd_or_even='1' then
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_odd_BOA_i7(i);
                    end loop;
                else
                    for i in 0 to 63 loop
                        input2_BOA(i) <= REGS_output_even_BOA_i7(i);
                    end loop;
                end if;
            when others => null;
        end case;
    end process;
    
    BOA : bank_of_adders
    port map (clock  => clock,
              reset  => reset,
              input1 => input1_BOA,
              input2 => input2_BOA,
              start  => start_BOA,
              done   => done_BOA,
              output => output_BOA);
    
    -- THESE REGS ARE NOT NECESSARY
    regs_BOA : process(clock, reset, output_BOA, done_BOA, dest_reg, odd_or_even, clear_regs)
    begin
        if rising_edge(clock) then
            if reset='1' or clear_regs='1' then
                for i in 0 to 63 loop
                    REGS_output_odd_BOA_i0(i)  <= (others => '0');
                    REGS_output_odd_BOA_i1(i)  <= (others => '0');
                    REGS_output_odd_BOA_i2(i)  <= (others => '0');
                    REGS_output_odd_BOA_i3(i)  <= (others => '0');
                    REGS_output_odd_BOA_i4(i)  <= (others => '0');
                    REGS_output_odd_BOA_i5(i)  <= (others => '0');
                    REGS_output_odd_BOA_i6(i)  <= (others => '0');
                    REGS_output_odd_BOA_i7(i)  <= (others => '0');
                    
                    REGS_output_even_BOA_i0(i) <= (others => '0');
                    REGS_output_even_BOA_i1(i) <= (others => '0');
                    REGS_output_even_BOA_i2(i) <= (others => '0');
                    REGS_output_even_BOA_i3(i) <= (others => '0');
                    REGS_output_even_BOA_i4(i) <= (others => '0');
                    REGS_output_even_BOA_i5(i) <= (others => '0');
                    REGS_output_even_BOA_i6(i) <= (others => '0');
                    REGS_output_even_BOA_i7(i) <= (others => '0');
                end loop;
            elsif done_BOA='1' then
                case dest_reg is
                    when "000" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i0(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i0(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "001" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i1(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i1(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "010" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i2(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i2(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "011" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i3(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i3(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "100" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i4(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i4(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "101" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i5(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i5(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "110" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i6(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i6(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when "111" => 
                        if odd_or_even='1' then
                            for i in 0 to 63 loop
                                REGS_output_odd_BOA_i7(i) <= output_BOA(i);
                            end loop;
                        else
                            for i in 0 to 63 loop
                                REGS_output_even_BOA_i7(i) <= output_BOA(i);
                            end loop;
                        end if;
                    when others => null;
                end case;
            end if;
        end if;    
    end process;
    
    -- ======== CONTROLLER ========
    next_state : process(cs, start, done_FFT, done_BOA, done_BOM)
    begin
        ns <= cs;
        case cs is
            when "00" =>
                if start='1' then
                    ns <= "01";
                end if;
            when "01" =>
                if done_FFT='1' then
                    ns <= "10";
                end if;
            when "10" =>
                if done_BOM='1' then
                    ns <= "11";
                end if;
            when "11" =>
                if done_BOA='1' then
                    ns <= "00";
                end if;
            when others => null;
        end case;
    end process;
    
    current_state : process(clock, reset, ns, cs)
    begin
        if rising_edge(clock) then
            if reset='1' then
                cs <= "00";
                ps <= "00";
            else
                cs <= ns;
                ps <= cs;
            end if;
        end if;
    end process;
    
    -- control signal
    start_fft <= '1' when cs="01" and ps="00" else '0';
    start_BOM <= '1' when cs="10" and ps="01" else '0';
    start_BOA <= '1' when cs="11" and ps="10" else '0';
    done      <= '1' when cs="00" and ps="11" else '0';
    
    output_0o <= REGS_output_odd_BOA_i0;
    output_1o <= REGS_output_odd_BOA_i1;
    output_2o <= REGS_output_odd_BOA_i2;
    output_3o <= REGS_output_odd_BOA_i3;
    output_4o <= REGS_output_odd_BOA_i4;
    output_5o <= REGS_output_odd_BOA_i5;
    output_6o <= REGS_output_odd_BOA_i6;
    output_7o <= REGS_output_odd_BOA_i7;
        
    output_0e <= REGS_output_even_BOA_i0;
    output_1e <= REGS_output_even_BOA_i1;
    output_2e <= REGS_output_even_BOA_i2;
    output_3e <= REGS_output_even_BOA_i3;
    output_4e <= REGS_output_even_BOA_i4;
    output_5e <= REGS_output_even_BOA_i5;
    output_6e <= REGS_output_even_BOA_i6;
    output_7e <= REGS_output_even_BOA_i7;
    
end even_odd_accumulator_arch;
