----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:55:27 04/27/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	generic (
		constant move: natural := 1
	);
	
	Port (
		num1_i	: 	STD_LOGIC_VECTOR(3 downto 0);
		num2_i	:	STD_LOGIC_VECTOR(3 downto 0);
		choice_i :	STD_LOGIC_VECTOR(3 downto 0);
		alu_o		:	out STD_LOGIC_VECTOR(7 downto 0);
		carry_o	:	out STD_LOGIC
	);
end ALU;
	
architecture Behavioral of ALU is
		signal s_res : STD_LOGIC_VECTOR(7 downto 0);
		signal s_out : STD_LOGIC_VECTOR(8 downto 0);
begin
		process(num1_i, num2_i, choice_i)
		begin
			case(choice_i) is
			--Aritmetical functions
				when "0000" =>
					s_res <= num1_i + num2_i;
				when "0001" =>
					s_res <= num1_i - num2_i;
				when "0010" =>
					s_res <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(num1_i)) * to_integer(unsigned(num2_i))),8));	
				when "0011" =>
					s_res <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(num1_i)) / to_integer(unsigned(num2_i))),8));	
				when "0100" =>
					s_res <= num1_i + 1;
				when "0101" =>
					s_res <= num2_i + 1;
				when "0110" =>
					s_res <= num1_i - 1;
				when "0111" =>
					s_res <= num2_i - 1;
				--Logical functions
				when "1000" =>
					s_res <= num1_i AND num2_i;			
				when "1001" =>
					s_res <= num1_i NAND num2_i;
				when "1010" =>
					s_res <= num1_i OR num2_i;
				--BitWise functions
				when "1011" =>
					s_res <= STD_LOGIC_VECTOR(unsigned(num1_i) sll move);
				when "1100" =>
					s_res <= STD_LOGIC_VECTOR(unsigned(num2_i) sll move);
				when "1101" =>
					s_res <= STD_LOGIC_VECTOR(unsigned(num1_i) srl move);
				when "1110" =>
					s_res <= STD_LOGIC_VECTOR(unsigned(num2_i) srl move);
				--Comparisons
				when "1111" =>
					if(num1_i > num2_i) then
						s_res <= num1_i;
					else
						s_res <= num2_i;
					end if;
				when others => s_res <= num1_i + num2_i;
				end case;
			end process;
			alu_o <= s_res;
			s_out <= ('0' & num1_i) + ('0' & num2_i);
			carry_o <= s_out(8);
end Behavioral;

