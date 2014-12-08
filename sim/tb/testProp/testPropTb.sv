// +UEFSHDR----------------------------------------------------------------------
// 2014 UEFS Universidade Estadual de Feira de Santana
// TEC499-Sistemas Digitais
// ------------------------------------------------------------------------------
// TEAM: Grupo1
// ------------------------------------------------------------------------------
// PROJECT: Core Musa
// ------------------------------------------------------------------------------
// FILE NAME  : unit_controlTb
// KEYWORDS 	: unit control, controller
// -----------------------------------------------------------------------------
// PURPOSE: Testa todas as opera��es do modulo unit_control
// -----------------------------------------------------------------------------
module testPropTb;
//Defini��o de variaveis para os testes
reg clock;
reg reset;
wire [31:0] _npc1;
wire [2:0] stage;

initial begin 
  //aqui dentro, inicio a logica do teste
    //inicio tudo em 0
    clock = 0;
    reset = 0;
    #200
    $finish;
end


//Clock do bloco de registradores
  always 
  begin
    #1  clock =  ! clock;
 end

 dataPathTest TESTE1 (
  .clk (clock),
  .rst (reset),
  .stage (stage),
  ._npc1 (_npc1)
  );
endmodule