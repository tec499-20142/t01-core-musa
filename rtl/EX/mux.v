module mux(
input [31:0] data_a,
input [31:0] data_b, 
input sel, 
output reg[31:0] data);

always @(sel) begin 
	if(~sel) begin 
		data = data_a;
	end
	else begin
		data = data_b;
	end 
end 
endmodule 