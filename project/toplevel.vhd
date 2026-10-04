--top level design file
--radix means what we want to output, 0 is 8, 1 is 14

entity toplevel is 
	port(
	updown, enable, radix, load, clock: in std_logic;
	parallel_inputs : in std_logic_vector(12 downto 0);
	badload : out std_logic;
	seg7_1, seg7_2, seg7_3, seg7_4, seg7_5: out std_logic_vector(6 downto 0);
	loaddisplay : out std_logic_vector(12 downto 0);
	lsbdisplay : out std_logic_vector(7 downto 0)
	);
end  entity;

architecture logic of toplevel is
	
	signal c: std_logic;
	signal Q: std_logic_vector(12 downto 0);
	signal Qn: std_logic_vector(12 downto 0);
	signal Qnew: std_logic_vector(15 downto 0);
	
	component fullcount is
		port(clock, ena, updown, isload : in std_logic;
			pinput : in std_logic_vector(12 downto 0);
			inlim : out std_logic;
			qpout, qnpout : out std_logic_vector(12 downto 0));
		end component fullcount;
		
	component r8r14 is
		port(input : in std_logic_vector(12 downto 0);
			output : out std_logic_vector(15 downto 0));
		end component r8r14;
	
	component octal_to_7seg is 
		port(C,B,A : IN std_logic;
			HL: OUT std_logic_vector(6 downto 0));
		end component octal_to_7seg;
	
	component radix14_to_7seg is
		port(D,C,B,A : IN std_logic;
			HL: OUT std_logic_vector(6 downto 0));
		end component radix14_to_7seg;
		
	component clk_gen_1_output is
		generic( n  : integer := 25000;
			n1 : integer := 2000);  
		port( Clock : in  std_logic;
			c_out : out std_logic);
		end component clk_gen_1_output;

begin
		
	stage0: clk_gen_1_output port map(clock, c);
	stage1: fullcount port map(clock, enable, updown, load, parallel_inputs, badload, Q, Qn); --change clock to c
	
	--green lsb lights
	lsbdisplay(7 downto 0) <= Q(7 downto 0);
	
	--dislpay the loading value
	loadsisplay <= load;
	
	process(radix)
	begin
		if radix = '0' then 
			stage2: octal_to_7seg port map(q(2), q(1), q(0), seg7_1);
			stage3: octal_to_7seg port map(q(5), q(4), q(3), seg7_2);
			stage4: octal_to_7seg port map(q(8), q(7), q(6), seg7_3);
			stage4: octal_to_7seg port map(q(11), q(10), q(9), seg7_4);
			stage5: octal_to_7seg port map('0', '0', q(12), seg7_5);
		else
			stage2: r8r14 port map(Q, Qnew);
			stage3: radix14_to_7seg port map(qnew(3), qnew(2), qnew(1), qnew(0), seg7_1);
			stage4: radix14_to_7seg port map(qnew(7), qnew(6), qnew(5), qnew(4), seg7_2);
			stage5: radix14_to_7seg port map(qnew(11), qnew(10), qnew(9), qnew(8), seg7_3);
			stage6: radix14_to_7seg port map(qnew(15), qnew(14), qnew(13), qnew(12), seg7_4);
			stage7: radix14_to_7seg port map('0', '0', '0', '0', seg7_5);
		end if;
	end process;
end architecture; 
		
		
		
		