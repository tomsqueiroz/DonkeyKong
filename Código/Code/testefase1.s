.data
.include "Fase1.s"
.include "Izerado.s"
.include "IIzeradocompleto.s"
.include "Topzerado.s"
.include "Mzeradocompleto.s"
.include "bonus5000.s"
.include "Lzerado.s"
.include "princess_pe_direito_ok.s"
.include "parametros.s"


.text

#Alterar valor de sp para passar da memória do controle do jogo posicoes e status

# Carrega a imagem1
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA
	li t2,0xFF012C00	# endereco final 
	la s1,Fase1		# endereï¿½o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informaï¿½ï¿½es de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o ï¿½ltimo endereï¿½o entï¿½o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memï¿½ria VGA
	addi t1,t1,4		# soma 4 ao endereï¿½o
	addi s1,s1,4
	j LOOP1			# volta a verificar
	
	
# devolve o controle ao sistema operacional
FIM:	jal ra, zeraL
	jal ra, zeraBonus
	jal ra, zeraM
	jal ra, zeraII
	jal ra, zeraI
	jal ra, zeraI
	jal ra, zeraTop
	li a7, 10
	ecall
	
zeraL:	#responsavel por zerar L
	li a0, END_X_LZERADO
	li a1, END_Y_LZERADO
	la a2, Lzerado
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret




zeraBonus: #responsavel por zerar Bonus para bonus inicial -> 5000
	li a0, END_X_BONUS5000
	li a1, END_Y_BONUS5000
	la a2, bonus5000
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

		
				
	
zeraM:	#responsável por zerar pontuação M
	li a0, END_X_MZERADOCOMPLETO
	li a1, END_Y_MZERADOCOMPLETO
	la a2, Mzeradocompleto
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret	

	
zeraII: #responsável por zerar pontuação II
 	li a0, END_X_IIZERADOCOMPLETO
	li a1, END_Y_IIZERADOCOMPLETO
	la a2, IIzeradocompleto
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
		
				
zeraI: # responsável por zerar a pontuação I
	li a0, END_X_IZERADO
	li a1, END_Y_IZERADO
	la a2, Izerado
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
zeraTop: #responsável por zerar a pontuação Top
	li a0, END_X_TOPZERADO
	li a1, END_Y_TOPZERADO
	la a2, Topzerado
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	


movimenta_princess: 	#os argumentos estão na memória endereco 0(fp)
# 0(fp) -> x || 4(fp) -> y || 8(fp) -> estado
# princess vai ter dois estados 
# 'd' -> pé direito na frente 
# 'e' -> pé esquerdo na frente





movimenta_dk: 
# 12(fp) -> x 




		
	
	
# a0 - x inicial da imagem
# a1 - y inicial da imagem
# a2 - endereco imagem


DesenhaTela:	
	li s0,0xFF000000	# Frame0
	li t0, 320
	mul t0, t0, a1 		#y inicial
	add t0, t0, a0		
	add s0, s0, t0
	mv t0, a2		# endereï¿½o da imagem
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


