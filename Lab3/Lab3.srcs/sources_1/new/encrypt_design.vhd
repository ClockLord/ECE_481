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
        key_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        input_val : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        encrypt_cntl : IN STD_LOGIC;
        output_val : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
           
end encrypt_design;

architecture Behavioral of encrypt_design is

--we need to store the initial values of the LFSR
signal LFSR_init : std_logic_vector(7 downto 0) := "00110100"; --value correcponds to 34 in hex
signal shiftNum : integer := 1; --the number of shifts between sampled values is 1

begin

--this will push the state machine forwards
--so this shifting needs to have a predetermined number of shifts basiclally we will need to count
    process(clk)
    begin

         for i in 0 to shiftNum loop
        --this is where the "feedback polynomial" takes place.
             LFSR_init(0) <=
             LFSR_init(1) <=
             LFSR_init(2) <=
             LFSR_init(3) <=
             LFSR_init(4) <=
             LFSR_init(5) <=
             LFSR_init(6) <=
             LFSR_init(7) <=
         end loop;
         
    end process;
    
end Behavioral;
