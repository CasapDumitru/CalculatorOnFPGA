library	 IEEE;
use IEEE.STD_LOGIC_1164.all;

entity afis_semn is
	port ( Semn_rez:in STD_LOGIC;
	semn:in STD_LOGIC; 
	h:in STD_LOGIC;
	semn_final:	out STD_LOGIC
	);
end afis_semn;

architecture  afis_semn of afis_semn is	   
begin
process(semn_rez,h,semn)	--daca h=0, se afiseaza semnul numarului care se introduce la moment,
                            --daca h =1, se afiseaza semnul rezultatului
begin
	if h='0' then
		semn_final<=semn;
	else 
		semn_final<=semn_rez;	
	end if;
	end process;   
	end afis_semn;
	