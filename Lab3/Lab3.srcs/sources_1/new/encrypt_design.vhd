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

--need to make state machine
begin
if rising_edge 

end Behavioral;
