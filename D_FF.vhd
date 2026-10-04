Library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
	port
	(
		-- Input ports
		CLK, D, CR, PR	: in  std_logic;

		-- Output ports
		Q, Qn	: out std_logic
	);
end D_FF;

architecture behavior of D_FF is

	signal Qt : std_logic;

begin

	process (CLK, D , CR, PR)
	begin 
		if rising_edge(CLK) then
			if (CR xor PR) = '1' then Qt <= (Qt and CR) or not(PR);
			else Qt <= D;
			end if;
		end if;
	end process;
	Q <= Qt;
	Qn <= not(Qt);

end behavior;
