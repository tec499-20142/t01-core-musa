module mux(
input [31:0] data_0,
input [31:0] data_1,
input [31:0] data_2, 
input [31:0] data_3, 
input [1:0] sel, 
output reg[31:0] data
);

always @(*) begin 
	case (sel)
	   2'b00: begin 
	     data = data_0; 
	   end 
	   2'b01: begin 
	     data = data_1;
	   end 
	   2'b10: begin 
	     data = data_2;
	   end 
	   2'b11: begin 
	     data = data_3;
	   end
	endcase 
end 
endmodule 
