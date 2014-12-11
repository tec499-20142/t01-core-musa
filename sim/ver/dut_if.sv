// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA Processor
//------------------------------------------------------------------------------
// FILE NAME: dut_if.v
// -----------------------------------------------------------------------------
// PURPOSE:  DUT Interface.
// -----------------------------------------------------------------------------

interface dut_if (input bit clk);

    `include "defines.sv"
    `include "opcodes.sv"

//---------------------------------------//
//---------- Monitor Signals ------------//
//---------------------------------------//
    logic boot_mode;
    logic instr_rd_en; //
    logic data_rd_en; //
    logic data_wr_en; //
    logic [DATA_WIDTH-1:0] instruction; //
    logic [DATA_WIDTH-1:0] data_read; // leitura de dados
    logic [DATA_WIDTH-1:0] data_write; // escrita de dados
    logic [DATA_ADDR_WIDTH-1:0] data_addr; //endereço do dado
    logic [DATA_WIDTH-1:0] regs [0:(2**ADDRESS_WIDTH)-1]; //banco de registradores
    logic [INST_ADDR_WIDTH-1:0] dram_addr; //
    logic reg_rd_en1_out; //enable saída do reg do data A
    logic reg_rd_en2_out; // ?
    logic reg_a_wr_en_out; // 
    logic reg_b_wr_en_out; //
    logic imm_inst_out; //
    logic mem_data_rd_en_out; //
    logic mem_data_wr_en_out; //
    logic write_back_mux_sel_out; // seletor do mux entre banco de reg e memoria
    logic branch_inst_out; //
    logic branch_use_r_out; //
    logic jump_inst_out; //
    logic jump_use_r_out; //
    logic dram_we_n; // 
    logic dram_cas_n; //
    logic dram_ras_n; //
    logic dram_cs_n; //
    logic dram_cke; //
    bit rst_n; //
    bit clk_musa; //
    bit clk_dl; //
    bit clk_env; //

    
    property activate_control_signals_sw0; //testa de os sinais de SW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == SW_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                       (reg_rd_en2_out) and
                                                         (imm_inst_out) and
                                                  (mem_data_wr_en_out));  
    endproperty
    property activate_control_signals_lw0; // testa se os sinais de LW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == LW_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                      (reg_a_wr_en_out) and
                                                         (imm_inst_out) and
                                                   (mem_data_rd_en_out) and
                                              (write_back_mux_sel_out));
    endproperty
    property activate_control_signals_add0; // testa se for ADDI ou SUBI ou ANDI ou ORI os sinais são ativados
        @(posedge clk_musa)
        ((instruction[31:26] == ADDI_OPCODE) or
         (instruction[31:26] == SUBI_OPCODE) or
         (instruction[31:26] == ANDI_OPCODE) or
         (instruction[31:26] == ORI_OPCODE)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                         (reg_a_wr_en_out) and
                                                           (imm_inst_out));
    endproperty
    property activate_control_signals_jpc0; //testa se os sinais de JPC são ativados
        @(posedge clk_musa)
        (instruction[31:26] == JPC_OPCODE) |-> ##[1:2] jump_inst_out;
    endproperty
    property activate_control_signals_brfl0; //testa se os sinais de BRFL são ativados
        @(posedge clk_musa)
        (instruction[31:26] == BRFL_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                           (imm_inst_out) and
                                                        (branch_inst_out) and
                                                      (branch_use_r_out));
    endproperty
    property activate_control_signals_jrcal0; // testa os sinais se for JR ou CALL 
        @(posedge clk_musa)
        ((instruction[31:26] == JR_OPCODE) or
         (instruction[31:26] == CALL_OPCODE)) |-> ##[1:2] ((reg_a_wr_en_out) and
                                                             (jump_inst_out));
    endproperty
    property activate_control_signals_ret0; //testa os sinais de RET
        @(posedge clk_musa)
        (instruction[31:26] == RET_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                         (jump_inst_out) and
                                                        (jump_use_r_out));
    endproperty
    property activate_control_signals_rtype0; //testa os sinais das instruções do tipo R: ADD, SUB, AND, OR, NOT
        @(posedge clk_musa)
        (instruction[31:26] == R_TYPE_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                            (jump_inst_out) and
                                                            (jump_use_r_out));
    endproperty
    property activate_control_signals_muldiv0; //testa os sinais se for MUL ou DIV
        @(posedge clk_musa)
        ((instruction[5:0] == MULT_OPCODE) or (instruction[5:0] == DIV_OPCODE)) |-> ##[1:2] ((reg_rd_en1_out) and
                                                                                                      (reg_rd_en2_out) and
                                                                                                     (reg_a_wr_en_out) and
                                                                                                     (reg_b_wr_en_out));
    endproperty
    property activate_control_signals_cmp0; //testa os sinais do CMP
        @(posedge clk_musa)
        (instruction[31:26] == CMP_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                        (reg_rd_en2_out) and
                                                        (reg_a_wr_en_out) and
                                                        (reg_b_wr_en_out));
    endproperty
    property activate_control_signals_halt0; //testa os sinais do HALT
        @(posedge clk_musa)
        (instruction[31:26] == HALT_OPCODE) |-> ##[1:2] ((reg_rd_en1_out) and
                                                        (reg_rd_en2_out) and
                                                        (reg_a_wr_en_out) and
                                                        (reg_b_wr_en_out));
    endproperty

    assert property (activate_control_signals_sw0);
    assert property (activate_control_signals_lw0);
    assert property (activate_control_signals_add0);
    assert property (activate_control_signals_jpc0);
    assert property (activate_control_signals_brfl0);
    assert property (activate_control_signals_jrcal0);
    assert property (activate_control_signals_ret0);    
    assert property (activate_control_signals_rtype0);
    assert property (activate_control_signals_muldiv0);
    assert property (activate_control_signals_cmp0);
    assert property (activate_control_signals_halt0);
endinterface

