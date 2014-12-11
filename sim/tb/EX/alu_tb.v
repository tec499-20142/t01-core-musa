module alu_tb(
output  [31:0] result, 
output  [2:0] flag);
 
 reg [31:0] data_a; 
 reg [31:0] data_b; 
 reg [2:0] alu_control; 
 reg [5:0] func; 
 reg [0:0]reset;
 
 initial begin
  reset = 0;
  data_a = 4294967295; 
  data_b = 0; 
  alu_control = 2;
  func = 1;
  reset = 1;
 end  
 
  alu alu_tb(
	.reset(reset), 
	.data_a(data_a), 
	.data_b(data_b),
	.alu_control(alu_control),
	.func(func),  
	.result(result), 
	.flag(flag), 
	.branch(branch));
	
	
endmodule 