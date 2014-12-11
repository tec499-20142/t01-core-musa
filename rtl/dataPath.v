module dataPath(clk, rst);

input clk, rst;
wire [31:0] instruction;
wire [31:0] AluOut;
wire  push, pop, memRead, memWrite, aluSrc;
wire [2:0] pcSrc;
wire  [1:0] aluOp;
wire  [31:0] word_sign;
wire [31:0] result; 
wire [31:0] readData1, readData2;
wire [31:0] _mem_Data;
wire _pcWrite;
wire [31:0] pc_1;
wire [31:0] _pcOutput, _pcInput;
wire [31:0] jump_jpc;
wire [1:0] data_a_select, data_b_select;
wire [31:0] stack_out;
wire [5:0] func;

StageOne BLOCO1 (
  ._clk (clk),
  ._reset(rst),
  ._pcWrite(_pcWrite),
  ._pcInput(_pcInput),
  ._pcOutput(_pcOutput),
  .pcNew(pc_1),
  .instruction(instruction),
  .push(push),
  .pop(pop),
  .stack_out(stack_out)
  );

StageTwo BLOCO2(
.instruction(instruction), 
.clk(clk),
.rst(rst),  
.pcSrc(pcSrc), 
.memRead(memRead), 
.memWrite(memWrite),
.push_out(push),
.pop_out(pop), 
.PCWrite(_pcWrite), 
.aluOp(aluOp),
.outputWord(word_sign),
.AluOut(AluOut),
.mem_Data(_mem_Data),
.readData1(readData1),
.readData2(readData2), 
.jump_jpc(jump_jpc),
.data_a_select(data_a_select),
.data_b_select(data_b_select),
.func(func)
);

ex_stage BLOCO3 (
.data_a(readData1), 
.data_b(readData2),
.reset (rst),
.pc(_pcOutput), 
.pc_1(pc_1),
.immediate(word_sign),
.immediate_div_4(jump_jpc),
.stack(stack_out),
.data_a_select(data_a_select),
.data_b_select(data_b_select),
.pc_select(pcSrc),
.alu_control(aluOp),
.func(func),
.result(result),
.next_pc(_pcInput)
); 

stage_Four_Five BLOCO4 (
  .clk (clk),
  .addr (result),
  .data_in(readData2),
  .data_out(_mem_Data),
 .memRead(memRead),
 .memWrite(memWrite)
 );



endmodule