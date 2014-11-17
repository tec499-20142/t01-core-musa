module sign_extend(inst, inst_out);

input [15:0]inst;
output [31:0]inst_out;

zero = 16'b0000000000000000;
one = 16'b1111111111111111;

always @(*)
begin
if(inst[15] == 0) 
inst_out = {inst,zero};
else
inst_out = {inst,one};
end 