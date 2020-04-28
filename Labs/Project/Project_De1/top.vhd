----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:31:36 04/28/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
port (
	--10 kHz clock signal
	clk_i	:	in STD_LOGIC;
	--For the first 4 bit number
	SW0_CPLD, SW1_CPLD, SW2_CPLD, SW3_CPLD	:	IN STD_LOGIC;
	--For the second 4 bit number
	SW4_CPLD, SW5_CPLD, SW6_CPLD, SW7_CPLD	:	IN STD_LOGIC;
	--For chosing what operation should be made
	SW8_CPLD, SW9_CPLD, SW10_CPLD, SW11_CPLD	:	IN STD_LOGIC;
	
	disp_seg_o	:	out	STD_LOGIC_VECTOR(7-1 downto 0);
	disp_dig_o	:	out	STD_LOGIC_VECTOR(4-1 downto 0)
);
end top;

architecture Behavioral of top is
	signal s_num1, s_num2	:	STD_LOGIC_VECTOR(4-1 downto 0);
	signal s_choice	:	STD_LOGIC_VECTOR(4-1 downto 0);
	signal s_result	:	STD_LOGIC_VECTOR(4-1 downto 0);
	signal s_num_hun_o, s_num_ten_o, s_num_one_o	:	STD_LOGIC_VECTOR(3 downto 0);
begin
	--Setting number 1
	s_num1(0) <= SW0_CPLD;
	s_num1(1) <= SW1_CPLD;
	s_num1(2) <= SW2_CPLD;
	s_num1(3) <= SW3_CPLD;
	--Setting number 2
	s_num2(0) <= SW4_CPLD;
	s_num2(1) <= SW5_CPLD;
	s_num2(2) <= SW6_CPLD;
	s_num2(3) <= SW7_CPLD;
	--Setting operation choice
	s_choice(0) <= SW8_CPLD;
	s_choice(1) <= SW9_CPLD;
	s_choice(2) <= SW10_CPLD;
	s_choice(3) <= SW11_CPLD;

--Sub-block of Clock enable
Clock_Enable	:	entity work.clock_enable
generic map (
	g_NPERIOD => x"0100"
)
port map (
	clk_i => clk_i,
	clock_enable_o => s_en
);
--Sub-block of Arithetical Logical Unit
ALU	:	entity work.ALU
port map (
	clk_i => clk_i,
	num1_i => s_num1,
	num2_i => s_num2,
	choice_i => s_choice,
	alu_disp_1_o => s_num_hun_o,
	alu_disp_2_o => s_num_ten_o,
	alu_disp_3_o => s_num_one_o
);
--Sub-block of Driver 7 segment
DRIVER_7SEG	:	entity work.driver_7seg
port map(
	clk_i <= clk_i,
	data3_i => "0000",
	data2_i => s_num_hun_o,
	data1_i => s_num_ten_o,
	data0_i => s_num_one_o,
	dp_i => "1111",
	seg_o => disp_seg_o,
	dig_o => disp_dig_o
);
end Behavioral;

