.data
	msg1: .asciiz "Forne�a um numero: "
	msgPar: .asciiz "O numero � par "
	msgImp: .asciiz "O numero � Impar "
.text
	#imprime a mensagem
	li $v0, 4
	la $a0, msg1
	syscall 
	
	# faz a leitura do numero
	li $v0 5 
	syscall
	
	li $t0, 2
	div $v0, $t0
		
	mfhi $t1 #possui o resto da divis�o por 2
	
	beq $t1, $zero, imprimePar # verifica se o resto $t0 � igual a zero
	
	# imprime se � impar
	li $v0, 4 
	la $a0, msgImp
	syscall 

	li $v0, 10
	syscall

	# imprime se � par
	imprimePar: 
	   li $v0, 4
	   la $a0, msgPar
	   syscall 
		
	