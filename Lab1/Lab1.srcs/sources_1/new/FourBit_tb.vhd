

-- import libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all;
--test bench = empty entity
entity FourBit_tb is
--  Port ( );
end FourBit_tb;

architecture Behavioral of FourBit_tb is

    component FourBit is
        port (
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            Sum : out std_logic_vector(3 downto 0);
            Op_Sel : in std_logic
        );
    end component;


-- initial signal values
signal A :  std_logic_vector (3 downto 0) := "0000" ;
signal B :  std_logic_vector (3 downto 0) := "0000" ;
signal Sum :  std_logic_vector (3 downto 0) := "0000";
signal Op_Sel : std_logic := '0';

begin

-- unit under test
uut: FourBit port map
(
    A => A,
    B => B,
    Sum => Sum,
    Op_Sel => Op_Sel
);


process
begin

for  i in 0 to 15 loop

--every 10 ns, chagne B value 
 for j in 0 to 15 loop 

   B <= B + 1 ;
   
   wait for 10 ns;
   
 end loop;


 A <= A + 1; 
 
 wait for 20 ns; 
end loop;
end process; 

end Behavioral;
