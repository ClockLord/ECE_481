LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--------- FSM design example for EE VHDL lecture 
ENTITY StateMachine IS
    PORT (
        reset_L : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        L_turn : IN STD_LOGIC;
        R_turn : IN STD_LOGIC;
        L_light : OUT STD_LOGIC;
        R_light : OUT STD_LOGIC;
        H_light : OUT STD_LOGIC);
        
END StateMachine;

ARCHITECTURE Behavioral OF StateMachine IS
    -- define states in the state graph 
    TYPE state_type IS (IDLE, LSIG, RSIG, H1, H2);
    
    SIGNAL pr_state, nx_state : state_type;
    
BEGIN
    --- sequential part (state memory logic) -- 
    PROCESS (clk)
    BEGIN
    
        IF (clk'event AND clk = '1') THEN --- rising_edge
            pr_state <= nx_state;
        END IF;
        
    END PROCESS;

    PROCESS (pr_state, L_turn, R_turn)
    BEGIN

        --- case statement to describe state transition
        CASE pr_state IS
            WHEN IDLE =>
                IF ((L_turn = '1') AND (R_turn = '1')) THEN
                    nx_state <= H1;
                ELSIF ((L_turn = '1') AND (R_turn = '0')) THEN
                    nx_state <= LSIG;
                ELSIF ((L_turn = '0') AND (R_turn = '1')) THEN
                    nx_state <= RSIG;
                ELSE
                    nx_state <= IDLE;
                END IF;
                L_light <= '0';
                R_light <= '0';
                H_light <= '0';
            WHEN LSIG =>
                L_light <= '1';
                R_light <= '0';
                H_light <= '0';
                nx_state <= IDLE;
            WHEN RSIG =>
                L_light <= '0';
                R_light <= '1';
                H_light <= '0';
                nx_state <= IDLE;
            WHEN H1 =>
                L_light <= '1';
                R_light <= '1';
                H_light <= '0';
                nx_state <= H2;
            WHEN H2 =>
                L_light <= '0';
                R_light <= '0';
                H_light <= '1';
                nx_state <= IDLE;
            WHEN OTHERS =>
                nx_state <= IDLE;
                L_light <= '0';
                R_light <= '0';
                H_light <= '0';
        END CASE;
    END PROCESS;
END Behavioral;