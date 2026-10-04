LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity demultiplexer is
	port
	(
		-- Input ports
		w0, s	: in  STD_LOGIC;

		-- Output ports
		f0, f1	: out STD_LOGIC
	);
end demultiplexer;

architecture Behaviour of demultiplexer is
	begin
		PROCESS (w0,s)
		BEGIN
		 CASE s IS
			WHEN '0' =>
				f0 <= w0;
				f1 <= '0';
				
			WHEN OTHERS =>
				f1 <= w0;
				f0 <= '0';
		END CASE;
	END PROCESS;
end Behaviour;
