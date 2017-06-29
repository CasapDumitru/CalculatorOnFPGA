library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity introdu_cifra is		  -- va fi apelata pentru fiecare cifra a numarului din introdu_numar
	port(
	Nr: in STD_LOGIC;
	clk:in STD_LOGIC;	  --clk divizat la o secunda din clk_div
	n:in STD_LOGIC;
	x:out STD_LOGIC_VECTOR(3 downto 0)
	);
end introdu_cifra;

architecture introdu_cifra of introdu_cifra is


begin 
	
	
	process(Nr,clk)	
	variable q:STD_LOGIC_VECTOR(3 downto 0):=(others=> '0');
	begin 
		
	if n='1' then q:="0000";	  --n este iesire din selec_operatie
		--care se face 1, daca se tasteaza vreo operatie, odata ce se 
		--da click pe operatie,toate cifrele urmatorului numar vor fi zero
		else 
	if Nr='1' then	  --atita timp cit un switch de la D la A este conectat, se numara de la 0 la 9
	if clk'event and clk='1' 
		then  if q="1001"
			then q:="0000" ;
		else q:=q+1; 
			end if;
	else q:=q;
	end if;	
	end if;
	end if;
	x<=q;
	end process; 
	
	end introdu_cifra;
	

	