
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FourBit is
    port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Sum : out std_logic_vector(3 downto 0);
        Op_Sel : in std_logic
    );
end FourBit;

architecture Behavioral of FourBit is
    component OneBit
    
        port(
            A: in std_logic;
            B: in std_logic;
            Cin: in std_logic;
            Cout : out std_logic;
            Sum : out std_logic
            );
            
    end component;
    
    signal Bor : std_logic_vector(3 downto 0);
    signal Cout :std_logic_vector(3 downto 0);
    
begin

    Bor <= (B(3) or Op_Sel) & (B(2) or Op_Sel) & (B(1) or Op_Sel) & (B(0) or Op_Sel);
    
    --Bor(0)<= B(0) or Op_Sel;
    --Bor(0)<= B(1) or Op_Sel;
    --Bor(0)<= B(2) or Op_Sel;
   -- Bor(0)<= B(3) or Op_Sel;
    


S0: OneBit port map (

A => A(0), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(0),
Cin => Op_Sel,
Cout => Cout(0),
Sum => Sum(0));

S1: OneBit port map (

A => A(1), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(1),
Cin => Cout(0),
Cout => Cout(1),
Sum => Sum(1));

S2: OneBit port map (

A => A(2), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(2),
Cin => Cout(1),
Cout => Cout(2),
Sum => Sum(2));

S3: OneBit port map (

A => A(3), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(3),
Cin => Cout(2),
Cout => Cout(3),
Sum => Sum(3));



end Behavioral;
