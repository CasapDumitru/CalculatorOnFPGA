library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity	introdu_numar is
	port(
	D:in STD_LOGIC;
	C: in STD_LOGIC; 
	B: in STD_LOGIC;
	A: in STD_LOGIC; 
	clk:in STD_LOGIC;
	n:in STD_LOGIC;
	m:out STD_LOGIC;
	numar:out integer:=0
	);
end introdu_numar;

architecture introdu_numar of introdu_numar is	
signal D1,C1,B1,A1 : STD_LOGIC_VECTOR(3 downto 0);
 component introdu_cifra is
	port(
	Nr: in STD_LOGIC;
	clk:in STD_LOGIC; 
	n:in STD_LOGIC;
	x:out STD_LOGIC_VECTOR(3 downto 0)
	);
end component ;	  

begin 
	
	Numar_D: introdu_cifra port map(Nr=>D,clk=>clk,x=>D1,n=>n);				 --pentru fiecare cifra se cheama
    Numar_C: introdu_cifra port map(Nr=>C,clk=>clk,x=>C1,n=>n); 			 --componenta intru_cifra,astfel
	Numar_B: introdu_cifra port map(Nr=>B,clk=>clk,x=>B1,n=>n);				 --cifrele la care switchul corespunzator
	Numar_A: introdu_cifra port map(Nr=>A,clk=>clk,x=>A1,n=>n);  			 --va fi pe 1 va numara
	
	process(D,C,B,A,clk)   ------- (D,C,B,A)
	variable num:integer:=0; 
	begin  
	
		num:=1000*conv_integer(D1)+100*conv_integer(C1)+ 10*conv_integer(B1)+conv_integer(A1);	
		--avind unitatile,zecimile,sutimile,miimile se formeaza numarul
		if D='1' or C='1' or B='1' or A='1' then 
			m<='1';	 --avem semnalul m care se face 1 daca se introduce un nou numar
		else 
			m<='0';		--signal ramine 0 daca nici unul din switchuri dupa operatie nu au fost atinse
		end if;
	numar<=num;	  --semnalul numar va avea valoarea numarului introdus
	end process; 
	end introdu_numar;
		



