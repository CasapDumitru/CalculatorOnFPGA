  library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity  div_afis is
	port(
	clk:in STD_LOGIC;
	clk_div_afis:out STD_LOGIC
   );				
end div_afis;

architecture  div_afis of div_afis is

begin 
	
	process(clk)			--divizarea cloculi pentru shiftarea anozilor la o viteza relativ mare
	variable N:STD_LOGIC_VECTOR(16 downto 0):=(others=>'0');
	begin
		
		if clk'event and clk='1' then
			N:=N+1;
		end if;
		clk_div_afis<=N(16);
		--clk_div_afis<=clk;--
		end process;  
	
	end div_afis;