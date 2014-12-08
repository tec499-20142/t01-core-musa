module ex_stage(

	input reset,
	input[31:0] data_a, 
	input[31:0] data_b,
	input[31:0] pc, 
	input[31:0] pc_1, 
	input[31:0] jump_address,
	input[31:0] immediate,
	input[31:0] stack, 
	input data_a_select; 
	input data_b_select; 
	input[2:0] pc_select,
	input[2:0] alu_control,
	input[5:0] func,
	output reg[31:0] result, 
	output reg[2:0] flag,
	output reg[31:0] next_pc, 
	); 

	
	
endmodule 
