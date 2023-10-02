----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2023 11:26:11 AM
-- Design Name: 
-- Module Name: FourBitLookAheadNoComponents - Behavioral
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

entity FourBitLookAheadNoComponents is
  Port (A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Sum : out std_logic_vector(3 downto 0);
        Op_Sel : in std_logic;
        cout : out std_logic);
end FourBitLookAheadNoComponents;

architecture Behavioral of FourBitLookAheadNoComponents is

    signal Bor : std_logic_vector(3 downto 0);
    signal Ci :std_logic_vector(3 downto 0);
    signal P : std_logic_vector(3 downto 0);
    signal G : std_logic_vector(3 downto 0);

begin

    Bor <= (B(3) xor Op_Sel) & (B(2) xor Op_Sel) & (B(1) xor Op_Sel) & (B(0) xor Op_Sel);

---- --propogate function
    P(0)<=A(0) or Bor(0);
   P(1)<=A(1) or Bor(1);
    P(2)<=A(2) or Bor(2);
    P(3)<=A(3) or Bor(3);
 
---- --generate function
    G(0)<= A(0) and Bor(0);
    G(1)<= A(1) and Bor(1);
    G(2)<= A(2) and Bor(2);
    G(3)<= A(3) and Bor(3);
    
-- --Implement Ripple Carry logic
    Ci(0) <= G(0) or (P(0) and Op_Sel);  -- Op_Sel is '1' for addition
    Ci(1) <= G(1) or (P(1) and G(0)) or (P(1) and Ci(0));
    Ci(2) <= G(2) or (P(2) and G(1)) or (P(2) and Ci(1));
    Ci(3) <= G(3) or (P(3) and G(2)) or (P(3) and Ci(2));
    
    
    Cout <= Ci(3);
    --Cout is the last carry
    
    Sum(0) <= A(0) xor B(0) xor Ci(0);
    Sum(1) <= A(1) xor B(1) xor Ci(1);
    Sum(2) <= A(2) xor B(2) xor Ci(2);
    Sum(3) <= A(3) xor B(3) xor Ci(3);

 --A xor B xor Cin;
   

end Behavioral;
