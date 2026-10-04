-- one-bit counter for last octal section.
library ieee;
use ieee.std_logic_1164.all;

entity onecount is 
	port(clk, en, load, CR, PR :in std_logic;
		data: in std_logic;
		qo : out std_logic);
end entity onecount;

architecture logic of onecount is
	
	signal qt: std_logic;
	signal dl: std_logic;
	signal qnot: std_logic;

	component D_FF is
		port(CLK, D, CR, PR	: in  std_logic;
			Q, Qn	: out std_logic);
	end component D_FF;
			
	component multiplexer is 
		port(	w0, w1, s	: in  STD_LOGIC;
			f	: out STD_LOGIC);
	end component multiplexer;

begin
	
	stage0: multiplexer port map ((en xor qt), data, load, dl);

	stage1: D_FF port map (clk, dl, CR, PR, qt, qnot);
	
qo <= qt;

end architecture;
	

	