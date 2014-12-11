module musa_tb();

parameter PERIODO_CLK = 20;
reg clk = 1;
reg rst = 1;

initial begin
	#(PERIODO_CLK);  
end

//gerador de clock
always@(*) begin
#(PERIODO_CLK/2)clk <= !clk;
end

dataPath bloco(
.clk(clk),
.rst(rst)
);

endmodule





