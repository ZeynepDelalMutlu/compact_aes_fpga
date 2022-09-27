----------------------------------------------------------------------------------
-- Company: Tobb University
-- Engineer: Zeynep Delal Mutlu
-- 
-- Create Date: 08/07/2020 09:25:56 AM
-- Design Name: Key Sechedule
-- Module Name: Key_Schedule - Behavioral
-- Project Name: Compact AES Encryption and 
--              Decryption Algorithm on FPGA
-- Target Devices: Zedboard
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

entity Key_Schedule is
    Port ( clk : in STD_LOGIC;
           --init : in STD_LOGIC;
           input32 : in STD_LOGIC_VECTOR (31 downto 0);
           output32 : out STD_LOGIC_VECTOR (31 downto 0));
end Key_Schedule;

architecture Behavioral of Key_Schedule is
component rot is
    Port ( input_rot : in STD_LOGIC_VECTOR (31 downto 0);
           output_rot : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component subbytes is
    Port ( input_subbytes : in STD_LOGIC_VECTOR (31 downto 0);
           output_subbytes : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component tri_shiftregister is
    Port ( input_trishiftreg : in STD_LOGIC_VECTOR (31 downto 0);
           output_trishiftreg : out STD_LOGIC_VECTOR (31 downto 0));
end component;

--function rcon(cnt : integer range 1 to 10)
--    return std_logic_vector is
--begin
--    case cnt is
--        when 1 => return "00000001000000000000000000000000";
--        when 2 => return "00000010000000000000000000000000";
--        when 3 => return "00000100000000000000000000000000";
--        when 4 => return "00001000000000000000000000000000";
--        when 5 => return "00010000000000000000000000000000";
--        when 6 => return "00100000000000000000000000000000";
--        when 7 => return "01000000000000000000000000000000";
--        when 8 => return "10000000000000000000000000000000";
--        when 9 => return "00011011000000000000000000000000";
--        when 10 => return "00110110000000000000000000000000";
--    end case;
--end function rcon;

signal input_rot_process : STD_LOGIC_VECTOR (31 downto 0);
signal output_rot_process : STD_LOGIC_VECTOR (31 downto 0);

--signal input_subbytes_process : STD_LOGIC_VECTOR (31 downto 0);
signal output_subbytes_process : STD_LOGIC_VECTOR (31 downto 0);

signal input_trishiftreg_process : STD_LOGIC_VECTOR (31 downto 0);
--signal new_register_process : STD_LOGIC;
signal output_trishiftreg_process : STD_LOGIC_VECTOR (31 downto 0);


begin               
--rot1: rot port map( input_rot => input_rot_process,
--                    output_rot => output_rot_process);
                                                     
--sub1: subbytes port map(input_subbytes => output_rot_process,
--                        output_subbytes => output_subbytes_process);
rot1: rot port map(input_rot_process, output_rot_process);
                                                                     
sub1: subbytes port map(input_subbytes => output_rot_process, output_subbytes => output_subbytes_process);                                          
tri1: tri_shiftregister port map(input_trishiftreg => input_trishiftreg_process,
                                 output_trishiftreg => output_trishiftreg_process);
                                 
process(clk)
    variable counter : integer range 1 to 44 := 1;
    variable which32bit : integer range 1 to 4 := 1;
    variable rconbits : STD_LOGIC_VECTOR(31 downto 0); 
    --variable rconbits : STD_LOGIC_VECTOR(31 downto 0);
    variable processed32bit : STD_LOGIC_VECTOR (31 downto 0);

begin
    if(rising_edge(clk))then
        if(counter < 4)then -- First three 32 bit.
            processed32bit := input32; -- This 32-bit input must be processed.
            input_trishiftreg_process <= processed32bit;
            output32 <= processed32bit;
        
        else
            if(counter = 4 or counter = 8 or counter = 12 or counter = 16 or counter = 20
            or counter = 24 or counter = 28 or counter = 32 or counter = 36 or counter =40 or counter=44)then --bitorder = 4, just fourth 32-bits iput is processing.
                if(counter = 4)then
                    processed32bit := input32;
                end if;
                                input_rot_process <= processed32bit;


                input_trishiftreg_process <= processed32bit;
                output32 <= processed32bit;
                case counter is
                        when 4 => rconbits := "00000001000000000000000000000000";
                        when 8 => rconbits := "00000010000000000000000000000000";
                        when 12 => rconbits := "00000100000000000000000000000000";
                        when 16 => rconbits := "00001000000000000000000000000000";
                        when 20 => rconbits := "00010000000000000000000000000000";
                        when 24 => rconbits := "00100000000000000000000000000000";
                        when 28 => rconbits := "01000000000000000000000000000000";
                        when 32 => rconbits := "10000000000000000000000000000000";
                        when 36 => rconbits := "00011011000000000000000000000000";
                        when 40 => rconbits := "00110110000000000000000000000000";
                        when others => rconbits := "00110110000000000000000000000000";

                end case;
                processed32bit := output_trishiftreg_process xor rconbits;-- xor output_subbytes_process;
              
              --processed32bit := processed32bit xor output_subbytes_process;
            else --First, second and third 32-bits iputs are processing.
                input_trishiftreg_process <= processed32bit;
                output32 <= processed32bit;
                processed32bit := processed32bit xor output_trishiftreg_process;
            end if;
        end if;
        
        counter := counter + 1;

    end if;
end process;
end Behavioral;
