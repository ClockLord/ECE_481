
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LookAheadOneBit is
    port(
    
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Ci : in STD_LOGIC;
        pi : out STD_LOGIC;
        gi : out STD_LOGIC;
        Sum : out STD_LOGIC;
        op_sel : in std_logic
    
    );
end LookAheadOneBit;

architecture Behavioral of LookAheadOneBit is

begin

    pi <= A or (B xor op_sel);
    gi <= A and (B xor op_sel);
    
    Sum <= A xor (B xor op_sel) xor Ci;

    
    

    
    
end Behavioral;
