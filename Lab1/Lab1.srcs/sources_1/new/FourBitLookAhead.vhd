----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/21/2023 10:42:12 AM
-- Design Name: 
-- Module Name: FourBitLookAhead - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FourBitLookAhead is
    port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Sum : out std_logic_vector(3 downto 0);
        Op_Sel : in std_logic
    );
end FourBitLookAhead;



architecture Behavioral of FourBitLookAhead is

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
    signal Ci :std_logic_vector(3 downto 0);
    signal P : std_logic_vector(3 downto 0);
    signal G : std_logic_vector(3 downto 0);
    signal Bin : std_logic_vector(3 downto 0);
    
    
begin

 Bin <= (others => '0') when (Op_Sel = '0') else (not Op_Sel & "000");
 Bor <= (B(3) xor Op_Sel) & (B(2) xor Op_Sel) & (B(1) xor Op_Sel) & (B(0) xor Op_Sel);
 
 --propogate function
 P(0)<=A(0) or B(0);
 P(1)<=A(1) or B(1);
 P(2)<=A(2) or B(2);
 P(3)<=A(3) or B(3);
 
 --generate function
 G(0)<= A(0) and B(0);
 G(1)<= A(1) and B(1);
 G(2)<= A(2) and B(2);
 G(3)<= A(3) and B(3);

 --Implement Ripple Carry logic
 Ci(0)<=G(0) or (P(0) and Bin(0));  --Op_Sel is first carry in
 Ci(1)<=G(1) or (P(1) and (G(0) or (P(0) and Bin(1))));
 Ci(2)<=G(2) or (P(2) and (G(1) or (P(1) and (G(0) or (P(0) and Bin(2))))));
 Ci(3)<=G(3) or (P(3) and (G(2) or (P(2) and (G(1) or (P(1) and (G(0) or (P(0) and Bin(3))))))));




S0: OneBit port map (

A => A(0), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(0),
Cin => Op_Sel,
Cout => Ci(0),
Sum => Sum(0));

S1: OneBit port map (

A => A(1), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(1),
Cin => ci(0),
Cout => Ci(1),
Sum => Sum(1));

S2: OneBit port map (

A => A(2), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(2),
Cin => Ci(1),
Cout => Ci(2),
Sum => Sum(2));

S3: OneBit port map (

A => A(3), --A(0) in four_bit_adder.vhd is associated with A in full_adder.vhd
B => Bor(3),
Cin => Ci(2),
Cout => Ci(3),
Sum => Sum(3));
end Behavioral;
