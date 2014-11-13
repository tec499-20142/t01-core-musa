`include "PCAdder.sv"

module testPCAdder;

reg [31:0] pcInput;

initial begin

pcInput = 32'b01010001000101100010101010001000
#1

end

PCAdder pcadder(.pcOld(pcInput));

endmodule

