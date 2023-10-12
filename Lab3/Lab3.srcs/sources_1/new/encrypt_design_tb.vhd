LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY encrypt_design_tb IS
    -- Port ( );
END encrypt_design_tb;

ARCHITECTURE Behavioral OF encrypt_design_tb IS

    COMPONENT encrypt_design IS
        PORT (
            clk : IN STD_LOGIC;
            load_key : IN STD_LOGIC;
            LFSR_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --testing
            input_val : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            encrypt_cntl : IN STD_LOGIC;
            output_val : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL load_key : STD_LOGIC := '0';
    SIGNAL input_val : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL encrypt_cntl : STD_LOGIC := '0';
    SIGNAL output_val : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL LFSR_out : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0'); --testing
    CONSTANT clk_period : TIME := 10 ns;
    
BEGIN

    uut : encrypt_design
    PORT MAP
    (
        clk => clk,
        load_key => load_key,
        LFSR_out => LFSR_out, --testing
        input_val => input_val,
        encrypt_cntl => encrypt_cntl,
        output_val => output_val
    );
    --generate clock stimuli
    PROCESS
    BEGIN
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
        clk <= '0';
    END PROCESS;
    PROCESS
    BEGIN
        WAIT FOR clk_period;
        input_val <= x"34"; --set initial key
        ---a pulse on load_key
        WAIT FOR clk_period;
        load_key <= '1';
        WAIT FOR clk_period;
        load_key <= '0';
        ---first value of input message
        WAIT FOR clk_period;
        input_val <= x"67";
        WAIT FOR clk_period;
        ---a pulse on encrypt_cntl
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '1';
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '0';
        ---second value of input message
        WAIT FOR clk_period;
        input_val <= x"6A";
        WAIT FOR clk_period;
        ---a pulse on encrypt_cntl
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '1';
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '0';
        ---third value of input message
        WAIT FOR clk_period;
        input_val <= x"D1";
        WAIT FOR clk_period;
        ---a pulse on encrypt_cntl
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '1';
        WAIT FOR 5 * clk_period;
        encrypt_cntl <= '0';
        WAIT;
    END PROCESS;
END Behavioral;