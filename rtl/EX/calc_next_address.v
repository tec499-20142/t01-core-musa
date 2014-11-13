module cal_next_address(
	input [31:0] pc_in, 
	input [31:0] jump_address, 
	input [31:0] branch_address, 
	input branch, 
	input jump_sel,
	input [3:0] alu_flag,
	input reset,
	output reg [31:0] next_address
);

reg[31:0] next_temp;

always @(*)begin 
		if(reset) begin  
			next_temp = 0;
		end 
		else begin  
			if(branch && alu_flag)begin 
				next_temp = branch_address; 
			end 
			else begin 
				next_temp = pc_in + 1; //talvez eu peço para mudar do if. 
			end 
		end 
	end

always @(*) begin
	if(reset) begin 
		next_address = 0;
	end
	else begin 
		if(jump_sel) begin 
			next_address = jump_address; 
		end 
		else begin 
			next_address = next_temp;
		end
	end
end 	
endmodule 

