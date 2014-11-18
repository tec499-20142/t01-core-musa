module stagetwo(
instruction, clk, rst,  
branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, PCWrite, 
aluOp,
word,
readData1, readData2, readData3, outputWord);

input [31:0] instruction;
input clk, rst;
input [31:0] AluOut;
output  branch, memRead, memWrite, aluSrc, jump, PCWrite;
output  [1:0] aluOp;
output  [15:0] word;
output [31:0] readData1, readData2, readData3, outputWord;
wire [5:0] opcode = instruction[31:26]; 
wire [4:0] ReadRegister1 = instruction[25:21];
wire [4:0] ReadRegister2 = instruction[20:16];
wire MemToReg;
wire regDst;
wire _regWrite;
wire [31:0] out_Mux_Write_Data;
wire [4:0] out_destination;
input [31:0] mem_Data;
wire [4:0] destination = instruction[15:11];

always@ (*)
begin
	if(MemToReg)
		out_Mux_Write_Data = mem_Data;
	else
		out_Mux_Write_Data = AluOut;
end

always@ (*)
begin
	if(regDst)
		out_destination = destination;
	else
		out_destination = ReadRegister2;
end

RegisterFile BLOCO1 (
  .ReadRegister1 (ReadRegister1),
  .clk (clk),
  .reset (rst),
  .ReadRegister2 (ReadRegister2),
  .WriteData (out_Mux_Write_Data),
  .WriteRegister(out_destination),
  .ReadData1(readData1),
  .ReadData2(readData2),
  .RegWrite (_regWrite)
  );
  
 unit_control BLOCO2 (
  .opcode (ReadRegister1),
  .clk (clk),
  .reset (rst),
  .branch (branch),
  .memRead (memRead),
  .memToReg(memToReg),
  .memWrite(memWrite),
  .aluSrc(aluSrc),
  .RegWrite (_regWrite),
  .jump (jump),
  .RegDst (regDst),
  .PCWrite (PCWrite),
  .aluOp (aluOp)
  );

 endmodule
 
