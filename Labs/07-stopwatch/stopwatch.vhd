library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- Provides unsigned numerical computation
use ieee.std_logic_unsigned.all;

------------------------------------------------------------------------
------------------------------------------------------------------------
entity stopwatch is
port (
    clk_i    	: in  std_logic;
    srst_n_i	: in  std_logic;   -- Synchronous reset (active low)
    ce_100Hz_i	: in  std_logic;   -- Enable
    cnt_en_i	: in  std_logic;
    
    sec_h_o : out std_logic_vector(4-1 downto 0);
	sec_l_o : out std_logic_vector(4-1 downto 0);
	hth_h_o : out std_logic_vector(4-1 downto 0);
	hth_l_o : out std_logic_vector(4-1 downto 0)
);
end entity stopwatch;

------------------------------------------------------------------------
architecture Behavioral of stopwatch is
	signal s_cnt0 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt1 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt2 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt3 : unsigned(4-1 downto 0) := (others => '0');
    signal s_cnt4 : unsigned(4-1 downto 0) := (others => '0');
    
    s_cnt0 <= s_cnt0 + 1;
    s_cnt1 <= s_cnt1 + 1;
    s_cnt2 <= s_cnt2 + 1;
    s_cnt3 <= s_cnt3 + 1;

    hth_l_o <= std_logic_vector(s_cnt0);
    hth_h_o <= std_logic_vector(s_cnt1);
    sec_l_o <= std_logic_vector(s_cnt2);
    sec_h_o <= std_logic_vector(s_cnt3);
begin
------------------------------------------------------------------------

BCD0 : entity work.BCDCounter
	generic map 
    (
    	g_NBIT => 9
	)
	port map 
    (
	clk_i => clk_i,
    srst_n_i => srst_n_i,
    en_i => s_cnt0,
    cnt_o => hth_l_o,
    carry_o => s_cnt1
	);
    
BCD1 : entity work.BCDCounter
    generic map 
    (
   		g_NBIT => 9
    )
	port map 
    (
	clk_i => clk_i,
    srst_n_i => srst_n_i,
    en_i => s_cnt1,
    cnt_o => hth_h_o,
    carry_o => s_cnt2
	);
    
BCD2 : entity work.BCDCounter
	generic map 
    (
    	g_NBIT => 9
	)
	port map 
    (
	clk_i => clk_i,
    srst_n_i => srst_n_i,
    en_i => s_cnt2,
    cnt_o => sec_l_o,
    carry_o => s_cnt3
	);
    
BCD3 : entity work.BCDCounter
	generic map 
    (
    	g_NBIT => 5 
	)
	port map 
    (
	clk_i => clk_i,
    srst_n_i => srst_n_i,
    en_i => s_cnt3,
    cnt_o => sec_h_o,
    carry_o => s_cnt4
	);  

p_stop_watch_cnt : process (clk_i)
begin
    if rising_edge(clk_i) then
     if srst_n_i = '0' then
     s_cnt0 <= '0';  
     else
     	and_dc0 <= ce_100Hz_i and cnt_en_i;     
     end if;
   end if;
end process p_stop_watch_cnt;
end architecture Behavioral;
