module musa_tb();

parameter PERIODO_CLK = 20;
reg clk = 0;
reg rst = 1;
reg read1, read2, read3, read4;

initial begin
	#(PERIODO_CLK);  
end

//gerador de clock
always@(*) begin
#(PERIODO_CLK/2)clk <= !clk;
end

dataPath bloco(
.clk(clk),
.rst(rst), 
.read1(read1), 
.read2(read2), 
.read3(read3), 
.read4(read4)
);

endmodule





