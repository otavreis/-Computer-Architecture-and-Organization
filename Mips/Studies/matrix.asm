.data
Mat: .space 36 # 3x3 * 4 (inteiro)
Ent1: .asciiz " Insira o valor de Mat["
Ent2: .asciiz "]["
Ent3: .asciiz "]: "
.text
main: la $a0, Mat # Endere�o base de Mat
     li $a1, 3 # N�mero de linhas
     li $a2, 3 # N�mero de colunas
     jal leitura # leitura(mat, nlin, ncol)
     move $a0, $v0 # Endere�o da matriz lida
     jal escrita # escrita(mat, nlin, ncol)
     li $v0, 10 # C�digo para finalizar o programa
     syscall # Finaliza o programa
     
     indice:
          mul $v0, $t0, $a2 # i * ncol
          add $v0, $v0, $t1 # (i * ncol) + j
          sll $v0, $v0, 2 # [(i * ncol) + j] * 4 (inteiro)
          add $v0, $v0, $a3 # Soma o endere�o base de mat
          jr $ra # Retorna para o caller

     leitura:
          subi $sp, $sp, 4 # Espa�o para 1 item na pilha
          sw $ra, ($sp) # Salva o retorno para a main
          move $a3, $a0 # aux = endere�o base de mat
          l: la $a0, Ent1 # Carrega o endere�o da string
          li $v0, 4 # C�digo de impress�o de string
          syscall # Imprime a string
          move $a0, $t0 # Valor de i para impress�o
          li $v0, 1 # C�digo de impress�o de inteiro
          syscall # Imprime i
          la $a0, Ent2 # Carrega o endere�o da string
          li $v0, 4 # C�digo de impress�o de string
          syscall # Imprime a string
          move $a0, $t1 # Valor de j para impress�o
          li $v0, 1 # C�digo de impress�o de inteiro
          syscall # Imprime j
          la $a0, Ent3 # Carrega o endere�o da string
          li $v0, 4 # C�digo de impress�o de string
          syscall # Imprime a string
          li $v0, 5 # C�digo de leitura de inteiro
          syscall # Leitura do valor (retorna em $v0)
          move $t2, $v0 # aux = valor lido
          jal indice # Calcula o endere�o de mat[i][j]
          sw $t2, ($v0) # mat[i][j] = aux
          addi $t1, $t1, 1 # j++
          blt $t1, $a2, l # if(j < ncol) goto l
          li $t1, 0 # j = 0

          addi $t0, $t0, 1 # i++
          blt $t0, $a1, l # if(i < nlin) goto l
          li $t0, 0 # i = 0
          lw $ra, ($sp) # Recupera o retorno para a main
          addi $sp, $sp, 4 # Libera o espa�o na pilha
          move $v0, $a3 # Endere�o base da matriz para retorno
          jr $ra # Retorna para a main

    escrita:
          subi $sp, $sp, 4 # Espa�o para 1 item na pilha
          sw $ra, ($sp) # Salva o retorno para a main
          move $a3, $a0 # aux = endere�o base de mat
          e: jal indice # Calcula o endere�o de mat[i][j]
          lw $a0, ($v0) # Valor em mat[i][j]
          li $v0, 1 # C�digo de impress�o de inteiro
          syscall # Imprime mat[i][j]
          la $a0, 32 # C�digo ASCII para espa�o
          li $v0, 11 # C�digo de impress�o de caractere
          syscall # Imprime o espa�o
          addi $t1, $t1, 1 # j++
          blt $t1, $a2, e # if(j < ncol) goto e
          la $a0, 10 # C�digo ASCII para newline ('\n')
          syscall # Pula a linha
          li $t1, 0 # j = 0
          addi $t0, $t0, 1 # i++
          blt $t0, $a1, e # if(i < nlin) goto e
          li $t0, 0 # i = 0
          lw $ra, ($sp) # Recupera o retorno para a main
          addi $sp, $sp, 4 # Libera o espa�o na pilha
          move $v0, $a3 # Endere�o base da matriz para retorno
          jr $ra # Retorna para a main