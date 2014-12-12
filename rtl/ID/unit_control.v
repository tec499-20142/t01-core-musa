module unit_control(
	opcode, 
clk, reset, 
pcSrc, memRead, pop, push, memToReg, memWrite, data_a_select, data_b_select, regWrite, regDst, PCWrite, 
aluOp, stage, aux_push_pop);

input [5:0] opcode;
input clk;
input reset;
output reg memRead, memToReg, memWrite, regWrite, regDst,PCWrite, push, pop;
output reg [2:0] stage = 3'b000;
output reg [2:0] pcSrc;
output reg [1:0] data_a_select, data_b_select; 
output reg [2:0] aluOp;
output reg aux_push_pop;


parameter nop = 6'b000000;
parameter LOGICAS = 6'b000000;	
parameter MUL = 6'b011100;		
parameter DIV = 6'b000101;	
parameter CMP= 6'b000000;		

parameter ADDI = 6'b001000;		
parameter SUBI= 6'b001001; //InstruÃƒÂ§ÃƒÂ£o: addiu		
parameter ANDI = 6'b001100;		
parameter ORI	= 6'b001101;
parameter LW	= 6'b100011;
parameter SW	= 6'b101011;

parameter JR = 6'b010001;            //InstruÃƒÂ§ÃƒÂ£o: bclf
parameter JPC	=	6'b000010;			  	  //InstruÃƒÂ§ÃƒÂ£o: j
parameter BRFL	=	6'b000100;				    //InstruÃƒÂ§ÃƒÂ£o: beq
parameter CALL		=      6'b000011;				    //InstruÃƒÂ§ÃƒÂ£o: jal
parameter RET		=      6'b000001;
parameter HALT = 6'b111111; //FALTA O OPCODE DO HALT

always@ (*)
begin
  case(opcode)
	    LOGICAS :
	      begin
      		regDst = 1'b1;
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b010;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
		      pcSrc = 3'b010;
		      data_a_select = 2'b10;
		      data_b_select = 2'b01;
				push = 1'b0;
				pop = 1'b0;
  		  end
		MUL :
		begin
		      regDst = 1'b1;
				memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b010;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
		      pcSrc = 3'b010;
		      data_a_select = 2'b10;
		      data_b_select = 2'b01;
				push = 1'b0;
				pop = 1'b0;
		end
	  
	  DIV :
		begin
		      regDst = 1'b1;
				memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b010;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
		      pcSrc = 3'b010;
		      data_a_select = 2'b10;
		      data_b_select = 2'b01;
				push = 1'b0;
				pop = 1'b0;
		end
		
	 ADDI :
		begin
		      regDst = 1'b0;
		      data_a_select = 2'b10;
		      data_b_select = 2'b00;
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b000;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
				push = 1'b0;
				pop = 1'b0;
		end
		
		ANDI :
		begin
		      regDst = 1'b0;
		      data_a_select = 2'b10;
		      data_b_select = 2'b00;
		      pcSrc = 3'b010;
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b011;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
				push = 1'b0;
				pop = 1'b0;
		end
	SUBI :
		begin
		      regDst = 1'b0;
		      data_a_select = 2'b10;
		      data_b_select = 2'b00;
		      pcSrc = 3'b010;
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b001;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
				push = 1'b0;
				pop = 1'b0;
		end
		
	 ORI :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b10;
		      data_b_select = 2'b00;
		      pcSrc = 3'b010;
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b100;
		      memWrite = 1'b0;
		      regWrite = 1'b1;
				push = 1'b0;
				pop = 1'b0;
		end
		
	 LW :
		begin
		     	regDst = 1'b0;
		      data_a_select = 2'b10;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b010;
	         memRead = 1'b1;
	         memToReg = 1'b1;
	         aluOp = 3'b000;
          	memWrite = 1'b0;
	         regWrite = 1'b1;
				push = 1'b0;
				pop = 1'b0;
		end
	 SW :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b10;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b010;
				memWrite = 1'b1;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				push = 1'b0;
				pop = 1'b0;
		      
		      
		end
		
	 JR :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b00;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b001;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				push = 1'b0;
				pop = 1'b0;
		end
		
		JPC :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b00;
		  	   data_b_select = 2'b10;
		  	   pcSrc = 3'b100;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				push = 1'b0;
				pop = 1'b0;
		end
		
		BRFL :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b10;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b001;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b101;
	         regWrite = 1'b0;
				push = 1'b0;
				pop = 1'b0;
		end
		
		CALL :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b00;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b001;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				push = 1'b1;
				pop = 1'b0;
		end
		
		
	 RET :
		begin
				regDst = 1'b0;
		      data_a_select = 2'b00;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b000;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				pop = 1'b1;
				push = 1'b0;
		end
			
	 HALT :
		begin
		      regDst = 1'b0;
		      data_a_select = 2'b00;
		  	   data_b_select = 2'b00;
		  	   pcSrc = 3'b110;
				memWrite = 1'b0;
	         memRead = 1'b0;
	         memToReg = 1'b0;
	         aluOp = 3'b000;
	         regWrite = 1'b0;
				push = 1'b0;
				pop = 1'b0;
		end
		 default :
		 begin
		      regDst = 1'b0;//nop
		      memRead = 1'b0;
		      memToReg = 1'b0;
		      aluOp = 3'b010;
		      memWrite = 1'b0;
		      regWrite = 1'b0;
		      pcSrc = 3'b010;
		      data_a_select = 2'b00;
		      data_b_select = 2'b00;
				push = 1'b0;
				pop = 1'b0;
		 end
		    
  endcase
end

  always @(posedge clk) begin
    stage <= stage + 3'b001;
		if(stage == 3'b100)begin
			stage <= 3'b000;
			PCWrite <= 1;
		end
		else if(stage == 3'b001)begin
		  PCWrite <= 0;
		  aux_push_pop <= 1;
		end else if(stage == 3'b011)begin
		  PCWrite <= 0;
		  aux_push_pop <= 0;
		  end else PCWrite <= 0;
		
	end
endmodule