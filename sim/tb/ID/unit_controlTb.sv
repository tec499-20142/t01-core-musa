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
module unit_controlTb;
//Defini��o de variaveis para os testes
reg [5:0] opcode; //codigo da op
reg clock;
reg reset;
wire [1:0] pcSrc;
wire push;
wire memRead;
wire memWrite;
wire memToReg;
wire regWrite;
wire pop;
wire regDst;
wire PCWrite;
wire [1:0] aluOp;
wire [1:0] aluSrc;
wire [2:0] stage;

initial begin 
  //aqui dentro, inicio a logica do teste
    //inicio tudo em 0
    clock = 0;
    reset = 0;
    opcode = 6'b000000;
    
     #3  opcode = 6'b011100;
     #4 reset = 1;
     #1 reset = 0;
     #10  opcode = 6'b000101;
     #10  opcode = 6'b001000;
     #10  opcode = 6'b001001;
     #10  opcode = 6'b001100;
     #10  opcode = 6'b001101;
     #10  opcode = 6'b100011;
     #10  opcode = 6'b101011;
     #10  opcode = 6'b010001;
     #10  opcode = 6'b000010;
     #10  opcode = 6'b000100;
     #10  opcode = 6'b000011;
     #10  opcode = 6'b000001;
     $finish; //  aguardo 10 unidades de tempo e finalizo o teste
end


//Clock do bloco de registradores
  always 
  begin
    #1  clock =  ! clock;
 end

//Aqui eu instancio o modulo que eu quero testar. Nesse caso, o modulo Processing_Unit � o que eu quero testar.
 unit_Control BLOCO1 (
  .opcode (opcode),
  .clk (clock),
  .pcSrc (pcSrc),
  .push (push),
  .memRead (memRead),
  .memWrite(memWrite),
  .memToReg(memToReg),
  .aluSrc(aluSrc),
  .regWrite (_regWrite),
  .pop (pop),
  .regDst (regDst),
  .PCWrite (PCWrite),
  .aluOp (aluOp),
  .stage (stage),
  .reset (reset)
  );
endmodule