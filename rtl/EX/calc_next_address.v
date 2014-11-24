module cal_next_address(
	input [31:0] pc_in,
	input[31:0] brfl_address,
	input [31:0] jump_address,
	input branch, 
	input jump_sel,
	input [3:0] alu_flag,
	input reset,
	output reg [31:0] next_address
);

reg[31:0] next_temp;

always @(*)begin 
		// se for reset, zera o reg temporário
		if(reset) begin
			next_temp = 0;
		end 
		else begin
			// se for brfl o endereço q vem em data_a é associado ao reg temporário
			if(branch && alu_flag == data_b)begin
				next_temp = data_a; 
			end 
			else begin
				// se for jump, coloca endereço do jump no reg temporário
				if(jump_sel) begin
					next_temp = jump_address; 
				end
				// normal, próximo pc, ou seja pc + 1 
				else begin	
					next_temp = pc_in + 1;
				end
			end 
		end

always @(*) begin
	// se for reset, zera o pc
	if(reset) begin
		next_address = 0;
	end
	// se não coloca o prox valor se pc na saída
	else begin  
		next_address = next_temp;
	end
end 	
endmodule 