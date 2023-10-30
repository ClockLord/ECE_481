LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_VGA_basics IS
END ENTITY tb_VGA_basics;

ARCHITECTURE behavior OF tb_VGA_basics IS
    -- Signal declarations for your testbench
    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL VGA_R, VGA_G, VGA_B : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL VGA_HSYNC, VGA_VSYNC : STD_LOGIC;
    
    -- Constants for your test
    CONSTANT SIM_TIME: TIME := 10 ms;
    CONSTANT CLOCK_PERIOD: TIME := 20 ns; -- Adjust this based on your clock frequency
    
BEGIN
    -- Instantiate the VGA_basics module
    vga : ENTITY work.VGA_basics
        PORT MAP (
            clk => clk,
            rst => rst,
            VGA_R => VGA_R,
            VGA_G => VGA_G,
            VGA_B => VGA_B,
            VGA_HSYNC => VGA_HSYNC,
            VGA_VSYNC => VGA_VSYNC
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
    reset_process: PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 100 ns; -- Adjust as needed
        rst <= '0';
        WAIT;
        
    END PROCESS;


    -- Your test scenario here
    -- Apply test vectors to input signals (clk, rst, etc.) and observe output signals (VGA_R, VGA_G, VGA_B, VGA_HSYNC, VGA_VSYNC).

END behavior;




