// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA
//------------------------------------------------------------------------------
// FILE NAME: opcodes.sv
// -----------------------------------------------------------------------------
// PURPOSE:  DEFINE.
// -----------------------------------------------------------------------------

localparam R_TYPE_OPCODE = 6'h0x00;
localparam MULT_OPCODE = 6'h0x1C;
localparam DIV_OPCODE = 6'h0x05;
localparam CMP_OPCODE = 6'h0x1D;
localparam ADDI_OPCODE = 6'h0x08;
localparam SUBI_OPCODE = 6'h0x09;
localparam ANDI_OPCODE = 6'h0x0C;
localparam ORI_OPCODE = 6'h0x0D;
localparam LW_OPCODE = 6'h0x23;
localparam SW_OPCODE = 6'h0x2B;
localparam JR_OPCODE = 6'h0x11;
localparam JPC_OPCODE = 6'h0x02;
localparam BRFL_OPCODE = 6'h0x04;
localparam CALL_OPCODE = 6'h0x03;
localparam RET_OPCODE = 6'h0x01;
localparam HALT_OPCODE = 6'h0x3F;
