module dataPathTest(clk, rst, stage, _npc1, aux_push_pop);


input clk;
input rst;
output wire [31:0] _npc1;
wire [31:0] _npc2;
wire [31:0] _npc3;
wire [31:0] _npc4;
wire [31:0] _npc5;
wire _pcWrite;
output wire [2:0] stage;
wire [31:0] pc1;
output wire aux_push_pop;

assign pc1 = _npc1+1;

ProgramCounter BLOCO1 (
  .clk (clk),
  .reset(rst),
  .pcInput(_npc5),
  .pcOutput(_npc1),
  .pcWrite(_pcWrite)
  );

testStage2 BLOCO2(
.clk(clk),
.npcIn(pc1),
.npcOut(_npc2)
);

testStage3 BLOCO3 (
.clk(clk),
.npcIn(_npc2),
.npcOut(_npc3)
); 

testStage4 BLOCO4 (
.clk(clk),
.npcIn(_npc3),
.npcOut(_npc4)
 );

testStage5 BLOCO5 (
.clk(clk),
.npcIn(_npc4),
.npcOut(_npc5)
 );

 testProp BLOCO6 (
.clk(clk),
.pcWrite(_pcWrite),
.stage(stage),
.aux_push_pop(aux_push_pop)
 );

endmodule