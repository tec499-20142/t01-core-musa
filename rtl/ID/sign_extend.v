module sign_extend(inst, inst_out);

input [15:0]inst;
output reg [31:0]inst_out;

reg [15:0]zero = 16'b0000000000000000;
reg [15:0]one = 16'b1111111111111111;

always @(*)
begin
  if(inst[15] == 0) 
    inst_out = {zero,inst};
  else
    inst_out = {one,inst};
end 

endmodule