

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateMachine_tb is
--  Port ( );
end StateMachine_tb;

architecture Behavioral of StateMachine_tb is



component StateMachine 
    port(
        reset_L : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        L_turn : IN STD_LOGIC;
        R_turn : IN STD_LOGIC;
        L_light : OUT STD_LOGIC;
        R_light : OUT STD_LOGIC;
        H_light : OUT STD_LOGIC
    );
end component;

    signal reset_L : std_logic := '1';
    signal clk : std_logic := '0';
    signal L_turn : std_logic := '0';
    signal R_turn : std_logic := '0';
    signal L_light : std_logic := '0';
    signal R_light : std_logic := '0';
    signal H_light : std_logic := '0';
    
    constant CLOCK_PERIOD : time := 1000ns; -- Adjust as needed
    signal simulation_done : boolean := false;
    
begin

uut: StateMachine PORT MAP (
    reset_L => reset_L,
    clk => clk,
    L_turn => L_turn,
    R_turn => R_turn,
    L_light => L_light,
    R_light => R_Light,
    H_light => H_Light
);

 clk_process: process
    begin
        while not simulation_done loop
            clk <= '0';
            wait for CLOCK_PERIOD / 10000;
            clk <= '1';
            wait for CLOCK_PERIOD / 100000;
        end loop;
        wait;
    end process;
    
    simulation_process: process
    begin
        -- Initialize inputs
        reset_L <= '1';
        L_turn <= '0';
        R_turn <= '0';

        -- Reset and start the state machine
        reset_L <= '0';
        wait for 20 ns; -- Assuming a reset time of 20 ns

        -- Test cases
        -- You can add more test cases here by modifying input values
        L_turn <= '1';
        R_turn <= '0';
        wait for 100 ns;
        L_turn <= '0';
        R_turn <= '1';
        wait for 100 ns;
        L_turn <= '1';
        R_turn <= '1';
        wait for 100 ns;
        simulation_done <= true;
        wait;
    end process;

end Behavioral;
