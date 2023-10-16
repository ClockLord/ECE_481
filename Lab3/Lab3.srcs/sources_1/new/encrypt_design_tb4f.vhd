LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY encrypt_design_tb4f IS
    -- Port ( );
END encrypt_design_tb4f;

ARCHITECTURE Behavioral OF encrypt_design_tb4f IS

    COMPONENT encrypt_design IS
        PORT (
            clk : IN STD_LOGIC;
            load_key : IN STD_LOGIC;
            LFSR_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --testing
            input_val : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            encrypt_cntl : IN STD_LOGIC;
            output_val : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
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

    -- Clock stimuli process
    PROCESS
    BEGIN
        WAIT FOR clk_period/2;
        clk <= NOT clk; --toggles clock
    END PROCESS;

    -- Test process
    PROCESS
    BEGIN
        WAIT FOR 10 ns;  -- Initial waiting time

        -- Set the initial key value: C7 (hex)
        input_val <= x"C7";

        -- Data sequences
        DATA_SEQUENCE: FOR i IN 1 TO 7 LOOP
            CASE i IS
                WHEN 1 =>
                    input_val <= x"47";
                WHEN 2 =>
                    input_val <= x"6F";
                WHEN 3 =>
                    input_val <= x"6F";
                WHEN 4 =>
                    input_val <= x"64";
                WHEN 5 =>
                    input_val <= x"62";
                WHEN 6 =>
                    input_val <= x"79";
                WHEN 7 =>
                    input_val <= x"65";          
            END CASE;

            -- Pulse on load_key
            load_key <= '1';
            WAIT FOR clk_period;
            load_key <= '0';

            -- Pulse on encrypt_cntl
            encrypt_cntl <= '1';
            WAIT FOR clk_period;
            encrypt_cntl <= '0';

            WAIT FOR 5 * clk_period;
        END LOOP;

        WAIT;

    END PROCESS;

END Behavioral;