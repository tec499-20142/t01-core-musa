module alu(
input[31:0] data_a, 
input [31:0] data_b,
input [4:0] alu_control, 
input reset, 
output reg[31:0] result,
output reg [3:0] flag);

	parameter ADD = 6'b000000;
	parameter ADDI = 6'b000001;
	parameter SUB = 6'b000010;
	parameter MUL = 6'b000011; 
	parameter DIV = 6'b000100;
	parameter AND = 6'b000101;
	parameter ANDI = 6'b000110;
	parameter OR = 6'b000111;
	parameter ORI = 6'b001000;
	parameter NOT = 6'b001001; 
	parameter CMP = 6'b001010;
	parameter SLT = 6'b001011;
	parameter BEQ = 6'b001100;
	parameter BNE = 6'b001101;
	

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
					ADD: result = data_a + data_b; 
					ADDI: result = data_a + data_b;
					SUB: result = data_a - data_b; 
					MUL: result = data_a * data_b; // isso talvez nao seja sintetizavel 
					DIV: result = data_a / data_b;
					AND: result = data_a & data_b; 
					ANDI: result = data_a & data_b; 
					OR: result = data_a | data_b; 
					ORI: result = data_a | data_b;
					NOT : result = ~data_b; 
					CMP : begin //isso daqui eu tenho duvida
						if(data_a == data_b)begin 
							result = 1;
						end
					end 
				endcase
			end
	end 
endmodule 