
`timescale 1ns/1ns 

module MemIP(
	addr,
	clk,
	din,
	dout,
	nd,
//	rfd,
	rdy,
	we);


input [10 : 0] addr;
input clk;
input [31 : 0] din;
output [31 : 0] dout;
input nd;
//output rfd;
output rdy;
input we;
reg [31:0] dout;
reg [31:0] musaRAM [0:2047];
reg rdy;

integer memout;
initial begin : IOfiles
memout = $fopen ("OutputRAM.hex");
$readmemh ("SayehRAM.hex", musaRAM);
dout = 16'bZ;
end

always @(posedge clk) begin : MemoryRead
if (nd) begin
#1 rdy <= 1 ;
dout = musaRAM [addr];
end else begin
#1 rdy <= 0;
dout = 16'hZZZZ;
end
end

always @(posedge clk) begin : MemoryWrite
#1 if (we) #1 musaRAM [addr] <= din;
end



endmodule