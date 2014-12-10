module shift_two(in, out);
input [25:0] in;
output reg [31:0] out;

parameter aux = 00000000;

always@(*)
begin
	out = {aux, in[25:2]};
end  
endmodule