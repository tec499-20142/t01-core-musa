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
	parameter CMP = 6'b101010;
	
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
	parameter FLAG_OVERFLOW = 011;
	parameter FLAG_UNDERFLOW = 100;
	parameter FLAG_ABOVE = 101;
	
	reg [31:0] reg_flag;   //registrador de flag
	reg [64:0] result_checker; 

//ainda falta colocar algumas das funçoes aqui na alu. 
	always @(alu_control, func, data_a, data_b, reset) 
		if(~reset) begin
			result = 0;
		end
		else begin 
			case (alu_control)
				ADDI: begin
					result_checker = data_a + data_b;  
					case ({result_checker[32], result_checker[31]}) 
						2'b00: begin 
							reg_flag = FLAG_NOT_ACTIVED;
						end 
						2'b01: begin 
							reg_flag = FLAG_OVERFLOW;
						end 
						2'b10: begin
							reg_flag = FLAG_UNDERFLOW;
						end 
						2'b11: begin
							reg_flag = FLAG_OVERFLOW;
						end
					endcase			
				end 
				SUBI: begin 
					result_checker = data_a - data_b;
					case ({result_checker[32], result_checker[31]}) 
						2'b00: begin 
							reg_flag = FLAG_NOT_ACTIVED;
						end 
						2'b01: begin 
							reg_flag = FLAG_OVERFLOW;
						end 
						2'b10: begin
							reg_flag = FLAG_UNDERFLOW;
						end 
						2'b11: begin
							reg_flag = FLAG_OVERFLOW;
						end
					endcase	
				end 
				TYPE_R: begin 
					case(func)
						ADD: begin 
							result_checker = data_a + data_b;
						end 
						SUB: begin 
							result_checker = data_a - data_b;
						end
						MUL: begin 
							result_checker = data_a * data_b;
						end 
						DIV: begin 
							result_checker = data_a / data_b;
						end 
						AND: begin 
							result = data_a & data_b; 
						end 
						OR: begin 
							result = data_a | data_b;
						end 
						NOT: begin
							result = ~data_b;
						end 
						
					endcase
					//verificação do overflow e underflow 
					if(func == MUL || func == DIV) begin 
						case ({result_checker[64], result_checker[63]}) 
							2'b00: begin 
								reg_flag = FLAG_NOT_ACTIVED;
							end 
							2'b01: begin 
								reg_flag = FLAG_OVERFLOW;
							end 
							2'b10: begin
								reg_flag = FLAG_UNDERFLOW;
							end 
							2'b11: begin
								reg_flag = FLAG_OVERFLOW;
							end 
						endcase
					end 
					else begin 
						case ({result_checker[32], result_checker[31]}) 
							2'b00: begin 
								reg_flag = FLAG_NOT_ACTIVED;
							end 
							2'b01: begin 
								reg_flag = FLAG_OVERFLOW;
							end 
							2'b10: begin
								reg_flag = FLAG_UNDERFLOW;
							end 
							2'b11: begin
								reg_flag = FLAG_OVERFLOW;
							end
						endcase					
					end 							
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
				end
				ANDI: begin 
					result = data_a & data_b;
				end 
				ORI: begin 
					result = data_a | data_b;
				end 
				BRFL: begin 
					result = data_a;
					if(reg_flag == data_b) begin 	
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
