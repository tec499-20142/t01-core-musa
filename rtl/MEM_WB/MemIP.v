module Mem_Data(
	addr,
	clk,
	data_in,
	data_out,
	memRead,
	rdy,
	memWrite);


input [10 : 0] addr;
input clk;
input [31 : 0] data_in;
output [31 : 0] data_out;
input memRead;
output rdy;
input memWrite;
reg [31:0] data_out;
reg [31:0] musaRAM [0:2047];
reg rdy;

always @(posedge clk) begin
	if (memRead) begin
		rdy <= 1 ;
		data_out <= musaRAM [addr];
	end else begin
		rdy <= 0;
		data_out = 16'hZZZZ;
	end
end

always @(posedge clk) begin
	if (memWrite) 
		musaRAM [addr] <= data_in;
end



endmodule