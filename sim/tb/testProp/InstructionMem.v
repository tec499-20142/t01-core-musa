// +UEFSHDR----------------------------------------------------------------------
// 2014 UEFS Universidade Estadual de Feira de Santana
// TEC499-Sistemas Digitais
// ------------------------------------------------------------------------------
// TEAM: <P01>
// ------------------------------------------------------------------------------
// PROJECT: <MUSA>
// ------------------------------------------------------------------------------
// FILE NAME  : {InstructionMem.v}
// KEYWORDS 	: {Memory, Instruction, IF}
// -----------------------------------------------------------------------------
// PURPOSE: {TBD}
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy      : <None>
//   Clock Domains       : <TBD>
//   Instantiations      : <None>
//   Synthesizable (y/n) : <y>
// -UEFSHDR----------------------------------------------------------------------

module InstructionMem(address, data, clk);
  
input wire clk; 
input wire [31:0] address;
output reg [31:0] data; 
reg [2047:0] mem [31:0] = $readmemb("example.txt", mem);  

  always @(posedge clk) begin
		data <= mem[address];
	end
endmodule
