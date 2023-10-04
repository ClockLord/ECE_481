

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


end Behavioral;
