module cal_next_address(
	input reset,
	input [31:0] pc,
	input [31:0] pc_1, 
	input [31:0] branch_address, 
	input [31:0] stack, 
	input [31:0] jr,
	input [2:0] pc_select,
	output reg [31:0] next_address
);

	parameter STACK = 3'b000; 
	parameter JR = 3'b001; 
	parameter NPC = 3'b010; 
	parameter BRANCH = 3'b011; 
	parameter HALT = 3'b100;
	

always @(*)begin 
	case(pc_select)
		STACK: begin 
			next_address = stack; 
		end 
		JR: begin
			next_address = jr; 
		end 
		NPC: begin
			next_address = pc_1; 
		end 
		BRANCH: begin
			next_address = branch_address; 
		end 
		HALT: begin
			next_address = pc; 
		end 
		default: begin 
		  next_address = pc_1; 
		end 
	endcase
end	

endmodule	 