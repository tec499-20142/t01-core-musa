// topo da hierarquia no testbench. Sem sinais de entrada ou saida.
module testbench ();
// sinais para estímulo
logic clock;
logic reset;
// fios para interconexão entre os módulos.
logic [3:0] saida_duv, saida_modelo;
logic houve_erro;
// conexões
contador_duv duv (.clock(clock),.reset(reset), .contador(saida_duv));
contador_modelo referencia(.clock(clock),.reset(reset), .contador(saida_modelo));
output_checker comparador (.a(saida_duv),.b(saida_modelo),.diff(houve_erro));

initial // você pode ter várias construções initial-begin-end, tal como
	begin // múltiplos always_comb em um mesmo module

		clock=1'b0;
		reset=1'b1; // reset inativo. Valores default
		#20 reset<=1'b0; // após 20 passos de simulação, o reset vai pra zero (ativo)
		#20 reset<=1'b1; // após 20 passos de simulação, oreset vai pra um (inativo)
		for (int i=1;i<32;i=i+1) // loop com 16 pulsos de clock para testar a sequencia do contador
			#10 clock<=~clock; // a cada 10 passos de simulação, o clock alterna
		$display ("PASSOU: Não há bugs!!");
		$stop; // a simulação pára
	end
always @(posedge houve_erro) // sempre que houver borda positiva do houve_erro
	begin
		$display ("FALHOU: Há bugs!!"); // mensagem
		#10; // aguarda um pouco
		$stop; // a simulação páa (antes que a mensagem PASSOU apareça!)
	end
endmodule
