library ieee;

use ieee.std_logic_1164.all;
use work.my_package.all;

entity SIGNED_ADDER_12 is
    port(
        add_sub : in std_logic; -- 0 add/ 1 sub
        op1 : in real12; 
        op2 : in real12;
        res : out real12
    );
end entity SIGNED_ADDER_12;

architecture SIGNED_ADDER_12_ARCH of SIGNED_ADDER_12 is
    component add_sub12 is
	port
	(
		add_sub		: in std_logic ; -- 1 add 0 sub
		dataa		: in std_logic_vector (11 downto 0);
		datab		: in std_logic_vector (11 downto 0);
		result		: out std_logic_vector (11 downto 0)
	);
    end component add_sub12;
    
    component compare12 is
	port
	(
		dataa		: in std_logic_vector (11 downto 0);
		datab		: in std_logic_vector (11 downto 0);
		aeb		    : out std_logic ;
		ageb		: out std_logic 
	);
    end component compare12;
    
    signal op : std_logic;
    signal M : std_logic;
    signal M2 : std_logic;
    signal r : std_logic_vector(11 downto 0);
    signal a1 : std_logic_vector(11 downto 0);
    signal a2 : std_logic_vector(11 downto 0);
    signal switch_operand : std_logic;
begin
    A: add_sub12 port map(add_sub => op, dataa => a1, datab => a2, result => r);
    C: compare12 port map(dataa => op1.m, datab => op2.m, aeb => M2, ageb => M); -- M=1 means op1>=op2, else M=0 op1<op2
    
    op <= (add_sub and (op1.s xor op2.s)) or (not add_sub and not (op1.s xor op2.s));
    
    switch_operand <= (((not add_sub and not M) and (op1.s xor op2.s)) or ((add_sub and not M) and not (op1.s xor op2.s)));
    a1 <= op2.m when switch_operand='1' else op1.m;
    a2 <= op1.m when switch_operand='1' else op2.m;
    
    res.s <= '0' when (M2='1' and (op1.s xor op2.s)='1' and add_sub='0') else ((not add_sub and ((not M and op2.s) or (M and op1.s))) or (add_sub and ((not M and not op2.s) or (M and op1.s))));
    res.m <= r;
end SIGNED_ADDER_12_ARCH;
