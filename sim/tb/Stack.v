`include "Stack.v"

module testStack;

reg [12:0] pcInput;
reg clk;
reg reset;
reg readStack;
reg writeStack;
reg [12:0] pc;
wire [12:0] stackOut;
reg [12:0] regStack [7:0];
wire stackOverflow;

initial begin

pc = 13'b0100010001011
#1

end

Stack stack(.*);

endmodule

