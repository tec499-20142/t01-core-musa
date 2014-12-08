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


module ProgramCounter(clk, reset, pcWrite, pcInput, pcOutput);  
 
 input clk; 
 input reset; 
 input pcWrite; 
 input wire [31:0] pcInput; 
 output reg [31:0] pcOutput = 32'b0; 
 
 always @ (posedge clk) begin
			if(reset == 1)
				pcOutput <= 32'b0;
		  if(pcWrite)
			  pcOutput <= pcInput; 
  end
endmodule