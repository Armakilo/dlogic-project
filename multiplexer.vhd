LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity multiplexer is
	port
	(
		-- Input ports
		w0, w1, s	: in  STD_LOGIC;

		-- Output ports
		f	: out STD_LOGIC
	);
end multiplexer;

architecture Behaviour of multiplexer is
	begin
		PROCESS (w0,w1,s)
		BEGIN
		 CASE s IS
			WHEN '0' =>
				F <= w0;
			WHEN OTHERS =>
				F <= w1;
		END CASE;
	END PROCESS;
end Behaviour;
