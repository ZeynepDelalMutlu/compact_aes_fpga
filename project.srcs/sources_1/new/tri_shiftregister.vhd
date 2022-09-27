----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2020 04:28:05 PM
-- Design Name: 
-- Module Name: tri_shiftregister - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tri_shiftregister is
    Port ( input_trishiftreg : in STD_LOGIC_VECTOR (31 downto 0);
           --new_register : in STD_LOGIC;
           output_trishiftreg : out STD_LOGIC_VECTOR(31 downto 0));
end tri_shiftregister;

architecture Behavioral of tri_shiftregister is
    --each row;
    signal first : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
    signal second : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
    signal third : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";

begin

--process(new_register)
--begin
--if(rising_edge(new_register))then
output_trishiftreg <= first;
first <= second;
second <= third;
third <= input_trishiftreg;
--end if;
--end process;                
     
end Behavioral;
