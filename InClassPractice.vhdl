
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- this entity is kindoff like a class object. It is essentially a blueprint of a circuit
entity Test is 

--the port is where you define your inputs and outputs of the circuit
    port(

    );

end Test

--the architecture defines the behavior of the circuit.
architecture behavior of Test is

    --begin signifies the start of the executable part of the VHDL code and is typically paired with an end keyword to define the scope of the code.
    begin
        process(clk)
        begin

        end process;


end behavior