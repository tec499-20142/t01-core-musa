// +UEFSHDR----------------------------------------------------------------------
// 2014 UEFS Universidade Estadual de Feira de Santana
// TEC499-Sistemas Digitais
// ------------------------------------------------------------------------------
// TEAM: <P01>
// ------------------------------------------------------------------------------
// PROJECT: <MUSA>
// ------------------------------------------------------------------------------
// FILE NAME  : {StageOne.v}
// KEYWORDS 	: {IF, PC, Instruction Memory}
// -----------------------------------------------------------------------------
// PURPOSE: {Represents the stage IF of MUSA}
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy      : <sychronous, active in low level reset>
//   Clock Domains       : <TBD>
//   Instantiations      : <ProgramCounter, pcAdder & InstructionMem>
//   Synthesizable (y/n) : <y>
// -UEFSHDR----------------------------------------------------------------------

module StageOne(_clk, _reset, _pcWrite, _pcInput, _pcOutput, pcNew, instruction);

input _clk, _reset, _pcWrite;
input [31:0] _pcInput;
output wire [31:0] _pcOutput;
output wire [31:0] instruction;
output wire [31:0] pcNew;


ProgramCounter programCouter(
.clock(_clk), 
.reset(_reset), 
.pcWrite(_pcWrite), 
.pcInput(_pcInput),
.pcOutput(_pcOutput)
);

PCAdder pcAdder(
.pcOld(_pcOutput),
.pcNew(pcNew)
);

InstructionMem instructionMem(
.clock(_clk), 
.address(_pcOutput), 
.data(instruction)
);

endmodule
