.data
.include "Fase1.s"
.include "113.s"


.text



# Carrega a imagem1
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA
	li t2,0xFF012C00	# endereco final 
	la s1,Fase1		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP1			# volta a verificar
	
	
# devolve o controle ao sistema operacional
FIM:	jal ra, DesenhaTela
	li a7, 10
	ecall
	
# a0 - x inicial da imagem
# a1 - y inicial da imagem
# a2 - endereco imagem


DesenhaTela:	
	li a0, 101
	li a1, 23
	la a2, barril
	li s0,0xFF000000	# Frame0
	li t0, 320
	mul t0, t0, a1 		#y inicial
	add t0, t0, a0		
	add s0, s0, t0
	mv t0, a2		# endere�o da imagem
	lw t1,0(t0)		# Numero de x
	lw t2,4(t0)		# numero de y
	li t3, 0 		#contador x
	li t4, 0 		#contador y
	addi t0,t0,8		# primeiro pixel da imagem
LOOPY: 	beq t4,t2,FORAY	
LOOPX:	beq t3,t1,FORAX			
		lb t5,0(t0)
		sb t5,0(s0)
		addi t0,t0,1
		addi s0,s0,1 
		addi t3, t3, 1
		j LOOPX
FORAX:
	li t3, 0
	sub s0, s0, t1
	addi s0, s0, 320
	addi t4, t4, 1
	j LOOPY
FORAY:	ret


