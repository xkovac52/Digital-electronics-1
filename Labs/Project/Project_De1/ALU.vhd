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
use IEEE.math_real.all;
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
		--Input for setting numbers/choosing with operation we want to use
		clk_i	:	in STD_LOGIC;
		num1_i	: 	in STD_LOGIC_VECTOR(3 downto 0);
		num2_i	:	in STD_LOGIC_VECTOR(3 downto 0);
		choice_i :	in STD_LOGIC_VECTOR(3 downto 0);
		--Output to send to 7seg display
		alu_disp_1_o	:	out STD_LOGIC_VECTOR(3 downto 0); -- Used for displaying Hundreds
		alu_disp_2_o	:	out STD_LOGIC_VECTOR(3 downto 0); -- Used for displaying Tens
		alu_disp_3_o	:	out STD_LOGIC_VECTOR(3 downto 0)  -- Used for displaying Ones
	);
end ALU;
	
architecture Behavioral of ALU is
		signal s_res : STD_LOGIC_VECTOR(7 downto 0); --The 8bit result of our mathematical operation
		signal s_res_int	:  integer; --Convertion of binary number to integer for BCD calculation
		signal s_digit_calc	:  integer; --The calculation of the amout of times hundreds/tens/ones are in a number
begin
		p_calculation	:	process(num1_i, num2_i, choice_i, s_res, s_res_int, s_digit_calc)
		begin
			if rising_edge(clk_i) then
				case(choice_i) is
				--Aritmetical functions
				when "0000" => -- Add A to B
					s_res <= num1_i + num2_i;
				when "0001" => -- Substracting B from A
					s_res <= num1_i - num2_i;
				when "0010" => --Multiplying A by B
					s_res <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(num1_i)) * to_integer(unsigned(num2_i))),8));	
				when "0011" => --Dividing A with B
					s_res <= STD_LOGIC_VECTOR(to_unsigned((to_integer(unsigned(num1_i)) / to_integer(unsigned(num2_i))),8));	
				when "0100" => --Incrementing A by one
					s_res <= num1_i + 1;
				when "0101" => --Incrementing B by one
					s_res <= num2_i + 1;
				when "0110" => --Decrementing A by one
					s_res <= num1_i - 1;
				when "0111" => --Decrementing A by one
					s_res <= num2_i - 1;
				--Logical functions
				when "1000" => --A and B
					s_res <= num1_i AND num2_i;			
				when "1001" => -- A or B
					s_res <= num1_i OR num2_i;
				when "1010" => -- A xor B
					s_res <= num1_i XOR num2_i;
				--BitWise functions
				when "1011" => --Moving the bits of A to the left for example from 0001 to 0010
					s_res <= STD_LOGIC_VECTOR(unsigned(num1_i) sll move);
				when "1100" => --Moving the bits of B to the left
					s_res <= STD_LOGIC_VECTOR(unsigned(num2_i) sll move);
				when "1101" => --Moving the bits of A to the right for example from 0010 to 0001
					s_res <= STD_LOGIC_VECTOR(unsigned(num1_i) srl move);
				when "1110" => --Moving the bits of B to the right
					s_res <= STD_LOGIC_VECTOR(unsigned(num2_i) srl move);
				--Comparisons
				when "1111" => --Comparing A to B and writing the bigger one into the result
					if(num1_i > num2_i) then
						s_res <= num1_i;
					else
						s_res <= num2_i;
					end if;
				when others => s_res <= num1_i + num2_i;--The default calculation if all switches are off
			end case;
			--A basic binary to BCD convertor
			--Calculating the number for the First Display (first digit: Hundreds)
			s_res_int <= to_integer(signed(s_res)); --Converting binary numbers into integer
			s_digit_calc <= FLOOR(s_res_int / 100); --Calculating the number of Hundreds and rounding down the final number
			alu_disp_1_o <= STD_LOGIC_VECTOR(s_digit_calc); --Converting integer back to binary so the 7seg can display the number
			s_res_int <= s_res_int - s_digit_calc * 100; --Removing the hundreds from the number so the cant be more then 9 tens
			--Calculating the number for the Second Display (second digit: tens)
			s_res_int <= to_integer(signed(s_res));
			s_digit_calc <= FLOOR(s_res_int / 10);
			alu_disp_2_o <= STD_LOGIC_VECTOR(s_digit_calc);
			s_res_int <= s_res_int - s_digit_calc * 10;
			--Calculating the number for the Third Display (third digit: ones)
			s_res_int <= to_integer(signed(s_res));
			s_digit_calc <= FLOOR(s_res_int / 1);
			alu_disp_3_o <= STD_LOGIC_VECTOR(s_digit_calc);
		end if;	
	end process p_calculation;		
			
end Behavioral;

