library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity TB_fft_stage_2 is
end entity TB_fft_stage_2;

architecture TB_fft_stage_2_ARCH of TB_fft_stage_2 is
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
    signal opA    : complex12;
    signal opB    : complex12;
    signal opC    : complex12;
    signal opD    : complex12;
    signal opE    : complex12;
    signal opF    : complex12;
    signal opG    : complex12;
    signal opH    : complex12;
    signal opI    : complex12;
    signal opJ    : complex12;
    signal opK    : complex12;
    signal opL    : complex12;
    signal opM    : complex12;
    signal opN    : complex12;
    signal opO    : complex12;
    signal opP    : complex12;
    signal opQ    : complex12;
    signal opR    : complex12;
    signal opS    : complex12;
    signal opT    : complex12;
    signal opU    : complex12;
    signal opV    : complex12;
    signal opW    : complex12;
    signal opX    : complex12;
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
    
    component fft_stage_2
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
              opA    : in complex12;
              opB    : in complex12;
              opC    : in complex12;
              opD    : in complex12;
              opE    : in complex12;
              opF    : in complex12;
              opG    : in complex12;
              opH    : in complex12;
              opI    : in complex12;
              opJ    : in complex12;
              opK    : in complex12;
              opL    : in complex12;
              opM    : in complex12;
              opN    : in complex12;
              opO    : in complex12;
              opP    : in complex12;
              opQ    : in complex12;
              opR    : in complex12;
              opS    : in complex12;
              opT    : in complex12;
              opU    : in complex12;
              opV    : in complex12;
              opW    : in complex12;
              opX    : in complex12;
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
    dut : fft_stage_2
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
              opA    => opA,
              opB    => opB,
              opC    => opC,
              opD    => opD,
              opE    => opE,
              opF    => opF,
              opG    => opG,
              opH    => opH,
              opI    => opI,
              opJ    => opJ,
              opK    => opK,
              opL    => opL,
              opM    => opM,
              opN    => opN,
              opO    => opO,
              opP    => opP,
              opQ    => opQ,
              opR    => opR,
              opS    => opS,
              opT    => opT,
              opU    => opU,
              opV    => opV,
              opW    => opW,
              opX    => opX,
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
	op1.c <= '0'; op1.l.s <= '1'; op1.l.m <= std_logic_vector(to_unsigned(1*128,op1.l.m'length)); op1.r.s <= '0'; op1.r.m <= std_logic_vector(to_unsigned(0,op1.r.m'length));
	op2.c <= '0'; op2.l.s <= '0'; op2.l.m <= std_logic_vector(to_unsigned(2*128,op2.l.m'length)); op2.r.s <= '0'; op2.r.m <= std_logic_vector(to_unsigned(0,op2.r.m'length));
	op3.c <= '0'; op3.l.s <= '1'; op3.l.m <= std_logic_vector(to_unsigned(3*128,op3.l.m'length)); op3.r.s <= '0'; op3.r.m <= std_logic_vector(to_unsigned(0,op3.r.m'length));
	op4.c <= '0'; op4.l.s <= '0'; op4.l.m <= std_logic_vector(to_unsigned(4*128,op4.l.m'length)); op4.r.s <= '0'; op4.r.m <= std_logic_vector(to_unsigned(0,op4.r.m'length));
	op5.c <= '0'; op5.l.s <= '1'; op5.l.m <= std_logic_vector(to_unsigned(5*128,op5.l.m'length)); op5.r.s <= '0'; op5.r.m <= std_logic_vector(to_unsigned(0,op5.r.m'length));
	op6.c <= '0'; op6.l.s <= '0'; op6.l.m <= std_logic_vector(to_unsigned(6*128,op6.l.m'length)); op6.r.s <= '0'; op6.r.m <= std_logic_vector(to_unsigned(0,op6.r.m'length));
	op7.c <= '0'; op7.l.s <= '1'; op7.l.m <= std_logic_vector(to_unsigned(7*128,op7.l.m'length)); op7.r.s <= '0'; op7.r.m <= std_logic_vector(to_unsigned(0,op7.r.m'length));
	
	opA.c <= '0'; opA.l.s <= '0'; opA.l.m <= std_logic_vector(to_unsigned(5*128,opA.l.m'length)); opA.r.s <= '0'; opA.r.m <= std_logic_vector(to_unsigned(0,opA.r.m'length));
	opB.c <= '0'; opB.l.s <= '0'; opB.l.m <= std_logic_vector(to_unsigned(7*128,opB.l.m'length)); opB.r.s <= '0'; opB.r.m <= std_logic_vector(to_unsigned(0,opB.r.m'length));
	opC.c <= '0'; opC.l.s <= '0'; opC.l.m <= std_logic_vector(to_unsigned(4*128,opC.l.m'length)); opC.r.s <= '0'; opC.r.m <= std_logic_vector(to_unsigned(0,opC.r.m'length));
	opD.c <= '0'; opD.l.s <= '0'; opD.l.m <= std_logic_vector(to_unsigned(7*128,opD.l.m'length)); opD.r.s <= '0'; opD.r.m <= std_logic_vector(to_unsigned(0,opD.r.m'length));
	opE.c <= '0'; opE.l.s <= '0'; opE.l.m <= std_logic_vector(to_unsigned(7*128,opE.l.m'length)); opE.r.s <= '0'; opE.r.m <= std_logic_vector(to_unsigned(0,opE.r.m'length));
	opF.c <= '0'; opF.l.s <= '0'; opF.l.m <= std_logic_vector(to_unsigned(7*128,opF.l.m'length)); opF.r.s <= '0'; opF.r.m <= std_logic_vector(to_unsigned(0,opF.r.m'length));
	opG.c <= '0'; opG.l.s <= '0'; opG.l.m <= std_logic_vector(to_unsigned(8*128,opG.l.m'length)); opG.r.s <= '0'; opG.r.m <= std_logic_vector(to_unsigned(0,opG.r.m'length));
	opH.c <= '0'; opH.l.s <= '0'; opH.l.m <= std_logic_vector(to_unsigned(7*128,opH.l.m'length)); opH.r.s <= '0'; opH.r.m <= std_logic_vector(to_unsigned(0,opH.r.m'length));
	
	opI.c <= '0'; opI.l.s <= '1'; opI.l.m <= std_logic_vector(to_unsigned(1*128,opI.l.m'length)); opI.r.s <= '0'; opI.r.m <= std_logic_vector(to_unsigned(0,opI.r.m'length));
	opJ.c <= '0'; opJ.l.s <= '1'; opJ.l.m <= std_logic_vector(to_unsigned(2*128,opJ.l.m'length)); opJ.r.s <= '0'; opJ.r.m <= std_logic_vector(to_unsigned(0,opJ.r.m'length));
	opK.c <= '0'; opK.l.s <= '1'; opK.l.m <= std_logic_vector(to_unsigned(3*128,opK.l.m'length)); opK.r.s <= '0'; opK.r.m <= std_logic_vector(to_unsigned(0,opK.r.m'length));
	opL.c <= '0'; opL.l.s <= '1'; opL.l.m <= std_logic_vector(to_unsigned(4*128,opL.l.m'length)); opL.r.s <= '0'; opL.r.m <= std_logic_vector(to_unsigned(0,opL.r.m'length));
	opM.c <= '0'; opM.l.s <= '1'; opM.l.m <= std_logic_vector(to_unsigned(5*128,opM.l.m'length)); opM.r.s <= '0'; opM.r.m <= std_logic_vector(to_unsigned(0,opM.r.m'length));
	opN.c <= '0'; opN.l.s <= '1'; opN.l.m <= std_logic_vector(to_unsigned(6*128,opN.l.m'length)); opN.r.s <= '0'; opN.r.m <= std_logic_vector(to_unsigned(0,opN.r.m'length));
	opO.c <= '0'; opO.l.s <= '1'; opO.l.m <= std_logic_vector(to_unsigned(7*128,opO.l.m'length)); opO.r.s <= '0'; opO.r.m <= std_logic_vector(to_unsigned(0,opO.r.m'length));
	opP.c <= '0'; opP.l.s <= '1'; opP.l.m <= std_logic_vector(to_unsigned(8*128,opP.l.m'length)); opP.r.s <= '0'; opP.r.m <= std_logic_vector(to_unsigned(0,opP.r.m'length));
	
	opQ.c <= '0'; opQ.l.s <= '0'; opQ.l.m <= std_logic_vector(to_unsigned(8*128,opQ.l.m'length)); opQ.r.s <= '0'; opQ.r.m <= std_logic_vector(to_unsigned(0,opQ.r.m'length));
	opR.c <= '0'; opR.l.s <= '0'; opR.l.m <= std_logic_vector(to_unsigned(5*128,opR.l.m'length)); opR.r.s <= '0'; opR.r.m <= std_logic_vector(to_unsigned(0,opR.r.m'length));
	opS.c <= '0'; opS.l.s <= '1'; opS.l.m <= std_logic_vector(to_unsigned(2*128,opS.l.m'length)); opS.r.s <= '0'; opS.r.m <= std_logic_vector(to_unsigned(0,opS.r.m'length));
	opT.c <= '0'; opT.l.s <= '0'; opT.l.m <= std_logic_vector(to_unsigned(0*128,opT.l.m'length)); opT.r.s <= '0'; opT.r.m <= std_logic_vector(to_unsigned(0,opT.r.m'length));
	opU.c <= '0'; opU.l.s <= '1'; opU.l.m <= std_logic_vector(to_unsigned(1*128,opU.l.m'length)); opU.r.s <= '0'; opU.r.m <= std_logic_vector(to_unsigned(0,opU.r.m'length));
	opV.c <= '0'; opV.l.s <= '0'; opV.l.m <= std_logic_vector(to_unsigned(2*128,opV.l.m'length)); opV.r.s <= '0'; opV.r.m <= std_logic_vector(to_unsigned(0,opV.r.m'length));
	opW.c <= '0'; opW.l.s <= '0'; opW.l.m <= std_logic_vector(to_unsigned(3*128,opW.l.m'length)); opW.r.s <= '0'; opW.r.m <= std_logic_vector(to_unsigned(0,opW.r.m'length));
	opX.c <= '0'; opX.l.s <= '0'; opX.l.m <= std_logic_vector(to_unsigned(4*128,opX.l.m'length)); opX.r.s <= '0'; opX.r.m <= std_logic_vector(to_unsigned(0,opX.r.m'length));
	
	wait for 20 ns;
	start <= '0';
	start2 <= '1';
	wait for 20 ns;
	start2 <= '0';
	wait for 20 ns;
	
-- 512.000000000000 + 0.00000000000000i
-- -768.000000000000 + 0.00000000000000i
-- 1024.00000000000 + 0.00000000000000i
-- -1280.00000000000 + 0.00000000000000i
-- -512.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- -512.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- -1.13687040000000e-13 - 512.000000000000i
-- 126.661120000000 + 640.268800000000i
-- -362.035200000000 - 724.083200000000i
-- 680.844800000000 + 697.651200000000i
-- 1.13687040000000e-13 + 512.000000000000i
-- -363.174400000000 - 542.297600000000i
-- 724.083200000000 + 362.035200000000i
-- -974.745600000000 + 11.8854400000000i
-- 1536.00000000000 + 0.00000000000000i
-- 1792.00000000000 + 0.00000000000000i
-- 1536.00000000000 + 0.00000000000000i
-- 1792.00000000000 + 0.00000000000000i
-- -256.000000000000 + 0.00000000000000i
-- 0.00000000000000 + 0.00000000000000i
-- -512.000000000000 + 0.00000000000000i
-- 0.00000000000000 + 0.00000000000000i
-- 640.000000000000 - 896.000000000000i
-- 484.915200000000 - 1170.67520000000i
-- -362.035200000000 - 1086.11840000000i
-- -484.915200000000 - 1170.67520000000i
-- 640.000000000000 + 896.000000000000i
-- 1170.67520000000 + 484.915200000000i
-- 1086.11840000000 + 362.035200000000i
-- 1170.67520000000 - 484.915200000000i
-- -768.000000000000 + 0.00000000000000i
-- -1024.00000000000 + 0.00000000000000i
-- -1280.00000000000 + 0.00000000000000i
-- -1536.00000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- -128.000000000000 + 640.000000000000i
-- 57.3875200000000 + 807.500800000000i
-- 362.035200000000 + 905.100800000000i
-- 750.118400000000 + 864.896000000000i
-- -128.000000000000 - 640.000000000000i
-- -530.419200000000 - 611.571200000000i
-- -905.100800000000 - 362.035200000000i
-- -1141.99040000000 + 81.1584000000000i
-- 896.000000000000 + 0.00000000000000i
-- 896.000000000000 + 0.00000000000000i
-- 128.000000000000 + 0.00000000000000i
-- 512.000000000000 + 0.00000000000000i
-- 1152.00000000000 + 0.00000000000000i
-- 384.000000000000 + 0.00000000000000i
-- -640.000000000000 + 0.00000000000000i
-- -512.000000000000 + 0.00000000000000i
-- 1024.00000000000 + 128.000000000000i
-- 493.312000000000 - 481.433600000000i
-- -452.544000000000 - 90.5100800000000i
-- -473.024000000000 - 195.929600000000i
-- 1024.00000000000 - 128.000000000000i
-- 689.254400000000 - 8.40422400000000i
-- 90.5100800000000 + 452.544000000000i
-- 473.024000000000 + 195.929600000000i
	
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

end TB_fft_stage_2_ARCH;
