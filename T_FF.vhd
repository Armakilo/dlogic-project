Library ieee;
use ieee.std_logic_1164.all;

entity T_FF is
	port
	(
		-- Input ports
		CLK, T, CL, PR	: in  std_logic;

		-- Output ports
		Q, Qn	: out std_logic
	);
end T_FF;

architecture behavior of T_FF is

	signal Qt : std_logic;

begin

	process (CLK, T , CL, PR)
	begin 
		if rising_edge(CLK) then
			if (CL xor PR) = '1' then Qt <= (Qt and CL) or not(PR);
			else Qt <= Qt xor T;
			end if;
		end if;
	end process;
	Q <= Qt;
	Qn <= not(Qt);

end behavior;
