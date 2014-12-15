// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA
//------------------------------------------------------------------------------
// FILE NAME: opcodes.sv
// -----------------------------------------------------------------------------
// PURPOSE:  DEFINE.
// -----------------------------------------------------------------------------

localparam R_TYPE_OPCODE = 6'b000000;
localparam MULT_OPCODE = 6'b011100;
localparam DIV_OPCODE = 6'b000101;
localparam CMP_OPCODE = 6'b011101;
localparam ADDI_OPCODE = 6'b001000;
localparam SUBI_OPCODE = 6'b001001;
localparam ANDI_OPCODE = 6'b001100;
localparam ORI_OPCODE = 6'b001101;
localparam LW_OPCODE = 6'b100011;
localparam SW_OPCODE = 6'b101011;
localparam JR_OPCODE = 6'b010001;
localparam JPC_OPCODE = 6'b000010;
localparam BRFL_OPCODE = 6'b000100;
localparam CALL_OPCODE = 6'b000011;
localparam RET_OPCODE = 6'b000001;
localparam HALT_OPCODE = 6'b111111;
