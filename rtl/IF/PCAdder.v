// +UEFSHDR----------------------------------------------------------------------
// 2014 UEFS Universidade Estadual de Feira de Santana
// TEC499-Sistemas Digitais
// ------------------------------------------------------------------------------
// TEAM: <P01>
// ------------------------------------------------------------------------------
// PROJECT: <MUSA>
// ------------------------------------------------------------------------------
// FILE NAME  : {PCAdder.v}
// KEYWORDS 	: {PC, Add, IF}
// -----------------------------------------------------------------------------
// PURPOSE: {TDB}
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy      : <None>
//   Clock Domains       : <None>
//   Instantiations      : <None>
//   Synthesizable (y/n) : <y>
// -UEFSHDR----------------------------------------------------------------------

module PCAdder(pcOld, pcNew);  

input [31:0] pcOld;
output reg[31:0] pcNew;

  always @(*) begin
    pcNew = pcOld + 1'b1;
    end
endmodule
