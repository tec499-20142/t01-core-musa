module ex_tb(output [31:0] result, 
output [2:0] flag, 
output [31:0] next_pc
);  

reg [31:0] pc; 
reg [31:0] pc_1; 
reg [31:0]immediate; 
reg[31:0] immediate_div_4; 
reg [2:0] pc_select; 
reg [5:0] func; 
reg [2:0] alu_control; 
reg [31:0] jump_address; 
reg [31:0] data_a;
reg [31:0] data_b;
reg [31:0] stack;
reg[1:0] data_a_select; 
reg [1:0] data_b_select;
reg [0:0] reset; 

initial begin 

  pc = 0; 
  pc_1 = 1; 
  immediate = 5; 
  immediate_div_4 = 3; 
  pc_select =   2;
  func = 0; 
  alu_control = 0; 
  jump_address = 1;
  data_a = 2; 
  data_b = 3; 
  stack = 1; 
  data_a_select = 2; 
  data_b_select = 0;
  reset = 1;

end 

ex_stage EX_STAGE(
  .reset(reset),
	.data_a(data_a), 
	.data_b(data_b),
	.pc(pc), 
	.pc_1(pc_1), 
	.jump_address(jump_address),
	.immediate(immediate),
	.immediate_div_4(immediate_div_4),
	.stack(stack), 
	.data_a_select(data_a_select),
	.data_b_select(data_b_select), 
	.pc_select(pc_select),
	.alu_control(alu_control),
	.func(func),
	.result(result), 
	.flag(flag),
	.next_pc(next_pc) 
	); 
	
endmodule 