library verilog;
use verilog.vl_types.all;
entity shift_two is
    generic(
        aux             : integer := 0
    );
    port(
        \in\            : in     vl_logic_vector(25 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of aux : constant is 1;
end shift_two;
