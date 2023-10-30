LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pattern_cntl IS
    PORT (
        video_on : IN STD_LOGIC;
        h_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        v_pos : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
        graph_r : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        graph_g : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        graph_b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END pattern_cntl;

ARCHITECTURE pattern_arch OF pattern_cntl IS
    CONSTANT E_v_0 : INTEGER := 200;
    CONSTANT E_v_1 : INTEGER := 210;
    CONSTANT E_v_2 : INTEGER := 250;
    CONSTANT E_v_3 : INTEGER := 260;
    CONSTANT E_v_4 : INTEGER := 300;
    CONSTANT E_v_5 : INTEGER := 310;
    CONSTANT E_h_0 : INTEGER := 100;
    CONSTANT E_h_1 : INTEGER := 110;
    CONSTANT E_h_2 : INTEGER := 200;
    CONSTANT E_h_3 : INTEGER := 250;
    CONSTANT E_h_4 : INTEGER := 260;
    CONSTANT E_h_5 : INTEGER := 350;
    CONSTANT E_h_6 : INTEGER := 400;
    CONSTANT E_h_7 : INTEGER := 410;
    CONSTANT E_h_8 : INTEGER := 500;
    SIGNAL Left_E_on, Right_E_on, Middle_C_on : STD_LOGIC;
    SIGNAL Left_E_r, Right_E_r, Middle_C_r : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Left_E_g, Right_E_g, Middle_C_g : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Left_E_b, Right_E_b, Middle_C_b : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL h_pos_int, v_pos_int : unsigned(10 DOWNTO 0);
    
BEGIN
    h_pos_int <= unsigned(h_pos);
    v_pos_int <= unsigned(v_pos);
    ---- LEFT E
    LEFT_E_on <= '1' WHEN((((E_h_0 <= h_pos_int) AND (h_pos_int <= E_h_1)) AND
        ((E_v_0 <= v_pos_int) AND (v_pos_int <= E_v_5))) OR(((E_h_1 <= h_pos_int) AND
        (h_pos_int <= E_h_2)) AND ((E_v_0 <= v_pos_int) AND (v_pos_int <= E_v_1)))
        OR (((E_h_1 <= h_pos_int) AND (h_pos_int <= E_h_2)) AND ((E_v_2 <= v_pos_int) AND
        (v_pos_int <= E_v_3))) OR (((E_h_1 <= h_pos_int) AND (h_pos_int <= E_h_2)) AND
        ((E_v_4 <= v_pos_int) AND (v_pos_int <= E_v_5)))) ELSE
        '0';
    LEFT_E_r <= "0000"; --blue VGA_RGB = X"001"
    LEFT_E_g <= "0000";
    LEFT_E_b <= "1111";
    --- MIDDLE C
    Middle_C_on <= '1' WHEN((((E_h_3 <= h_pos_int) AND (h_pos_int <= E_h_4)) AND
        ((E_v_0 <= v_pos_int) AND (v_pos_int <= E_v_5))) OR
        (((E_h_4 <= h_pos_int) AND (h_pos_int <= E_h_5)) AND ((E_v_0 <= v_pos_int) AND
        (v_pos_int <= E_v_1)))
        OR
        (((E_h_4 <= h_pos_int) AND (h_pos_int <= E_h_5)) AND ((E_v_4 <= v_pos_int) AND
        (v_pos_int <= E_v_5)))) ELSE
        '0';
    Middle_C_r <= "0000"; --green VGA_RGB = X"010"
    Middle_C_g <= "1111";
    Middle_C_b <= "0000";
    ---- LEFT E
    Right_E_on <= '1' WHEN((((E_h_6 <= h_pos_int) AND (h_pos_int <= E_h_7)) AND
        ((E_v_0 <= v_pos_int) AND (v_pos_int <= E_v_5))) OR
        (((E_h_7 <= h_pos_int) AND (h_pos_int <= E_h_8)) AND ((E_v_0 <= v_pos_int) AND
        (v_pos_int <= E_v_1)))
        OR
        (((E_h_7 <= h_pos_int) AND (h_pos_int <= E_h_8)) AND ((E_v_2 <= v_pos_int) AND
        (v_pos_int <= E_v_3)))
        OR
        (((E_h_7 <= h_pos_int) AND (h_pos_int <= E_h_8)) AND ((E_v_4 <= v_pos_int) AND
        (v_pos_int <= E_v_5)))) ELSE
        '0';
    Right_E_r <= "1111"; --red VGA_RGB = X"100"
    Right_E_g <= "0000";
    Right_E_b <= "0000";
    PROCESS (video_on, Left_E_on, Right_E_on, Middle_C_on, Left_E_r,
        Right_E_r, Middle_C_r, Left_E_g, Right_E_g, Middle_C_g, Left_E_b, Right_E_b, Middle_C_b)
    BEGIN
        IF (video_on = '0') THEN
            --black VGA_RGB = X"000"
            graph_r <= "0000";
            graph_g <= "0000";
            graph_b <= "0000";
        ELSE
            IF (Left_E_on = '1') THEN
                graph_r <= Left_E_r;
                graph_g <= Left_E_g;
                graph_b <= Left_E_b;
            ELSIF (Middle_C_on = '1') THEN
                graph_r <= Middle_C_r;
                graph_g <= Middle_C_g;
                graph_b <= Middle_C_b;
            ELSIF (Right_E_on = '1') THEN
                graph_r <= Right_E_r;
                graph_g <= Right_E_g;
                graph_b <= Right_E_b;
            ELSE
                -- yellow VGA_RGB = X"110" background
                graph_r <= "1111";
                graph_g <= "1111";
                graph_b <= "0000";
            END IF;
        END IF;
    END PROCESS;
END pattern_arch;