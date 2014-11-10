module Stack(clk, reset, readStack, writeStack, pc, stackOut, stackOverflow);

input clk;
input reset;
input readStack;
input writeStack;
input [12:0] pc;
output reg [12:0] stackOut;
reg [3:0] stackLevel;
reg [7:0] regStack [12:0];
output reg stackOverflow;

initial begin 
  stackLevel = 4'b0;
  stackOverflow = 1'b0;
end
always @(posedge clk)
begin

  if (reset == 1) begin
    stackLevel = 4'b0;
    stackOverflow = 1'b0;
  end
  else if (readStack == 1) begin 
      case (stackLevel)
        4'b0 : stackOverflow = 1'b1;
    			 4'b1 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b10 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b11 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b100 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel];
			         end
    			 4'b101 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b110 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b111 : begin stackLevel = stackLevel - 1'd1;
  			               stackOut = regStack [stackLevel]; 
			         end
    			 4'b1000 : begin stackLevel = stackLevel - 1'd1;
			               stackOut = regStack [stackLevel];
			         end
			endcase
  end
  if (writeStack == 1) begin  
      case (stackLevel)
    			 4'b0 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b1 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b10 : begin regStack [stackLevel = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b11 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b100 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b101 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b110 : begin regStack [stackLevel] = pc;
    			              stackLevel = stackLevel + 1'd1;
			         end
    			 4'b111 : begin regStack [stackLevel] = pc; 
    			              stackLevel = stackLevel + 1'd1; 
			         end
    			 4'b1000 : stackOverflow = 1'b1;
			endcase
  end
  
end
endmodule