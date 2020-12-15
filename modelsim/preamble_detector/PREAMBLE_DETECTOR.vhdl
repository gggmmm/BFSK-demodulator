library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity PREAMBLE_DETECTOR is
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
end entity PREAMBLE_DETECTOR;

architecture PREAMBLE_DETECTOR_arch of PREAMBLE_DETECTOR is
    -- ===== EVEN ODD ACCUMULATOR =====
    component even_odd_accumulator
    port (clock       : in std_logic;
          reset       : in std_logic;
          input       : in input_fft_zp;
          start       : in std_logic;
          clear_regs  : in std_logic;
          dest_reg    : in std_logic_vector (2 downto 0);
          odd_or_even : in std_logic;
          output_0e   : out output_bank_of_adders;
          output_0o   : out output_bank_of_adders;
          output_1e   : out output_bank_of_adders;
          output_1o   : out output_bank_of_adders;
          output_2e   : out output_bank_of_adders;
          output_2o   : out output_bank_of_adders;
          output_3e   : out output_bank_of_adders;
          output_3o   : out output_bank_of_adders;
          output_4e   : out output_bank_of_adders;
          output_4o   : out output_bank_of_adders;
          output_5e   : out output_bank_of_adders;
          output_5o   : out output_bank_of_adders;
          output_6e   : out output_bank_of_adders;
          output_6o   : out output_bank_of_adders;
          output_7e   : out output_bank_of_adders;
          output_7o   : out output_bank_of_adders;
          done        : out std_logic);
    end component;

    signal input_EOA    : input_fft_zp;
    signal start_EOA    : std_logic := '0';
    signal dest_reg     : std_logic_vector (2 downto 0);
    signal odd_or_even  : std_logic := '0';
    signal output_0e    : output_bank_of_adders;
    signal output_0o    : output_bank_of_adders;
    signal output_1e    : output_bank_of_adders;
    signal output_1o    : output_bank_of_adders;
    signal output_2e    : output_bank_of_adders;
    signal output_2o    : output_bank_of_adders;
    signal output_3e    : output_bank_of_adders;
    signal output_3o    : output_bank_of_adders;
    signal output_4e    : output_bank_of_adders;
    signal output_4o    : output_bank_of_adders;
    signal output_5e    : output_bank_of_adders;
    signal output_5o    : output_bank_of_adders;
    signal output_6e    : output_bank_of_adders;
    signal output_6o    : output_bank_of_adders;
    signal output_7e    : output_bank_of_adders;
    signal output_7o    : output_bank_of_adders;
    signal done_EOA     : std_logic := '0';
    signal clear_regs_EOA  : std_logic := '0';
    -- REGS
    signal REGS_output_0e   : output_bank_of_adders;
    signal REGS_output_0o   : output_bank_of_adders;
    signal REGS_output_1e   : output_bank_of_adders;
    signal REGS_output_1o   : output_bank_of_adders;
    signal REGS_output_2e   : output_bank_of_adders;
    signal REGS_output_2o   : output_bank_of_adders;
    signal REGS_output_3e   : output_bank_of_adders;
    signal REGS_output_3o   : output_bank_of_adders;
    signal REGS_output_4e   : output_bank_of_adders;
    signal REGS_output_4o   : output_bank_of_adders;
    signal REGS_output_5e   : output_bank_of_adders;
    signal REGS_output_5o   : output_bank_of_adders;
    signal REGS_output_6e   : output_bank_of_adders;
    signal REGS_output_6o   : output_bank_of_adders;
    signal REGS_output_7e   : output_bank_of_adders;
    signal REGS_output_7o   : output_bank_of_adders;

    -- ========== MAXS ==========
    component maxs is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        input_odd   : in output_bank_of_adders;
        input_even  : in output_bank_of_adders;
        start       : in std_logic;
        
        done        : out std_logic := '0';
        val_odd     : out std_logic_vector(8 downto 0);
        val_even    : out std_logic_vector(8 downto 0);        
        max_index_odd   : out std_logic_vector(5 downto 0);
        max_index_even  : out std_logic_vector(5 downto 0);
        val_odd_index_even    : out std_logic_vector(8 downto 0);
        val_even_index_odd    : out std_logic_vector(8 downto 0)
    );
    end component maxs;
    
    signal start_MAXS   : std_logic := '0';
    signal  done_MAXS0,
            done_MAXS1, 
            done_MAXS2,
            done_MAXS3,
            done_MAXS4,
            done_MAXS5,
            done_MAXS6, 
            done_MAXS7 : std_logic := '0';
    
    signal  input_odd0, 
            input_odd1, 
            input_odd2, 
            input_odd3, 
            input_odd4, 
            input_odd5, 
            input_odd6, 
            input_odd7 : output_bank_of_adders;
            
    signal  input_even0, 
            input_even1, 
            input_even2,
            input_even3,
            input_even4,
            input_even5,
            input_even6, 
            input_even7 : output_bank_of_adders;
    
    type TYPE_ARR_8_x_12bit is array (0 to 7) of std_logic_vector (8 downto 0);
    type TYPE_ARR_8_x_6bit is array (0 to 7) of std_logic_vector (5 downto 0);

    signal  out_val_odd_MAXS,
            out_val_even_MAXS, 
            out_val_odd_index_even_MAXS,
            out_val_even_index_odd_MAXS  : TYPE_ARR_8_x_12bit;
    
    signal  out_index_max_odd,
            out_index_max_even  : TYPE_ARR_8_x_6bit;
        
    -- REGS
    signal  REGS_val_odd_MAXS,
            REGS_val_even_MAXS, 
            REGS_val_odd_index_even_MAXS,
            REGS_val_even_index_odd_MAXS  : TYPE_ARR_8_x_12bit;
            
    signal  REGS_index_max_odd,
            REGS_index_max_even  : TYPE_ARR_8_x_6bit;
    
    -- ========== R ==========
    component R is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        
        max_val_odd         : in std_logic_vector(8 downto 0);
        max_val_even        : in std_logic_vector(8 downto 0);
        val_even_index_odd  : in std_logic_vector(8 downto 0);
        val_odd_index_even  : in std_logic_vector(8 downto 0);
        
        done        : out std_logic := '0';
        result      : out std_logic_vector(8 downto 0)
    );
    end component R;
    
    signal start_R  : std_logic := '0';
    signal  done_R0, 
            done_R1, 
            done_R2,
            done_R3,
            done_R4,
            done_R5,
            done_R6, 
            done_R7   : std_logic := '0';
            
    signal  result_R0,
    		result_R1,
    		result_R2,
    		result_R3,
    		result_R4,
    		result_R5,
    		result_R6,
    		result_R7 : std_logic_vector (8 downto 0) := (others => '0');
    -- REGS
    signal  REGS_result_R0,
    		REGS_result_R1,
    		REGS_result_R2,
    		REGS_result_R3,
    		REGS_result_R4,
    		REGS_result_R5,
    		REGS_result_R6,
    		REGS_result_R7 : std_logic_vector (8 downto 0) := (others => '0');
    
    -- ========== MAX OF RS ==========
    component max_of_Rs is
    port(
        clock       : in std_logic;
        reset       : in std_logic;
        start       : in std_logic;
        
        R0  : in std_logic_vector(8 downto 0);
        R1  : in std_logic_vector(8 downto 0);
        R2  : in std_logic_vector(8 downto 0);
        R3  : in std_logic_vector(8 downto 0);
        R4  : in std_logic_vector(8 downto 0);
        R5  : in std_logic_vector(8 downto 0);
        R6  : in std_logic_vector(8 downto 0);
        R7  : in std_logic_vector(8 downto 0);
        
        done        : out std_logic := '0';
        result      : out std_logic_vector(2 downto 0)
    );
    end component max_of_Rs;
    
    signal start_MOR  : std_logic := '0';
    signal done_MOR   : std_logic := '0';
    signal result_MOR : std_logic_vector(2 downto 0) := (others => '0');
    signal t_binLow   : std_logic_vector(5 downto 0) := (others => '0');
    signal t_binHigh  : std_logic_vector(5 downto 0) := (others => '0');
        
    signal REG_delaysel : std_logic_vector(2 downto 0) := (others => '0');
    signal REG_binLow   : std_logic_vector(5 downto 0) := (others => '0');
    signal REG_binHigh  : std_logic_vector(5 downto 0) := (others => '0');
    
    signal bin1, bin2 : std_logic_vector(5 downto 0) := (others => '0');
    
    -- ====================
    -- ==== CONTROLLER ====
    signal cs, ns, ps : std_logic_vector(2 downto 0) := (others => '0');
    signal i_counter : std_logic_vector(2 downto 0)  := (others => '0');
    signal j_counter : std_logic_vector(3 downto 0)  := (others => '0');
    
    constant S_IDLE             : std_logic_vector(2 downto 0) := "000";
    constant S_EOA              : std_logic_vector(2 downto 0) := "001";
    constant S_INCR_i           : std_logic_vector(2 downto 0) := "010";
    constant S_INCR_j           : std_logic_vector(2 downto 0) := "011";
    constant S_WAIT_FOR_DATA    : std_logic_vector(2 downto 0) := "100";
    constant S_MAXS             : std_logic_vector(2 downto 0) := "101";
    constant S_R                : std_logic_vector(2 downto 0) := "110";
    constant S_MOR              : std_logic_vector(2 downto 0) := "111";
begin
    -- ======================================== EVEN ODD ACCUMULATOR ========================================
    process(input)
    begin
        for i in 0 to 7 loop
            input_EOA(i) <= input(i);
        end loop;
    end process;
    
    EOA : even_odd_accumulator
    port map (clock       => clock,
              reset       => reset,
              input       => input_EOA,
              start       => start_EOA,
              clear_regs  => clear_regs_EOA,
              dest_reg    => dest_reg,
              odd_or_even => odd_or_even,
              output_0e   => output_0e,
              output_0o   => output_0o,
              output_1e   => output_1e,
              output_1o   => output_1o,
              output_2e   => output_2e,
              output_2o   => output_2o,
              output_3e   => output_3e,
              output_3o   => output_3o,
              output_4e   => output_4e,
              output_4o   => output_4o,
              output_5e   => output_5e,
              output_5o   => output_5o,
              output_6e   => output_6e,
              output_6o   => output_6o,
              output_7e   => output_7e,
              output_7o   => output_7o,
              done        => done_EOA);
              
    dest_reg    <= i_counter;
    -- in MATLAB because arrays start from 1, the first is an odd, while here because it starts from 0, the first
    -- is an even. therefore the negation makes it as it is supposed to be
    odd_or_even <= not j_counter(0);
              
    process(clock, reset, done_EOA)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to 63 loop
                    REGS_output_0e(i) <= (others => '0');
                    REGS_output_0o(i) <= (others => '0');
                    REGS_output_1e(i) <= (others => '0');
                    REGS_output_1o(i) <= (others => '0');
                    REGS_output_2e(i) <= (others => '0');
                    REGS_output_2o(i) <= (others => '0');
                    REGS_output_3e(i) <= (others => '0');
                    REGS_output_3o(i) <= (others => '0');
                    REGS_output_4e(i) <= (others => '0');
                    REGS_output_4o(i) <= (others => '0');
                    REGS_output_5e(i) <= (others => '0');
                    REGS_output_5o(i) <= (others => '0');
                    REGS_output_6e(i) <= (others => '0');
                    REGS_output_6o(i) <= (others => '0');
                    REGS_output_7e(i) <= (others => '0');
                    REGS_output_7o(i) <= (others => '0');
                end loop;
            elsif done_EOA='1' then
                REGS_output_0e <= output_0e;
                REGS_output_0o <= output_0o;
                REGS_output_1e <= output_1e;
                REGS_output_1o <= output_1o;
                REGS_output_2e <= output_2e;
                REGS_output_2o <= output_2o;
                REGS_output_3e <= output_3e;
                REGS_output_3o <= output_3o;
                REGS_output_4e <= output_4e;
                REGS_output_4o <= output_4o;
                REGS_output_5e <= output_5e;
                REGS_output_5o <= output_5o;
                REGS_output_6e <= output_6e;
                REGS_output_6o <= output_6o;
                REGS_output_7e <= output_7e;
                REGS_output_7o <= output_7o;
            end if;
        end if;
    end process;
    
    -- ======================================== MAXS ========================================
    process(    REGS_output_0e, 
                REGS_output_0o, 
                REGS_output_1e, 
                REGS_output_1o, 
                REGS_output_2e, 
                REGS_output_2o, 
                REGS_output_3e, 
                REGS_output_3o,  
                REGS_output_4e, 
                REGS_output_4o,  
                REGS_output_5e, 
                REGS_output_5o,  
                REGS_output_6e, 
                REGS_output_6o, 
                REGS_output_7e, 
                REGS_output_7o)
    begin
        for i in 0 to 63 loop
            input_odd0(i)   <= REGS_output_0o(i);
            input_even0(i)  <= REGS_output_0e(i);
            input_odd1(i)   <= REGS_output_1o(i);
            input_even1(i)  <= REGS_output_1e(i);
            input_odd2(i)   <= REGS_output_2o(i);
            input_even2(i)  <= REGS_output_2e(i);
            input_odd3(i)   <= REGS_output_3o(i);
            input_even3(i)  <= REGS_output_3e(i);
            input_odd4(i)   <= REGS_output_4o(i);
            input_even4(i)  <= REGS_output_4e(i);
            input_odd5(i)   <= REGS_output_5o(i);
            input_even5(i)  <= REGS_output_5e(i);
            input_odd6(i)   <= REGS_output_6o(i);
            input_even6(i)  <= REGS_output_6e(i);
            input_odd7(i)   <= REGS_output_7o(i);
            input_even7(i)  <= REGS_output_7e(i);
        end loop;
    end process;
    
    MAXSu0 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_0o,
              input_even            => REGS_output_0e,
              start                 => start_MAXS,
              done                  => done_MAXS0,
              max_index_odd         => out_index_max_odd(0),
              max_index_even        => out_index_max_even(0),
              val_odd               => out_val_odd_MAXS(0),
              val_even              => out_val_even_MAXS(0),
              val_odd_index_even    => out_val_odd_index_even_MAXS(0),
              val_even_index_odd    => out_val_even_index_odd_MAXS(0) );
              
    MAXSu1 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_1o,
              input_even            => REGS_output_1e,
              start                 => start_MAXS,
              done                  => done_MAXS1,              
              max_index_odd         => out_index_max_odd(1),
              max_index_even        => out_index_max_even(1),
              val_odd               => out_val_odd_MAXS(1),
              val_even              => out_val_even_MAXS(1),
              val_odd_index_even    => out_val_odd_index_even_MAXS(1),
              val_even_index_odd    => out_val_even_index_odd_MAXS(1) );
              
    MAXSu2 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_2o,
              input_even            => REGS_output_2e,
              start                 => start_MAXS,
              done                  => done_MAXS2,
              max_index_odd         => out_index_max_odd(2),
              max_index_even        => out_index_max_even(2),              
              val_odd               => out_val_odd_MAXS(2),
              val_even              => out_val_even_MAXS(2),
              val_odd_index_even    => out_val_odd_index_even_MAXS(2),
              val_even_index_odd    => out_val_even_index_odd_MAXS(2) );
              
    MAXSu3 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_3o,
              input_even            => REGS_output_3e,
              start                 => start_MAXS,
              done                  => done_MAXS3,              
              max_index_odd         => out_index_max_odd(3),
              max_index_even        => out_index_max_even(3),
              val_odd               => out_val_odd_MAXS(3),
              val_even              => out_val_even_MAXS(3),
              val_odd_index_even    => out_val_odd_index_even_MAXS(3),
              val_even_index_odd    => out_val_even_index_odd_MAXS(3) );
              
    MAXSu4 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_4o,
              input_even            => REGS_output_4e,
              start                 => start_MAXS,
              done                  => done_MAXS4,              
              max_index_odd         => out_index_max_odd(4),
              max_index_even        => out_index_max_even(4),
              val_odd               => out_val_odd_MAXS(4),
              val_even              => out_val_even_MAXS(4),
              val_odd_index_even    => out_val_odd_index_even_MAXS(4),
              val_even_index_odd    => out_val_even_index_odd_MAXS(4) );
              
    MAXSu5 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_5o,
              input_even            => REGS_output_5e,
              start                 => start_MAXS,
              done                  => done_MAXS5,              
              max_index_odd         => out_index_max_odd(5),
              max_index_even        => out_index_max_even(5),
              val_odd               => out_val_odd_MAXS(5),
              val_even              => out_val_even_MAXS(5),
              val_odd_index_even    => out_val_odd_index_even_MAXS(5),
              val_even_index_odd    => out_val_even_index_odd_MAXS(5) );
              
    MAXSu6 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_6o,
              input_even            => REGS_output_6e,
              start                 => start_MAXS,
              done                  => done_MAXS3,              
              max_index_odd         => out_index_max_odd(6),
              max_index_even        => out_index_max_even(6),
              val_odd               => out_val_odd_MAXS(6),
              val_even              => out_val_even_MAXS(6),
              val_odd_index_even    => out_val_odd_index_even_MAXS(6),
              val_even_index_odd    => out_val_even_index_odd_MAXS(6) );
              
    MAXSu7 : maxs
    port map (clock                 => clock,
              reset                 => reset,
              input_odd             => REGS_output_7o,
              input_even            => REGS_output_7e,
              start                 => start_MAXS,
              done                  => done_MAXS3,              
              max_index_odd         => out_index_max_odd(7),
              max_index_even        => out_index_max_even(7),
              val_odd               => out_val_odd_MAXS(7),
              val_even              => out_val_even_MAXS(7),
              val_odd_index_even    => out_val_odd_index_even_MAXS(7),
              val_even_index_odd    => out_val_even_index_odd_MAXS(7) );
              
    
    
    process(clock, reset, done_MAXS0, out_val_odd_MAXS, out_val_even_MAXS, out_val_odd_index_even_MAXS, out_val_even_index_odd_MAXS, out_index_max_odd, out_index_max_even)
    begin
        if rising_edge(clock) then
            if reset='1' then
                for i in 0 to 7 loop
                    REGS_val_odd_MAXS(i)            <= (others => '0');
                    REGS_val_even_MAXS(i)           <= (others => '0');
                    REGS_val_odd_index_even_MAXS(i) <= (others => '0');
                    REGS_val_even_index_odd_MAXS(i) <= (others => '0');
                    REGS_index_max_odd(i)           <= (others => '0');
                    REGS_index_max_even(i)          <= (others => '0');
                end loop;
            elsif done_MAXS0='1' then
                for i in 0 to 7 loop
                    REGS_val_odd_MAXS(i)            <= out_val_odd_MAXS(i);
                    REGS_val_even_MAXS(i)           <= out_val_even_MAXS(i);
                    REGS_val_odd_index_even_MAXS(i) <= out_val_odd_index_even_MAXS(i);
                    REGS_val_even_index_odd_MAXS(i) <= out_val_even_index_odd_MAXS(i);
                    
                    REGS_index_max_odd(i)           <= out_index_max_odd(i);
                    REGS_index_max_even(i)          <= out_index_max_even(i);
                end loop;
            end if;
        end if;
    end process;
    
    -- ======================================== R ========================================
    R0 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(0),
              max_val_even       => REGS_val_even_MAXS(0),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(0),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(0),
              done               => done_R0,
              result             => result_R0);
              
    R1 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(1),
              max_val_even       => REGS_val_even_MAXS(1),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(1),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(1),
              done               => done_R1,
              result             => result_R1);
              
    R2 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(2),
              max_val_even       => REGS_val_even_MAXS(2),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(2),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(2),
              done               => done_R2,
              result             => result_R2);
              
    R3 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(3),
              max_val_even       => REGS_val_even_MAXS(3),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(3),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(3),
              done               => done_R3,
              result             => result_R3);
              
    R4 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(4),
              max_val_even       => REGS_val_even_MAXS(4),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(4),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(4),
              done               => done_R4,
              result             => result_R4);
              
    R5 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(5),
              max_val_even       => REGS_val_even_MAXS(5),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(5),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(5),
              done               => done_R5,
              result             => result_R5);
              
    R6 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(6),
              max_val_even       => REGS_val_even_MAXS(6),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(6),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(6),
              done               => done_R6,
              result             => result_R6);
              
    R7 : R
    port map (clock              => clock,
              reset              => reset,
              start              => start_R,
              max_val_odd        => REGS_val_odd_MAXS(7),
              max_val_even       => REGS_val_even_MAXS(7),
              val_even_index_odd => REGS_val_even_index_odd_MAXS(7),
              val_odd_index_even => REGS_val_odd_index_even_MAXS(7),
              done               => done_R7,
              result             => result_R7);
              
    process(clock, reset, 
            result_R0, 
            result_R1, 
            result_R2, 
            result_R3, 
            result_R4, 
            result_R5,
            result_R6,
            result_R7, 
            done_R0)
    begin
        if rising_edge(clock) then
            if reset='1' then
                REGS_result_R0 <= (others => '0');
                REGS_result_R1 <= (others => '0');
                REGS_result_R2 <= (others => '0');
                REGS_result_R3 <= (others => '0');
                REGS_result_R4 <= (others => '0');
                REGS_result_R5 <= (others => '0');
                REGS_result_R6 <= (others => '0');
                REGS_result_R7 <= (others => '0');
            elsif done_R0='1' then
                REGS_result_R0 <= result_R0;
                REGS_result_R1 <= result_R1;
                REGS_result_R2 <= result_R2;
                REGS_result_R3 <= result_R3;
                REGS_result_R4 <= result_R4;
                REGS_result_R5 <= result_R5;
                REGS_result_R6 <= result_R6;
                REGS_result_R7 <= result_R7;
            end if;
        end if;
    end process;
    
    -- ===================================== MAX OF RS ======================================
    MAX_OF_RSu : max_of_Rs
    port map (clock  => clock,
              reset  => reset,
              start  => start_MOR,
              R0     => REGS_result_R0,
              R1     => REGS_result_R1,
              R2     => REGS_result_R2,
              R3     => REGS_result_R3,
              R4     => REGS_result_R4,
              R5     => REGS_result_R5,
              R6     => REGS_result_R6,
              R7     => REGS_result_R7,
              done   => done_MOR,
              result => result_MOR);
              
    process(clock, reset, done_MOR, result_MOR, t_binLow, t_binHigh)
    begin
        if rising_edge(clock) then
            if reset='1' then
                REG_delaysel <= (others => '0');
                REG_binLow   <= (others => '0');
                REG_binHigh  <= (others => '0');
            elsif done_MOR='1' then
                REG_delaysel <= result_MOR;
                REG_binLow   <= t_binLow;
                REG_binHigh  <= t_binHigh;
            end if;
        end if;    
    end process;
    
    -- OUTPUT
    delaysel    <= REG_delaysel;
    binLow      <= REG_binLow;
    binHigh     <= REG_binHigh;
    
    process(done_MOR, REG_delaysel, REGS_index_max_even, REGS_index_max_odd, bin1, bin2)
    begin
        if done_MOR='1' then
            bin1 <= REGS_index_max_even(to_integer(unsigned(REG_delaysel)));
            bin2 <= REGS_index_max_odd(to_integer(unsigned(REG_delaysel)));
            
            if bin1 > bin2 then
                t_binHigh <= bin1;
                t_binLow  <= bin2;
            else
                t_binHigh <= bin2;
                t_binLow  <= bin1;
            end if;
        else
            bin1      <= (others => '0');
            bin2      <= (others => '0');
            t_binHigh <= (others => '0');
            t_binLow  <= (others => '0');
        end if;
    end process;
    
    
    
        
    -- ===================================== CONTROLLER =====================================
    counters_update : process(clock, reset, i_counter, j_counter, cs)
    begin
        if rising_edge(clock) then
            if reset = '1' or cs=S_MAXS then
                i_counter <= (others => '0');
                j_counter <= (others => '0');
            else
                if cs=S_INCR_i then
                    i_counter <= std_logic_vector( unsigned(i_counter) +1 );
                end if;
                
                if cs=S_INCR_j then
                    j_counter <= std_logic_vector( unsigned(j_counter) +1 );
                end if;                
            end if;
        end if;
    end process;
    
    
    -- controller output
    start_EOA       <= '1' when (cs=S_EOA and (ps=S_IDLE or ps=S_WAIT_FOR_DATA)) else '0';
    clear_regs_EOA  <= '1' when cs=S_MAXS else '0';
    
    start_MAXS  <= '1' when cs=S_MAXS and ps=S_INCR_j   else '0';
    start_R     <= '1' when cs=S_R and ps=S_MAXS        else '0';
    start_MOR   <= '1' when cs=S_MOR and ps=S_R         else '0';
    
    waiting_for_data <= '1' when cs=S_WAIT_FOR_DATA else '0';
    
    done <= '1' when cs=S_IDLE and ps=S_MOR else '0';
    
    next_state : process(cs, start, done_EOA, i_counter, j_counter, done_MAXS0, done_R0, done_MOR, input_data_ready)
    begin
        ns <= cs;
        case cs is
            when S_IDLE =>
                if start='1' then
                    ns <= S_EOA;
                end if;
            when S_EOA =>
                if done_EOA='1' then
                    ns <= S_INCR_i;
                end if;
            when S_INCR_i =>
                if i_counter="111" then
                    ns <= S_INCR_j;
                else
                    ns <= S_WAIT_FOR_DATA;
                end if;
            when S_INCR_j =>
                if j_counter="1101" and i_counter="000" then
                    ns <= S_MAXS;
                else
                    ns <= S_WAIT_FOR_DATA;
                end if;
            when S_WAIT_FOR_DATA =>
                if input_data_ready='1' then
                    ns <= S_EOA;
                end if;
            when S_MAXS =>
                if done_MAXS0='1' then
                    ns <= S_R;
                end if;
            when S_R =>
                if done_R0='1' then
                    ns <= S_MOR;
                end if;
            when S_MOR =>
                if done_MOR='1' then
                    ns <= S_IDLE;
                end if;
            when others => null;
        end case;
    end process;
    
    update_current_state : process(clock, reset, ns, cs)
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
end PREAMBLE_DETECTOR_arch;
