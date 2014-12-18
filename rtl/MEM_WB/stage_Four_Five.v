module stage_Four_Five(
	addr,
	clk,
	data_in,
	data_out,
	memRead,
	memWrite);

input [31:0] addr;
input clk;
input [31:0] data_in;
output [31:0] data_out;
input memRead;
input memWrite;

Mem_Data BLOCO4 (
  .addr (addr),
  .clk (clk),
  .data_in (data_in),
  .data_out (data_out),
  .memRead (memRead),
  .memWrite (memWrite)
  );

endmodule