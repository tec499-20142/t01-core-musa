
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

reg clk;

//dut_if interface
dut_if dut_if(clk);


dataPath
      #(
         .DATA_WIDTH(DATA_WIDTH),
         .ADDR_WIDTH(ADDR_WIDTH)
      )
      musa_u0
      (
         .clk(clk),
         .rst(dut_if.rst_n),
         .read_in(),
         .read1(),
         .read2(),
         .read3(),
         .read4()
      );

initial begin
 clk = 0;
end

always begin
   #10  clk = ~clk;
end

//------------------------------------ MONITOR -----------------------------------------//
always@(*)begin
   //clk = musa_u0.clk;
   //dut_if.clk = musa_u0.clk;
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

   for(int i=0;i<NUM_REGS;i++)begin
    dut_if.regs[i]= musa_u0.BLOCO2.StageTwo.BLOCO1.RegisterFile.MemoryFile[i];
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
   monitor_u0.reset();
   monitor_u0.read_data();
   monitor_u0.read_instruction();
   repeat(100)@(posedge clk);
end

endmodule