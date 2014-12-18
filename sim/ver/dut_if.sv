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
    logic [DATA_WIDTH-1:0] instruction; //
    logic [DATA_WIDTH-1:0] data_read; // leitura de dados
    logic [DATA_WIDTH-1:0] data_write; // escrita de dados
    logic [ADDR_WIDTH-1:0] data_addr; //endereço do dado
    logic [DATA_WIDTH-1:0] regs [0:(2**ADDRESS_WIDTH)-1]; //banco de registradores
    bit rst_n; //
    bit clk_musa; //

    logic reg_dst;
    logic mem_read;
    logic mem_to_reg;
    logic alu_op;
    logic mem_write;
    logic reg_write;
    logic data_a_s;
    logic data_b_s;
    logic pc_src;
    logic pop;
    logic push;
    
    
    property activate_control_signals_sw0; //testa de os sinais de SW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == SW_OPCODE) |-> ##[1:5] ((mem_write) and
                                                      (data_a_s == 2'b10) and
                                                      (pc_src == 3'b010));

    endproperty
    property activate_control_signals_lw0; // testa se os sinais de LW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == LW_OPCODE) |-> ##[1:5] ((mem_read) and
                                                      (mem_to_reg) and
                                                      (reg_write) and
                                                      (pc_src == 3'b010));
    endproperty
    property activate_control_signals_add0; // testa se for ADDI ou SUBI ou ANDI ou ORI os sinais são ativados
        @(posedge clk_musa)
        ((instruction[31:26] == ADDI_OPCODE) or
         (instruction[31:26] == SUBI_OPCODE) or
         (instruction[31:26] == ANDI_OPCODE) or
         (instruction[31:26] == ORI_OPCODE)) |-> ##[1:5] ((reg_write) and 
                                                          (data_a_s == 2'b10) and
                                                          (data_b_s == 2'b00) and
                                                          (pc_src == 3'b010));
    endproperty
    property activate_control_signals_jpc0; //testa se os sinais de JPC são ativados
        @(posedge clk_musa)
        (instruction[31:26] == JPC_OPCODE) |-> ##[1:5] ((data_b_s == 2'b10) and
                                                        (pc_src == 3'b011));
    endproperty
    property activate_control_signals_brfl0; //testa se os sinais de BRFL são ativados
        @(posedge clk_musa)
        (instruction[31:26] == BRFL_OPCODE) |-> ##[1:5] ((alu_op == 3'b101) and
                                                          (data_a_s == 2'b10) and 
                                                          (pc_src == 3'b001));
    endproperty
    property activate_control_signals_jr0; // testa os sinais se for JR 
        @(posedge clk_musa)
        (instruction[31:26] == JR_OPCODE) |-> ##[1:5] (pc_src == 3'b001);
    endproperty
    property activate_control_signals_cal0; // testa os sinais se for CALL
        @(posedge clk_musa)
        (instruction[31:26] == CALL_OPCODE) |-> ##[1:5]((push) and 
                                                        (pc_src == 3'b001));
    endproperty
    property activate_control_signals_ret0; //testa os sinais de RET
        @(posedge clk_musa)
        (instruction[31:26] == RET_OPCODE) |-> ##[1:5] ((pop) and
                                                        (pc_src == 3'b000));
    endproperty
    property activate_control_signals_rtype0; //testa os sinais das instruções do tipo R: ADD, SUB, AND, OR, NOT e NOP
        @(posedge clk_musa)
        (instruction[31:26] == R_TYPE_OPCODE) |-> ##[1:5] ((reg_dst) and
                                                          (reg_write) and
                                                          (alu_op == 3'b010) and 
                                                          (data_a_s == 2'b10) and
                                                          (data_b_s == 2'b01) and
                                                          (pc_src == 3'b010));
    endproperty
    property activate_control_signals_muldiv0; //testa os sinais se for MUL ou DIV
        @(posedge clk_musa)
        ((instruction[5:0] == MULT_OPCODE) or (instruction[5:0] == DIV_OPCODE)) |-> ##[1:5] ((reg_dst) and
                                                                                              (reg_write) and
                                                                                              (alu_op == 3'b010) and
                                                                                              (data_a_s == 2'b10) and
                                                                                              (data_b_s == 2'b01) and
                                                                                              (pc_src == 3'b010));
    endproperty
    property activate_control_signals_cmp0; //testa os sinais do CMP
        @(posedge clk_musa)
        (instruction[31:26] == CMP_OPCODE) |-> ##[1:5] ((alu_op == 3'b110) and
                                                        (data_a_s == 2'b10) and
                                                        (data_b_s == 2'b01) and
                                                        (pc_src == 3'b010));
    endproperty
    property activate_control_signals_halt0; //testa os sinais do HALT
        @(posedge clk_musa)
        (instruction[31:26] == HALT_OPCODE) |-> ##[1:5] (pc_src == 3'b100);
    endproperty

    assert property (activate_control_signals_sw0);
    assert property (activate_control_signals_lw0);
    assert property (activate_control_signals_add0);
    assert property (activate_control_signals_jpc0);
    assert property (activate_control_signals_brfl0);
    assert property (activate_control_signals_jr0);
    assert property (activate_control_signals_cal0);
    assert property (activate_control_signals_ret0);    
    assert property (activate_control_signals_rtype0);
    assert property (activate_control_signals_muldiv0);
    assert property (activate_control_signals_cmp0);
    assert property (activate_control_signals_halt0);
endinterface

