module StageTwo(
	instruction, clk, rst,  
	pcSrc, memRead, memWrite, push_out, pop_out, PCWrite, 
	aluOp,
	AluOut, mem_Data,
	readData1, readData2, outputWord, jump_jpc, data_a_select, data_b_select, func);

input [31:0] instruction;
input clk, rst;
input [31:0] AluOut;
output memRead, memWrite, PCWrite ,pop_out, push_out;
wire pop, push;
output [1:0] data_a_select, data_b_select;
output [2:0] pcSrc;
output reg  [2:0] aluOp;
output [31:0] jump_jpc;
output reg [31:0] readData1 = 1'd0;
output reg [31:0] readData2 = 1'd0;
output reg [31:0] outputWord = 8'h0;
output reg [5:0] func;
wire [31:0] read_data_1_rf, read_data_2_rf;
wire [25:0] out_jump = instruction[25:0];
wire [5:0] opcode = instruction[31:26]; 
wire [4:0] ReadRegister1 = instruction[25:21];
wire [4:0] ReadRegister2 = instruction[20:16];
wire [15:0] word = instruction[15:0];
wire [2:0] aluOp_out;
wire [5:0] func_out;
wire memToReg;
wire regDst;
wire _regWrite;
reg [31:0] out_Mux_Write_Data;
reg [4:0] out_destination;
input [31:0] mem_Data;
wire [4:0] destination = instruction[15:11];
wire aux_push_pop;
wire [31:0] word_sign;

assign func_out = instruction[5:0];
assign pop_out = aux_push_pop & pop;
assign push_out = aux_push_pop & push;

always@ (posedge clk)
begin
	readData1 <= read_data_1_rf;
	readData2 <= read_data_2_rf;
	outputWord <= word_sign;
	aluOp <= aluOp_out;
	func <= func_out;
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
  .aluOp (aluOp_out)
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
 
