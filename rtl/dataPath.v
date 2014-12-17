module dataPath(clk, rst, read1, read2, read3, read4, read_in, lcd_data_out, lcd_on_out,
lcd_blon_out, lcd_rw_out, lcd_en_out, lcd_rs_out);

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;

// LCD signals
output [7:0] lcd_data_out; 	// LCD data
output lcd_on_out;			// LCD power on/off
output lcd_blon_out;		// LCD back light on/off
output lcd_rw_out;			// LCD read/write select, 0 = write, 1 = read
output lcd_en_out;			// LCD enable
output lcd_rs_out;			// LCD command/data select, 0 = command, 1 = data
input read_in; 

input clk, rst;
wire [31:0] instruction;
wire  push, pop, memRead, memWrite, aluSrc;
wire [2:0] pcSrc;
wire  [2:0] aluOp;
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
output read1, read2, read3, read4;

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
.pcSrc(pcSrc), //fonte do PC
.memRead(memRead), //leitura de memória
.memWrite(memWrite), //escrita de memória
.push_out(push), //coloca na pilha
.pop_out(pop), //retira da pilha
.PCWrite(_pcWrite), //escrita do PC
.aluOp(aluOp), //operação da ULA
.outputWord(word_sign), //?? 
.AluOut(result), //resultado da ULA
.mem_Data(_mem_Data), //??
.readData1(readData1), //??
.readData2(readData2), //??
.jump_jpc(jump_jpc), //??
.data_a_select(data_a_select),// seleção do mux do dado a
.data_b_select(data_b_select),// seleção do mux do dado b
.read1(read1),//??
.read2(read2),//??
.read3(read3),//??
.read4(read4),//??
.func(func)// func da instrução R ?
);

ex_stage BLOCO3 (
.data_a(readData1), 
.data_b(readData2),
.clk(clk),
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

lcd_mem_read 
#(
	.ADDR_WIDTH(ADDR_WIDTH),
	.DATA_WIDTH(DATA_WIDTH)
) lcd_mem_read_u0 (
	.clk_50(clk),    			// Board clock 50Mhz
	.rst_n(rst),  				// Asynchronous reset active low key[0]
	.read_in(read_in),			// Read trigger key[3]
	
	// Data memory
	.mem_data_in(_mem_Data), 	// Data memory output
	.addr_out(result),	// Data memory address
	.data_mem_rd_en_out(memRead),			// Data memory read enable

	// LCD signals
	.lcd_data_out(lcd_data_out), 	// LCD data
	.lcd_on_out(lcd_on_out),			// LCD power on/off
	.lcd_blon_out(lcd_blon_out),		// LCD back light on/off
	.lcd_rw_out(lcd_rw_out),			// LCD read/write select, 0 = write, 1 = read
	.lcd_en_out(lcd_en_out),			// LCD enable
	.lcd_rs_out(lcd_rs_out)			// LCD command/data select, 0 = command, 1 = data
);



endmodule