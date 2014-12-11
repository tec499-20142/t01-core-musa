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
    logic [DATA_WIDTH-1:0] instruction; //
    logic [DATA_WIDTH-1:0] data_read; // leitura de dados
    logic [DATA_WIDTH-1:0] data_write; // escrita de dados
    logic [DATA_ADDR_WIDTH-1:0] data_addr; //endereço do dado
    logic [DATA_WIDTH-1:0] regs [0:(2**ADDRESS_WIDTH)-1]; //banco de registradores
    logic [INST_ADDR_WIDTH-1:0] dram_addr; //
    logic dram_we_n; // 
    logic dram_cas_n; //
    logic dram_ras_n; //
    logic dram_cs_n; //
    logic dram_cke; //
    bit rst_n; //
    bit clk_musa; //
    bit clk_dl; //
    bit clk_env; //

    logic reg_dst;
    logic mem_read;
    logic mem_to_reg;
    logic mem_write;
    logic reg_write;
    logic data_a_s;
    logic data_b_s;
    logic pc_src;
    logic pop;
    logic push;
    
    
    property activate_control_signals_sw0; //testa de os sinais de SW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == SW_OPCODE) |-> ##[1:2] (mem_write);

    endproperty
    property activate_control_signals_lw0; // testa se os sinais de LW são ativados
        @(posedge clk_musa)
        (instruction[31:26] == LW_OPCODE) |-> ##[1:2] ((mem_read) and
                                                      (reg_write));
    endproperty
    property activate_control_signals_add0; // testa se for ADDI ou SUBI ou ANDI ou ORI os sinais são ativados
        @(posedge clk_musa)
        ((instruction[31:26] == ADDI_OPCODE) or
         (instruction[31:26] == SUBI_OPCODE) or
         (instruction[31:26] == ANDI_OPCODE) or
         (instruction[31:26] == ORI_OPCODE)) |-> ##[1:2] (reg_write);
    endproperty
    property activate_control_signals_jpc0; //testa se os sinais de JPC são ativados
        @(posedge clk_musa)
        (instruction[31:26] == JPC_OPCODE) |-> ##[1:2] ;
    endproperty
    property activate_control_signals_brfl0; //testa se os sinais de BRFL são ativados
        @(posedge clk_musa)
        (instruction[31:26] == BRFL_OPCODE) |-> ##[1:2] ;
    endproperty
    property activate_control_signals_jr0; // testa os sinais se for JR 
        @(posedge clk_musa)
        (instruction[31:26] == JR_OPCODE) |-> ##[1:2] ;
    endproperty
    property activate_control_signals_cal0; // testa os sinais se for CALL
        @(posedge clk_musa)
        (instruction[31:26] == CALL_OPCODE)) |-> ##[1:2] (push);
    endproperty
    property activate_control_signals_ret0; //testa os sinais de RET
        @(posedge clk_musa)
        (instruction[31:26] == RET_OPCODE) |-> ##[1:2] (pop);
    endproperty
    property activate_control_signals_rtype0; //testa os sinais das instruções do tipo R: ADD, SUB, AND, OR, NOT e NOP
        @(posedge clk_musa)
        (instruction[31:26] == R_TYPE_OPCODE) |-> ##[1:2] ((reg_dst) and
                                                          (reg_write));
    endproperty
    property activate_control_signals_muldiv0; //testa os sinais se for MUL ou DIV
        @(posedge clk_musa)
        ((instruction[5:0] == MULT_OPCODE) or (instruction[5:0] == DIV_OPCODE)) |-> ##[1:2] ((reg_dst) and
                                                                                              (reg_write));
    endproperty
    property activate_control_signals_cmp0; //testa os sinais do CMP
        @(posedge clk_musa)
        (instruction[31:26] == CMP_OPCODE) |-> ##[1:2] ;
    endproperty
    property activate_control_signals_halt0; //testa os sinais do HALT
        @(posedge clk_musa)
        (instruction[31:26] == HALT_OPCODE) |-> ##[1:2] ;
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

