module ProgramCounter(clk, reset, pcWrite, pcInput);

input clk;
input reset;
input pcWrite;
input wire [31:0] pcInput;
output reg [12:0] pcOutput;

initial begin
pcOutput = 13'b0;
end

always @(posedge clk) begin
if(reset == 1) begin
	pcOutput <= 13'b0;
	end

else if	(pcWrite == 1) begin
	pcOutput <= pcInput;
	end
end
endmodule 
