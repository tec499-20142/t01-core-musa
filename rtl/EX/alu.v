module alu(
input[31:0] data_a, 
input [31:0] data_b,
input [4:0] alu_control,
input [4:0] func, 
input reset, 
output reg[31:0] result, 
output reg [2:0] flag);

	parameter ARITHMETIC_R = 0; 
	parameter LOGIC_R = 1; 
	parameter ARITHMETIC_I = 2; 
	parameter LOGIC_I = 3; 
	
	
	parameter ADD = 0;
	parameter ADDI = 1;
	parameter SUB = 2;
	parameter SUBI = 3;
	parameter MUL = 4; 
	parameter DIV = 5;
	parameter AND = 6;
	parameter ANDI = 7;
	parameter OR = 8;
	parameter ORI = 9;
	parameter NOT = 10; 
	parameter CMP = 11;
	parameter BRFL = 12;
	
	reg [32:0] result_checker; 
	reg [64:0] result_muld;

//ainda falta colocar algumas das funçoes aqui na alu. 
always @(alu_control, func, data_a, data_b, reset) begin
		if(reset) begin
				result = 32'b0;
			end
		else 	begin 
			case(alu_control)	
				ARITHMETIC_R: begin 	
					case(func) 			
						ADD: begin 
							result_checker = data_a + data_b; 		
						end	
						SUB: begin 
							result_checker = data_a - data_b; 
						end 
							result = result_checker[31:0];
							overflow = result_checker[32];
					endcase
				end 
					MUL: begin 
						//Aqui ainda precisa ser refeito. Temos que pegar o mais significativos
						result_muld = data_a * data_b; 
						result = result_muld[63:32];
						overflow = result_checker[64];
					end 
					
					DIV: begin 
						result_checker = data_a / data_b; 
						result = result_checker[31:0];
						overflow = result_checker[32];
					end
							
					AND: begin 
						result = data_a & data_b; 
					end
					ANDI: begin 
						result = data_a & data_b;
					end 
					OR: begin 
						result = data_a | data_b;
					end 
					ORI: begin 
						result = data_a | data_b;
					end 
					NOT : begin 
						result = ~data_a; //considerando que o registrador de destino e data_a
					end 
					CMP : begin //isso daqui eu tenho duvida
						if(data_a == data_b)begin 
							flag = 4'b0000;
						end
					end 
				endcase
			end
	end 
endmodule 
