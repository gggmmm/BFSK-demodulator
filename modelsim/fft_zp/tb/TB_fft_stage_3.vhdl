library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_fft_stage_3 is
end entity TB_fft_stage_3;

architecture TB_fft_stage_3_ARCH of TB_fft_stage_3 is
    signal clock  : std_logic := '0';
    signal reset  : std_logic := '0';
    signal start  : std_logic := '0';
    signal start2 : std_logic := '0';
    signal op0    : complex12;
    signal op1    : complex12;
    signal op2    : complex12;
    signal op3    : complex12;
    signal op4    : complex12;
    signal op5    : complex12;
    signal op6    : complex12;
    signal op7    : complex12;
    signal op8    : complex12;
    signal op9    : complex12;
    signal op10   : complex12;
    signal op11   : complex12;
    signal op12   : complex12;
    signal op13   : complex12;
    signal op14   : complex12;
    signal op15   : complex12;
    signal op16   : complex12;
    signal op17   : complex12;
    signal op18   : complex12;
    signal op19   : complex12;
    signal op20   : complex12;
    signal op21   : complex12;
    signal op22   : complex12;
    signal op23   : complex12;
    signal op24   : complex12;
    signal op25   : complex12;
    signal op26   : complex12;
    signal op27   : complex12;
    signal op28   : complex12;
    signal op29   : complex12;
    signal op30   : complex12;
    signal op31   : complex12;
    signal op32   : complex12;
    signal op33   : complex12;
    signal op34   : complex12;
    signal op35   : complex12;
    signal op36   : complex12;
    signal op37   : complex12;
    signal op38   : complex12;
    signal op39   : complex12;
    signal op40   : complex12;
    signal op41   : complex12;
    signal op42   : complex12;
    signal op43   : complex12;
    signal op44   : complex12;
    signal op45   : complex12;
    signal op46   : complex12;
    signal op47   : complex12;
    signal op48   : complex12;
    signal op49   : complex12;
    signal op50   : complex12;
    signal op51   : complex12;
    signal op52   : complex12;
    signal op53   : complex12;
    signal op54   : complex12;
    signal op55   : complex12;
    signal op56   : complex12;
    signal op57   : complex12;
    signal op58   : complex12;
    signal op59   : complex12;
    signal op60   : complex12;
    signal op61   : complex12;
    signal op62   : complex12;
    signal op63   : complex12;
    signal res0   : complex12;
    signal res1   : complex12;
    signal res2   : complex12;
    signal res3   : complex12;
    signal res4   : complex12;
    signal res5   : complex12;
    signal res6   : complex12;
    signal res7   : complex12;
    signal res8   : complex12;
    signal res9   : complex12;
    signal res10  : complex12;
    signal res11  : complex12;
    signal res12  : complex12;
    signal res13  : complex12;
    signal res14  : complex12;
    signal res15  : complex12;
    signal res16  : complex12;
    signal res17  : complex12;
    signal res18  : complex12;
    signal res19  : complex12;
    signal res20  : complex12;
    signal res21  : complex12;
    signal res22  : complex12;
    signal res23  : complex12;
    signal res24  : complex12;
    signal res25  : complex12;
    signal res26  : complex12;
    signal res27  : complex12;
    signal res28  : complex12;
    signal res29  : complex12;
    signal res30  : complex12;
    signal res31  : complex12;
    signal res32  : complex12;
    signal res33  : complex12;
    signal res34  : complex12;
    signal res35  : complex12;
    signal res36  : complex12;
    signal res37  : complex12;
    signal res38  : complex12;
    signal res39  : complex12;
    signal res40  : complex12;
    signal res41  : complex12;
    signal res42  : complex12;
    signal res43  : complex12;
    signal res44  : complex12;
    signal res45  : complex12;
    signal res46  : complex12;
    signal res47  : complex12;
    signal res48  : complex12;
    signal res49  : complex12;
    signal res50  : complex12;
    signal res51  : complex12;
    signal res52  : complex12;
    signal res53  : complex12;
    signal res54  : complex12;
    signal res55  : complex12;
    signal res56  : complex12;
    signal res57  : complex12;
    signal res58  : complex12;
    signal res59  : complex12;
    signal res60  : complex12;
    signal res61  : complex12;
    signal res62  : complex12;
    signal res63  : complex12;
    
    component fft_stage_3
        port (clock  : in std_logic;
              reset  : in std_logic;
              start  : in std_logic;
              start2 : in std_logic;
              op0    : in complex12;
              op1    : in complex12;
              op2    : in complex12;
              op3    : in complex12;
              op4    : in complex12;
              op5    : in complex12;
              op6    : in complex12;
              op7    : in complex12;
              op8    : in complex12;
              op9    : in complex12;
              op10   : in complex12;
              op11   : in complex12;
              op12   : in complex12;
              op13   : in complex12;
              op14   : in complex12;
              op15   : in complex12;
              op16   : in complex12;
              op17   : in complex12;
              op18   : in complex12;
              op19   : in complex12;
              op20   : in complex12;
              op21   : in complex12;
              op22   : in complex12;
              op23   : in complex12;
              op24   : in complex12;
              op25   : in complex12;
              op26   : in complex12;
              op27   : in complex12;
              op28   : in complex12;
              op29   : in complex12;
              op30   : in complex12;
              op31   : in complex12;
              op32   : in complex12;
              op33   : in complex12;
              op34   : in complex12;
              op35   : in complex12;
              op36   : in complex12;
              op37   : in complex12;
              op38   : in complex12;
              op39   : in complex12;
              op40   : in complex12;
              op41   : in complex12;
              op42   : in complex12;
              op43   : in complex12;
              op44   : in complex12;
              op45   : in complex12;
              op46   : in complex12;
              op47   : in complex12;
              op48   : in complex12;
              op49   : in complex12;
              op50   : in complex12;
              op51   : in complex12;
              op52   : in complex12;
              op53   : in complex12;
              op54   : in complex12;
              op55   : in complex12;
              op56   : in complex12;
              op57   : in complex12;
              op58   : in complex12;
              op59   : in complex12;
              op60   : in complex12;
              op61   : in complex12;
              op62   : in complex12;
              op63   : in complex12;
              res0   : out complex12;
              res1   : out complex12;
              res2   : out complex12;
              res3   : out complex12;
              res4   : out complex12;
              res5   : out complex12;
              res6   : out complex12;
              res7   : out complex12;
              res8   : out complex12;
              res9   : out complex12;
              res10  : out complex12;
              res11  : out complex12;
              res12  : out complex12;
              res13  : out complex12;
              res14  : out complex12;
              res15  : out complex12;
              res16  : out complex12;
              res17  : out complex12;
              res18  : out complex12;
              res19  : out complex12;
              res20  : out complex12;
              res21  : out complex12;
              res22  : out complex12;
              res23  : out complex12;
              res24  : out complex12;
              res25  : out complex12;
              res26  : out complex12;
              res27  : out complex12;
              res28  : out complex12;
              res29  : out complex12;
              res30  : out complex12;
              res31  : out complex12;
              res32  : out complex12;
              res33  : out complex12;
              res34  : out complex12;
              res35  : out complex12;
              res36  : out complex12;
              res37  : out complex12;
              res38  : out complex12;
              res39  : out complex12;
              res40  : out complex12;
              res41  : out complex12;
              res42  : out complex12;
              res43  : out complex12;
              res44  : out complex12;
              res45  : out complex12;
              res46  : out complex12;
              res47  : out complex12;
              res48  : out complex12;
              res49  : out complex12;
              res50  : out complex12;
              res51  : out complex12;
              res52  : out complex12;
              res53  : out complex12;
              res54  : out complex12;
              res55  : out complex12;
              res56  : out complex12;
              res57  : out complex12;
              res58  : out complex12;
              res59  : out complex12;
              res60  : out complex12;
              res61  : out complex12;
              res62  : out complex12;
              res63  : out complex12);
    end component;
begin
    dut : fft_stage_3
    port map (clock  => clock,
              reset  => reset,
              start  => start,
              start2 => start2,
              op0    => op0,
              op1    => op1,
              op2    => op2,
              op3    => op3,
              op4    => op4,
              op5    => op5,
              op6    => op6,
              op7    => op7,
              op8    => op8,
              op9    => op9,
              op10   => op10,
              op11   => op11,
              op12   => op12,
              op13   => op13,
              op14   => op14,
              op15   => op15,
              op16   => op16,
              op17   => op17,
              op18   => op18,
              op19   => op19,
              op20   => op20,
              op21   => op21,
              op22   => op22,
              op23   => op23,
              op24   => op24,
              op25   => op25,
              op26   => op26,
              op27   => op27,
              op28   => op28,
              op29   => op29,
              op30   => op30,
              op31   => op31,
              op32   => op32,
              op33   => op33,
              op34   => op34,
              op35   => op35,
              op36   => op36,
              op37   => op37,
              op38   => op38,
              op39   => op39,
              op40   => op40,
              op41   => op41,
              op42   => op42,
              op43   => op43,
              op44   => op44,
              op45   => op45,
              op46   => op46,
              op47   => op47,
              op48   => op48,
              op49   => op49,
              op50   => op50,
              op51   => op51,
              op52   => op52,
              op53   => op53,
              op54   => op54,
              op55   => op55,
              op56   => op56,
              op57   => op57,
              op58   => op58,
              op59   => op59,
              op60   => op60,
              op61   => op61,
              op62   => op62,
              op63   => op63,
              res0   => res0,
              res1   => res1,
              res2   => res2,
              res3   => res3,
              res4   => res4,
              res5   => res5,
              res6   => res6,
              res7   => res7,
              res8   => res8,
              res9   => res9,
              res10  => res10,
              res11  => res11,
              res12  => res12,
              res13  => res13,
              res14  => res14,
              res15  => res15,
              res16  => res16,
              res17  => res17,
              res18  => res18,
              res19  => res19,
              res20  => res20,
              res21  => res21,
              res22  => res22,
              res23  => res23,
              res24  => res24,
              res25  => res25,
              res26  => res26,
              res27  => res27,
              res28  => res28,
              res29  => res29,
              res30  => res30,
              res31  => res31,
              res32  => res32,
              res33  => res33,
              res34  => res34,
              res35  => res35,
              res36  => res36,
              res37  => res37,
              res38  => res38,
              res39  => res39,
              res40  => res40,
              res41  => res41,
              res42  => res42,
              res43  => res43,
              res44  => res44,
              res45  => res45,
              res46  => res46,
              res47  => res47,
              res48  => res48,
              res49  => res49,
              res50  => res50,
              res51  => res51,
              res52  => res52,
              res53  => res53,
              res54  => res54,
              res55  => res55,
              res56  => res56,
              res57  => res57,
              res58  => res58,
              res59  => res59,
              res60  => res60,
              res61  => res61,
              res62  => res62,
              res63  => res63);
    
    clock <= not clock after 10 ns;

    process
    	variable test : integer := 0;
    	variable total : integer := 0;
    begin
    
    reset <= '1';
    wait for 50 ns;
    reset <= '0';
	
	-- ===== TEST 1 =====
	start <= '1';
	start2 <= '0';
	
	op0.c <= '0'; op0.l.s <= '0'; op0.l.m <= std_logic_vector(to_unsigned(0*128,op0.l.m'length)); op0.r.s <= '0'; op0.r.m <= std_logic_vector(to_unsigned(0,op0.r.m'length));	
	op1.c <= '0'; op1.l.s <= '0'; op1.l.m <= std_logic_vector(to_unsigned(1*128,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(2*128,op2.l.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '0'; op3.l.m <= std_logic_vector(to_unsigned(3*128,op3.l.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '1'; op4.l.m <= std_logic_vector(to_unsigned(4*128,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(0,op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '1'; op5.l.m <= std_logic_vector(to_unsigned(5*128,op5.l.m'length)); op5.r.s <= '0'; op5.r.m <= std_logic_vector(to_unsigned(0,op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '1'; op6.l.m <= std_logic_vector(to_unsigned(6*128,op6.l.m'length)); op6.r.s <= '0'; op6.r.m <= std_logic_vector(to_unsigned(0,op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '1'; op7.l.m <= std_logic_vector(to_unsigned(7*128,op7.l.m'length)); op7.r.s <= '0'; op7.r.m <= std_logic_vector(to_unsigned(0,op7.r.m'length));
	
	op8.c <= '0'; op8.l.s <= '0'; op8.l.m <= std_logic_vector(to_unsigned(0*128,op8.l.m'length)); op8.r.s <= '0'; op8.r.m <= std_logic_vector(to_unsigned(0,op8.r.m'length));
	op9.c <= '0'; op9.l.s <= '1'; op9.l.m <= std_logic_vector(to_unsigned(1*128,op9.l.m'length)); op9.r.s <= '0'; op9.r.m <= std_logic_vector(to_unsigned(0,op9.r.m'length));
	op10.c <= '0'; op10.l.s <= '1'; op10.l.m <= std_logic_vector(to_unsigned(2*128,op10.l.m'length)); op10.r.s <= '0'; op10.r.m <= std_logic_vector(to_unsigned(0,op10.r.m'length));
	op11.c <= '0'; op11.l.s <= '0'; op11.l.m <= std_logic_vector(to_unsigned(3*128,op11.l.m'length)); op11.r.s <= '0'; op11.r.m <= std_logic_vector(to_unsigned(0,op11.r.m'length));
	op12.c <= '0'; op12.l.s <= '0'; op12.l.m <= std_logic_vector(to_unsigned(4*128,op12.l.m'length)); op12.r.s <= '0'; op12.r.m <= std_logic_vector(to_unsigned(0,op12.r.m'length));
	op13.c <= '0'; op13.l.s <= '0'; op13.l.m <= std_logic_vector(to_unsigned(5*128,op13.l.m'length)); op13.r.s <= '0'; op13.r.m <= std_logic_vector(to_unsigned(0,op13.r.m'length));
	op14.c <= '0'; op14.l.s <= '0'; op14.l.m <= std_logic_vector(to_unsigned(6*128,op14.l.m'length)); op14.r.s <= '0'; op14.r.m <= std_logic_vector(to_unsigned(0,op14.r.m'length));
	op15.c <= '0'; op15.l.s <= '0'; op15.l.m <= std_logic_vector(to_unsigned(7*128,op15.l.m'length)); op15.r.s <= '0'; op15.r.m <= std_logic_vector(to_unsigned(0,op15.r.m'length));
	
	op16.c <= '0'; op16.l.s <= '0'; op16.l.m <= std_logic_vector(to_unsigned(7*128,op16.l.m'length)); op16.r.s <= '0'; op16.r.m <= std_logic_vector(to_unsigned(0,op16.r.m'length));
	op17.c <= '0'; op17.l.s <= '0'; op17.l.m <= std_logic_vector(to_unsigned(6*128,op17.l.m'length)); op17.r.s <= '0'; op17.r.m <= std_logic_vector(to_unsigned(0,op17.r.m'length));
	op18.c <= '0'; op18.l.s <= '0'; op18.l.m <= std_logic_vector(to_unsigned(5*128,op18.l.m'length)); op18.r.s <= '0'; op18.r.m <= std_logic_vector(to_unsigned(0,op18.r.m'length));
	op19.c <= '0'; op19.l.s <= '0'; op19.l.m <= std_logic_vector(to_unsigned(4*128,op19.l.m'length)); op19.r.s <= '0'; op19.r.m <= std_logic_vector(to_unsigned(0,op19.r.m'length));
	op20.c <= '0'; op20.l.s <= '0'; op20.l.m <= std_logic_vector(to_unsigned(3*128,op20.l.m'length)); op20.r.s <= '0'; op20.r.m <= std_logic_vector(to_unsigned(0,op20.r.m'length));
	op21.c <= '0'; op21.l.s <= '1'; op21.l.m <= std_logic_vector(to_unsigned(2*128,op21.l.m'length)); op21.r.s <= '0'; op21.r.m <= std_logic_vector(to_unsigned(0,op21.r.m'length));
	op22.c <= '0'; op22.l.s <= '1'; op22.l.m <= std_logic_vector(to_unsigned(1*128,op22.l.m'length)); op22.r.s <= '0'; op22.r.m <= std_logic_vector(to_unsigned(0,op22.r.m'length));
	op23.c <= '0'; op23.l.s <= '0'; op23.l.m <= std_logic_vector(to_unsigned(0*128,op23.l.m'length)); op23.r.s <= '0'; op23.r.m <= std_logic_vector(to_unsigned(0,op23.r.m'length));
	
	op24.c <= '0'; op24.l.s <= '1'; op24.l.m <= std_logic_vector(to_unsigned(5*128,op24.l.m'length)); op24.r.s <= '0'; op24.r.m <= std_logic_vector(to_unsigned(0,op24.r.m'length));
	op25.c <= '0'; op25.l.s <= '1'; op25.l.m <= std_logic_vector(to_unsigned(5*128,op25.l.m'length)); op25.r.s <= '0'; op25.r.m <= std_logic_vector(to_unsigned(0,op25.r.m'length));
	op26.c <= '0'; op26.l.s <= '1'; op26.l.m <= std_logic_vector(to_unsigned(5*128,op26.l.m'length)); op26.r.s <= '0'; op26.r.m <= std_logic_vector(to_unsigned(0,op26.r.m'length));
	op27.c <= '0'; op27.l.s <= '1'; op27.l.m <= std_logic_vector(to_unsigned(5*128,op27.l.m'length)); op27.r.s <= '0'; op27.r.m <= std_logic_vector(to_unsigned(0,op27.r.m'length));
	op28.c <= '0'; op28.l.s <= '1'; op28.l.m <= std_logic_vector(to_unsigned(5*128,op28.l.m'length)); op28.r.s <= '0'; op28.r.m <= std_logic_vector(to_unsigned(0,op28.r.m'length));
	op29.c <= '0'; op29.l.s <= '1'; op29.l.m <= std_logic_vector(to_unsigned(5*128,op29.l.m'length)); op29.r.s <= '0'; op29.r.m <= std_logic_vector(to_unsigned(0,op29.r.m'length));
	op30.c <= '0'; op30.l.s <= '1'; op30.l.m <= std_logic_vector(to_unsigned(5*128,op30.l.m'length)); op30.r.s <= '0'; op30.r.m <= std_logic_vector(to_unsigned(0,op30.r.m'length));
	op31.c <= '0'; op31.l.s <= '1'; op31.l.m <= std_logic_vector(to_unsigned(5*128,op31.l.m'length)); op31.r.s <= '0'; op31.r.m <= std_logic_vector(to_unsigned(0,op31.r.m'length));
	
	op32.c <= '0'; op32.l.s <= '0'; op32.l.m <= std_logic_vector(to_unsigned(1*128,op32.l.m'length)); op32.r.s <= '0'; op32.r.m <= std_logic_vector(to_unsigned(0,op32.r.m'length));
	op33.c <= '0'; op33.l.s <= '0'; op33.l.m <= std_logic_vector(to_unsigned(2*128,op33.l.m'length)); op33.r.s <= '0'; op33.r.m <= std_logic_vector(to_unsigned(0,op33.r.m'length));
	op34.c <= '0'; op34.l.s <= '0'; op34.l.m <= std_logic_vector(to_unsigned(3*128,op34.l.m'length)); op34.r.s <= '0'; op34.r.m <= std_logic_vector(to_unsigned(0,op34.r.m'length));
	op35.c <= '0'; op35.l.s <= '0'; op35.l.m <= std_logic_vector(to_unsigned(4*128,op35.l.m'length)); op35.r.s <= '0'; op35.r.m <= std_logic_vector(to_unsigned(0,op35.r.m'length));
	op36.c <= '0'; op36.l.s <= '0'; op36.l.m <= std_logic_vector(to_unsigned(5*128,op36.l.m'length)); op36.r.s <= '0'; op36.r.m <= std_logic_vector(to_unsigned(0,op36.r.m'length));
	op37.c <= '0'; op37.l.s <= '0'; op37.l.m <= std_logic_vector(to_unsigned(6*128,op37.l.m'length)); op37.r.s <= '0'; op37.r.m <= std_logic_vector(to_unsigned(0,op37.r.m'length));
	op38.c <= '0'; op38.l.s <= '0'; op38.l.m <= std_logic_vector(to_unsigned(7*128,op38.l.m'length)); op38.r.s <= '0'; op38.r.m <= std_logic_vector(to_unsigned(0,op38.r.m'length));
	op39.c <= '0'; op39.l.s <= '0'; op39.l.m <= std_logic_vector(to_unsigned(8*128,op39.l.m'length)); op39.r.s <= '0'; op39.r.m <= std_logic_vector(to_unsigned(0,op39.r.m'length));
	
	op40.c <= '0'; op40.l.s <= '1'; op40.l.m <= std_logic_vector(to_unsigned(1*128,op40.l.m'length)); op40.r.s <= '0'; op40.r.m <= std_logic_vector(to_unsigned(0,op40.r.m'length));
	op41.c <= '0'; op41.l.s <= '1'; op41.l.m <= std_logic_vector(to_unsigned(1*128,op41.l.m'length)); op41.r.s <= '0'; op41.r.m <= std_logic_vector(to_unsigned(0,op41.r.m'length));
	op42.c <= '0'; op42.l.s <= '1'; op42.l.m <= std_logic_vector(to_unsigned(1*128,op42.l.m'length)); op42.r.s <= '0'; op42.r.m <= std_logic_vector(to_unsigned(0,op42.r.m'length));
	op43.c <= '0'; op43.l.s <= '0'; op43.l.m <= std_logic_vector(to_unsigned(1*128,op43.l.m'length)); op43.r.s <= '0'; op43.r.m <= std_logic_vector(to_unsigned(0,op43.r.m'length));
	op44.c <= '0'; op44.l.s <= '0'; op44.l.m <= std_logic_vector(to_unsigned(2*128,op44.l.m'length)); op44.r.s <= '0'; op44.r.m <= std_logic_vector(to_unsigned(0,op44.r.m'length));
	op45.c <= '0'; op45.l.s <= '0'; op45.l.m <= std_logic_vector(to_unsigned(2*128,op45.l.m'length)); op45.r.s <= '0'; op45.r.m <= std_logic_vector(to_unsigned(0,op45.r.m'length));
	op46.c <= '0'; op46.l.s <= '0'; op46.l.m <= std_logic_vector(to_unsigned(2*128,op46.l.m'length)); op46.r.s <= '0'; op46.r.m <= std_logic_vector(to_unsigned(0,op46.r.m'length));
	op47.c <= '0'; op47.l.s <= '0'; op47.l.m <= std_logic_vector(to_unsigned(2*128,op47.l.m'length)); op47.r.s <= '0'; op47.r.m <= std_logic_vector(to_unsigned(0,op47.r.m'length));
		
	op48.c <= '0'; op48.l.s <= '1'; op48.l.m <= std_logic_vector(to_unsigned(1*128,op48.l.m'length)); op48.r.s <= '0'; op48.r.m <= std_logic_vector(to_unsigned(0,op48.r.m'length));
	op49.c <= '0'; op49.l.s <= '0'; op49.l.m <= std_logic_vector(to_unsigned(2*128,op49.l.m'length)); op49.r.s <= '0'; op49.r.m <= std_logic_vector(to_unsigned(0,op49.r.m'length));
	op50.c <= '0'; op50.l.s <= '0'; op50.l.m <= std_logic_vector(to_unsigned(3*128,op50.l.m'length)); op50.r.s <= '0'; op50.r.m <= std_logic_vector(to_unsigned(0,op50.r.m'length));
	op51.c <= '0'; op51.l.s <= '0'; op51.l.m <= std_logic_vector(to_unsigned(6*128,op51.l.m'length)); op51.r.s <= '0'; op51.r.m <= std_logic_vector(to_unsigned(0,op51.r.m'length));
	op52.c <= '0'; op52.l.s <= '0'; op52.l.m <= std_logic_vector(to_unsigned(6*128,op52.l.m'length)); op52.r.s <= '0'; op52.r.m <= std_logic_vector(to_unsigned(0,op52.r.m'length));
	op53.c <= '0'; op53.l.s <= '0'; op53.l.m <= std_logic_vector(to_unsigned(6*128,op53.l.m'length)); op53.r.s <= '0'; op53.r.m <= std_logic_vector(to_unsigned(0,op53.r.m'length));
	op54.c <= '0'; op54.l.s <= '0'; op54.l.m <= std_logic_vector(to_unsigned(3*128,op54.l.m'length)); op54.r.s <= '0'; op54.r.m <= std_logic_vector(to_unsigned(0,op54.r.m'length));
	op55.c <= '0'; op55.l.s <= '1'; op55.l.m <= std_logic_vector(to_unsigned(1*128,op55.l.m'length)); op55.r.s <= '0'; op55.r.m <= std_logic_vector(to_unsigned(0,op55.r.m'length));
	
	op56.c <= '0'; op56.l.s <= '1'; op56.l.m <= std_logic_vector(to_unsigned(1*128,op56.l.m'length)); op56.r.s <= '0'; op56.r.m <= std_logic_vector(to_unsigned(0,op56.r.m'length));
	op57.c <= '0'; op57.l.s <= '0'; op57.l.m <= std_logic_vector(to_unsigned(2*128,op57.l.m'length)); op57.r.s <= '0'; op57.r.m <= std_logic_vector(to_unsigned(0,op57.r.m'length));
	op58.c <= '0'; op58.l.s <= '0'; op58.l.m <= std_logic_vector(to_unsigned(3*128,op58.l.m'length)); op58.r.s <= '0'; op58.r.m <= std_logic_vector(to_unsigned(0,op58.r.m'length));
	op59.c <= '0'; op59.l.s <= '0'; op59.l.m <= std_logic_vector(to_unsigned(4*128,op59.l.m'length)); op59.r.s <= '0'; op59.r.m <= std_logic_vector(to_unsigned(0,op59.r.m'length));
	op60.c <= '0'; op60.l.s <= '0'; op60.l.m <= std_logic_vector(to_unsigned(4*128,op60.l.m'length)); op60.r.s <= '0'; op60.r.m <= std_logic_vector(to_unsigned(0,op60.r.m'length));
	op61.c <= '0'; op61.l.s <= '1'; op61.l.m <= std_logic_vector(to_unsigned(5*128,op61.l.m'length)); op61.r.s <= '0'; op61.r.m <= std_logic_vector(to_unsigned(0,op61.r.m'length));
	op62.c <= '0'; op62.l.s <= '1'; op62.l.m <= std_logic_vector(to_unsigned(6*128,op62.l.m'length)); op62.r.s <= '0'; op62.r.m <= std_logic_vector(to_unsigned(0,op62.r.m'length));
	op63.c <= '0'; op63.l.s <= '1'; op63.l.m <= std_logic_vector(to_unsigned(1*128,op63.l.m'length)); op63.r.s <= '0'; op63.r.m <= std_logic_vector(to_unsigned(0,op63.r.m'length));
	
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	wait for 20 ns;
	
--	          256 +          0i
--	          512 +          0i
--	         -256 +          0i
--	         -256 +          0i
--	          512 +        768i
--	       181.02 +     1086.1i
--	          512 -        768i
--	      -1086.1 -     181.02i
--	         -256 +          0i
--	          256 +          0i
--	          256 +          0i
--	         -512 +          0i
--	          512 -        768i
--	      -181.02 -     1086.1i
--	          512 +        768i
--	       1086.1 +     181.02i
--	         1536 +          0i
--	         1280 +          0i
--	          256 +          0i
--	          256 +          0i
--	          384 +        128i
--	      -181.02 +     181.02i
--	          384 -        128i
--	      -181.02 +     181.02i
--	        -1280 +          0i
--	        -1280 +          0i
--	            0 +          0i
--	            0 +          0i
--	         -640 +        640i
--	  -1.1369e-13 +      905.1i
--	         -640 -        640i
--	       -905.1 - 1.7053e-13i
--	          512 +          0i
--	          768 +          0i
--	         -256 +          0i
--	         -256 +          0i
--	          640 -        896i
--	      -181.02 -     1267.1i
--	          640 +        896i
--	       1267.1 +     181.02i
--	         -256 +          0i
--	            0 +          0i
--	            0 +          0i
--	         -256 +          0i
--	          256 -        256i
--	   5.6844e-14 -     362.04i
--	          256 +        256i
--	       362.04 + 5.6844e-14i
--	          256 +          0i
--	         1024 +          0i
--	         -512 +          0i
--	         -512 +          0i
--	          768 -        384i
--	       633.56 -     452.54i
--	          768 +        384i
--	       452.54 -     633.56i
--	          256 +          0i
--	          768 +          0i
--	         -512 +          0i
--	         -256 +          0i
--	          512 +        768i
--	      -362.04 +     543.05i
--	          512 -        768i
--	      -543.05 +     362.04i
	
	if      res0.l.s='0' and res0.l.m=std_logic_vector(to_unsigned(1024, res0.l.m'length)) and res0.r.s='0' and res0.r.m=std_logic_vector(to_unsigned(0, res0.r.m'length)) and
	        res1.l.s='0' and res1.l.m=std_logic_vector(to_unsigned(128, res1.l.m'length)) and res1.r.s='0' and res1.r.m=std_logic_vector(to_unsigned(0, res1.r.m'length)) and
	        res2.l.s='0' and res2.l.m=std_logic_vector(to_unsigned(256, res2.l.m'length)) and res2.r.s='0' and res2.r.m=std_logic_vector(to_unsigned(0, res2.r.m'length)) and
	        res3.l.s='0' and res3.l.m=std_logic_vector(to_unsigned(384, res3.l.m'length)) and res3.r.s='0' and res3.r.m=std_logic_vector(to_unsigned(0, res3.r.m'length)) and
	        res4.l.s='0' and res4.l.m=std_logic_vector(to_unsigned(512, res4.l.m'length)) and res4.r.s='0' and res4.r.m=std_logic_vector(to_unsigned(0, res4.r.m'length)) and
	        res5.l.s='0' and res5.l.m=std_logic_vector(to_unsigned(640, res5.l.m'length)) and res5.r.s='0' and res5.r.m=std_logic_vector(to_unsigned(0, res5.r.m'length)) and
	        res6.l.s='0' and res6.l.m=std_logic_vector(to_unsigned(768, res6.l.m'length)) and res6.r.s='0' and res6.r.m=std_logic_vector(to_unsigned(0, res6.r.m'length)) and
	        res7.l.s='0' and res7.l.m=std_logic_vector(to_unsigned(896, res7.l.m'length)) and res7.r.s='0' and res7.r.m=std_logic_vector(to_unsigned(0, res7.r.m'length)) and
	        res8.l.s='0' and res8.l.m=std_logic_vector(to_unsigned(896, res8.l.m'length)) and res8.r.s='0' and res8.r.m=std_logic_vector(to_unsigned(0, res8.r.m'length)) and
	        res9.l.s='0' and res9.l.m=std_logic_vector(to_unsigned(896, res9.l.m'length)) and res9.r.s='0' and res9.r.m=std_logic_vector(to_unsigned(0, res9.r.m'length)) and
	        res10.l.s='0' and res10.l.m=std_logic_vector(to_unsigned(896, res10.l.m'length)) and res10.r.s='0' and res10.r.m=std_logic_vector(to_unsigned(0, res10.r.m'length)) and
	        res11.l.s='0' and res11.l.m=std_logic_vector(to_unsigned(896, res11.l.m'length)) and res11.r.s='0' and res11.r.m=std_logic_vector(to_unsigned(0, res11.r.m'length)) and
	        res12.l.s='0' and res12.l.m=std_logic_vector(to_unsigned(896, res12.l.m'length)) and res12.r.s='0' and res12.r.m=std_logic_vector(to_unsigned(0, res12.r.m'length)) and
	        res13.l.s='0' and res13.l.m=std_logic_vector(to_unsigned(896, res13.l.m'length)) and res13.r.s='0' and res13.r.m=std_logic_vector(to_unsigned(0, res13.r.m'length)) and
	        res14.l.s='0' and res14.l.m=std_logic_vector(to_unsigned(896, res14.l.m'length)) and res14.r.s='0' and res14.r.m=std_logic_vector(to_unsigned(0, res14.r.m'length)) and
	        res15.l.s='0' and res15.l.m=std_logic_vector(to_unsigned(896, res15.l.m'length)) and res15.r.s='0' and res15.r.m=std_logic_vector(to_unsigned(0, res15.r.m'length)) and
	        res16.l.s='0' and res16.l.m=std_logic_vector(to_unsigned(896, res16.l.m'length)) and res16.r.s='0' and res16.r.m=std_logic_vector(to_unsigned(0, res16.r.m'length)) and
	        res17.l.s='0' and res17.l.m=std_logic_vector(to_unsigned(896, res17.l.m'length)) and res17.r.s='0' and res17.r.m=std_logic_vector(to_unsigned(0, res17.r.m'length)) and
	        res18.l.s='0' and res18.l.m=std_logic_vector(to_unsigned(896, res18.l.m'length)) and res18.r.s='0' and res18.r.m=std_logic_vector(to_unsigned(0, res18.r.m'length)) and
	        res19.l.s='0' and res19.l.m=std_logic_vector(to_unsigned(896, res19.l.m'length)) and res19.r.s='0' and res19.r.m=std_logic_vector(to_unsigned(0, res19.r.m'length)) and
	        res20.l.s='0' and res20.l.m=std_logic_vector(to_unsigned(896, res20.l.m'length)) and res20.r.s='0' and res20.r.m=std_logic_vector(to_unsigned(0, res20.r.m'length)) and
	        res21.l.s='0' and res21.l.m=std_logic_vector(to_unsigned(896, res21.l.m'length)) and res21.r.s='0' and res21.r.m=std_logic_vector(to_unsigned(0, res21.r.m'length)) and
	        res22.l.s='0' and res22.l.m=std_logic_vector(to_unsigned(896, res22.l.m'length)) and res22.r.s='0' and res22.r.m=std_logic_vector(to_unsigned(0, res22.r.m'length)) and
	        res23.l.s='0' and res23.l.m=std_logic_vector(to_unsigned(896, res23.l.m'length)) and res23.r.s='0' and res23.r.m=std_logic_vector(to_unsigned(0, res23.r.m'length)) and
	        res24.l.s='0' and res24.l.m=std_logic_vector(to_unsigned(896, res24.l.m'length)) and res24.r.s='0' and res24.r.m=std_logic_vector(to_unsigned(0, res24.r.m'length)) and
	        res25.l.s='0' and res25.l.m=std_logic_vector(to_unsigned(896, res25.l.m'length)) and res25.r.s='0' and res25.r.m=std_logic_vector(to_unsigned(0, res25.r.m'length)) and
	        res26.l.s='0' and res26.l.m=std_logic_vector(to_unsigned(896, res26.l.m'length)) and res26.r.s='0' and res26.r.m=std_logic_vector(to_unsigned(0, res26.r.m'length)) and
	        res27.l.s='0' and res27.l.m=std_logic_vector(to_unsigned(896, res27.l.m'length)) and res27.r.s='0' and res27.r.m=std_logic_vector(to_unsigned(0, res27.r.m'length)) and
	        res28.l.s='0' and res28.l.m=std_logic_vector(to_unsigned(896, res28.l.m'length)) and res28.r.s='0' and res28.r.m=std_logic_vector(to_unsigned(0, res28.r.m'length)) and
	        res29.l.s='0' and res29.l.m=std_logic_vector(to_unsigned(896, res29.l.m'length)) and res29.r.s='0' and res29.r.m=std_logic_vector(to_unsigned(0, res29.r.m'length)) and
	        res30.l.s='0' and res30.l.m=std_logic_vector(to_unsigned(896, res30.l.m'length)) and res30.r.s='0' and res30.r.m=std_logic_vector(to_unsigned(0, res30.r.m'length)) and
	        res31.l.s='0' and res31.l.m=std_logic_vector(to_unsigned(896, res31.l.m'length)) and res31.r.s='0' and res31.r.m=std_logic_vector(to_unsigned(0, res31.r.m'length)) and
	        res32.l.s='0' and res32.l.m=std_logic_vector(to_unsigned(896, res32.l.m'length)) and res32.r.s='0' and res32.r.m=std_logic_vector(to_unsigned(0, res32.r.m'length)) and
	        res33.l.s='0' and res33.l.m=std_logic_vector(to_unsigned(896, res33.l.m'length)) and res33.r.s='0' and res33.r.m=std_logic_vector(to_unsigned(0, res33.r.m'length)) and
	        res34.l.s='0' and res34.l.m=std_logic_vector(to_unsigned(896, res34.l.m'length)) and res34.r.s='0' and res34.r.m=std_logic_vector(to_unsigned(0, res34.r.m'length)) and
	        res35.l.s='0' and res35.l.m=std_logic_vector(to_unsigned(896, res35.l.m'length)) and res35.r.s='0' and res35.r.m=std_logic_vector(to_unsigned(0, res35.r.m'length)) and
	        res36.l.s='0' and res36.l.m=std_logic_vector(to_unsigned(896, res36.l.m'length)) and res36.r.s='0' and res36.r.m=std_logic_vector(to_unsigned(0, res36.r.m'length)) and
	        res37.l.s='0' and res37.l.m=std_logic_vector(to_unsigned(896, res37.l.m'length)) and res37.r.s='0' and res37.r.m=std_logic_vector(to_unsigned(0, res37.r.m'length)) and
	        res38.l.s='0' and res38.l.m=std_logic_vector(to_unsigned(896, res38.l.m'length)) and res38.r.s='0' and res38.r.m=std_logic_vector(to_unsigned(0, res38.r.m'length)) and
	        res39.l.s='0' and res39.l.m=std_logic_vector(to_unsigned(896, res39.l.m'length)) and res39.r.s='0' and res39.r.m=std_logic_vector(to_unsigned(0, res39.r.m'length)) and
	        res40.l.s='0' and res40.l.m=std_logic_vector(to_unsigned(896, res40.l.m'length)) and res40.r.s='0' and res40.r.m=std_logic_vector(to_unsigned(0, res40.r.m'length)) and
	        res41.l.s='0' and res41.l.m=std_logic_vector(to_unsigned(896, res41.l.m'length)) and res41.r.s='0' and res41.r.m=std_logic_vector(to_unsigned(0, res41.r.m'length)) and
	        res42.l.s='0' and res42.l.m=std_logic_vector(to_unsigned(896, res42.l.m'length)) and res42.r.s='0' and res42.r.m=std_logic_vector(to_unsigned(0, res42.r.m'length)) and
	        res43.l.s='0' and res43.l.m=std_logic_vector(to_unsigned(896, res43.l.m'length)) and res43.r.s='0' and res43.r.m=std_logic_vector(to_unsigned(0, res43.r.m'length)) and
	        res44.l.s='0' and res44.l.m=std_logic_vector(to_unsigned(896, res44.l.m'length)) and res44.r.s='0' and res44.r.m=std_logic_vector(to_unsigned(0, res44.r.m'length)) and
	        res45.l.s='0' and res45.l.m=std_logic_vector(to_unsigned(896, res45.l.m'length)) and res45.r.s='0' and res45.r.m=std_logic_vector(to_unsigned(0, res45.r.m'length)) and
	        res46.l.s='0' and res46.l.m=std_logic_vector(to_unsigned(896, res46.l.m'length)) and res46.r.s='0' and res46.r.m=std_logic_vector(to_unsigned(0, res46.r.m'length)) and
	        res47.l.s='0' and res47.l.m=std_logic_vector(to_unsigned(896, res47.l.m'length)) and res47.r.s='0' and res47.r.m=std_logic_vector(to_unsigned(0, res47.r.m'length)) and
	        res48.l.s='0' and res48.l.m=std_logic_vector(to_unsigned(896, res48.l.m'length)) and res48.r.s='0' and res48.r.m=std_logic_vector(to_unsigned(0, res48.r.m'length)) and
	        res49.l.s='0' and res49.l.m=std_logic_vector(to_unsigned(896, res49.l.m'length)) and res49.r.s='0' and res49.r.m=std_logic_vector(to_unsigned(0, res49.r.m'length)) and
	        res50.l.s='0' and res50.l.m=std_logic_vector(to_unsigned(896, res50.l.m'length)) and res50.r.s='0' and res50.r.m=std_logic_vector(to_unsigned(0, res50.r.m'length)) and
	        res51.l.s='0' and res51.l.m=std_logic_vector(to_unsigned(896, res51.l.m'length)) and res51.r.s='0' and res51.r.m=std_logic_vector(to_unsigned(0, res51.r.m'length)) and
	        res52.l.s='0' and res52.l.m=std_logic_vector(to_unsigned(896, res52.l.m'length)) and res52.r.s='0' and res52.r.m=std_logic_vector(to_unsigned(0, res52.r.m'length)) and
	        res53.l.s='0' and res53.l.m=std_logic_vector(to_unsigned(896, res53.l.m'length)) and res53.r.s='0' and res53.r.m=std_logic_vector(to_unsigned(0, res53.r.m'length)) and
	        res54.l.s='0' and res54.l.m=std_logic_vector(to_unsigned(896, res54.l.m'length)) and res54.r.s='0' and res54.r.m=std_logic_vector(to_unsigned(0, res54.r.m'length)) and
	        res55.l.s='0' and res55.l.m=std_logic_vector(to_unsigned(896, res55.l.m'length)) and res55.r.s='0' and res55.r.m=std_logic_vector(to_unsigned(0, res55.r.m'length)) and
	        res56.l.s='0' and res56.l.m=std_logic_vector(to_unsigned(896, res56.l.m'length)) and res56.r.s='0' and res56.r.m=std_logic_vector(to_unsigned(0, res56.r.m'length)) and
	        res57.l.s='0' and res57.l.m=std_logic_vector(to_unsigned(896, res57.l.m'length)) and res57.r.s='0' and res57.r.m=std_logic_vector(to_unsigned(0, res57.r.m'length)) and
	        res58.l.s='0' and res58.l.m=std_logic_vector(to_unsigned(896, res58.l.m'length)) and res58.r.s='0' and res58.r.m=std_logic_vector(to_unsigned(0, res58.r.m'length)) and
	        res59.l.s='0' and res59.l.m=std_logic_vector(to_unsigned(896, res59.l.m'length)) and res59.r.s='0' and res59.r.m=std_logic_vector(to_unsigned(0, res59.r.m'length)) and
	        res60.l.s='0' and res60.l.m=std_logic_vector(to_unsigned(896, res60.l.m'length)) and res60.r.s='0' and res60.r.m=std_logic_vector(to_unsigned(0, res60.r.m'length)) and
	        res61.l.s='0' and res61.l.m=std_logic_vector(to_unsigned(896, res61.l.m'length)) and res61.r.s='0' and res61.r.m=std_logic_vector(to_unsigned(0, res61.r.m'length)) and
	        res62.l.s='0' and res62.l.m=std_logic_vector(to_unsigned(896, res62.l.m'length)) and res62.r.s='0' and res62.r.m=std_logic_vector(to_unsigned(0, res62.r.m'length)) and
	        res63.l.s='0' and res63.l.m=std_logic_vector(to_unsigned(896, res63.l.m'length)) and res63.r.s='0' and res63.r.m=std_logic_vector(to_unsigned(0, res63.r.m'length)) then
	        
		test := test +1;
	else
		report "FAILED 1";
	end if;
	total := total +1;
    wait for 50 ns;
    
	-- ========== PRINT RESULTS ==========
	report integer'image(test) & "/" & integer'image(total);
        
        wait;
    end process;

end TB_fft_stage_3_ARCH;
