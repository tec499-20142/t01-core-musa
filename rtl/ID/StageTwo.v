module stagetwo(
instruction, clk, rst,  
pcSrc, memRead, memWrite, aluSrc, push, pop, PCWrite, 
aluOp,
word,
AluOut,
out_jump, mem_Data,
readData1, readData2, outputWord);

input [31:0] instruction;
input clk, rst;
input [31:0] AluOut;
output  push, pop, memRead, memWrite, aluSrc, PCWrite;
output [2:0] pcSrc;
output  [1:0] aluOp;
output  [15:0] word;
output reg [31:0] readData1, readData2, outputWord;
wire [31:0] read_data_1_rf, read_data_2_rf, word_sign;
output [25:0] out_jump = instruction[25:0];
wire [5:0] opcode = instruction[31:26]; 
wire [4:0] ReadRegister1 = instruction[25:21];
wire [4:0] ReadRegister2 = instruction[20:16];
wire MemToReg;
wire regDst;
wire _regWrite;
reg [31:0] out_Mux_Write_Data;
reg [4:0] out_destination;
input [31:0] mem_Data;
wire [4:0] destination = instruction[15:11];



always@ (posedge clk)
begin
	readData1 <= read_data_1_rf;
	readData2 <= read_data_2_rf;
	outputWord <= word_sign;
end

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
  .ReadData1(read_data_1_rf),
  .ReadData2(read_data_2_rf),
  .RegWrite (_regWrite)
  );
  
 unit_Control BLOCO2 (
  .opcode (opcode),
  .clk (clk),
  .pcSrc (pcSrc),
  .push (push),
  .memRead (memRead),
  .memWrite(memWrite),
  .memToReg(memToReg),
  .regWrite (_regWrite),
  .pop (pop),
  .regDst (regDst),
  .PCWrite (PCWrite),
  .aluOp (aluOp)
  );
  
  sign_extend BLOCO3 (
  .inst (word),
  .inst_out (word_sign)
  );

 endmodule
 
