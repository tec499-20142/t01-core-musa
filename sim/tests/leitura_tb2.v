module leitura_tb2; 
 
reg [31:0] data;
file arq;

arq = $fopen(Estimulo_Binario, "rb");

initial begin
        $display("Binário:");
	while (!$feof(arq)) 
	begin 
	data = $fscanf(arq, "%b", data);
        $display("%b",data);
	end
end     
endmodule 