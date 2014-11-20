module ex_stage(input[31:0] data_a, 
input [31:0] data_b,
input [4:0] alu_control, 
input reset, 
input [31:0] pc_in, 
input [31:0] jump_address, 
input branch, 
input jump_sel,
input reset,
output reg[31:0] result,
output reg overflow, 
output reg underflow, 
output reg [3:0] flag,
output reg [31:0] next_address); 

	alu alu0 (
		.data_a(data_a), 
		.data_b(data_b),
		.alu_control(alu_control), 
		.reset(reset), 
		.result(result),
		.overflow(overflow), 
		.underflow(underflow), 
		.flag(flag));

	cal_next_address cal_next_address0(
		.pc_in(pc_in),
		.data_a(data_a),
		.data_b(data_b),	
		.jump_address(jump_address), 
		.branch_address(branch_address), 
		.branch(branch), 
		.jump_sel(jump_sel),
		.alu_flag(flag),
		.reset(reset),
		.next_address(next_address);


endmodule 
