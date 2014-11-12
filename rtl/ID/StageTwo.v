module stagetwo(
instruction, 
writeData, writeRegister, clk, rst,  
branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, regDst, 
aluOp,
word,
readData1, readData2, readData3, outputWord);

input [31:0] instruction;
input writeData, writeRegister, clk, rst;
output  branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, regDst;
output  [1:0] aluOp;
output  [15:0] word;
output [31:0] readData1, readData2, readData3, outputWord;
reg [2:0] stage = 0;
wire [5:0] operation = instruction[31:26]; 
reg  branch, memRead, memToReg, memWrite, aluSrc, regWrite, jump, regDst;
reg  [1:0] aluOp;


always@ (posedge clk or posedge rst)
begin
	if(clk)
	begin
		if(stage == 3'd0) begin
		
			stage <= 3'd1; 
		end
		else if (stage == 3'd1) begin
			if(operation == 6'h01)
				begin
				regDst <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b0;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b0;
				regWrite <= 1'b1;
				jump <= 1'b0;
				end
			else if(operation == 6'h02)
				begin
				regDst <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b0;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b0;
				regWrite <= 1'b1;
				jump <= 1'b0;
				end
			else if(operation == 6'h03)
				begin
				regDst <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b1;
				regWrite <= 1'b1;
				jump <= 1'b0;
				end
			else if (operation == 6'h04)
			   begin
			   regDst <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b1;
				regWrite <= 1'b1;
				jump <= 1'b0;
			   end
			else if (operation == 6'h05)
			   begin
			  regDst <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b1;
				regWrite <= 1'b1;
				jump <= 1'b0;
			   end
			else if (operation == 6'h06)
			   begin
			     regDst <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b10;
				memWrite <= 1'b0;
				aluSrc <= 1'b1;
				regWrite <= 1'b1;
				jump <= 1'b0;
			   end
			else if (operation == 6'h07)
			  begin 
			   regDst <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b1;
				memToReg <= 1'b1;
				aluOp <= 2'b00;
				memWrite <= 1'b0;
				aluSrc <= 1'b1;
				regWrite <= 1'b1;
				jump <= 1'b0;
			  end
			  
			else if (operation == 6'h08)
			  begin 
			     regDst <= 1'b1;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b00;
				memWrite <= 1'b1;
				aluSrc <= 1'b1;
				regWrite <= 1'b0;
				jump <= 1'b0;
			  end
			else if (operation == 6'h09)
			  begin 
			  jump <= 1'b0;
			  end 
			  
			else if (operation == 6'h0a)
			  begin 
			  jump <= 1'b0;
			  end 
			else if (operation == 6'h0b)
			  begin 
			      regDst <= 1'b1;
				branch <= 1'b1;
				memRead <= 1'b0;
				memToReg <= 1'b1;
				aluOp <= 2'b01;
				memWrite <= 1'b0;
				aluSrc <= 1'b0;
				regWrite <= 1'b0;
				jump <= 1'b0;
			  end
			else if (operation == 6'h0c)
			  begin 
			  jump <= 1'b1;
			  end
			else if (operation == 6'h0d)
			  begin 
			  jump <= 1'b1;
			  end
			  
			 else if (operation == 6'h0e)
			  begin 
			  
			  end
			 else if(operation == 6'h00)
			   begin
			     	      regDst <= 1'b0;
				branch <= 1'b0;
				memRead <= 1'b0;
				memToReg <= 1'b0;
				aluOp <= 2'b00;
				memWrite <= 1'b0;
				aluSrc <= 1'b0;
				regWrite <= 1'b0;
				jump <= 1'b0;
			     end
			  else
			    begin
			    //tratamento de erros;
			    end


			stage <= 3'd2;
		end
		else if (stage == 3'd2) begin
		
			stage <= 3'd3;
		end
		else if(stage == 3'd3) begin
		
			stage <= 3'd4;
		end
		else begin
		
			stage <= 3'd0;
		end
	end
	else begin
	  	stage <= 3'd0;
	  end

end

endmodule


