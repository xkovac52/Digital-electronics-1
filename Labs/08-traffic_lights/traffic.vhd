library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic is
	port (	clk_i: in STD_LOGIC;
    		clr_i: in STD_logic;
			ce_2Hz_i : IN  std_logic;
            	lights_o: out unsigned(5 downto 0));
end traffic;


architecture traffic of traffic is
    
    --G is for green, Y is for yellow, R is for Red
    type state_type is (s_GR, s_YR, s_RR1, s_RG, s_RY, s_RR2);
    signal s_state: state_type;
    signal s_count: unsigned (3 downto 0);
    constant SEC5: unsigned (3 downto 0) := "1111";
    constant SEC1: unsigned (3 downto 0) := "0011";
    begin
    process(clk_i, clr_i)
    begin
    

		if clr_i = '0' then 
        			s_state <= s_GR;
                    s_count <= x"0";
        elsif rising_edge(clk_i) and ce_2Hz_i = '1' then
        case s_state is
        	when s_GR =>
            	if s_count < SEC5 then
                	s_state <= s_GR;
                    s_count <= s_count + 1;
                else
                	s_state <= s_YR;
                    s_count <= x"0";
                    end if;
             when s_YR =>
            	if s_count < SEC1 then
                	s_state <= s_YR;
                    s_count <= s_count + 1;
                else
                	s_state <= s_RR1;
                    s_count <= x"0";
                    end if;
              when s_RR1 =>
            	if s_count < SEC1 then
                	s_state <= s_RR1;
                    s_count <= s_count + 1;
                else
                	s_state <= s_RG;
                    s_count <= x"0";
                    end if;
             when s_RG =>
            	if s_count < SEC5 then
                	s_state <= s_RG;
                    s_count <= s_count + 1;
                else
                	s_state <= s_RY;
                    s_count <= x"0";
                    end if;
             when s_RY =>
            	if s_count < SEC1 then
                	s_state <= s_RY;
                    s_count <= s_count + 1;
                else
                	s_state <= s_RR2;
                    s_count <= x"0";
                    end if;
             when s_RR2 =>
            	if s_count < SEC1 then
                	s_state <= s_RR2;
                    s_count <= s_count + 1;
                else
                	s_state <= s_GR;
                    s_count <= x"0";
                end if;
           	when others =>
            			s_state <= s_GR;
		end case;
  	end if;
end process;

C2: process (s_state)
begin
case s_state is
		when s_GR => lights_o <= "100001";
        when s_YR => lights_o <= "100010";
        when s_RR1 => lights_o <= "100100";
        when s_RG => lights_o <= "001100";
        when s_RY => lights_o <= "010100";
        when s_RR2 => lights_o <= "100100";
        when others => lights_o <= "100001";
	end case;
end process;
end traffic;