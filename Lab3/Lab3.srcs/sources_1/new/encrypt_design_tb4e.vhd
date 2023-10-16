LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY encrypt_design_tb4e IS
    -- Port ( );
END encrypt_design_tb4e;

ARCHITECTURE Behavioral OF encrypt_design_tb4e IS

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
        WAIT FOR 5 ns;
        clk <= NOT clk;
    END PROCESS;

    -- Test process
    PROCESS
    BEGIN
        WAIT FOR 10 ns;  -- Initial waiting time

        -- Set the initial key value: C7 (hex)
        input_val <= x"C7";

        -- Data sequences
        DATA_SEQUENCE: FOR i IN 1 TO 25 LOOP
            CASE i IS
                WHEN 1 =>
                    input_val <= x"AB";
                WHEN 2 =>
                    input_val <= x"94";
                WHEN 3 =>
                    input_val <= x"94";
                WHEN 4 =>
                    input_val <= x"28";
                WHEN 5 =>
                    input_val <= x"75";
                WHEN 6 =>
                    input_val <= x"15";
                WHEN 7 =>
                    input_val <= x"FC";
                WHEN 8 =>
                    input_val <= x"07";
                WHEN 9 =>
                    input_val <= x"D5";
                WHEN 10 =>
                    input_val <= x"08";
                WHEN 11 =>
                    input_val <= x"92";
                WHEN 12 =>
                    input_val <= x"15";
                WHEN 13 =>
                    input_val <= x"D8";
                WHEN 14 =>
                    input_val <= x"05";
                WHEN 15 =>
                    input_val <= x"28";
                WHEN 16 =>
                    input_val <= x"79";
                WHEN 17 =>
                    input_val <= x"65";
                WHEN 18 =>
                    input_val <= x"6E";
                WHEN 19 =>
                    input_val <= x"B5";
                WHEN 20 =>
                    input_val <= x"AE";
                WHEN 21 =>
                    input_val <= x"38";
                WHEN 22 =>
                    input_val <= x"DE";
                WHEN 23 =>
                    input_val <= x"0E";
                WHEN 24 =>
                    input_val <= x"C5";
                WHEN 25 =>
                    input_val <= x"AF";
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