LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY VGA_basics IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
       -- switch_input : in std_logic_vector(2 downto 0);
        VGA_R : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- C8 B8 B3 A3
        VGA_G : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- D6 C6 D5 C5
        VGA_B : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- C9 B9 D7 C7
        VGA_HSYNC : OUT STD_LOGIC;--C11
        VGA_VSYNC : OUT STD_LOGIC -- B11
    );
END VGA_basics;

ARCHITECTURE vgadisp_arch OF VGA_basics IS
    COMPONENT vga_sync
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            h_sync : OUT STD_LOGIC;
            v_sync : OUT STD_LOGIC;
            h_pos : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            v_pos : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
            video_on : OUT STD_LOGIC);
            
    END COMPONENT;
    -- signal red_data, green_data, blue_data : std_logic;
   -- SIGNAL rgb_s : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL VGA_r_s : STD_LOGIC_VECTOR(3 DOWNTO 0); --
    SIGNAL VGA_g_s : STD_LOGIC_VECTOR(3 DOWNTO 0); --
    SIGNAL VGA_b_s : STD_LOGIC_VECTOR(3 DOWNTO 0); --
    
    SIGNAL video_on : STD_LOGIC;
    SIGNAL h_pos, v_pos : STD_LOGIC_VECTOR(10 DOWNTO 0);
    
    COMPONENT pattern_cntl
        PORT (
            video_on : IN STD_LOGIC;
            h_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            v_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            graph_r : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            graph_g : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            graph_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL clk_25M : STD_LOGIC;
BEGIN
    PROCESS (clk)
    BEGIN
        IF (clk'event AND clk = '1') THEN
            clk_25M <= NOT clk_25M;
            --clk_25M <= NOT clk_25M;
        END IF;
    END PROCESS;
    
    --- synchronous design methodology: 25-MHz enable tick
    vga : vga_sync
    PORT MAP(
        clk => clk_25M,
        rst => rst,  -- Connect the 'rst' port
        h_sync => VGA_HSYNC,
        v_sync => VGA_VSYNC,
        h_pos => h_pos,
        v_pos => v_pos,
        video_on => video_on
    );
    --------------------------------------------------------------------------
    -- function : display color patern
    pattern : pattern_cntl
    PORT MAP(
        video_on => video_on,
        h_pos => h_pos,
        v_pos => v_pos,
        graph_r => VGA_r_s,
        graph_g => VGA_g_s,
        graph_b => VGA_b_s);
        VGA_R <= VGA_r_s;
        VGA_G <= VGA_g_s;
        VGA_B <= VGA_b_s;
    ---
END vgadisp_arch;