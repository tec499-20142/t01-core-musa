module ex_stage(

	input[31:0] data_a, 
	input [31:0] data_b,
	input [31:0] immediate, 
	input [4:0] alu_control, 
	input [5:0] func, 
	input reset, 
	input [31:0] pc_in, 
	input [26:0] jump_address, 
	input [1:0] pcSource,
	output reg[31:0] result, 
	output reg [2:0] flag,
	output reg [31:0] next_address); 

	reg [31:0] data_um;  
	
	mux m0(.data_a(immediate), 
	.data_b(data_b), 
	.sel(pcSource[0], 
	.data(data_um)));
	

	alu alu0 (
		.data_a(data_a), 
		.data_b(data_um),
		.alu_control(alu_control), 
		.reset(reset), 
		.func(func)
		.result(result),
		.flag(flag));

	cal_next_address cal_next_address0(
		.pc_in(pc_in),
		.data_a(data_a),	
		.jump_address(jump_address), 
		.branch(branch), 
		.jump_sel(jump_sel),
		.alu_flag(flag),
		.reset(reset),
		.next_address(next_address);


endmodule 
