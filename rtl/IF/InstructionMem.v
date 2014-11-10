module InstructionMem(address, data, clk);
  
input wire clk; 
input wire [12:0] address;
output reg [31:0] data; 
reg [31:0] mem [2047:0];  

initial begin
    //$readmemb("example.bin",mem); 
    $readmemh("example.hex",mem); 
    data = mem[address];
  end

  always @(posedge clk) begin
				data= mem[address];
		end

 endmodule