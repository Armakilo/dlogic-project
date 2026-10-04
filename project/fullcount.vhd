library ieee;
use ieee.std_logic_1164.all;

entity fullcount is 
	port(clock, ena, updown, isload : in std_logic;
		pinput : in std_logic_vector(12 downto 0);
		inlim : out std_logic;
		qpout, qnpout : out std_logic_vector(12 downto 0)); -- do we need q1 in octalcount?
end entity;

architecture brains of fullcount is
	
	signal qt : std_logic_vector(12 downto 0);
	signal qcarryint : std_logic_vector(3 downto 0);
	signal clear : std_logic_vector(12 downto 0);
	signal chold : std_logic;
	signal preset : std_logic_vector(12 downto 0);
	signal phold : std_logic;
	signal l : std_logic;
	
	component octalcount is
		port(clk, en, ud, load :in std_logic;
			CR: in std_logic_vector(2 downto 0);
			PR: in std_logic_vector(2 downto 0);
			data: in std_logic_vector(2 downto 0);
			qo : out std_logic_vector(2 downto 0);
			qcarry : out std_logic);
	end component octalcount;
			
	component onecount is
		port(clk, en, load, CR, PR :in std_logic;
		data: in std_logic;
		qo : out std_logic);
	end component onecount;

			
begin

	process (pinput)
	begin
		if pinput > "1011111111000" then 
		inlim <= '1';
		l <= '0';
		else 
		inlim <= '0';
		l <= isload;
		end if;
	end process;
	
		phold <= (qt(0) or qt(1) or qt(2) or qt(3) or qt(4) or qt(5) or qt(6) or qt(7) or qt(8) or qt(9) or qt(10) or qt(11) or qt(12));
		chold <= not(qt(3) and qt(4) and qt(5) and qt(6) and qt(7) and qt(8) and qt(9) and qt(10) and qt(12));
	
	process (updown)
	begin
		if updown = '0' then 
		clear(0) <= chold; clear(1) <= chold; clear(2) <= chold; clear(3) <= chold; clear(4) <= chold; clear(5) <= chold; clear(6) <= chold;
		clear(7) <= chold; clear(8) <= chold; clear(9) <= chold; clear(10) <= chold; clear(11) <= chold; clear(12) <= chold;
		preset <= "1111111111111";
		else 
		clear(10 downto 3) <= "11111111"; clear(12) <= '1';
		clear(0) <= phold; clear(1) <= phold; clear(2) <= phold; clear(11) <= phold;
		preset(2 downto 0) <= "111"; preset(11) <= '1';
		preset(3) <= phold; preset(4) <= phold; preset(5) <= phold; preset(6) <= phold; preset(7) <= phold; 
		preset(8) <= phold; preset(9) <= phold; preset(10) <= phold; preset(12) <= phold;
		end if;
	end process;		
	
	stage0: octalcount port map(clock, ena, updown, l, clear(2 downto 0), preset(2 downto 0), pinput(2 downto 0), qt(2 downto 0), qcarryint(0));
	stage1: octalcount port map(clock, qcarryint(0) , updown, l, clear(5 downto 3), preset(5 downto 3), pinput(5 downto 3), qt(5 downto 3), qcarryint(1));
	stage2: octalcount port map(clock, qcarryint(1), updown, l, clear(8 downto 6), preset(8 downto 6), pinput(8 downto 6), qt(8 downto 6), qcarryint(2));
	stage3: octalcount port map(clock, qcarryint(2) , updown, l, clear(11 downto 9), preset(11 downto 9), pinput(11 downto 9), qt(11 downto 9), qcarryint(3));
	stage4: onecount port map (clock, qcarryint(3), l, clear(12), preset(12), pinput(12), qt(12));
	
	qpout <= qt;
	qnpout <= not(qt);
	
end architecture brains;