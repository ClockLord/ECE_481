library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity WaveGen_tb is
end WaveGen_tb;

architecture Behavioral of WaveGen_tb is
    signal iCLK_tb, iRESET_tb : std_logic := '0';
    signal IEN_DAC_tb : std_logic := '1';
    signal Switch_tb : std_logic_vector(1 downto 0) := "01";
    signal oSYNC_L_tb, oDONE_DAC_tb, oBUSY_DAC_tb : std_logic;
    signal oSDATA_DAC_tb : std_logic := '0';
    signal DivClk_tb : std_logic;

    COMPONENT WaveGen
        Port (
            Switch : in std_logic_vector (1 downto 0);
            iCLK : in  std_logic;
            iRESET : IN  std_logic;
            iEN_DAC : IN  std_logic;
            oSYNC_L : OUT  std_logic;
            oSDATA_DAC : OUT  std_logic;
            oDONE_DAC : OUT  std_logic;
            oBUSY_DAC : OUT  std_logic;
            DivClk : Out std_logic  
        );
    end COMPONENT;

    constant Clock_Period : time := 40 ns; -- Adjust as needed
    constant Sim_Time : time := 500 ns;   -- Adjust as needed

begin

    UUT: WaveGen 
        port map (
            Switch => Switch_tb,
            iCLK => iCLK_tb,
            iRESET => iRESET_tb,
            iEN_DAC => iEN_DAC_tb,
            oSYNC_L => oSYNC_L_tb,
            oSDATA_DAC => oSDATA_DAC_tb,
            oDONE_DAC => oDONE_DAC_tb,
            oBUSY_DAC => oBUSY_DAC_tb
            --DivClk => DivClk_tb
        );

    CLK_Process: process
    begin
      --  while now < Sim_Time loop
            iCLK_tb <= '0';
            wait for Clock_Period / 2;
            iCLK_tb <= '1';
            wait for Clock_Period / 2;
    --    end loop;
    --    wait;
    end process;

 

end Behavioral;
