// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA Processor
//------------------------------------------------------------------------------
// FILE NAME: musa_monitor.v
// -----------------------------------------------------------------------------
// PURPOSE: Observes and Check data from DUT.
// -----------------------------------------------------------------------------

class musa_monitor;

  `include "musa_data_item.sv"
  `include "opcodes.sv"
  `include "defines.sv"

  musa_data_item data_collected = new;
  virtual interface dut_if dut_if;

  int cnt_stop;
  logic [DATA_WIDTH-1:0] instruction;
  logic [DATA_WIDTH-1:0] regs_reference [0:(2**ADDRESS_WIDTH)-1];
  logic [DATA_WIDTH-1:0] data_write_reference [0:MAX_LENGTH-1];

  function new (virtual interface dut_if m_dut_if);
  begin
     dut_if = m_dut_if;
  end
  endfunction

  task reset();
    begin
      for(int i=0; i<MAX_LENGTH; i++)begin
        data_collected.data_write[i] = 0;
      end
      dut_if.rst_n = 1;
      #10;
      dut_if.rst_n = 0;
      #30;
    end
  endtask

  task read_data();
    fork
      forever begin
        $display("----------------- READ DATA MONITOR --------------------");
        @(posedge dut_if.clk);   
        if(dut_if.mem_write)
           data_collected.data_write[dut_if.data_addr] = dut_if.data_write;
      end
    join_none
  endtask

  task read_instruction();
    fork
      forever begin
        $display("-------------- READ INSTRUCTION MONITOR ----------------");
        @(posedge dut_if.clk);
        $display("instruction: %x", dut_if.instruction);
        instruction = dut_if.instruction;
        if(instruction == 'h00) begin
          $display("entrei no if1");
          if(cnt_stop == 5) begin
            cnt_stop = 0;
            repeat(15)@(negedge dut_if.clk);
            $display("vou entrar no check");
            check();
          end
          else begin
            cnt_stop = cnt_stop + 1;
          end
        end
        else begin
          cnt_stop = 0;
        end
    end
    join_none
  endtask

  task check();
    begin
      string compile_c;
      string execute_c;
      string f_path;
      integer fp,c;
      int cnt, ok;
      int error_reg;
      int error_mem;

      $display("entrei no check");
      $sformat (compile_c, "gcc ../model/mainHex.c -o mainHex_model.o");
      $system(compile_c);
      //$sformat (execute_c, "./mainHex_model.o ../tests/estimulos_binario_simples.bin");
      $sformat (execute_c, "./mainHex_model.o %s ",MUSA_TEST);
      $system(execute_c);
      $display("DISPLAY: %s",MUSA_TEST);

      f_path = "./registers.hex";
      fp = $fopen( f_path, "r");
      error_reg = 0;
      cnt = 0;
      c = $fgetc(fp);
      while(c!=EOF)begin
         //Push the character back to the file then read the next time
         ok = $ungetc(c, fp);
         //read data
         ok = $fscanf(fp,"%h\t", regs_reference[cnt]);
         //compare reference model and rtl results
         if(regs_reference[cnt] !== dut_if.regs[cnt]) begin
            if(!error_reg)begin
              $display("\n");
              $display("********************************************************");
              $display("********   ERROR : RESULTS FROM REGISTER BANK   ********");
              $display("********************************************************");
              error_reg = 1;
            end
            $display("REF register[%0d]: %0h <----> DUT register[%0d]: %0h", cnt, regs_reference[cnt], cnt, dut_if.regs[cnt]);
         end
         cnt = cnt + 1;
         //while not EOF
         c = $fgetc(fp);
      end
      f_path = "./mem.hex";
      fp = $fopen( f_path, "r");
      error_mem = 0;
      cnt = 0;
      c = $fgetc(fp);
      while(c!=EOF)begin
         //Push the character back to the file then read the next time
         ok = $ungetc(c, fp);
         //read data
         ok = $fscanf(fp,"%h\t", data_write_reference[cnt]);
         //compare reference model and rtl results
         if(data_write_reference[cnt] !== data_collected.data_write[cnt])begin
            if(!error_mem)begin
              $display("\n");
              $display("********************************************************");
              $display("********   ERROR : RESULTS FROM MEMORY DATA   **********");
              $display("********************************************************");
              error_mem = 1;
            end
            $display("REF memory addr[%0d]: %0h <----> DUT memory addr[%0d]: %0h", cnt, data_write_reference[cnt], cnt, data_collected.data_write[cnt]);
         end
         cnt = cnt + 1;
         //while not EOF
         c = $fgetc(fp);
      end
      if(error_mem || error_reg)
        $finish;
      $display("\n");
      $display("********************************************************");
      $display("*********  TEST PASSED : CONGRATULATIONS!!  ************");
      $display("********************************************************");
      $stop;
    end
  endtask

endclass