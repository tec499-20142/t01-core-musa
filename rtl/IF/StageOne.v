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

module StageOne(_clk, _reset, _pcWrite, _pcInput, _pcOutput, instruction);

input _clk, _reset, _pcWrite;
input [31:0] _pcInput;
output reg [12:0] _pcOutput;
output reg [31:0] instruction;

ProgramCounter programCouter(.clk(_clk), 
.reset(_reset), 
.pcWrite(_pcWrite), 
.pcInput(_pcInput),
.pcOutput(_pcOutput));

PCAdder pcAdder(.pcOld(_pcInput), .pcNew(_pcOutput));

InstructionMem instructionMem(.clk(_clk), 
.reset(_reset), .address(_pcOutput), .data(instruction));

endmodule
