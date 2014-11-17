`include "PCAdder.v"

module PCAdder_tb;

reg [31:0] pcInput;
wire [31:0] pcOutput;

PCAdder pcadder(.pcOld(pcInput), .pcNew(pcOutput)); 
		
initial begin

pcInput = 32'b01010001000101100010101010001000; 
#5;
pcInput = 32'b01010001000101100010101010011000; 
#5;
pcInput = 32'b01010001000101100010101010001100; 
#5;
pcInput = 32'b11010011000101100010101010001000; 
#5
pcInput = 32'b01010001000101100010101010011011;
#5

$finish; 

end

initial

$monitor ("pcInput = %d, pcOutput = %d", pcInput, pcOutput);

endmodule

