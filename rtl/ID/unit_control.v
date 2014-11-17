module unit_Control(
opcode, 
clk, 
branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, regDst, PCWrite, 
aluOp);

input [5:0] opcode;
input clk;
output  branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, regDst,PCWrite;
reg [2:0]stage;
output  [1:0] aluOp;


always@ (*)
begin
			if(opcode == 6'h01)
				begin
				regDst = 1'b1;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b0;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b0;
				regWrite = 1'b1;
				jump = 1'b0;
				end
			else if(opcode == 6'h02)
				begin
				regDst = 1'b1;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b0;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b0;
				regWrite = 1'b1;
				jump = 1'b0;
				end
			else if(opcode == 6'h03)
				begin
				regDst = 1'b0;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b1;
				regWrite = 1'b1;
				jump = 1'b0;
				end
			else if (opcode == 6'h04)
			   begin
			   regDst = 1'b0;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b1;
				regWrite = 1'b1;
				jump = 1'b0;
			   end
			else if (opcode == 6'h05)
			   begin
			  regDst = 1'b0;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b1;
				regWrite = 1'b1;
				jump = 1'b0;
			   end
			else if (opcode == 6'h06)
			   begin
			     regDst = 1'b0;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b10;
				memWrite = 1'b0;
				aluSrc = 1'b1;
				regWrite = 1'b1;
				jump = 1'b0;
			   end
			else if (opcode == 6'h07)
			  begin 
			   regDst = 1'b1;
				branch = 1'b0;
				memRead = 1'b1;
				memToReg = 1'b1;
				aluOp = 2'b00;
				memWrite = 1'b0;
				aluSrc = 1'b1;
				regWrite = 1'b1;
				jump = 1'b0;
			  end
			  
			else if (opcode == 6'h08)
			  begin 
			     regDst = 1'b1;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b00;
				memWrite = 1'b1;
				aluSrc = 1'b1;
				regWrite = 1'b0;
				jump = 1'b0;
			  end
			else if (opcode == 6'h09)
			  begin 
			  jump = 1'b0;
			  end 
			  
			else if (opcode == 6'h0a)
			  begin 
			  jump = 1'b0;
			  end 
			else if (opcode == 6'h0b)
			  begin 
			      regDst = 1'b1;
				branch = 1'b1;
				memRead = 1'b0;
				memToReg = 1'b1;
				aluOp = 2'b01;
				memWrite = 1'b0;
				aluSrc = 1'b0;
				regWrite = 1'b0;
				jump = 1'b0;
			  end
			else if (opcode == 6'h0c)
			  begin 
			  jump = 1'b1;
			  end
			else if (opcode == 6'h0d)
			  begin 
			  jump = 1'b1;
			  end
			  
			 else if (opcode == 6'h0e)
			  begin 
			  
			  end
			 else if(opcode == 6'h00)
			   begin
			     	      regDst = 1'b0;
				branch = 1'b0;
				memRead = 1'b0;
				memToReg = 1'b0;
				aluOp = 2'b00;
				memWrite = 1'b0;
				aluSrc = 1'b0;
				regWrite = 1'b0;
				jump = 1'b0;
			     end
			  else
			    begin
			    //tratamento de erros;
			    end

end

always@ (posedge clk)
begin
	stage <= stage + 1'b1;
	if(stage == 3'b101)
	begin
		stage <= 1'd0;
		PCWrite <= 1'b1;
	end
	else if(stage == 3'b000)
			PCWrite <= 1'b0;
		

end

endmodule


