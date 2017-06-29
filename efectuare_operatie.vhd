library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity efectuare_operatie is
	port
	(numar: in integer:=0;
	operatie: in STD_LOGIC_VECTOR(2 downto 0); 
	semn:in STD_LOGIC;
	h:in STD_LOGIC;	    
	semn_rez:out STD_LOGIC;
	rezultat:out integer:=0;
	rest:out integer
	);
	 end efectuare_operatie;
	architecture  efectuare_operatie of efectuare_operatie is	  
	signal semn1:STD_LOGIC:='0';  
	 signal o1,o2:std_logic_vector(2 downto 0);
	begin
		process(numar,operatie,h)
		variable rez,x:integer:=0; 
		variable oper1,oper2: STD_LOGIC_VECTOR(2 downto 0):="000";	--folosim 2 semnale pentru operatie,oper 2 va
		variable rest1:integer:=0;									--contine operatia care se variable efectua la moment
		variable rest2:integer:=0;									--iar oper1, operatia tastata imediat
		begin	
			
			if h='0' then 					 --daca h=0,suntem in procesul de introducere numar,si aici nu se schimba nimic
				rez:=rez;
				oper1:=oper1;
				oper2:=oper2; 
				rest1:=rest1;
				
			else 
				 if x=0 then 		 --cazul cind se introduce abia primul numar si prima operatie
					oper1:=oper1 ;	   --oper1 ramine neschimbata
		            oper2:=operatie;   --iar oper2,care va fi folosita la urmatoarea operatie,ia operatia tastata
				     semn1<=semn;
					rez:=numar;	  	  --se preiau toate informatiile din numar in rez, la fel signal semnul
					x:=1;  			  --primul numar a fost introdus, si se va intra mereu in else urmator deja
					rest1:=rest1;
					
				else  
					if operatie="111" then 
				null;
				else
					oper2:=oper1; 			--se va efectua mereu operatia tastata anterior,iar asta noua se va folosi
				   						   --pentru urmatorul numar
					oper1:=operatie; 	 -- oper1 va lua valoarea operatii noi  ,deci ca si cum se variable face o siftare
					                     --pe 2 biti a operatiilor , un fel de FIFO, prima intra, prima iese
					case oper2 is  		  --se face un case pe oper2,si se vor efectua operatiile in funtctie de valoarea pe care
						                 --o are,selectate si codificate in sele_operatie
						when "000" =>								 --adunare
						rest1:=rest1;
						if   semn='0' and semn1='0' then		 --ambele pozitive,semnul ramine pozitiv
							 semn1<='0';
						     rez:=rez+numar;   					   --rezultatul e suma lor
							 
						elsif semn1='0' and semn='1' then		  --unul pozitiv altul negativ, se ia semnul celui mai mare
							if rez>=numar then					  --iar rezultatul e diferenta dintre cel mai mare signal cel
								rez:=rez-numar;					  --mai mic
								semn1<='0';						   
							else
								rez:=numar-rez;
								semn1<='1';
							end if;
							elsif  semn1='1' and semn='0' then	   --invers la fel
								if numar>=rez then
									rez:=numar-rez;
									semn1<='0';
								else 
									rez:=rez-numar;			  
									semn1<='1';
								end if;
						   else  
							   rez:=rez+numar;				 --daca ambele negative,se face suma loc,semnul minus
							   semn1<='1';
						    end if;
								
							
						when "001" => 						 --scadere
						rest1:=rest1;
						if semn1='0' and semn='0' then		   --daca ambele pozitive
							if rez>=numar then
							    rez:=rez-numar;	 
								semn1<='0';
							else  
								rez:=numar-rez;
								semn1<='1';
							end if;
							elsif semn1='0' and semn='1' then		--daca numar ii pozitiv si rez negativ
								rez:=rez+numar;
								semn1<='0';
							elsif semn1='1' and semn='0' then	   --invers
								rez:=rez+numar;
								semn1<='1';
							else
								if numar>=rez then
									rez:=numar-rez;
									semn1<='0';
								else						  --ambele negtive
									rez:=rez-numar;
									semn1<='1';	
								end if;
								end if;
								
						when "010" =>						  --inmultire
						rest1:=rest1;
						if semn1=semn then					  --daca semnele egale,semnul e plus
						rez:=rez*numar;						  --daca diferite,negatic
						semn1<='0';
						else 
							rez:=rez*numar;
							semn1<='1';
							end if;
							
						when "011"=>  				  --inpartire
						rest2:=rez rem numar; 		   --restul e pe 1 bit
						if rest2>999 then
							rest1:=rest2/1000;
						elsif rest2>99 then
							rest1:=rest2/100;
						elsif rest2>9 then
							rest1:=rest2/10;
						else rest1:=rest2;
							end if;
							
						if semn1=semn then
						rez:=rez/numar;
						semn1<='0';
						else 
							rez:=rez/numar;
							semn1<='1';
						end if;	
						
						when "100"=> 				--egal
						rest1:=rest1;
						rez:=rez;
						when others => 
						rest1:=rest1;
						rez:=rez;
					end case;
				end if;
				end if;	
				end if;
				rezultat<=rez; 
				semn_rez<=semn1;
				rest<=rest1;
				
				
			end process; 
			
					end efectuare_operatie;	