library	IEEE;	 
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cod_afisor is
	port
	(Nr:in integer:=0;
	a_to_g: out STD_LOGIC_VECTOR(6 downto 0) 
	); 
	end cod_afisor;
	
	architecture cod_afisor of cod_afisor is 
	begin
	process(Nr)	 --codificam codul pentru cifre pentru afisor, pe catozi
begin  
	case Nr is	 
			when 0 => a_to_g <= "0000001"; --0
			when 1 => a_to_g <= "1001111"; --1
			when 2 => a_to_g <= "0010010"; --2
			when 3 => a_to_g <= "0000110"; --3
			when 4 => a_to_g <= "1001100"; --4
			when 5 => a_to_g <= "0100100"; --5
			when 6 => a_to_g <= "0100000"; --6
			when 7 => a_to_g <= "0001101"; --7
			when 8 => a_to_g <= "0000000"; --8
			when others => a_to_g <= "0000100"; --9
			
		end case;
end process; 
end ;	