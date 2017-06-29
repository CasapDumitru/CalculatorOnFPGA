library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity  afisor is  
	port(
	Numar:in integer:=0;
	rezultat:in integer:=0;
	clk:in STD_LOGIC; 
	h:in STD_LOGIC;	 
	rest:in integer:=0;
	a_to_g: out STD_LOGIC_VECTOR(6 downto 0);
	dp:out STD_LOGIC;
	an:out STD_LOGIC_VECTOR(3 downto 0)
	);
	
end afisor;

architecture  afisor of afisor is	 
	 

component cod_afisor is
	port
	(Nr:integer:=0;
	a_to_g: out STD_LOGIC_VECTOR(6 downto 0) 
	); 
end component;	

component DISP_SOLD is
    port ( Numar: in integer:=0;
	--EN:in STD_LOGIC;	 
	--clk:in STD_Logic;	
	rest1:in integer:=0;
	este_rest:out integer:=0;
	D:out integer:=0;
	C:out integer:=0;  
	B:out integer:=0;
	A:out integer:=0;
	eror:out integer);
end component;

signal aen:STD_LOGIC_VECTOR(3 downto 0):="1110";
signal D1,C1,B1,A1:integer:=0; 
signal eror1:integer:=0;
signal a_to_g_D,a_to_g_C,a_to_g_B,a_to_g_A: STD_LOGIC_VECTOR(6 downto 0);	 
signal Nr:integer:=0;
signal rest1:integer:=0; 
signal este_rest:integer:=0;  --afisam rest daca =1,daca =0 ->nu;
begin 
	
	aflare_cod_D_pentru_afisor	: cod_afisor port map(Nr=>D1,a_to_g=>a_to_g_D);
	aflare_cod_C_pentru_afisor	: cod_afisor port map(Nr=>C1,a_to_g=>a_to_g_C);
	aflare_cod_B_pentru_afisor	: cod_afisor port map(Nr=>B1,a_to_g=>a_to_g_B);
	aflare_cod_A_pentru_afisor	: cod_afisor port map(Nr=>A1,a_to_g=>a_to_g_A);
	mii_sutimi_zecimi_unitati   :DISP_SOLD port map(Numar=>NR,D=>D1,C=>C1,B=>B1,A=>A1,rest1=>rest1,eror=>eror1,este_rest=>este_rest);
	process(h)	--h=0,se introduce numar,pe afisor va fi afisat numarul
	--h=1,am selctat operatie,daca este prima,se afiseaza primul numar introdus,daca nu,noul rezultat efectuat
	--h este iesire din h_select
	begin
		if h='0' then
			Nr<=Numar;
			rest1<=0;
		else
			Nr<=rezultat;
			rest1<=rest;
		end if;	
	end process;
		


  process (clk)		   --pe clk de la placa divizat,dar care ramine foarte rabid,se shifteaza valoarea "1110" pe anozi,
                       --fiicare fiind activi pe rind, ca sa vedem numarul intreg
begin 
	if clk'event and clk='1' then
		aen(3)<=aen(0);aen(2)<=aen(3);aen(1)<=aen(2);aen(0)<=aen(1);
	end if;
end process;  

process(aen)
begin
	case aen is
		when "1110"=> 
		
		dp<='1';
		if eror1=1 then			   --daca error1=1, numarul a depasit valoarea maxima si se va afisa EROR pe afisor
			a_to_g<="0110000";	   --E
			else
		a_to_g<=a_to_g_D;	  --cifra de pe D
		
		end if;
		
		when "1101"=> 
		dp<='1';
		if eror1=1 then
			a_to_g<="0001000";	  --R
		else  
		
		
		a_to_g<=a_to_g_C;		--cifra de pe C
		end if;
		
		when "1011"=> 
		
		if eror1=1 then
			a_to_g<="0000001";	 --O
		else 
			if este_rest=1 then		  --daca avem rest, se aprinde punctul de la al 3 afisor
			dp<='0';
		else 
			dp<='1';
		end if;
		a_to_g<=a_to_g_B;	  --cifra de pe B
		 end if;
		
		 when "0111" => 
		 dp<='1';
		 if eror1=1 then
			a_to_g<="0001000";	  --R
			else
		a_to_g<=a_to_g_A; 	   --cifra de pe A
		 end if;
		when others=>  a_to_g<="1111111";
		
	end case; 
	an<=aen;
end process;  
end afisor;   


