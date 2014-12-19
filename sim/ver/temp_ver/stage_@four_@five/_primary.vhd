library verilog;
use verilog.vl_types.all;
entity stage_Four_Five is
    port(
        addr            : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0);
        memRead         : in     vl_logic;
        memWrite        : in     vl_logic
    );
end stage_Four_Five;
