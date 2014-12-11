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
localparam DATA_ADDR_WIDTH = 32;
localparam MAX_LENGTH = 100000;
localparam INST_ADDR_WIDTH = 20;
localparam DQM_WIDTH = 4;
localparam BA_WIDTH = 2;
localparam ADDRESS_WIDTH = 5;
localparam NUM_REGS = 32;
localparam EOF = 32'hFFFF_FFFF;

localparam DLX_TEST = "../tests/DLX_T1_1.hex";
