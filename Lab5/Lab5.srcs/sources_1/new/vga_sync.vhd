LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY vga_sync IS  --where is the clcok divider implemented
    PORT (
        clk, rst : IN STD_LOGIC;  -- Added the 'reset' port
        h_sync, v_sync : OUT STD_LOGIC;
        video_on, p_tick : OUT STD_LOGIC;
        h_pos, v_pos : OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
    );
END vga_sync;

ARCHITECTURE arch OF vga_sync IS
    -- VGA 640-by-480 sync parameters
    CONSTANT HD : INTEGER := 640; --horizontal display area
    CONSTANT HF : INTEGER := 16; --h. front porch
    CONSTANT HB : INTEGER := 48; --h. back porch
    CONSTANT HR : INTEGER := 96; --h. retrace
    CONSTANT VD : INTEGER := 480; --vertical display area
    CONSTANT VF : INTEGER := 10; --v. front porch
    CONSTANT VB : INTEGER := 33; --v. back porch
    CONSTANT VR : INTEGER := 2; --v. retrace
    -- mod-2 counter
    SIGNAL mod2_reg, mod2_next : STD_LOGIC; --this is where the clock divider is implemented
    -- sync counters
    SIGNAL v_count_reg, v_count_next : unsigned(10 DOWNTO 0);
    SIGNAL h_count_reg, h_count_next : unsigned(10 DOWNTO 0);
    -- output buffer
    SIGNAL v_sync_reg, h_sync_reg : STD_LOGIC;
    SIGNAL v_sync_next, h_sync_next : STD_LOGIC;
    -- status signal
    SIGNAL h_end, v_end, pixel_tick : STD_LOGIC;
BEGIN
    -- registers
    PROCESS (clk, rst)  --state machine
    BEGIN
        IF rst = '1' THEN
            mod2_reg <= '0';
            v_count_reg <= (OTHERS => '0');
            h_count_reg <= (OTHERS => '0');
            v_sync_reg <= '0';
            h_sync_reg <= '0';
            
        ELSIF (clk'event AND clk = '1') THEN --rising edge of the clock
            mod2_reg <= mod2_next;
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
            v_sync_reg <= v_sync_next;
            h_sync_reg <= h_sync_next;
        END IF;
        
    END PROCESS;
    -- mod-2 circuit to generate 25 MHz enable tick
    mod2_next <= NOT mod2_reg;
    mod2_next <= NOT mod2_reg;
    -- 25 MHz pixel tick
    pixel_tick <= '1' WHEN mod2_reg = '1' ELSE
        '0';
    -- status
    h_end <= -- end of horizontal counter
        '1' WHEN h_count_reg = (HD + HF + HB + HR - 1) ELSE --799
        '0';
    v_end <= -- end of vertical counter
        '1' WHEN v_count_reg = (VD + VF + VB + VR - 1) ELSE --524
        '0';
    -- mod-800 horizontal sync counter
    PROCESS (h_count_reg, h_end, pixel_tick)
    BEGIN
        IF pixel_tick = '1' THEN -- 25 MHz tick
            IF h_end = '1' THEN
                h_count_next <= (OTHERS => '0');
            ELSE
                h_count_next <= h_count_reg + 1;
            END IF;
        ELSE
            h_count_next <= h_count_reg;
        END IF;
    END PROCESS;
    -- mod-525 vertical sync counter
    PROCESS (v_count_reg, h_end, v_end, pixel_tick)
    BEGIN
        IF pixel_tick = '1' AND h_end = '1' THEN
            IF (v_end = '1') THEN
                v_count_next <= (OTHERS => '0');
            ELSE
                v_count_next <= v_count_reg + 1;
            END IF;
        ELSE
            v_count_next <= v_count_reg;
        END IF;
    END PROCESS;
    -- horizontal and vertical sync, buffered to avoid glitch
    h_sync_next <=
        '1' WHEN (h_count_reg >= (HD + HF)) --656
        AND (h_count_reg <= (HD + HF + HR - 1)) ELSE --751
        '0';
    v_sync_next <=
        '1' WHEN (v_count_reg >= (VD + VF)) --490
        AND (v_count_reg <= (VD + VF + VR - 1)) ELSE --491
        '0';
    -- video on/off
    video_on <=
        '1' WHEN (h_count_reg < HD) AND (v_count_reg < VD) ELSE
        '0';
    -- output signal
    h_sync <= h_sync_reg;
    v_sync <= v_sync_reg;
    h_pos <= STD_LOGIC_VECTOR(h_count_reg);
    v_pos <= STD_LOGIC_VECTOR(v_count_reg);
    p_tick <= pixel_tick;
    
END arch;