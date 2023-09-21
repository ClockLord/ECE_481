library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity OneBitLookAhead is

Port ( 

A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
P : out STD_Logic;
G : out std_logic;
Sum : out STD_LOGIC);

end OneBit;

architecture Behavioral of OneBitLookAhead is

begin

Sum <= A xor B xor Cin;
Cout <= (A and B) or (A and Cin) or (B and Cin);

end Behavioral;
