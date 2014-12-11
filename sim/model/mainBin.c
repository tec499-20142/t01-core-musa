#include <stdio.h>
#include <stdlib.h>

//Global Variables:
//pc: Program Counter
//registers[]: represent register bank
//mem[]: Represent the data memory
int  pc=0, registers[32], mem[1000], registerflag[1],stack[8];



//Fuction to identify the instruction type:
// i - I-type Instruction
// r - R-type Instruction
// j - J-type Instruction
char identify_instruction_type(int instruction_opcode){
	char result;
	if(instruction_opcode == 001000 || instruction_opcode == 001001 || instruction_opcode == 001100 || instruction_opcode == 001101 || instruction_opcode == 100011 || instruction_opcode == 101011 || instruction_opcode == 000100){
		result = 'i';
	}
	else if (instruction_opcode == 000000 || instruction_opcode == 011100 || instruction_opcode == 000101){
		result = 'r';
	}
	else if (instruction_opcode == 010001 || instruction_opcode == 0000010 || instruction_opcode == 000011 || instruction_opcode == 000001 || instruction_opcode == 111111){
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
	rs1 = (instruction >> 21);
	rd = (instruction >> 16);
	imm = (instruction);
	printf("RS1: %x RD: %x IMM: %x\n", rs1, rd, imm);

	//Load Instruction - lw RD = mem
	if(instruction_opcode == 100011){
		registers[rd] = mem[registers[rs1]];
	}
	//Store Instruction - sw mem = RD
	else if(instruction_opcode == 101011){
		mem[registers[rs1]] = registers[rd];
	}
	//addi - RD = RS1 + Sext(imm)
	else if(instruction_opcode == 001000){
		registers[rd] = registers[rs1] + imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
 	}
 	//subi RD = RS1 - Sext(imm)
 	else if(instruction_opcode == 001001){
		registers[rd] = registers[rs1] - imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//andi RD = RS1 ^ Sext(imm)
	else if(instruction_opcode == 001100){
		registers[rd] = registers[rs1] & imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//ori RD = RS1 V Sext(imm)
	else if(instruction_opcode == 001101){
		registers[rd] = registers[rs1] | imm;
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
    //brfl
	//else if(instruction_opcode == 000100){			
	//}
}

//Function responsible to reproduce the results of the r-type instructions
void decode_r_type(unsigned int instruction_opcode, unsigned int instruction){
	int rd, rs1, rs2, function;
	
	//Define the fields of the instructions
	rs1 = (instruction >> 21);
	rs2 = (instruction >> 16);
	rd = (instruction >> 11);
	function = (instruction);

	printf("RS1: %x RS2: %x RD: %x Function: %x\n", rs1, rs2, rd, function);
	
	//add - RD = RS1 + RS2
	if(function == 100000){
		registers[rd] = registers[rs1] + registers[rs2];
		printf("rs1: %x registers[rs1] %x\n",rs1, registers[rs1]);
		printf("Valor escrito no registrador %x eh: %x\n", rd, registers[rd]);
	}
	//sub - RD = RS1 - RS2
	else if(function == 100010){
		registers[rd] = registers[rs1] - registers[rs2];
	}
	//and - RD = RS1 & RS2
	else if(function == 100100){
		registers[rd] = registers[rs1] & registers[rs2];
	}
	//or
	else if(function == 100101){
		registers[rd] = registers[rs1] | registers[rs2];
	}
	//mult - RD = RS1 . RS2
	else if(function == 000010){
		registers[rd] = registers[rs1] * registers[rs2];
	}
	//div - RD = RS1 / RS2
	else if(function == 000001){
		registers[rd] = registers[rs1] / registers[rs2];
	}
	//cmp - RD = RS1 cmp RS2
	//else if(function == 101010){
	//	registers[rd] = registers[rs1] - registers[rs2];
	//}
	//not - RD = ~RS2
	else if(function == 100111){
		registers[rd] = ~registers[rs2];
	}
	//nop
	else if(function == 000000){
	}
}

//Function responsible to reproduce the results of the j-type instructions
void decode_j_type(unsigned int instruction_opcode, unsigned int instruction){
	int pc_offset;
	pc_offset = (instruction);

	//JR  pc = addr
	if(instruction_opcode == 010001){
            pc = pc_offset - 1;// -1 because the increment of for.
	}
	//JPC  pc = pc + addr
	if(instruction_opcode == 000010){
            pc = pc + pc_offset;// -1 because the increment of for.
	}
	//CALL
	else if(instruction_opcode == 000011){
            stack[0] = pc; //ponteiro para um endereço vazio da pilha
			pc = pc_offset;
	}
	//RET - 
	else if(instruction_opcode == 000001){
            pc = stack[0]; //fazer ponteiro
	}
	//HALT - finish the program
	else if(instruction_opcode == 111111){
            pc = pc_offset; 
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

	for(j=0;j<1000;j++){
		fprintf(arq_mem, "%x\n", mem[j]);
	}


	fclose(arq_registers);
	fclose(arq_mem);

}



void main (int argc, char *argv[]){
	FILE *arq_instructions;
	unsigned int *instruction;//[1048576];
	unsigned int instruction_opcode;
	char *reading_result, *reading_result_opcode;
	char instruction_type;
	int  size_instruction,i;
	printf("Parametro: %s\n", argv[1]);
	instruction = malloc( 1048576 ); //alterar tamanho da memória de instruções

	//Read the file that contains the instructions
	arq_instructions = fopen(argv[1], "rt");
	if (arq_instructions == NULL)
	{
    	printf("Instrunctions File was not opened\n");
    	return;
	}
	
	//Read all the instructions and storage in 'instruction' char vector
	//while(!feof(arq_instructions)){
	for(size_instruction=0; (!feof(arq_instructions)); size_instruction++){
		reading_result = fscanf(arq_instructions, "%x", &instruction[size_instruction]);

	}
	printf("size_instruction %d\n", size_instruction);
	fclose(arq_instructions);

	for(pc=0;pc<size_instruction;pc++){

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
		printf("Valor de PC: %x\n\n\n", pc);
	}

	write_results();

   free(instruction);
}


