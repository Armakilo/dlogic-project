-- 3-flipflop module to be instantiated in larger counter
-- Nessecary files : "D_FF" and "multiplexer"

-- clk is clock, 
-- en is data to go into first flipflop, 
-- ud is up/down toggle. 0 is up and vice versa
-- qo is the final output,
-- load is the toggle for if we will be loading. 0 is no load and vice versa
-- data is the data to load

library ieee;
use ieee.std_logic_1164.all;

entity octalcount is 
	port(clk, en, ud, load :in std_logic;
		CR: in std_logic_vector(2 downto 0);
		PR: in std_logic_vector(2 downto 0);
		data: in std_logic_vector(2 downto 0);
		qo : out std_logic_vector(2 downto 0);
		qcarry : out std_logic);
end entity;

architecture logic of octalcount is

-- qu is the value of q that we use.
-- q is the q output from the flipflop
-- qn is q bar
	signal q: std_logic_vector(2 downto 0);
	signal qn: std_logic_vector(2 downto 0);
	signal qu: std_logic_vector(2 downto 0);
	signal dl: std_logic_vector(2 downto 0);

	component D_FF is
		port(CLK, D, CR, PR	: in  std_logic;
			Q, Qn	: out std_logic);
	end component D_FF;
			
	component multiplexer is 
		port(	w0, w1, s	: in  STD_LOGIC;
			f	: out STD_LOGIC);
	end component multiplexer;

			
begin
	stage0: multiplexer port map ((en xor q(0)), data(0), load, dl(0));

	stage1: D_FF port map (clk, dl(0), CR(0), PR(0), q(0), qn(0));
	
	stage2: multiplexer port map (q(0), qn(0), ud, qu(0));
	
	
	
	stage3: multiplexer port map (((en and qu(0)) xor q(1)), data(1), load, dl(1));
	
	stage4: D_FF port map (clk, dl(1), CR(1), PR(1), q(1), qn(1));
	
	stage5: multiplexer port map (q(1), qn(1), ud, qu(1));
	
	
	
	stage6: multiplexer port map (((en and qu(0) and qu(1)) xor q(2)), data(2), load, dl(2));
	
	stage7: D_FF port map (clk, dl(2), CR(2), PR(2), q(2), qn(2));
	
	stage8: multiplexer port map (q(2), qn(2), ud, qu(2));
	
	
	qcarry <= (en and qu(2) and qu(1) and qu(0));
	qo <= q;
	
	
	
end architecture logic;

	