// topo da hierarquia no testbench. Sem sinais de entrada ou saida.
module testbench ();
// sinais para est�mulo
logic clock;
logic reset;
// fios para interconex�o entre os m�dulos.
logic [3:0] saida_duv, saida_modelo;
logic houve_erro;
// conex�es
contador_duv duv (.clock(clock),.reset(reset), .contador(saida_duv));
contador_modelo referencia(.clock(clock),.reset(reset), .contador(saida_modelo));
output_checker comparador (.a(saida_duv),.b(saida_modelo),.diff(houve_erro));

initial // voc� pode ter v�rias constru��es initial-begin-end, tal como
	begin // m�ltiplos always_comb em um mesmo module

		clock=1'b0;
		reset=1'b1; // reset inativo. Valores default
		#20 reset<=1'b0; // ap�s 20 passos de simula��o, o reset vai pra zero (ativo)
		#20 reset<=1'b1; // ap�s 20 passos de simula��o, oreset vai pra um (inativo)
		for (int i=1;i<32;i=i+1) // loop com 16 pulsos de clock para testar a sequencia do contador
			#10 clock<=~clock; // a cada 10 passos de simula��o, o clock alterna
		$display ("PASSOU: N�o h� bugs!!");
		$stop; // a simula��o p�ra
	end
always @(posedge houve_erro) // sempre que houver borda positiva do houve_erro
	begin
		$display ("FALHOU: H� bugs!!"); // mensagem
		#10; // aguarda um pouco
		$stop; // a simula��o p�a (antes que a mensagem PASSOU apare�a!)
	end
endmodule
