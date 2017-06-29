library	 IEEE;
use IEEE.STD_LOGIC_1164.all;

entity selec_operatie is 
	port (
	OP: in STD_LOGIC_VECTOR(4 downto 0);
	
	n:out STD_LOGIC;
	operatie:out STD_LOGIC_VECTOR(2 downto 0)
	);
end selec_operatie;

	architecture  selec_operatie of selec_operatie is  
	begin
		process(OP)	 --se selecteaza operatia, care este codificata pe 3 biti
		begin 
			
			case OP is
				when "10000" => 
                     n<='1';	  
					operatie<="000";  --plus
				
					when "01000" =>
				  n<='1';
				 operatie<="001";--minus	
				 
				 when "00100" => 
                     n<='1';
					operatie<="010"; --inmultit
				
					when "00010" =>
				  n<='1';
				 operatie<="011"; --inpartit
		       
				 when "00001" => 
                     n<='1';
					operatie<="100";--egal
				
					when others =>
				  n<='0';
				 operatie<="111"; 
				 end case;
			 end process;
			end selec_operatie;	  
			
			--semnal n se face 1 daca se alege vreo operatie, si ramine 0 in caz contrar
			
			
			
				
				
				
				
			
	
	
	
	