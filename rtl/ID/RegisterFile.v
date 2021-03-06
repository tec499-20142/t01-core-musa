module RegisterFile (ReadRegister1, clk, reset, 
ReadRegister2, WriteData, WriteRegister, ReadData1,
 read1, read2, read3, read4, ReadData2, RegWrite);

input [4:0] ReadRegister1;
input [4:0] ReadRegister2;
input clk, RegWrite, reset;
input [4:0] WriteRegister;
input [31:0] WriteData;
output wire [31:0] ReadData1, ReadData2;
output wire read1, read2, read3, read4;

reg [31:0] MemoryFile [0:31];
assign read1 = MemoryFile[1][0]; 
assign read2 = MemoryFile[1][1];
assign read3 = MemoryFile[1][2];
assign read4 = MemoryFile[1][3];
//initial $readmemh("b.b", MemoryFile);

assign ReadData1 = MemoryFile [ReadRegister1];
assign ReadData2 = MemoryFile [ReadRegister2];


// inicializa o banco de registradores com 0

integer i;
initial begin 
  for(i = 0; i < 32; i = i + 1)
    MemoryFile[i] = 0;
end

always @(posedge clk) begin
		if(~reset)begin
		  for(i = 0; i < 32; i = i + 1)
				MemoryFile[i] = 0;
		end
		 if (RegWrite && (WriteRegister != 5'b00000)) MemoryFile [WriteRegister] <= WriteData;
	end

endmodule