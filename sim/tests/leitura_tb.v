module leitura_tb; 
 
reg [31:0] data;

initial begin
        $display("Bin�rio:"); 
	$readmemb("Estimulos_Binario", data);
        $display("%b",data);

end     
endmodule 