module Mem_Data(
	addr,
	clk, rst,
	data_in,
	data_out,
	memRead,
	memWrite);


input [10:0] addr;
input clk, rst;
input [31:0] data_in;
output [31:0] data_out;
input memRead;
input memWrite;
reg [31:0] data_out;
reg [31:0] musaRAM [0:2047];

integer i;

initial begin
	for (i=0; i<2047; i=i+1)begin
		musaRAM[i] <= 0;
	end
		musaRAM[1] <= 1'd1;
end

always @(posedge clk) begin
	if (memRead) begin
		data_out <= musaRAM [addr];
	end
end

always @(posedge clk) begin
	if (memWrite) 
		musaRAM [addr] <= data_in;
	if(~rst)begin
		for (i=0; i<2047; i=i+1)begin
			musaRAM[i] <= 0;
		end
	end
end
 
endmodule