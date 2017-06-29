library	 IEEE;
use IEEE.STD_LOGIC_1164.all;

entity h_select is
	port( mn:in STD_LOGIC_VECTOR(1 downto 0);	  --are ca intrari, iesirile lui introdu_numar (m)->mn(1) si
	h:out STD_LOGIC								  --selec_operatie (n)	->mn(0)
	);
end h_select;

architecture h_select of h_select is
begin 
	process(mn)
	begin
	if mn(1)='1' then	  -- daca m este 1, adica se introduce un numar, h=0;  --indiferent de n
		h<='0'; 
	else
		if mn(0)='1' then		 --daca  m=0 si n =1, inseamna ca se introduce o opearatie, si h=1;
			h<='1';
		else											 --pentru m=0 si n=0
			if mn(1)'last_event<=mn(0)'last_event then	 --daca timpul cind a avut loc ultimul eveniment pe m este mai mic
				h<='0'	;								 --decit n,atunci h=0;
			else
				h<='1';									--contrar 1
			end if;
			end if;
			end if;
	end process;
end h_select;

--deci, h=0 cind suntem in procesul de intrucere numar si este egal cu 1,cind am selectat o operatie si nu am 
--atins switchurile caracteristice numarului