LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY tb_vga_sync IS
END ENTITY tb_vga_sync;

ARCHITECTURE behavior OF tb_vga_sync IS
    -- Signal declarations for your testbench
   SIGNAL clk, rst, h_sync, v_sync, video_on, p_tick : STD_LOGIC := '0';
   SIGNAL h_pos, v_pos : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    -- Constants for your test
    CONSTANT CLOCK_PERIOD: TIME := 20 ns; -- Adjust this based on your clock frequency

BEGIN
    -- Instantiate the vga_sync module
    vga_sync_inst: ENTITY work.vga_sync
        PORT MAP (
            clk => clk,
            rst => rst,
            h_sync => h_sync,
            v_sync => v_sync,
            video_on => video_on,
            p_tick => p_tick,
            h_pos => h_pos,
            v_pos => v_pos
        );

    -- Clock process
    clk_process: PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR CLOCK_PERIOD / 2;
        clk <= '1';
        WAIT FOR CLOCK_PERIOD / 2;
    END PROCESS;

    -- Reset process
    rst_process: PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT FOR 100 ns;  -- Remove or adjust this as needed
        rst <= '1';
        WAIT;
    END PROCESS;

    -- Test scenario 1 process
   

END behavior;