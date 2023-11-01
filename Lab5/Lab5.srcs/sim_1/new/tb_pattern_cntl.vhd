LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_pattern_cntl IS
-- ...
END ENTITY tb_pattern_cntl;

ARCHITECTURE behavior OF tb_pattern_cntl IS
    -- Signal declarations for your testbench
    SIGNAL video_on : STD_LOGIC := '0';
    SIGNAL h_pos : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    SIGNAL v_pos : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    SIGNAL graph_r, graph_g, graph_b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    
    COMPONENT pattern_cntl
        PORT (
            video_on : IN STD_LOGIC;
            h_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            v_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            graph_r : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            graph_g : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            graph_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    
BEGIN
    -- Instantiate the pattern_cntl module
    pattern : pattern_cntl
    PORT MAP(
        video_on => video_on,
        h_pos => h_pos,
        v_pos => v_pos,
        graph_r => graph_r,
        graph_g => graph_g,
        graph_b => graph_b
    );
    
    
    -- Stimulus process
    STIMULUS: PROCESS
    BEGIN
        -- You can apply different test vectors here
        -- For example:
         video_on <= '1';
         h_pos <= "10000000001";
         v_pos <= "10101010101";
         WAIT FOR 10 ns;
         video_on <='0';
         
         video_on <= '1';
         h_pos <= "00000111111"; -- Example h_pos value
         v_pos <= "11111100000"; -- Example v_pos value
         WAIT FOR 10 ns;
         video_on <='0';
         
         video_on <= '1';
         h_pos <= "11100011100"; -- Example h_pos value
         v_pos <= "00110011001"; -- Example v_pos value
         WAIT FOR 10 ns;
         video_on <='0';

        
        -- Make sure to include appropriate wait times to allow for signal propagation
     --   WAIT;
    END PROCESS;

END behavior;