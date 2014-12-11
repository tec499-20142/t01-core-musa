library verilog;
use verilog.vl_types.all;
entity codigo is
    generic(
        XCLK_FREQ       : integer := 48000000
    );
    port(
        xclk            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of XCLK_FREQ : constant is 1;
end codigo;
