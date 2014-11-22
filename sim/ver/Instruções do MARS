.data

v: .word 2, 250, 147483648, -10

.text
Main:

#bgez $t1, Main_exit #ret
#addiu $t1, $t2, 10 #subi
#bc1f Main_exit #jr
 
lw $t1, v
lw $t2, v+4
lw $t3, v+8
lw $t4, v+12

jal Arithmetic_Operations
jal Arithmetic_Operations_Immediate
jal Logical_Operations

Main_exit:
	sw $s2, v+16		
	j Exit

Arithmetic_Operations:
	add $s0, $t1, $t3	
	sub $s1, $t4, $t3	
	nop
	nop
	mult $s0, $s1
	mult $t2, $t3
	mult $t2, $t4
	div $s0, $t3, $t1
	div $s0, $t1, $t2
	nop
	nop 
	div $s0, $zero
	div $zero, $s0	
	
	jr $31	
	
	
Arithmetic_Operations_Immediate:
	addi $t5, $zero, 0 #Posição no vetor
	addi $t6, $zero, 0 #Tipo i = 0	
	nop
	nop
	addi $t7, $t5, 2 #Condição de parada
	lw $s1, v+4
	subi $s1, $s1, 200
	# Condição de parada $t5 < $t6
	loop:   	
   	subi $s1, $s1, 17   	
   	addi $t5, $t5, 4
   	addi $t6, $t6, 1
   	sw $s1, v($t5) 
   	slt $s0, $t6, $t7
   	beq $s0, 1, loop	
	
	jr $ra
	
	
Logical_Operations:	
	and $s0, $t1, $t2
	or $s1, $t1, $t2
	addi $t5, $zero, 0
	addi $t6, $zero, 1
	nop
	nop
	and $s0, $t5, $t6
	andi $s0, $t6, 1
	or $s1, $t5, $t6
	ori $s1, $t6, 1	
	not $t5, $t6
	
	slt $s2, $t5, $t6
	beq $s2, 1, save_and_quit
	j Main_exit
		save_and_quit:		
		jr $ra
		
Exit:
