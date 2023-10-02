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


entity FourBitLookAhead is

    port (
        A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Sum : out std_logic_vector(3 downto 0);
        Op_Sel : in std_logic;
        cout : out std_logic
    );
    
end FourBitLookAhead;



architecture Behavioral of FourBitLookAhead is

    component LookAheadOneBit
            port(
             A : in STD_LOGIC;
            B : in STD_LOGIC;
            Ci : in STD_LOGIC;
            pi : out STD_LOGIC;
            gi : out STD_LOGIC;
            Sum : out STD_LOGIC;
            op_sel : in std_logic
            ); 
    end component;
    
    signal Bor : std_logic_vector(3 downto 0);
    signal Ci :std_logic_vector(3 downto 0);
    signal P : std_logic_vector(3 downto 0);
    signal G : std_logic_vector(3 downto 0);
    
begin

 
 --Bor <= (B(3) xor Op_Sel) & (B(2) xor Op_Sel) & (B(1) xor Op_Sel) & (B(0) xor Op_Sel);
 
-- --propogate function
-- P(0)<=A(0) or Bor(0);
-- P(1)<=A(1) or Bor(1);
-- P(2)<=A(2) or Bor(2);
-- P(3)<=A(3) or Bor(3);
 
---- --generate function
--G(0)<= A(0) and Bor(0);
--G(1)<= A(1) and Bor(1);
--G(2)<= A(2) and Bor(2);
--G(3)<= A(3) and Bor(3);

-- --Implement Ripple Carry logic
Ci(0)<=G(0) or (p(0) and Op_Sel);  --Op_Sel is first carry in
Ci(1)<=G(1) or (P(1) and (G(0) or (P(0) and Op_Sel)));
Ci(2)<=G(2) or (P(2) and (G(1) or (P(1) and (G(0) or (P(0) and Op_Sel)))));
Ci(3)<=G(3) or (P(3) and (G(2) or (P(2) and (G(1) or (P(1) and (G(0) or (P(0) and Op_Sel)))))));

cout <= ci(3);

--Implement FourBitLookAhead as a combination of one bits
S0: LookAheadOneBit port map (

A => A(0),
B => B(0),
Pi => p(0),
Gi => g(0),
Ci => op_sel,
op_sel => op_sel,
Sum => Sum(0));

S1: LookAheadOneBit port map (

A => A(1),
B => B(1),
Pi => p(1),
Gi => g(1),
Ci => Ci(0),
op_sel => op_sel,
Sum => Sum(1));

S2: LookAheadOneBit port map (

A => A(2),
B => B(2),
Pi => p(2),
Gi => g(2),
Ci => Ci(1),
op_sel => op_sel,
Sum => Sum(2));

S3: LookAheadOneBit port map (

A => A(3),
B => B(3),
Pi => p(3),
Gi => g(3),
Ci => Ci(3),
op_sel => op_sel,
Sum => Sum(3));


end Behavioral;