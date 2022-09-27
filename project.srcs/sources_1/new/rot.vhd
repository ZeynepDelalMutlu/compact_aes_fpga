----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/07/2020 09:28:34 AM
-- Design Name: 
-- Module Name: rot - Behavioral
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
library work;
use work.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rot is
    Port ( input_rot : in STD_LOGIC_VECTOR (31 downto 0);
           output_rot : out STD_LOGIC_VECTOR (31 downto 0));
end rot;

architecture Behavioral of rot is
    signal rotated32bit : STD_LOGIC_VECTOR(31 downto 0);
begin

    rotated32bit(31 downto 0) <= input_rot(7 downto 0) & input_rot(31 downto 8);
    output_rot <= rotated32bit;

end Behavioral;

