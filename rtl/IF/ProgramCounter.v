  // +UEFSHDR----------------------------------------------------------------------
// 2014 UEFS Universidade Estadual de Feira de Santana
// TEC499-Sistemas Digitais
// ------------------------------------------------------------------------------
// TEAM: <P01>
// ------------------------------------------------------------------------------
// PROJECT: <MUSA>
// ------------------------------------------------------------------------------
// FILE NAME  : {ProgramCounter.v}
// KEYWORDS 	: {PC, IF}
// -----------------------------------------------------------------------------
// PURPOSE: {TDB}
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy      : <asychronous, active in low level reset>
//   Clock Domains       : <TBD>
//   Instantiations      : <None>
//   Synthesizable (y/n) : <y>
// -UEFSHDR----------------------------------------------------------------------

module mux_PC(pcSrc, pilha, ready_data1, relative_pc, pc_sequency, result);
input [31:0] pc_pilha, pc_ready_data1, relative_pc, pc_sequency;
output [31:0] result;
input [1:0] pcSrc;

parameter PILHA = 00;
parameter REGISTERS = 01;
parameter SEQUENCY = 00;

always@(*)
begin
    if(pcSrc == PILHA)
    result = pc_pilha;
    else if (pcSrc == REGISTERS)
    result = pc_ready_data1;
    else if(pcSrc == SEQUENCY)
    result = pc_sequency;
    else
    result = relative_pc;
end
endmodule
