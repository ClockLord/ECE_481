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

--need to make state machine
begin

--this will push the state machine forwards
--so this shifting needs to have a predetermined number of shifts
    process(clk)
    begin
        --this is where the "feedback polynomial" takes place.
        if rising_edge(clk) then
        
        
        end if;
    end process;
    
end Behavioral;
