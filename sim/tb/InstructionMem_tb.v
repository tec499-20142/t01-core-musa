`include "InstructionMem.v"

module InstructionMem_tb;

wire [31:0] data; 
reg [2047:0] mem [31:0]; 

InstructionMem instruction_mem(.address(address), .data(data), .mem(mem));

initial begin
$readmemb("example.txt",mem);
#10;

data = mem[13'b0000000000000];
#5;

data = mem[13'b0000000000001];
#5;

data = mem[13'b0000000000010];
#5;

data = mem[13'b0000000000011];
#5;

data = mem[13'b0000000000100];
#5;

data = mem[13'b0000000000101];
#5;

end

initial

$monitor ("data = %d", data);

endmodule
