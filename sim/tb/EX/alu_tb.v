module alu_tb(
  output [31:0] result, 
	output [2:0] flag, 
	output  branch);
 
 reg [31:0] data_a; 
 reg [31:0] data_b; 
 reg [2:0] alu_control; 
 reg [5:0] func; 
 
 initial begin 
  data_a  = 25; 
  data_b = 12;
  alu_control = 3'b000;
  func = 6'b0;
 end  
  alu alu_tb(
	.reset(1), 
	.data_a(data_a), 
	.data_b(data_b),
	.alu_control(alu_control),
	.func(func),  
	.result(result), 
	.flag(flag), 
	.branch(branch));
	
	
endmodule 