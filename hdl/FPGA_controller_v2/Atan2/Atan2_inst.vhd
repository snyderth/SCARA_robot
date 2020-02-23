	component Atan2 is
		port (
			areset : in  std_logic                     := 'X';             -- reset
			clk    : in  std_logic                     := 'X';             -- clk
			en     : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- en
			q      : out std_logic_vector(12 downto 0);                    -- q
			x      : in  std_logic_vector(31 downto 0) := (others => 'X'); -- x
			y      : in  std_logic_vector(31 downto 0) := (others => 'X')  -- y
		);
	end component Atan2;

	u0 : component Atan2
		port map (
			areset => CONNECTED_TO_areset, -- areset.reset
			clk    => CONNECTED_TO_clk,    --    clk.clk
			en     => CONNECTED_TO_en,     --     en.en
			q      => CONNECTED_TO_q,      --      q.q
			x      => CONNECTED_TO_x,      --      x.x
			y      => CONNECTED_TO_y       --      y.y
		);

