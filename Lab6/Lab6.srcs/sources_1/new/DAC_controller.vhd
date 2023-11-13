----------------------------------------------------------------------------------
-- Company: BU
-- Engineer:
--
-- Create Date: 08:11:52 03/28/2013
-- Design Name:
-- Module Name: DAC_controller - Behavioral
-- Project Name: VHDL Interface
-- Description: DAC controller ( direct description based on timing diagram in datasheet

-- assignment: using an internal counter instead
-- Dependencies: N/A
-- 50 MHz clock input
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 12-bit DAC, 4 leading zeros ===> 16 clock cycles
-- SCLK fmax = 30 MHz (25 MHz is chosen for spartan3E/A boards)
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
ENTITY DAC_controller IS
    PORT (
        iRESET : IN STD_LOGIC; --active High asynchronous reset
        iCLK : IN STD_LOGIC; ---i.e., SCLK_DAC (fmax = 30 MHz)
        iEN_DAC : IN STD_LOGIC; -- works if the pulse width varies
        --from 1 TO 16 clock cycles
        iDAC_DATA_V : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        oSYNC_L : OUT STD_LOGIC;
        oSDATA_DAC : OUT STD_LOGIC;
        oDONE_DAC : OUT STD_LOGIC;
        oBUSY_DAC : OUT STD_LOGIC);
END DAC_controller;
ARCHITECTURE Behavioral OF DAC_controller IS
    TYPE state_type IS(IDLE, S15, S14, S13, S12, S11, S10, S9, S8, S7, S6, S5, S4, S3,
    S2, S1, S0);
    SIGNAL pr_state, nx_state : state_type := IDLE;
    SIGNAL SDATA_DAC, DONE_DAC, BUSY_DAC : STD_LOGIC := '0';
    SIGNAL SYNC_L : STD_LOGIC := '1';
BEGIN
    ----------- redirected outputs
    oSYNC_L <= SYNC_L;
    oSDATA_DAC <= SDATA_DAC;
    oDONE_DAC <= DONE_DAC;
    oBUSY_DAC <= BUSY_DAC;
    --- Sequential part of FSM
    PROCESS (iCLK, iRESET)
    BEGIN
        IF (iRESET = '1') THEN
            pr_state <= IDLE;
        ELSIF rising_edge(iCLK) THEN
            pr_state <= nx_state;
        END IF;
    END PROCESS;
    --- Combinational part ( next state, output stage of FSM)
    PROCESS (pr_state, iEN_DAC, iDAC_DATA_V)
    BEGIN
        CASE pr_state IS
            WHEN IDLE =>
                ----- state transition
                IF (iEN_DAC = '1') THEN
                    nx_state <= S15;
                ELSE
                    nx_state <= IDLE;
                END IF;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '1';
                BUSY_DAC <= '0';
                SYNC_L <= '1';
            WHEN S15 => --- bit 15 (leading zero)
                ----- state transition
                nx_state <= S14;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S14 => --- bit 14 (leading zero)
                ----- state transition
                nx_state <= S13;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S13 => --- bit 13 (leading zero)
                ----- state transition
                nx_state <= S12;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S12 => --- bit 12 (leading zero)
                ----- state transition
                nx_state <= S11;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S11 => --- bit 11 (MSB)
                ----- state transition
                nx_state <= S10;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(11);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S10 =>
                ----- state transition
                nx_state <= S9;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(10);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S9 =>
                ----- state transition
                nx_state <= S8;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(9);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S8 =>
                ----- state transition
                nx_state <= S7;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(8);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S7 =>
                ----- state transition
                nx_state <= S6;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(7);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S6 =>
                ----- state transition
                nx_state <= S5;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(6);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S5 =>
                ----- state transition
                nx_state <= S4;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(5);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S4 =>
                ----- state transition
                nx_state <= S3;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(4);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S3 =>
                ----- state transition
                nx_state <= S2;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(3);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S2 =>
                ----- state transition
                nx_state <= S1;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(2);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S1 =>
                ----- state transition
                nx_state <= S0;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(1);
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN S0 =>
                ----- state transition
                nx_state <= IDLE;
                -------output--
                SDATA_DAC <= iDAC_DATA_V(0);
                DONE_DAC <= '0';
                ---- DONE_DAC or 1 clock cycle eariler/later
                BUSY_DAC <= '1';
                SYNC_L <= '0';
            WHEN OTHERS =>
                ----- state transition
                nx_state <= IDLE;
                -------output--
                SDATA_DAC <= '0';
                DONE_DAC <= '0';
                BUSY_DAC <= '1';
                SYNC_L <= '0';
        END CASE;
    END PROCESS;
END Behavioral;