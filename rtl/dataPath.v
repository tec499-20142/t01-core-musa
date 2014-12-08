module dataPath(clk, rst);


wire [31:0] instruction;
wire [31:0] AluOut;
wire  push, pop, memRead, memWrite, aluSrc;
wire [2:0] pcSrc;
wire  [1:0] aluOp;
wire  [15:0] word;
wire [31:0] result; 
wire [31:0] readData1, readData2, outputWord;
wire [31:0] _mem_Data;
wire _pcWrite;
wire [31:0] _pcOutput, _pcInput;
wire [25:0] out_jump;

StageOne BLOCO1 (
  ._clk (clk),
  ._reset(rst),
  ._pcWrite(_pcWrite),
  ._pcInput(_pcInput),
  ._pcOutput(_pcOutput),
  .instruction(instruction)
  );

stagetwo BLOCO2(
.instruction(instruction), 
.clk(clk),
.rst(rst),  
.pcSrc (pcSrc), 
.memRead (memRead), 
.memWrite(memWrite),
.aluSrc(aluSrc),
.push(push),
.pop(pop), 
.PCWrite(_pcWrite), 
.aluOp(aluOp),
.word(word),
.AluOut(AluOut),
.out_jump(out_jump),
.mem_Data(_mem_Data),
.readData1(readData1),
.readData2(readData2), 
.outputWord(outputWord)
);

ex BLOCO3 (
.data_a(readData1), 
.data_b(readData2),
alu_control(), 
.reset (rst), 
.pc_in(_pcOutput), 
.jump_address(out_jump), 
.result(result) ,
.next_address(_pcInput)
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