module uc_tb();
parameter periodo = 20;

reg [5:0] opcode;  
reg clk;
wire rst;
wire memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop;
wire [1:0] pcSrc, aluSrc;
wire [2:0] aluOp;
wire [2:0] stage;

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

initial  begin
//testar todas os opcodes;

	$display("\t\ttime,\topcode,\tmemRead,\tmemToReg,\tmemWrite,\tregWrite,\tregDst,\tPCWrite,\tpush,\tpop,\tpcSrc,\taluSrc,\taluOp");
	opcode = nop;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = LOGICAS;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp); 
	opcode = MUL;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = DIV;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = CMP;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = ADDI;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = SUBI;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = ANDI;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = ORI;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = LW;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = SW;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = JR;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = JPC;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = BRFL;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = CALL;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = RET;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
	opcode = HALT;
	#10 $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b", $time, opcode, memRead, memToReg, memWrite, regWrite, regDst, PCWrite, push, pop, pcSrc, aluSrc, aluOp);
end

always
#5  clk =!clk; 	

unit_Control BLOCO2 (
  .opcode (opcode),
  .clk (clk),
  .pcSrc (pcSrc),
  .push (push),
  .memRead (memRead),
  .memWrite(memWrite),
  .memToReg(memToReg),
  .aluSrc(aluSrc),
  .regWrite (regWrite),
  .pop (pop),
  .regDst (regDst),
  .PCWrite (PCWrite),
  .aluOp (aluOp),
.stage(stage)
  );
endmodule
