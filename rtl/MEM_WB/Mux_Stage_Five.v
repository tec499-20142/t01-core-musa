
module Mux_Stage_five(
	Mem_To_Reg,
	Read_Data,
	Alu_Result,
	Write_Data);


input Mem_To_Reg;
input [31 : 0] Read_Data;
input [31 : 0] Alu_Result;
output [31 : 0] Write_Data;

always @(*) begin 
	if(Mem_To_Reg) begin
		Write_Data = Read_Data;
	end else begin
		Write_Data = Alu_Result;
	end
end



endmodule