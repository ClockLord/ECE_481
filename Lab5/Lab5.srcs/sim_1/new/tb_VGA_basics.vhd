LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_VGA_basics IS
END ENTITY tb_VGA_basics;

ARCHITECTURE behavior OF tb_VGA_basics IS
    -- Signal declarations for your testbench
    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL VGA_R, VGA_G, VGA_B : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
    SIGNAL VGA_HSYNC, VGA_VSYNC : STD_LOGIC := '0';
    -- Constants for your test
    CONSTANT SIM_TIME : TIME := 10 ms;
    CONSTANT CLOCK_PERIOD : TIME := 20 ns; -- Adjust this based on your clock frequency

BEGIN
    -- Instantiate the VGA_basics module
    vga : ENTITY work.VGA_basics
        PORT MAP(
            clk => clk,
            rst => rst,
            VGA_R => VGA_R,
            VGA_G => VGA_G,
            VGA_B => VGA_B,
            VGA_HSYNC => VGA_HSYNC,
            VGA_VSYNC => VGA_VSYNC
        );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR CLOCK_PERIOD / 2;
        clk <= '1';
        WAIT FOR CLOCK_PERIOD / 2;
    END PROCESS;

    -- Reset process
    -- Your test scenario here
    TEST_SCENARIO : PROCESS
    BEGIN

        -- Initial reset
        rst <= '1';
        WAIT FOR 100 ns;
        rst <= '0';
        -- Generate VGA sync signals
        WAIT FOR 1 ms; -- Vertical sync pulse
        VGA_HSYNC <= '0'; -- Start of horizontal sync
        WAIT FOR 3 ms; -- Horizontal sync pulse
        VGA_HSYNC <= '1'; -- End of horizontal sync
        WAIT FOR 2 ms; -- Back porch
        VGA_HSYNC <= '0'; -- Start of active video
        VGA_R <= "1111"; -- Set color to white
        VGA_G <= "1111";
        VGA_B <= "1111";
        WAIT FOR 4 ms; -- Active video
        VGA_HSYNC <= '1'; -- End of active video
        VGA_R <= "0000"; -- Set color to black
        VGA_G <= "0000";
        VGA_B <= "0000";
        WAIT FOR 2 ms; -- Front porch
        VGA_HSYNC <= '0'; -- Start of horizontal sync
        WAIT FOR 3 ms; -- Horizontal sync pulse
        VGA_HSYNC <= '1'; -- End of horizontal sync
        WAIT FOR 16 ms; -- Horizontal sync and back porch

        -- Repeat for the next frame
        WAIT FOR 1 ms; -- Vertical sync pulse
        VGA_VSYNC <= '0'; -- Start of vertical sync
        WAIT FOR 3 ms; -- Vertical sync pulse
        VGA_VSYNC <= '1'; -- End of vertical sync
        WAIT FOR 16 ms; -- Vertical sync and back porch
        VGA_VSYNC <= '0'; -- Start of active video
        WAIT FOR 4 ms; -- Active video
        VGA_VSYNC <= '1'; -- End of active video
        WAIT FOR 16 ms; -- Vertical sync and back porch
        -- End of test
        WAIT FOR 100 ns;
        rst <= '1'; -- Reset the design
        WAIT;
    END PROCESS;

    -- Your test scenario here
    -- Apply test vectors to input signals (clk, rst, etc.) and observe output signals (VGA_R, VGA_G, VGA_B, VGA_HSYNC, VGA_VSYNC).

END behavior;