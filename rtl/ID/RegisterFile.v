module RegisterFile (ReadRegister1, clk, reset, ReadRegister2, WriteData, WriteRegister, ReadData1, ReadData2, RegWrite);

input [4:0] ReadRegister1;
input [4:0] ReadRegister2;
input clk, RegWrite, reset;
input [4:0] WriteRegister;
input [31:0] WriteData;
output wire [31:0] ReadData1, ReadData2;

reg [31:0] MemoryFile [0:31];
initial $readmemh("b.b", MemoryFile);

assign ReadData1 = MemoryFile [ReadRegister1];
assign ReadData2 = MemoryFile [ReadRegister2];

	always @(posedge clk) begin
		 if (RegWrite && (WriteRegister != 5'b00000)) MemoryFile [WriteRegister] <= WriteData;
	end

endmodule