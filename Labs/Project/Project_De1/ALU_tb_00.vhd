-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY ALU_tb_00 IS
  END ALU_tb_00;

  ARCHITECTURE behavior OF ALU_tb_00 IS 

  -- Component Declaration
          COMPONENT ALU
          PORT(
				clk_i 	: 	IN STD_LOGIC;
				num1_i	: 	IN	STD_LOGIC_VECTOR(3 downto 0);
				num2_i	: 	IN STD_LOGIC_VECTOR(3 downto 0);
				choice_i :	IN STD_LOGIC_VECTOR(3 downto 0);
				alu_test_o : OUT STD_LOGIC_VECTOR(7 downto 0)
                  );
          END COMPONENT;

				signal clk_i	:	STD_LOGIC := '0';
				signal num1_i 	: 	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
				signal num2_i 	: 	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
				signal choice_i :	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
				signal s_res : STD_LOGIC_VECTOR(7 downto 0);
				signal alu_test_o	:	STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

  BEGIN

  -- Component Instantiation
          uut: ALU PORT MAP(
						clk_i => clk_i,
                  num1_i => num1_i,
						num2_i => num2_i,
						choice_i => choice_i,
						alu_test_o => alu_test_o
          );


  --  Test Bench Statements
     tb : PROCESS
     BEGIN
			num1_i <= "0100";
			num2_i <= "0010";
			choice_i <= "0000";
        --wait for 100 ns; -- wait until global set/reset completes
			for i in 0 to 15 loop
					wait for 100 ns;
					choice_i <= STD_LOGIC_VECTOR(unsigned(choice_i) + 1);
			end loop;
        -- Add user defined stimulus here

			--wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
