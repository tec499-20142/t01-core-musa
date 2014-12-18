  module alu(
	input reset, 
	input[31:0] data_a, 
	input[31:0] data_b,
	input[2:0] alu_control,
	input[5:0] func,  
	output reg[31:0] result, 
	output reg [2:0] flag, 
	output reg [0:0] branch);
	
	//functions das operaçoes logicas e aritmeticas (instruçoes do tipo R)
	parameter ADD = 6'b100000;
	parameter SUB = 6'b100010;
	parameter MUL = 6'b000010; 
	parameter DIV = 6'b000001;
	parameter AND = 6'b100100;
	parameter OR = 6'b100101;
	parameter NOT = 6'b100111;
	
	//Opcode das instrucoes 
	parameter ADDI = 3'b000;
	parameter SUBI = 3'b001;
	parameter TYPE_R = 3'b010; 
	parameter ANDI = 3'b011;
	parameter ORI = 3'b100;
	parameter BRFL = 3'b101;
	parameter CMP = 3'b110;
	
	//flags 
	parameter FLAG_NOT_ACTIVED = 000;
	parameter FLAG_EQUAL = 001; 
	parameter FLAG_EXCEPTION = 010; 
	parameter FLAG_OVERFLOW_UNDERFLOW = 011;
	parameter FLAG_ABOVE = 100;
	
	reg [2:0] reg_flag;   //registrador de flag
	reg [64:0] result_checker; 

	always @(alu_control, func, data_a, data_b, reset) 
		if(~reset) begin
			result = 0;
		end
		else begin 
			case (alu_control)
				ADDI: 
				begin
					result_checker = data_a + data_b;
					reg_flag = ((result_checker[32]^result_checker[31]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag; 
					branch = 0;
				end 
				SUBI: begin 
					result_checker = data_a - data_b;
					reg_flag = ((result_checker[32]^result_checker[31]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag;
					branch = 0;
				end 
				TYPE_R: begin 
					case(func)
						ADD: begin 
							result_checker = data_a + data_b;
							reg_flag = ((result_checker[32]^result_checker[31]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag;
						end 
						SUB: begin 
							result_checker = data_a - data_b;
							reg_flag = ((result_checker[32]^result_checker[31]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag;
						end
						MUL: begin 
							result_checker = data_a * data_b;
							reg_flag = ((result_checker[64]^result_checker[63]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag;
						end 
						DIV: begin 
						  if(data_b == 0) begin 
						    reg_flag = FLAG_EXCEPTION;
						    result_checker = 64'b0;
						  end 
						  else begin 
							   result_checker = data_a / data_b;
							   reg_flag = ((result_checker[64]^result_checker[63]) == 1)? FLAG_OVERFLOW_UNDERFLOW : reg_flag;
						  end 
						end 
						AND: begin 
							result_checker = data_a & data_b; 
						end 
						OR: begin 
							result_checker = data_a | data_b;
						end 
						NOT: begin
							result_checker = ~data_a;
						end 			
					endcase			
					branch = 0;
				end
				CMP: begin 
					if(data_a == data_b) begin 
						reg_flag = FLAG_EQUAL;
					end 
					else begin
						if(data_a > data_b) begin 
							reg_flag = FLAG_ABOVE;
						end 
					end 
					branch = 0;
				end
				ANDI: begin 
					result_checker = data_a & data_b;
					branch = 0;
				end 
				ORI: begin 
					result_checker = data_a | data_b;
					branch = 0;
				end 
				BRFL: begin 
					result_checker[31:0] =  data_a;
					if(reg_flag == data_b[2:0]) begin 	
						branch = 0;
					end 
					else begin
						branch = 1;
					end 
				end 
			endcase	
		
			flag = reg_flag; 
			result = result_checker[31:0];					
		end
endmodule 
