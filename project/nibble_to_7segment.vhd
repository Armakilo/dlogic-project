library ieee;
use ieee.std_logic_1164.all;
entity nibble_to_7segment is 
	port(
		D,C,B,A : IN std_logic;
		HLa,HLb,HLc,HLd,HLe,HLf,HLg: OUT std_logic
		);
end nibble_to_7segment;
architecture decoder of nibble_to_7segment is 

signal m0,m1,m2,m3,m4,m5,m6,m7 : std_logic;
signal m8,m9,m10,m11,m12,m13,m14,m15 : std_logic;

begin
	m0 <=(not(D) and not(C) and not(B) and not(A)); 
	m1 <=(not(D) and not(C) and not(B) and A); 
	m2 <=(not(D) and not(C) and B and not(A)); 
	m3 <=(not(D) and not(C) and B and A);
	m4 <=(not(D) and C and not(B) and not(A)); 
	m5 <=(not(D) and C and not(B) and A);
	m6 <=(not(D) and C and B and not(A)); 
	m7 <=(not(D) and C and B and A);
	m8 <=( D and not(C) and not(B) and not(A));
	m9 <=( D and not(C) and not(B) and A);
	m10<=( D and not(C) and B and not(A));
	m11<=( D and not(C) and B and A);
	m12<=( D and C and not(B) and not(A));
	m13<=( D and C and not(B) and A);
	m14<=( D and C and B and not(A));
	m15<=( D and C and B and A);



	HLa <= m1 or m4 or m11 or m12 or m13;
	HLb <= m5 or m6 or m11 or m12 or m14 or m15; 
	HLc <= m2 or m12 or m14 or m15;
	HLd <= m1 or m4 or m7 or m9 or m10 or m15; 
	HLe <= m1 or m3 or m4 or m5 or m7 or m9; 
	HLf <= m1 or m2 or m3 or m7 or m12 or m13; 
	HLg <= m0 or m1 or m7;
end decoder;