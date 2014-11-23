module unit_Control(
opcode, 
clk, 
pcSrc, memRead, pop, push, memToReg, memWrite, aluSrc, regWrite, regDst, PCWrite, 
aluOp);

input [5:0] opcode;
input clk;
output reg memRead, memToReg, memWrite, aluSrc, regWrite, regDst,PCWrite, push, pop;
reg [2:0]stage;
output reg [1:0] pcSrc;
output reg [2:0] aluOp;


parameter nop = 000000;
parameter LOGICAS = 000000;	
parameter MUL = 011100;		
parameter DIV = 000101;	
parameter CMP=000000;		

parameter ADDI = 001000;		
parameter SUBI=001001; //Instrução: addiu		
parameter ANDI = 001100;		
parameter ORI	= 001101;
parameter LW	= 100011;
parameter SW	= 101011;

parameter JR = 010001;            //Instrução: bclf
parameter JPC	=	000010;			  	  //Instrução: j
parameter BRFL	=	000100;				    //Instrução: beq
parameter CALL		=      000011;				    //Instrução: jal
parameter RET		=      000001;
parameter HALT = 0; //FALTA O OPCODE DO HALT

always@ (*)
begin
	if(opcode == LOGICAS)
	begin
		regDst = 1'b1;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b010;
		memWrite = 1'b0;
		aluSrc = 2'b00;
		regWrite = 1'b1;
	end
	else if(opcode == MUL)
	begin
		regDst = 1'b1;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b010;
		memWrite = 1'b0;
		aluSrc = 2'b00;
		regWrite = 1'b1;
	end
	else if(opcode == DIV)
	begin
		regDst = 1'b1;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b010;
		memWrite = 1'b0;
		aluSrc = 2'b00;
		regWrite = 1'b1;
	end
	else if(opcode == ADDI)
	begin
		regDst = 1'b0;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b000;
		memWrite = 1'b0;
		aluSrc = 2'b01;
		regWrite = 1'b1;
	end
	else if(opcode == SUBI)
	begin
		regDst = 1'b0;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b001;
		memWrite = 1'b0;
		aluSrc = 2'b01;
		regWrite = 1'b1;
	end
	else if(opcode == ANDI)
	begin
		regDst = 1'b0;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b011;
		memWrite = 1'b0;
		aluSrc = 2'b01;
		regWrite = 1'b1;
	end
	else if(opcode == ORI)
	begin
		regDst = 1'b0;
		memRead = 1'b0;
		memToReg = 1'b0;
		aluOp = 3'b100;
		memWrite = 1'b0;
		aluSrc = 2'b01;
		regWrite = 1'b1;
	end
	else if(opcode == LW)
	begin
		regDst = 1'b0;
		memRead = 1'b1;
		memToReg = 1'b1;
		aluOp = 3'b000;
		memWrite = 1'b0;
		aluSrc = 2'b01;
		regWrite = 1'b1;
	end
	else if(opcode == SW)
	begin
		memRead = 1'b0;
		aluOp = 3'b001;
		memWrite = 1'b1;
		aluSrc = 2'b01;
		regWrite = 1'b0;
	end
	else if(opcode == JR)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b0;
		pop = 1'b0;
		pcSrc = 2'b01;
	end
		else if(opcode == JPC)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b0;
		pop = 1'b0;
		pcSrc = 2'b10;
	end
	else if(opcode == BRFL)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b0;
		pop = 1'b0;
		pcSrc = 2'b01;
	end
	else if(opcode == CALL)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b1;
		pop = 1'b0;
		pcSrc = 2'b01;
	end
	else if(opcode == RET)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b0;
		pop = 1'b1;
		pcSrc = 2'b00;
	end
	else if(opcode == HALT)
	begin
		memRead = 1'b0;
		memToReg = 1'b0;
		memWrite = 1'b0;
		regWrite = 1'b0;
		push = 1'b0;
		pop = 1'b0;
		pcSrc = 2'b01;
	end
end

always@ (posedge clk)
begin
	stage <= stage + 1'b1;
	if(stage == 3'b101)
		stage <= 1'd0;
	if(stage == 3'b000)
		PCWrite <= 1'b1;
		

end

endmodule


