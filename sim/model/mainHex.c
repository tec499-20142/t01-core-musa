#include <stdio.h>
#include <stdlib.h>

//define equals (Olhar na ula)

//Global Variables:
//pc: Program Counter
//registers[]: represent register bank
//mem[]: Represent the data memory
int  pc=0, registers[32], mem[65536], stack[8], *sp;
unsigned int registerflag = 0x00;
//sp = &stack[0];
int tam_stack = 0;

//Fuction to identify the instruction type:
// i - I-type Instruction
// r - R-type Instruction
// j - J-type Instruction
char identify_instruction_type(int instruction_opcode){
	char result;
	
	if(instruction_opcode == 0x08 || instruction_opcode == 0x09 || instruction_opcode == 0x0C || instruction_opcode == 0x0D || instruction_opcode == 0x23 || instruction_opcode == 0x2B || instruction_opcode == 0x1D){
		result = 'i';
	}
	else if (instruction_opcode == 0x00 || instruction_opcode == 0x1C || instruction_opcode == 0x05){
		result = 'r';
	}
	else if (instruction_opcode == 0x11 || instruction_opcode == 0x02 || instruction_opcode == 0x04 || instruction_opcode == 0x03 || instruction_opcode == 0x01 || instruction_opcode == 0x3F){
		result = 'j';
	}
	else{
		result = 'e';
	}
	return result;

}

//Function responsible to reproduce the results of the i-type instructions
void decode_i_type(unsigned int instruction_opcode, unsigned int instruction){
	int rd, rs1, imm;
	
	//Define the fields of the instructions
	rs1 = ((instruction >> 21) & 0x1F);
	rd = ((instruction >> 16) & 0x1F);		
	imm = (instruction & 0xFFFF);
	printf("RS1: %x RD: %x IMM: %x\n", rs1, rd, imm);

	//Load Instruction - lw RD = mem
	if(instruction_opcode == 0x23){
		registers[rd] = mem[registers[rs1]];
	}
	//Store Instruction - sw mem = RD
	else if(instruction_opcode == 0x2B){
		mem[registers[rs1]] = registers[rd];
	}
	//addi - RD = RS1 + Sext(imm)
	else if(instruction_opcode == 0x08){
		registers[rd] = registers[rs1] + imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
 	}
 	//subi RD = RS1 - Sext(imm)
 	else if(instruction_opcode == 0x09){
		registers[rd] = registers[rs1] - imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//andi RD = RS1 ^ Sext(imm)
	else if(instruction_opcode == 0x0C){
		registers[rd] = registers[rs1] & imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//ori RD = RS1 V Sext(imm)
	else if(instruction_opcode == 0x0D){
		registers[rd] = registers[rs1] | imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//cmp RF == CONST terminar
	else if(instruction_opcode == 0x1D){
		
        if (registers[rs1] == imm){
        	registerflag = 0x01;
		} 		
		else if(registers[rs1] > imm){
			registerflag = 0x04;
		} else {
			registerflag = 0x00;
		}
		            
            printf("Valor da Flag: %x\n", registerflag);
	}
}

//Function responsible to reproduce the results of the r-type instructions
void decode_r_type(unsigned int instruction_opcode, unsigned int instruction){
	int rd, rs1, rs2, function;
	
	//Define the fields of the instructions
	rs1 = ((instruction >> 21) & 0x1F);
	rs2 = ((instruction >> 16) & 0x1F);
	rd = ((instruction >> 11) & 0x1F);	
	function = (instruction & 0x3F);

	printf("RS1: %x RS2: %x RD: %x Function: %x\n", rs1, rs2, rd, function);
	
	//add - RD = RS1 + RS2
	if(function == 0x20){
		registers[rd] = registers[rs1] + registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//sub - RD = RS1 - RS2
	else if(function == 0x22){
		registers[rd] = registers[rs1] - registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//and - RD = RS1 & RS2
	else if(function == 0x24){
		registers[rd] = registers[rs1] & registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//or
	else if(function == 0x25){
		registers[rd] = registers[rs1] | registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//mult - RD = RS1 . RS2
	else if(function == 0x02){
		registers[rd] = registers[rs1] * registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//div - RD = RS1 / RS2
	else if(function == 0x01){
		registers[rd] = registers[rs1] / registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
		printf("\n PASSA DAQUI\n");
	}
	//not
	else if(function == 0x27){
		registers[rd] = ~registers[rs2];
		printf("rs1: %x registers[rs2] %x\n",rs2, registers[rs2]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//nop
	else if(function == 0x00){
	    printf("Nada acontece");
	}
}
//Implementar o BRFL
//Function responsible to reproduce the results of the j-type instructions
void decode_j_type(unsigned int instruction_opcode, unsigned int instruction){
	int pc_offset, rd;
	pc_offset = (instruction);
	rd = ((instruction >> 11) & 0x1F);

	//JR  pc = addr
	if(instruction_opcode == 0x11){
            pc = pc_offset - 1;// -1 because the increment of for.
	}
	//JPC  pc = pc + addr
	else if(instruction_opcode == 0x02){
            pc = pc + pc_offset;// -1 because the increment of for.
	}
	//BRFL
	else if(instruction_opcode == 0x04){
			if(registerflag == 0x01 || registerflag == 0x04){
				pc = registers[rd];
			}			
	}
	//CALL
	else if(instruction_opcode == 0x03){
            stack[tam_stack] = pc; //ponteiro para um endereço vazio da pilha
			pc = pc_offset;
			tam_stack++;
	}
	//RET -
	else if(instruction_opcode == 0x01){
            if(tam_stack >= 0){
            	pc = stack[tam_stack]; //fazer ponteiro
				tam_stack--;	
			}
			
	}
	//HALT - finish the program
	else if(instruction_opcode == 0x3F){
            pc = pc_offset - 1;
	}

}

//Function responsible to write in a file the values stored in registers and data memory.
//The files will be used to compare with the results of the hardware simulation
void write_results(void){
	int j;
	FILE *arq_registers, *arq_mem;
	arq_registers = fopen("registers.b", "wt");
	arq_mem = fopen("mem.b", "wt");

	for(j=0;j<32;j++){
		fprintf(arq_registers, "%x\n", registers[j]);
	}

	for(j=0;j<65536;j++){
		fprintf(arq_mem, "%x\n", mem[j]);
	}


	fclose(arq_registers);
	fclose(arq_mem);

}


void main (int argc, char *argv[]){
	FILE *arq_instructions;
	unsigned int *instruction;//[65536];
	unsigned int instruction_opcode;
	char *reading_result, *reading_result_opcode;
	char instruction_type;
	int  size_instruction;
	//printf("Parametro: %s\n", argv[1]);
	instruction = malloc(65536); //alterar tamanho da memória de instruções

	//Read the file that contains the instructions
	arq_instructions = fopen("fibonatti_hex.txt", "rt");
	if (arq_instructions == NULL)
	{
    	printf("Instrunctions File was not opened\n");
    	return;
	}

	//Read all the instructions and storage in 'instruction' char vector
	while(!feof(arq_instructions))
	for(size_instruction = 0; (!feof(arq_instructions)); size_instruction++){
		//reading_result = fscanf(arq_instructions, "%x", &instruction[size_instruction]);
		fscanf(arq_instructions, "%x", &instruction[size_instruction]);
	}
	printf("size_instruction %d\n", size_instruction);
	fclose(arq_instructions);

	for(pc=0; pc < size_instruction; pc++){

		printf("Instruction : %x\n", instruction[pc]);
		instruction_opcode = (instruction[pc] >> 26);
		printf("Instruction Opcode: %x\n", instruction_opcode);

		instruction_type = identify_instruction_type(instruction_opcode);

		printf("Instruction Type: %c\n", instruction_type);
		
		if(instruction_type == 'i'){
			decode_i_type(instruction_opcode, instruction[pc]);
		}
		else if(instruction_type == 'r'){
			decode_r_type(instruction_opcode, instruction[pc]);
		}
		else if(instruction_type == 'j'){
			decode_j_type(instruction_opcode, instruction[pc]);
		}
		else {
            printf("Error: Instrucao inexistente\n");
		}
		printf("Valor de PC: %x\n\n\n", pc);
		
	}

	write_results();

   free(instruction);
}


