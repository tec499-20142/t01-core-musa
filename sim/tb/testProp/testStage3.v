
module testStage3(clk, npcIn, npcOut);  
 
 input clk; 
 input [31:0] npcIn;
 output reg [31:0] npcOut = 32'b0;
 
 always @(posedge clk) begin 
 	npcOut <= npcIn;
 	end 
 endmodule