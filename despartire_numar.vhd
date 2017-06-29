library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DISP_SOLD is
    port ( Numar: in integer:=0;
	rest1:in integer:=0;
	este_rest:out integer:=0;
	D:out integer:=0;
	C:out integer:=0;  
	B:out integer:=0;
	A:out integer:=0;
	eror:out integer);
end;
architecture  DISP_SOLD of DISP_SOLD is

begin
    process(Numar)
    variable BIN: std_logic_vector(13 downto 0);
    variable BCD: std_logic_vector(15 downto 0):=(others => '0');
    variable i: integer:=0;	
	variable D1,C1,B1,A1:integer:=0;
   variable CONVERTED: std_logic:='0';
   begin   
	   if Numar<-9999 then 
		eror<=1;
	elsif Numar>9999 then
	eror<=1;
	else
		eror<=0;
	   	   for i in 0 to 15 loop
			BCD(i) := '0';
		end loop;
   
            BIN := conv_std_logic_vector(numar, 14);
           
            for i in 0 to 13 loop
                bcd(15 downto 1) := bcd(14 downto 0);  --shiftarea bitilor
                bcd(0) := bin(13);
                bin(13 downto 1) := bin(12 downto 0);
                bin(0) :='0';

                if(i < 13 and bcd(3 downto 0) > "0100") then --se adauga 3 daca BCD este mai mare decit 4
                bcd(3 downto 0) := bcd(3 downto 0) + "0011";
                end if;
                if(i < 13 and bcd(7 downto 4) > "0100") then --se adauga 3 daca BCD este mai mare decit 4
                bcd(7 downto 4) := bcd(7 downto 4) + "0011";
                end if;
                if(i < 13 and bcd(11 downto 8) > "0100") then  --se adauga 3 daca BCD este mai mare decit 4
                bcd(11 downto 8) := bcd(11 downto 8) + "0011";
                end if; 
                if(i < 13 and bcd(15 downto 12) > "0100") then  --se adauga 3 daca BCD este mai mare decit 4
                bcd(15 downto 12) := bcd(15 downto 12) + "0011";
                end if;
            end loop; 
            
            D1:=conv_integer(BCD(15 downto 12)); 
            C1:=conv_integer(BCD(11 downto 8));
            B1:=conv_integer( BCD(7 downto 4));
            A1:=conv_integer(BCD(3 downto 0));
	   	 
	end if;	
	if rest1=0 then 
		D1:=D1; C1:=C1; B1:=B1; A1:=A1;
		este_rest<=0;
	else 
		if Numar>999 then
			D1:=D1; C1:=C1; B1:=B1; A1:=A1;	
			este_rest<=0;
		else 
			este_rest<=1;
			  --o sa afisam rest pe al 4 afisor
			D1:=C1;C1:=B1;B1:=A1;A1:=rest1; -- mutam informatia de pe afisoare
		end if;
		end if;
	
		D<=D1;
		C<=C1 ;
		B<=B1  ;
		A<=A1;
    end process;	 
	end;