module stage_Four_Five(
	addr,
	clk,
	data_in,
	data_out,
	memRead,
	rdy,
	memWrite, result_out);


input [31 : 0] addr;
input clk;
input [31 : 0] data_in;
output reg [31 : 0] data_out;
input memRead;
output rdy;
input memWrite;
output reg [31:0] result_out;
wire [31:0] data;

always @(posedge clk)
begin
	data_out <= data;
	result_out <= addr;
end

Mem_Data BLOCO4 (
  .addr (addr),
  .clk (clk),
  .data_in (data_in),
  .data_out (data),
  .memRead (memRead),
  .rdy (rdy),
  .memWrite (memWrite)
  );

endmodule