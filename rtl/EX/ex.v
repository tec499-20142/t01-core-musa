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

	reg data_a_temp;
	reg data_b_temp;
	
	mux m_data_a(
	.data_a(pc_1),
	.data_b(data_a), 
	.sel(data_a_select), 
	.data(data_a_temp));
	
	mux m_data_b(
	.data_a(data_b),
	.data_b(immediate), 
	.sel(data_b_select), 
	.data(data_b_temp));
	
	alu alu_ex(
	.reset(reset), 
	.data_a(data_a_temp), 
	.data_b(data_b_temp),
	.alu_control(alu_control),
	.func(func),  
	.result(result), 
	.flag(flag));

	cal_next_address calc(
	.reset(reset),
	.pc(pc),
	.pc_1(pc_1), 
	.jump_address(jump_address), 
	.branch_address(result), 
	.stack(stack), 
	.jr(data_a),
	.pc_select(pc_select),
	.next_address(next_pc)
);
	
endmodule 
