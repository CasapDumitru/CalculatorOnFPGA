library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity calculator is
	port
	(D,C,B,A : in STD_LOGIC; 
	clk:in STD_LOGIC; 
	OPER:in STD_LOGIC_VECTOR(4 downto 0);	
	semn:in STD_LOGIC;	 
    a_to_g: out STD_LOGIC_VECTOR(6 downto 0);
	an:out STD_LOGIC_VECTOR(3 downto 0);  
	semn_final:out STD_LOGIC ;
	dp:out STD_LOGIC
	);
	
	
end calculator;

architecture calculator of calculator is

signal numar:integer:=0;
signal h:STD_LOGIC:='0'; 
signal operatie:STD_LOGIC_VECTOR(2 downto 0);
signal rezultat:integer:=0;
signal semn_rez:STD_LOGIC;	
signal mn:STD_LOGIC_VECTOR(1 downto 0);	
signal OP:STD_LOGIC_VECTOR(4 downto 0);	 
signal rest:integer:=0; --	
signal clk_div,clk_div_afis:STD_LOGIC;

 component  div is	     
	port(
	clk:in STD_LOGIC;
	clk_div:out STD_LOGIC
   );				
end component; 

component div_afis is
	port(
	clk:in STD_LOGIC;
	clk_div_afis:out STD_LOGIC
   );				
end component ;

component debounce IS
  GENERIC(
    counter_size  :  INTEGER := 19); 
  PORT(
    clk     : IN  STD_LOGIC;  
    button  : IN  STD_LOGIC;  
    result  : OUT STD_LOGIC); 
END	 component ; 


component introdu_numar is
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
end  component;	  

component efectuare_operatie is
	port
	(numar: in integer:=0;
	operatie: in STD_LOGIC_VECTOR(2 downto 0); 
	semn:in STD_LOGIC;
	h:in STD_LOGIC;
	semn_rez:out STD_LOGIC;
	rezultat:out integer:=0;
	rest:out integer:=0
	);
end component ;	 

component selec_operatie is 
	port (
	OP: in STD_LOGIC_VECTOR(4 downto 0);
	
	n:out STD_LOGIC;
	operatie:out STD_LOGIC_VECTOR(2 downto 0)
	);
end component ;

component afisor is  
	port(
	numar:in integer:=0;
	rezultat:in integer:=0;
	clk:in STD_LOGIC; 
	h:in STD_LOGIC;
	rest:in integer:=0;
	a_to_g: out STD_LOGIC_VECTOR(6 downto 0);
	an:out STD_LOGIC_VECTOR(3 downto 0);
	dp:out STD_LOGIC
	);
	
end component ;

component afis_semn is
	port ( Semn_rez:in STD_LOGIC;
	semn:in STD_LOGIC; 
	h:in STD_LOGIC;
	semn_final:	out STD_LOGIC
	);
end component ;	

component h_select is
	port( mn:in STD_LOGIC_VECTOR(1 downto 0);
	h:out STD_LOGIC
	);
end	component ;

begin
	DIV_1: div port map(clk=>clk,clk_div=>clk_div);
	DIV_2: div_afis	 port map(clk=>clk,clk_div_afis=>clk_div_afis);
	Deb1:debounce port map(clk=>clk_div,button=>OPER(4),result=>OP(4));
	Deb2:debounce port map(clk=>clk_div,button=>OPER(3),result=>OP(3));
	Deb3:debounce port map(clk=>clk_div,button=>OPER(2),result=>OP(2));
	Deb4:debounce port map(clk=>clk_div,button=>OPER(1),result=>OP(1));
	Deb5:debounce port map(clk=>clk_div,button=>OPER(0),result=>OP(0));
	C1: introdu_numar port map(D=>D,C=>C,B=>B,A=>A,clk=>clk_div,m=>mn(1),numar=>numar,n=>mn(0));
	C2: selec_operatie port map(OP=>OP,n=>mn(0),operatie=>operatie);
	C3: efectuare_operatie port map (numar=>numar,operatie=>operatie,semn=>semn,h=>h,semn_rez=>semn_rez,rezultat=>rezultat,rest=>rest); 
	C4: afisor port map(numar=>numar,rezultat=>rezultat,clk=>clk_div_afis,h=>h,a_to_g=>a_to_g,an=>an,dp=>dp,rest=>rest);
	C5: afis_semn port map(semn_rez=>semn_rez,semn=>semn,h=>h,semn_final=>semn_final);
	C6: h_select port map( mn=>mn,h=>h);
end;

	 --doar instatierea tuturor componentelor, pentru a intelege mai bine, vedeti schema block din documentatie







	
