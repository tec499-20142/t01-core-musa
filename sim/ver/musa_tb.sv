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
wire [DATA_WIDTH-1:0] gpio_o;
wire we_gpio;

/*top
      #(
         .DATA_WIDTH(DATA_WIDTH),
         .DATA_ADDR_WIDTH(DATA_ADDR_WIDTH),
         .INST_ADDR_WIDTH(INST_ADDR_WIDTH)
      )
      top_u0
      (//autoport
         .clk(clk),
         .rst_n(dut_if.rst_n),
         .clk_proc(clk_proc),
         .gpio_o(gpio_o),
         .we_gpio(we_gpio)
      );*/


wire clk_dl;

initial begin
 clk = 0;
 clk_proc =0;
end

always begin
   #100  clk = ~clk;
end

always begin
   #1000  clk_proc = ~clk_proc;
end


//------------------------------------ MONITOR -----------------------------------------//
always@(*)begin
/*   dut_if.reg_dst = top_u0.musa_processor_u0.regDst;
   dut_if.mem_read = top_u0.musa_processor_u0.memRead;
   dut_if.mem_to_reg = top_u0.musa_processor_u0.memToReg;
   dut_if.mem_write = top_u0.musa_processor_u0.memWrite;
   dut_if.reg_write = top_u0.musa_processor_u0.regWrite;
   dut_if.data_a_s = top_u0.musa_processor_u0.data_a_s;
   dut_if.data_b_s = top_u0.musa_processor_u0.data_b_s;
   dut_if.pc_src = top_u0.musa_processor_u0.pcSrc;
   dut_if.alu_op = top_u0.musa_processor_u0.aluOp;
   dut_if.pop = top_u0.musa_processor_u0.pop;
   dut_if.push = top_u0.musa_processor_u0.push;
//   dut_if.clk_dlx = top_u0.musa_processor_u0.clk;
   dut_if.clk_dl = clk_dl;
   for(int i=0;i<NUM_REGS;i++)begin
    dut_if.regs[i]= top_u0.musa_processor_u0.instruction_decode_u0.register_bank_u0.reg_file[i];
   end */
   
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
//   monitor_u0.reset();
   $display("deu reset");
   monitor_u0.read_data();
   $display("deu read_data");
   monitor_u0.read_instruction();
   $display("leu instrução");
   repeat(100)@(posedge clk);
end

endmodule
