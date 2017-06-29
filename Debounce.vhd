LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY debounce IS
  GENERIC(
    counter_size  :  INTEGER := 24); 
  PORT(
    clk     : IN  STD_LOGIC;  
    button  : IN  STD_LOGIC;  --semnalul care are nevoie de debounce
    result  : OUT STD_LOGIC); --semnalul nou
END debounce;

ARCHITECTURE logic OF debounce IS
  SIGNAL flipflops   : STD_LOGIC_VECTOR(1 DOWNTO 0); 
  SIGNAL counter_set : STD_LOGIC;                    
  SIGNAL counter_out : STD_LOGIC_VECTOR(counter_size DOWNTO 0) := (OTHERS => '0'); 
  Signal clk_div:STD_LOGIC;
 component div is
	port(
	clk:in STD_LOGIC;
	clk_div:out STD_LOGIC
   );				
end component ;
BEGIN
  
  counter_set <= flipflops(0) xor flipflops(1);   --determina cind incepe sau se reseteaza numaratorul
  
  PROCESS(clk)
  BEGIN
    IF(clk'EVENT and clk = '1') THEN
      flipflops(0) <= button;
      flipflops(1) <= flipflops(0);
      If(counter_set = '1') THEN                  --se reseteaza numaratorul,deoarece intrarea a fost modificata
        counter_out <= (OTHERS => '0');
      ELSIF(counter_out(counter_size) = '0') THEN 
        counter_out <= counter_out + 1;
      ELSE                                        
        result <= flipflops(1);
      END IF;    
    END IF;
  END PROCESS;
END logic;