// +----------------------------------------------------------------------------
// Universidade Estadual de Feira de Santana
//------------------------------------------------------------------------------
// PROJECT: MUSA
//------------------------------------------------------------------------------
// FILE NAME: musa_data_item.v
// -----------------------------------------------------------------------------
// PURPOSE: Data item of the MUSA Processor.
// -----------------------------------------------------------------------------
class musa_data_item;

    `include "defines.sv"

    logic [DATA_WIDTH-1:0] data_read [0:MAX_LENGTH-1];
    logic [DATA_WIDTH-1:0] data_write [0:MAX_LENGTH-1];
    logic [ADDR_WIDTH-1:0] data_addr [0:MAX_LENGTH-1];

endclass
