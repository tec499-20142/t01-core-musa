module testProp(clk, stage, pcWrite, aux_push_pop);

input clk;
output reg pcWrite;
output reg [2:0] stage = 3'b000;
output reg aux_push_pop = 1'b0;


  always @(posedge clk) begin
    stage <= stage + 1;
		if(stage == 3'b100)begin
			stage <= 3'b000;
			pcWrite <= 1;
		end
		else if(stage == 3'b001)begin
		  pcWrite <= 0;
		  aux_push_pop <= 1;
		end else if(stage == 3'b011)begin
		  pcWrite <= 0;
		  aux_push_pop <= 0;
		  end else pcWrite <= 0;
		
	end

 endmodule
 