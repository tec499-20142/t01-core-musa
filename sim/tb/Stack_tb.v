`include "Stack.v"

module Stack_tb;

//reg clk;
//reg reset;
reg readStack;
reg writeStack;
reg [12:0] pc;
wire [12:0] stackOut;
reg [12:0] regStack [7:0];
wire stackOverflow;

Stack stack(.readStack(readStack), .writeStack(writeStack), .pc(pc), .stackOut(stackOut), .readStack(readStack), .stackOverflow(stackOverflow));

initial begin

readStack = 0;
writeStack = 1;
pc = 13'b0100010001011;
#5

readStack = 1;
writeStack = 0;
#5

readStack = 0;
writeStack = 1;
pc = 13'b0100010001001;
#5

readStack = 0;
writeStack = 1;
pc = 13'b0010001001111;

#5
readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;

#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 0;
writeStack = 1;
pc = 13'b1000010001011;
#5

readStack = 1;
writeStack = 0;
#5

readStack = 1;
writeStack = 0;
#5

readStack = 1;
writeStack = 0;
#5

readStack = 1;
writeStack = 0;
#5

end

initial

$monitor ("readStack = %d, writeStack = %d, pc = %d, stackOut = %d, regStack = %d, stackOverflow = %d",  
readStack, writeStack, pc, stackOut, readStack, stackOverflow);

endmodule

