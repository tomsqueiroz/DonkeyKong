.data
.include "Fase1.s"
.include "Izerado.s"
.include "IIzeradocompleto.s"
.include "Topzerado.s"
.include "Mzeradocompleto.s"
.include "bonus5000.s"
.include "Lzerado.s"
.include "princess_pe_direito_ok.s"
.include "princess_pe_esquerdo_ok.s"
.include "parametros.s"


.text

#Alterar valor de sp para passar da mem�ria do controle do jogo posicoes e status

jal ra, Phase1
jal ra, zeraTudo


li t0, CONST_PRINCESS_ENDERECO_X_FASE1
li t1, CONST_PRINCESS_ENDERECO_Y_FASE1
li t2, CONST_PRINCESS_ESTADO_D
mv s0, sp
addi sp, sp, -12	#atualiza��o do valor de sp para nao mexer nos 12 bytes da princess
sw t0, 0(s0)
sw t1, 4(s0)
sw t2, 8(s0)
jal ra, movimenta_princess
li a7, 10
ecall






Phase1:
# Carrega a imagem1
FORA:	li t1,END_VGA_INICIAL	# endereco inicial da Memoria VGA
	li t2,END_VGA_FINAL	# endereco final 
	la s1,Fase1		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP1			# volta a verificar
	
	

FIM:	ret

zeraTudo: #zera todos as pontua��es
	addi sp, sp, -4
	sw  ra, 0(sp)
	jal ra, zeraL
	jal ra, zeraBonus
	jal ra, zeraM
	jal ra, zeraII
	jal ra, zeraI
	jal ra, zeraI
	jal ra, zeraTop
	lw ra, 0(sp)
	addi sp, sp, 4
	ret	

	
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

		
				
	
zeraM:	#respons�vel por zerar pontua��o M
	li a0, END_X_MZERADOCOMPLETO
	li a1, END_Y_MZERADOCOMPLETO
	la a2, Mzeradocompleto
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret	

	
zeraII: #respons�vel por zerar pontua��o II
 	li a0, END_X_IIZERADOCOMPLETO
	li a1, END_Y_IIZERADOCOMPLETO
	la a2, IIzeradocompleto
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
		
				
zeraI: # respons�vel por zerar a pontua��o I
	li a0, END_X_IZERADO
	li a1, END_Y_IZERADO
	la a2, Izerado
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
zeraTop: #respons�vel por zerar a pontua��o Top
	li a0, END_X_TOPZERADO
	li a1, END_Y_TOPZERADO
	la a2, Topzerado
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	


movimenta_princess: 	#os argumentos est�o na mem�ria endereco 0(fp)
# 0(fp) -> x || 4(fp) -> y || 8(fp) -> estado
# princess vai ter dois estados 
# 'd' -> p� direito na frente 
# 'e' -> p� esquerdo na frente
lw t0, 0(s0)
lw t1, 4(s0)
lw t2, 8(s0)

#se princess estiver estado d, muda para estado 'e' e atualiza na memoria
addi	t3, zero, CONST_PRINCESS_ESTADO_D 
beq	t2, t3, PRINCESS_VAI_PARA_ESTADO_E
#aqui significa que ta no estado 'e', portanto atualizar para estado 'd'
ret

PRINCESS_VAI_PARA_ESTADO_E:
	addi t3, zero, CONST_PRINCESS_ESTADO_E
	sw t3, 8(s0)
	#desenha princess no estado 'e'
	mv a0, t0
	mv a1, t1
	la a2, princess_pe_esquerdo_ok
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
	ret


movimenta_dk: 
# 12(fp) -> x 




		
	
	
# a0 - x inicial da imagem
# a1 - y inicial da imagem
# a2 - endereco imagem


DesenhaTela:	
	li s1,0xFF000000	# Frame0
	li t0, 320
	mul t0, t0, a1 		#y inicial
	add t0, t0, a0		
	add s1, s1, t0
	mv t0, a2		# endere�o da imagem
	lw t1,0(t0)		# Numero de x
	lw t2,4(t0)		# numero de y
	li t3, 0 		#contador x
	li t4, 0 		#contador y
	addi t0,t0,8		# primeiro pixel da imagem
LOOPY: 	beq t4,t2,FORAY	
LOOPX:	beq t3,t1,FORAX			
		lb t5,0(t0)
		sb t5,0(s1)
		addi t0,t0,1
		addi s1,s1,1 
		addi t3, t3, 1
		j LOOPX
FORAX:
	li t3, 0
	sub s1, s1, t1
	addi s1, s1, 320
	addi t4, t4, 1
	j LOOPY
FORAY:	ret


