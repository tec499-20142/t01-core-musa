
// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA Processor
//------------------------------------------------------------------------------
// FILE NAME: musa_tb.v
// -----------------------------------------------------------------------------
// PURPOSE: Testbench for MUSA Processor.
// -----------------------------------------------------------------------------
module musa_tb;

`include "musa_monitor.sv"
`include "defines.sv"

musa_monitor monitor_u0;

bit clk;

//dut_if interface
dut_if dut_if(clk);

//clk rst manager
reg clk_proc;

dataPath
      #(
         .DATA_WIDTH(DATA_WIDTH),
         .ADDR_WIDTH(ADDR_WIDTH)
      )
      musa_u0
      (//autoport
         .clk(clk),
         .rst_n(dut_if.rst_n)
      );



initial begin
 clk = 0;
end

always begin
   #100  clk = ~clk;
end

//------------------------------------ MONITOR -----------------------------------------//
always@(*)begin
   dut_if.pc_src = musa_u0.BLOCO2.pcSrc;
   dut_if.mem_read = musa_u0.BLOCO2.memRead;
   dut_if.mem_write = musa_u0.BLOCO2.memWrite;
   dut_if.push = musa_u0.BLOCO2.push_out;
   dut_if.pop = musa_u0.BLOCO2.pop_out;
   dut_if.alu_op = musa_u0.BLOCO2.aluOp;
   dut_if.data_a_s = musa_u0.BLOCO3.data_a_select;
   dut_if.data_b_s = musa_u0.BLOCO3.data_b_select;
   dut_if.instruction = musa_u0.BLOCO2.instruction;
   dut_if.mem_to_reg = musa_u0.BLOCO2.StageTwo.memToReg;   
   dut_if.reg_dst = musa_u0.BLOCO2.StageTwo.regDst;
   dut_if.reg_write = musa_u0.BLOCO2.StageTwo._regWrite;
   dut_if.clk = musa_u0.BLOCO2.clk;
   for(int i=0;i<NUM_REGS;i++)begin
    dut_if.regs[i]= musa_u0.BLOCO2.RegisterFile.MemoryFile[i];
   end 
   
end
//--------------------------------------------------------------------------------------//

//Verification Environment Flow
initial
begin
   $display("--------------------------------------------------------");
   $display("---------------- MUSA PROCESSOR SIMULATION --------------");
   $display("--------------------------------------------------------");
   $display("\n");
   monitor_u0 = new(dut_if);
   $display("criou o dut_if");
   monitor_u0.reset();
   $display("deu reset");
   monitor_u0.read_data();
   $display("deu read_data");
   monitor_u0.read_instruction();
   $display("leu instrucao");
   repeat(100)@(posedge clk);
end

endmodule