

----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11/12/2023 07:51:55 PM
-- Design Name:
-- Module Name: WaveGen - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--Create a component that is the DAC controller
--Based on what switch is pressed
--give the DAC controller the correct LUT
    -- in order to do that you will need to make a counter


entity WaveGen is
  Port (
    Switch : in std_logic_vector (1 downto 0);
    iCLK : in  STD_LOGIC;
    iRESET : IN  std_logic;
    iEN_DAC : IN  std_logic;
    oSYNC_L : OUT  std_logic;
    oSDATA_DAC : OUT  std_logic;
    oDONE_DAC : OUT  std_logic;
    oBUSY_DAC : OUT  std_logic
    --DivClk : Out std_logic  --just for simulation purposes
  );
end WaveGen;

architecture Behavioral of WaveGen is

COMPONENT DAC_controller
    PORT(
         iRESET : IN  std_logic;
         iCLK : IN  std_logic;
         iEN_DAC : IN  std_logic;
         iDAC_DATA_V : IN  std_logic_vector(11 downto 0);
         oSYNC_L : OUT  std_logic;
         oSDATA_DAC : OUT  std_logic;
         oDONE_DAC : OUT  std_logic;
         oBUSY_DAC : OUT  std_logic
        );
    END COMPONENT;
   
constant Resolution : INTEGER := 15;
type LUT is array (0 to Resolution) of std_logic_vector(11 downto 0);

constant sine_table: LUT := (
    "011111111111", "110000000000", "111011111111", "111111110000",
    "111111111111", "111111111111", "111111111111", "111111110000",
    "111011111111", "110000000000", "011111111111", "001011110100",
    "000110101111", "000011110100", "000001111010", "000000110011"
);

constant triangle_table: LUT := (
    "000000000000", "001010101010", "010101010101", "011111111111",
    "101010101010", "110101010101", "111111111111", "100000000000",
    "011111111111", "010101010101", "001010101010", "000000000000",
    "111111111111", "110101010101", "101010101010", "100000000000"
);

constant sawtooth_table: LUT := (
    "000000000000", "000111111111", "001111111111", "010111111111",
    "011111111111", "100111111111", "101111111111", "110111111111",
    "111111111111", "000111111111", "001111111111", "010111111111",
    "011111111111", "100111111111", "101111111111", "110111111111"
);

constant rectangular_table: LUT := (
    "111111111111", "111111111111", "111111111111", "111111111111",
    "111111111111", "000000000000", "000000000000", "000000000000",
    "000000000000", "111111111111", "111111111111", "111111111111",
    "111111111111", "000000000000", "000000000000", "000000000000"
);

signal DAC_DATA_Buff : STD_LOGIC_VECTOR (11 downto 0);    --signal to store the values that we pass to the controller
signal ClkDiv : std_logic := '0'; --clkDivided signal
signal ClkDivMax : INTEGER := 30000000; 
signal ClkCount : INTEGER := 0;
signal BuffCount : integer :=0;

signal DONE_DAC_temp : std_logic := '0';

begin
 WaveGen_cntrl: DAC_controller PORT MAP (
      iRESET => iRESET,
      iCLK => iCLK, --DAC works at maximum 30M clock
      iEN_DAC => iEN_DAC,
      iDAC_DATA_V => DAC_DATA_Buff, --pass the controller data from the buffer
      oSYNC_L => oSYNC_L,
      oSDATA_DAC => oSDATA_DAC,
      oDONE_DAC => DONE_DAC_temp,
      oBUSY_DAC => oBUSY_DAC    
        );
        
        
oDONE_DAC <= DONE_DAC_temp;--temporary variable to store output of the Done Flag

CLK_Divider:process(iCLK, iRESET) --implement clk divider circuit for the ADC needs 30Mhz clk
  begin
    if rising_edge(iCLK) then
        ClkCount <= ClkCount +1;
            if ClkCount >= ClkDivMax then --what triggers during the falling edge of clkDiv
                clkCount <= 0;
                ClkDiv <= not ClkDiv;
               -- DivClk <= ClkDiv; --just for simulation purposes
            end if;  
    end if;
    
    if rising_edge(ClkDiv) then --implement counter to go through LUT
        BuffCount <= BuffCount +1;
            if BuffCount >= Resolution then --loop througn
                BuffCount <=0;
            end if;
    end if;
end process;

 WaveSelect:process(iclk)
  begin
  if rising_edge(iclk) then
    if Switch = "00" then   --Sin Wave
       
      if DONE_DAC_temp = '1' then
             DAC_DATA_Buff <= sine_table(BuffCount);
      end if;
      
  end if;
  if rising_edge(iclk) then
    elsif Switch = "01" then --Triangle Wave
      
      if DONE_DAC_temp = '1' then
            DAC_DATA_Buff <= triangle_table(BuffCount);
      end if;
  
  end if;
  if rising_edge(iclk) then    
    elsif Switch = "10" then --Sawtooth Wave
      
      if DONE_DAC_temp = '1' then
            DAC_DATA_Buff <= sawtooth_table(BuffCount);
      end if;
  end if;
  if rising_edge(iclk) then
    elsif Switch = "11" then --Rectanglar Wave
    
        if DONE_DAC_temp ='1' then
            DAC_DATA_Buff <= Rectangular_table(BuffCount);
        end if;
    end if;
  end if;
  end process WaveSelect;

end Behavioral;