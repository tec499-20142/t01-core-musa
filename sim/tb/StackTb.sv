module StackTb;
//Defini��o de variaveis para os testes
reg clock;
reg reset;
reg readStack;
reg writeStack;
reg [31:0] pc;
wire [31:0] stackOut;
wire stackOverflow;
wire [31:0] _npc1;
wire [2:0] stage;

initial begin
    clock = 0;
    reset = 0;
    writeStack = 0;
    readStack = 0;
    #1 pc = 32'd100;
    #10 writeStack = 1;
    #3 writeStack = 0;
    #11 readStack = 1;
    #3 readStack = 0;
    #50
    $finish;
end


//Clock do bloco de registradores
  always 
  begin
    #1  clock =  ! clock;
 end

 Stack TESTE1 (
  .clock (clock),
  .reset (reset),
  .readStack (readStack),
  .writeStack (writeStack),
  .pc(pc),
  .stackOut(stackOut),
  .stackOverflow(stackOverflow)
  );
  
endmodule