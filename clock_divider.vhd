  library	 IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity  div is
	port(
	clk:in STD_LOGIC;
	clk_div:out STD_LOGIC
   );				
end div;

architecture  div of div is

begin 
	
	process(clk)
	variable N:STD_LOGIC_VECTOR(24 downto 0):=(others=>'0');
	begin
		
		if clk'event and clk='1' then
			N:=N+1;
		end if;
		clk_div<=N(24);			 --clockul folosit pentru numarare cifrelor numerelor (la 1 secunda)
		--clk_div<=clk;	--
		end process;  
	
	end div;