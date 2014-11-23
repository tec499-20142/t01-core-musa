module alu(
	
	input[31:0] data_a, 
	input [31:0] data_b,
	input [2:0] alu_control,
	input [4:0] func, 
	input reset, 
	output reg[31:0] result, 
	output reg [2:0] flag);

	//Valores do aluOp 
	parameter ARITHMETIC_LOGIC = 010; 
	
	
	//functions das operaçoes logicas e aritmeticas (instruçoes do tipo R)
	parameter ADD = 100000;
	parameter SUB = 100010;
	parameter MUL = 000010; 
	parameter DIV = 000001;
	parameter AND = 100100;
	parameter OR = 100101;
	parameter NOT = 100111;
	
	//Opcode das instrucoes 
	parameter ADDI = 000;
	parameter SUBI = 001;
	parameter ANDI = 011;
	parameter ORI = 100;
	
	parameter CMP = 101010;
	parameter BRFL = 000100;
	
	reg [2:0] reg_flag;//registrador de flag
	reg [32:0] result_checker; 
	reg [64:0] result_muld;

//ainda falta colocar algumas das funçoes aqui na alu. 
always @(alu_control, func, data_a, data_b, reset) begin
		if(reset) begin
				result = 32'b0;
			end
		else	begin 
			case (alu_control)
				ARITHMETIC_LOGIC: begin 
					case(func)
						ADD: begin 
							result_checker = data_a + data_b;
						end 
						SUB: begin 
							result_checker = data_a - data_b;
						end
						MUL: begin 
							result_muld = data_a * data_b;
						end 
						DIV: begin 
							result_muld = data_a / data_b;
						end 
					endcase
				end		
			endcase 
endmodule 
