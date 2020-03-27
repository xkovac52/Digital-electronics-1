--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:55:43 03/26/2020
-- Design Name:   
-- Module Name:   C:/Digital-electronics-1/Labs/08-traffic_lights/traffic_lights/traffic_top_tb00.vhd
-- Project Name:  traffic_lights
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: traffic
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT traffic
    PORT(
         clk_i : IN  std_logic;
         clr_i : IN  std_logic;
         ce_2Hz_i : IN  std_logic;
         lights_o : OUT  unsigned(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';
   signal clr_i : std_logic := '0';
   signal ce_2Hz_in : std_logic := '0';

 	--Outputs
   signal lights_out : unsigned(5 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: traffic PORT MAP (
          clk_i => clk_in,
          clr_i => clr_i,
          ce_2Hz_i => ce_2Hz_in,
          lights_o => lights_out
        );
		  
		Clk_gen: process	
  	begin
    	while Now < 500 nS loop
      		clk_in <= '0';
      		wait for 0.5 NS;
      		clk_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_gen;
	
	
	Clk_2Hz_gen: process	
  	begin
    	while Now < 500 nS loop
      		ce_2Hz_in <= '0';
      		wait for 1.5 NS;
      		ce_2Hz_in <= '1';
      		wait for 0.5 NS;
    	end loop;
    	wait;
  	end process Clk_2Hz_gen;

   -- Clock process definitions
   --clk_i_process :process
   --begin
	--	clk_i <= '0';
	--	wait for clk_i_period/2;
	--	clk_i <= '1';
	--	wait for clk_i_period/2;
   --end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
		clr_i <= '0';
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      wait until rising_edge(clk_in);
      clr_i <= '1';
      

      wait;
   end process;

END behavior;