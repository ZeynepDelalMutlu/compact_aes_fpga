----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2020 17:41:07
-- Design Name: 
-- Module Name: led_brightness_tb - Behavioral
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

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is
    constant clk_period : time :=100 ns;
    signal clk : STD_LOGIC;
    --signal init : STD_LOGIC;
    signal input32 : STD_LOGIC_VECTOR (31 downto 0);
    --signal addr_ram : integer range 1 to 44;
    signal output32 : STD_LOGIC_VECTOR (31 downto 0);
    --signal write_ram : STD_LOGIC;

begin

process
begin
   clk <= '1';
   wait for clk_period/2;
   clk <= '0';
   wait for clk_period/2;
end process;

process
begin
    --init <= '1';
    wait for 100 ns;
    input32 <= "00000000000000000000000011000000";
    wait for 100 ns;
    input32 <= "00000000000000000000000000000011";
    wait for 100 ns;
    input32 <= "00000000000000000000000000001100";
    wait for 100 ns;
    input32 <= "00000000000000000000000000110000";
    wait for 100 ns;
    --init <= '0';
    wait for 3500 ns;
    
  wait;
end process; 

KS :  entity work.Key_Schedule
        port map (  clk  => clk,
                    --init => init,
                    input32 => input32,
                    --addr_ram => addr_ram,
                    output32 => output32);
                    --write_ram  => write_ram);
end Behavioral;
