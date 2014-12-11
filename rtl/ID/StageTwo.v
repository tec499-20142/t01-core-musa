module StageTwo(
	instruction, clk, rst,  
	pcSrc, memRead, memWrite, push_out, pop_out, PCWrite, 
	aluOp,
	word,
	AluOut,
	out_jump, mem_Data,
	readData1, readData2, outputWord, jump_jpc, data_a_select, data_b_select);

input [31:0] instruction;
input clk, rst;
input [31:0] AluOut;
output memRead, memWrite, PCWrite ,pop_out, push_out;
wire pop, push;
output [1:0] data_a_select, data_b_select;
output [2:0] pcSrc;
output  [1:0] aluOp;
output  [15:0] word;
output [31:0] jump_jpc;
output reg [31:0] readData1, readData2, outputWord;
wire [31:0] read_data_1_rf, read_data_2_rf, word_sign;
output [25:0] out_jump = instruction[25:0];
wire [5:0] opcode = instruction[31:26]; 
wire [4:0] ReadRegister1 = instruction[25:21];
wire [4:0] ReadRegister2 = instruction[20:16];
wire memToReg;
wire regDst;
wire _regWrite;
reg [31:0] out_Mux_Write_Data;
reg [4:0] out_destination;
input [31:0] mem_Data;
wire [4:0] destination = instruction[15:11];
wire aux_push_pop;

assign pop_out = aux_push_pop & pop;
assign push_out = aux_push_pop & push;

always@ (posedge clk)
begin
	readData1 <= read_data_1_rf;
	readData2 <= read_data_2_rf;
	outputWord <= word_sign;
end

always@ (*)
begin
	if(memToReg)
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
  
 unit_control BLOCO2 (
  .opcode (opcode),
  .clk (clk),
  .pcSrc (pcSrc),
  .push (push),
  .memRead (memRead),
  .memWrite(memWrite),
  .memToReg(memToReg),
  .regWrite (_regWrite),
  .aux_push_pop (aux_push_pop),
  .data_a_select(data_a_select),
  .data_b_select(data_b_select),
  .pop (pop),
  .regDst (regDst),
  .PCWrite (PCWrite),
  .aluOp (aluOp)
  );
  
  shift_two BLOCO4 (
  .in (out_jump),
  .out(jump_jpc)
  );
  
  
  
  sign_extend BLOCO3 (
  .inst (word),
  .inst_out (word_sign)
  );

 endmodule
 
