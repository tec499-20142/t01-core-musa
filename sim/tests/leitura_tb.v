module leitura_tb; 
 
reg [31:0] data;

initial begin
        $display("Binário:"); 
	$readmemb("Estimulos_Binario", data);
        $display("%b",data);

end     
endmodule 