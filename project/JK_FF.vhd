Library ieee;
use ieee.std_logic_1164.all;

entity JK_FF is
	port
	(
		-- Input ports
		CLK, J, K, CL, PR	: in  std_logic;

		-- Output ports
		Q, Qn	: out std_logic
	);
end JK_FF;

architecture behavior of JK_FF is

	signal Qt : std_logic;

begin

	process (CLK, J, K, CL, PR)
	begin 
		if rising_edge(CLK) then
			if (CL xor PR) = '1' then Qt <= (Qt and CL) or not(PR);
				if J = K then Qt <= Qt xor J;
				else Qt <= J;
				end if;
			end if;
		end if;
	end process;
	Q <= Qt;
	Qn <= not(Qt);

end behavior;