module musa_tb();
parameter PERIODO_CLK = 20;
reg clk = 1;
reg rst = 1;
reg clk__ = 0;
reg [31:0] write_data, adr_write;
wire [31:0] saida_do_estagio_5;
wire [31:0] pc;

initial begin
//CARREGAR MEMÓRIA DE INSTRUÇÃO COM UM  PROGRAMA
//exemplo de um carregamento 
pc = 1’d0;
saida_do_estagio_5 = 1’d0;
write_data = 8’h3C011001;
adr_write = 8’h00000000;
#(PERIODO_CLK); 

//acabou de carregar liga o processador:
clk__=clk;
//espera executar todo o programa
#(/*tempo de execução do programa +2*/)


//VERIFICAR NA MEMÓRIA PRINCIPAL SE OS RESULTADOS CONDIZEM IMPRIMINDO MEMÓRIA(QUE IMPORTA) E VERIFICANDO MANUALMENTE SE OS RESULTADOS ESTÃO CERTOS; 
end


//gerador de clock
always@(*) begin
#(PERIODO_CLK/2)clk <= !clk;
end

dataPath bloco(
.clk(clk__),
.rst(rst),
.write_data(write_data),
.adr_write(adr_write),
.saida(saida_do_estagio_5),
.pc(pc)
);

endmodule





