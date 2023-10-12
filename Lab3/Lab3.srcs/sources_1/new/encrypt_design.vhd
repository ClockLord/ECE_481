----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2023 07:20:53 PM
-- Design Name: 
-- Module Name: encrypt_design - Behavioral
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

--port description
entity encrypt_design is

        Port (  
        clk : IN STD_LOGIC;
        load_key : IN STD_LOGIC;
        LFSR_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        input_val : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        encrypt_cntl : IN STD_LOGIC;
        output_val : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
           
end encrypt_design;

architecture Behavioral of encrypt_design is

--we need to store the initial values of the LFSR
signal LFSR : std_logic_vector(7 downto 0) := "00110100"; --value correcponds to 34 in hex
--signal shiftNum : integer := 1; --the number of shifts between sampled values is 1

begin

   


--this will push the state machine forwards
--so this shifting needs to have a predetermined number of shifts basiclally we will need to count
    process(clk)
    begin
    
    --load the key when load_key button is pressed
        if load_key = '1' then
            LFSR <= input_val;
        end if;
        
    --keygen
    if rising_edge(clk) then    --operate on the rising edge to avoid clocking issues
         for i in 0 to 1 loop
            --this is where the "feedback polynomial" takes place
             LFSR(0) <= LFSR(1);
             LFSR(1) <= LFSR(2);
             LFSR(2) <= LFSR(3);
             LFSR(3) <= LFSR(4) XNOR LFSR(0);   --this will be XNOR
             LFSR(4) <= LFSR(5) XNOR LFSR(0);   --this will be XNOR
             LFSR(5) <= LFSR(6) XNOR LFSR(0);   --this will be XNOR
             LFSR(6) <= LFSR(7);
             LFSR(7) <= LFSR(0);
         end loop;
     end if;
     
         LFSR_out <= LFSR;   --show the key on leds
         
    --Perform encryption
        if encrypt_cntl = '1' then
            output_val <= input_val xor LFSR xor LFSR;
        end if;
        
    end process;
    
    
    
end Behavioral;
