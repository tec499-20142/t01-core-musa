module ex_stage(
	input reset,
	input clk,
	input[31:0] data_a, 
	input[31:0] data_b,
	input[31:0] pc, 
	input[31:0] pc_1,
	input[31:0] immediate,
	input[31:0] immediate_div_4,
	input[31:0] stack, 
	input[1:0] data_a_select,
	input[1:0] data_b_select, 
	input[2:0] pc_select,
	input[2:0] alu_control,
	input[5:0] func,
	output [31:0] result, 
	output [2:0] flag,
	output [31:0] next_pc 
	); 

	wire [31:0] data_a_temp;
	wire [31:0] data_b_temp;
  reg [31:0] data_a_reg; 
  reg [31:0] data_b_reg; 
	wire [0:0] branch_temp;
	wire [0:0] branch;	
	wire [31:0] res_out;
	
	always@ (posedge clk) 
	begin 
	 data_a_reg <= data_a_temp; 
	 data_b_reg <= data_b_temp; 
	end 
	
	/*always@ (posedge clk)
	begin
		result <= res_out;
	end*/
	
	
	mux m_data_a(
	.data_0(pc),
	.data_1(pc_1),
	.data_2(data_a),
	.data_3(0),  
	.sel(data_a_select), 
	.data(data_a_temp)
	);
	
	
	mux m_data_b(
	.data_0(immediate),
	.data_1(data_b),
	.data_2(immediate_div_4), 
	.data_3(0), 
	.sel(data_b_select), 
	.data(data_b_temp));
	
	alu alu_ex(
	.reset(reset), 
	.data_a(data_a_temp), 
	.data_b(data_b_temp),
	.alu_control(alu_control),
	.func(func),  
	.result(result), 
	.flag(flag),
	.branch(branch));
	
	mux m_branch(
	.data_0(result),
	.data_1(pc_1),
	.data_2(0), 
	.data_3(0),
	.sel(branch), 
	.data(branch_temp));
	
	cal_next_address calc(
	.reset(reset),
	.pc(pc),
	.pc_1(pc_1), 
	.branch_address(branch_temp), 
	.stack(stack), 
	.jr(data_a),
	.pc_select(pc_select),
	.next_address(next_pc));
	
endmodule 
