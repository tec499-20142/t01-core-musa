module stage_Four_Five(
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
output reg [31 : 0] data_out;
input memRead;
output rdy;
input memWrite;
wire data;

always @(posedge clk)
begin
	data_out <= data;
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