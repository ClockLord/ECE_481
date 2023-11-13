--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 08:44:29 03/28/2013
-- Design Name:
-- Module Name:
--C : /Users/ylu2/Desktop/ECE331_Interface_VHDL/Interface/ADC_DAC/DAC_chipscope/
--DAC_chipscope/DAC_controller_tb.vhd
-- Project Name: DAC_chipscope
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: DAC_controller
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test. Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
ENTITY DAC_controller_tb IS
END DAC_controller_tb;
ARCHITECTURE behavior OF DAC_controller_tb IS
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT DAC_controller
        PORT (
            iRESET : IN STD_LOGIC;
            iCLK : IN STD_LOGIC;
            iEN_DAC : IN STD_LOGIC;
            iDAC_DATA_V : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            oSYNC_L : OUT STD_LOGIC;
            oSDATA_DAC : OUT STD_LOGIC;
            oDONE_DAC : OUT STD_LOGIC;
            oBUSY_DAC : OUT STD_LOGIC
        );
    END COMPONENT;
    --Inputs
    SIGNAL iRESET : STD_LOGIC := '1'; ---- initial reset
    SIGNAL iCLK : STD_LOGIC := '0';
    SIGNAL iEN_DAC : STD_LOGIC := '0';
    SIGNAL iDAC_DATA_V : STD_LOGIC_VECTOR(11 DOWNTO 0) := x"AA5"; --(others =>
  --  '0');
    --Outputs
    SIGNAL oSYNC_L : STD_LOGIC;
    SIGNAL oSDATA_DAC : STD_LOGIC;
    SIGNAL oDONE_DAC : STD_LOGIC;
    SIGNAL oBUSY_DAC : STD_LOGIC;
    -- Clock period definitions
    CONSTANT iCLK_period : TIME := 40 ns; ---25 MHz
BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut : DAC_controller PORT MAP(
        iRESET => iRESET,
        iCLK => iCLK,
        iEN_DAC => iEN_DAC,
        iDAC_DATA_V => iDAC_DATA_V,
        oSYNC_L => oSYNC_L,
        oSDATA_DAC => oSDATA_DAC,
        oDONE_DAC => oDONE_DAC,
        oBUSY_DAC => oBUSY_DAC
    );
    -- Clock process definitions
    iCLK_process : PROCESS
    BEGIN
        iCLK <= '0';
        WAIT FOR iCLK_period/2;
        iCLK <= '1';
        WAIT FOR iCLK_period/2;
    END PROCESS;
    -- Stimulus process
    stim_proc : PROCESS
    BEGIN
        WAIT FOR iCLK_period * 2;
        iRESET <= '0';
        WAIT FOR iCLK_period;
        IF (oDone_DAC = '1') THEN
            --- generate a pulse for iEN_DAC ---
            iEN_DAC <= '1';
            WAIT FOR iCLK_period;
            iEN_DAC <= '0';
        END IF;
        -- wait; -- hold the simulation or not
    END PROCESS;
END;