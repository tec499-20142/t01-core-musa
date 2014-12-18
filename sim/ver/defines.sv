// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA Processor
//------------------------------------------------------------------------------
// FILE NAME: defines.sv
// -----------------------------------------------------------------------------
// PURPOSE:  DEFINES.
// -----------------------------------------------------------------------------

localparam DATA_WIDTH = 32;
localparam ADDR_WIDTH = 32;
localparam MAX_LENGTH = 100000;
localparam ADDRESS_WIDTH = 5;
localparam NUM_REGS = 32;
localparam EOF = 32'hFFFF_FFFF;

localparam MUSA_TEST = "../tests/Estimulos_Binario_Simples.bin";