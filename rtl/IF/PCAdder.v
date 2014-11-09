module PCAdder(pcOld, pcNew);  

input [31:0] pcOld;
output [31:0] pcNew;

  always @* begin
    pcNew = pcOld + 1'b1;
    end
endmodule
