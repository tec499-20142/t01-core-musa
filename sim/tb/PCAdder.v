`include "PCAdder.v"

module testPCAdder;

reg [31:0] pcInput;
wire [31:0] pcOutput;

initial begin

$monitor ("pcInput = %b, pcOutput =%b", pcInput, pcOutput); 
pcInput = 32'b01010001000101100010101010001000
#1

end

PCAdder pcadder(.pcOld(pcInput)
		.pcNew(pcOutput);
endmodule

