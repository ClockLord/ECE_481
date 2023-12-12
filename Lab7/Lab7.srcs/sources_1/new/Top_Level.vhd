library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FFT_Spectrum_Analysis is
  Port (
    clk      : in  std_logic;
    reset    : in  std_logic;
    DataReady: in  std_logic;
    fft_out  : out std_logic_vector(31 downto 0)
  );
end FFT_Spectrum_Analysis;

architecture Behavioral of FFT_Spectrum_Analysis is

    constant Resolution : INTEGER := 12; -- Resolution of the sine wave lookup table
    signal flag : std_logic := '0'; -- Flag to indicate some condition (not used in the provided code)
    signal BuffCount : integer := 0; -- Counter to index the sine_table
    signal temp : std_logic_vector(31 downto 0); -- Temporary signal (not used in the provided code)

    type LUT is array (0 to Resolution) of std_logic_vector(31 downto 0);

    constant sine_table: LUT := (
        "00000000000000000000000000000000", -- 0.0
        "00010101010101010101010101010101", -- pi/6
        "00101010101010101010101010101010", -- pi/3
        "01000000000000000000000000000000", -- pi/2
        "01001010101010101010101010101010", -- 2*pi/3
        "01010101010101010101010101010101", -- 5*pi/6
        "01101110110110011110101110100001", -- pi
        "01111111111111111111111111111111", -- 7*pi/6
        "10001010101010101010101010101010", -- 4*pi/3
        "11000000000000000000000000000000", -- 3*pi/2
        "11010101010101010101010101010101", -- 5*pi/3
        "11101010101010101010101010101010", -- 11*pi/6
        "11111111111111111111111111111111"  -- 2*pi
    );
    
begin
  
    fftFlagCheck : process
    begin
        if rising_edge(clk) then
       
            if DataReady = '1' then
                -- Each time the flag is ready, output the value from the sine_table
                fft_out <= sine_table(BuffCount);
                BuffCount <= BuffCount + 1;
                
                -- Reset BuffCount if it reaches the resolution
                if BuffCount = Resolution then
                    BuffCount <= 0;
                end if;
            end if;
            
            -- Additional logic with the 'flag' and 'temp' signals (not used in the provided code)
            
        end if;
    end process;

end Behavioral;
