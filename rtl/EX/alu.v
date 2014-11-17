module alu(
input[31:0] data_a, 
input [31:0] data_b,
input [4:0] alu_control, 
input reset, 
output reg[31:0] result,
output reg overflow, 
output reg underflow, 
output reg [3:0] flag);

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
	
	reg [32:0] result_checker; 

//ainda falta colocar algumas das funçoes aqui na alu. 
always @(alu_control, data_a, data_b, reset)
	begin
		if(reset)
			begin
				result = 32'b0;
			end
		else 
			begin 
				case(alu_control)
					ADD: begin 
						result = data_a + data_b;
					end 
					ADDI: result = data_a + data_b;
					SUB: result = data_a - data_b; 
					SUBI: result = data_a - data_b;
					MUL: result = data_a * data_b; // isso talvez nao seja sintetizavel 
					DIV: result = data_a / data_b;
					AND: result = data_a & data_b; 
					ANDI: result = data_a & data_b; 
					OR: result = data_a | data_b; 
					ORI: result = data_a | data_b;
					NOT : result = ~data_a; //considerando que o registrador de destino e data_a
					CMP : begin //isso daqui eu tenho duvida
						if(data_a == data_b)begin 
							result = 1;
						end
					end 
				endcase
			end
	end 
endmodule 