`include "ProgramCounter.v"

module ProgramCounter_tb;

//reg clk;
//reg reset;
reg pcWrite;
reg [31:0] pcInput;
wire [12:0] pcOutput;

ProgramCounter programcounter(.pcWrite(pcWrite), .pcInput(pcInput), pcOutput(pcOutput)); //.clk(clk), .reset(reset)
		
initial begin
pcWrite = 0;
pcInput = 32'b01010001000101100010101010001000; 
#5;

pcWrite = 1;
pcInput = 32'b01010001000101100010101010011000; 
#5;

pcWrite = 1;
pcInput = 32'b01010001000101100010101010001100; 
#5;

pcWrite = 0;
pcInput = 32'b11010011000101100010101010001000; 
#5
pcWrite = 1;
pcInput = 32'b01010001000101100010101010011011;
#5

$finish; 

end

initial

$monitor ("pcWrite = %d, pcInput = %d, pcOutput = %d", pcWrite, pcInput, pcOutput);

endmodule
