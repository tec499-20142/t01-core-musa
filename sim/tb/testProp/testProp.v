module testProp(clk, stage, pcWrite);

input clk;
output reg pcWrite;
output reg [2:0] stage = 3'b000;


  always @(posedge clk) begin
    stage <= stage + 1;
		if(stage == 3'b100)begin
			stage <= 3'b000;
			pcWrite <= 1;
		end
		else pcWrite <= 0;
		
	end

 endmodule
 