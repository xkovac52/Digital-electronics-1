-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT ALU
          PORT(
				num1_i	: 	IN	STD_LOGIC_VECTOR(3 downto 0);
				num2_i	: 	IN STD_LOGIC_VECTOR(3 downto 0);
				choice_i :	IN STD_LOGIC_VECTOR(3 downto 0)
                  );
          END COMPONENT;

				signal num1_i 	: 	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
				signal num2_i 	: 	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
				signal choice_i :	STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

  BEGIN

  -- Component Instantiation
          uut: ALU PORT MAP(
                  num1_i => num1_i,
						num2_i => num2_i,
						choice_i => choice_i
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
					choice_i <= choice_i +1;
					num1_i <= num1_i + 1;
					num2_i <= num2_i + 1;
			end loop;
        -- Add user defined stimulus here
			num1_i <= "0110";
			num2_i <= "1010";
			--wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
