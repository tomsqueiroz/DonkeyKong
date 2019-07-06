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
.include "macaco_braco_baixo_ok.s"
.include "macaco_braco_esquerdo_ok.s"
.include "macaco_braco_direito_ok.s"

.include "parametros.s"


.text

#Alterar valor de sp para passar da memória do controle do jogo posicoes e status

jal ra, Phase1
jal ra, zeraTudo
jal ra, setValoresIniciais
jal ra, movimenta_dk


li a7, 10
ecall





setValoresIniciais:

	#Seta Valores Iniciais PRINCESS
	li t0, CONST_PRINCESS_ENDERECO_X_FASE1
	li t1, CONST_PRINCESS_ENDERECO_Y_FASE1
	li t2, CONST_PRINCESS_ESTADO_D
	mv s0, sp
	sw t0, 0(s0)
	sw t1, 4(s0)
	sw t2, 8(s0)
	#jal ra, movimenta_princess
	####---------------------###
	
	#Seta Valores Iniciais DK
	li t0, CONST_DK_ENDERECO_X_FASE1
	li t1, CONST_DK_ENDERECO_Y_FASE1
	li t2, CONST_DK_ESTADO_BRACO_ESQUERDO
	li t3, CONST_DK_ESTADO_BRACO_BAIXO
	sw t0, 12(s0)
	sw t1, 16(s0)
	sw t2, 20(s0)
	sw t3, 24(s0)
	ret


Phase1:
# Carrega a imagem1
FORA:	li t1,END_VGA_INICIAL	# endereco inicial da Memoria VGA
	li t2,END_VGA_FINAL	# endereco final 
	la s1,Fase1		# endereï¿½o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informaï¿½ï¿½es de nlin ncol
LOOP1: 	beq t1,t2,FIM		# Se for o ï¿½ltimo endereï¿½o entï¿½o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memï¿½ria VGA
	addi t1,t1,4		# soma 4 ao endereï¿½o
	addi s1,s1,4
	j LOOP1			# volta a verificar
	
	

FIM:	ret

zeraTudo: #zera todos as pontuações
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
	


movimenta_princess: 	#os argumentos estão na memória endereco X(fp)
# 0(fp) -> x || 4(fp) -> y || 8(fp) -> estado
# princess vai ter dois estados 
# 'd' -> pé direito na frente 
# 'e' -> pé esquerdo na frente
lw t0, 0(s0)
lw t1, 4(s0)
lw t2, 8(s0)

#se princess estiver estado d, muda para estado 'e' e atualiza na memoria
addi	t3, zero, CONST_PRINCESS_ESTADO_D 
beq	t2, t3, PRINCESS_VAI_PARA_ESTADO_E
#aqui significa que ta no estado 'e', portanto atualizar para estado 'd'
addi t3, zero, CONST_PRINCESS_ESTADO_D
	sw t3, 8(s0)
	#desenha princess no estado 'd'
	mv a0, t0
	mv a1, t1
	la a2, princess_pe_direito_ok
	addi sp, sp, -4
	sw ra, 0(sp)
	jal ra, DesenhaTela
	lw ra, 0(sp)
	addi sp, sp, 4
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
# 12(fp) -> x || 16(fp) -> y || 20(fp) -> state || 24(s0) -> state anterior || 28(s0) -> contador para barril horizontal/vertical
#dk tem 3 estados inicialmente 
	lw a0, 12(s0)
	lw a1, 16(s0)
	lw t0, 20(s0)
	lw t1, 24(s0)
	addi t2, zero, CONST_DK_ESTADO_BRACO_BAIXO
	addi t3, zero, CONST_DK_ESTADO_BRACO_DIREITO
	addi t4, zero, CONST_DK_ESTADO_BRACO_ESQUERDO
	beq	t0, t3, DK_VAI_PARA_BRACO_BAIXO		#se estiver com algum braço levantado, o próximo estado é com braço abaixado
	beq	t0, t4, DK_VAI_PARA_BRACO_BAIXO		#se estiver com algum braço levantado, o próximo estado é com braço abaixado
	#significa que está no estado com braço baixo, comparar estado anterior para saber o próximo
		beq t1, t3, DK_VAI_PARA_BRACO_ESQUERDO	#se no estado anterior ele estava com braco direito, agora e o braco esquerdo que levanta
		beq t1, t4, DK_VAI_PARA_BRACO_DIREITO	#se no estado anterior ele estava com braco esquerdo, agora e o braco direito que levanta
			#falta tratamento de erro, caso seja um caractere desconhecido
			ret
		
		DK_VAI_PARA_BRACO_ESQUERDO:
			
			sw	t4, 20(s0)	#atualiza o state
			sw	t0, 24(s0)	#atualiza o state anterior
			#a0 e a1 ja foram carregados anteriormente
			la	a2, macaco_braco_esquerdo_ok
			addi	sp, sp, -4
			sw	ra, 0(sp)
			jal	ra, DesenhaTela
			lw	ra, 0(sp)
			addi	sp, sp, 4
			ret
			
		
		DK_VAI_PARA_BRACO_DIREITO:
		
			sw	t3, 20(s0)	#atualiza o state
			sw	t0, 24(s0)	#atualiza o state anterior
			#a0 e a1 ja foram carregados anteriormente
			la	a2, macaco_braco_direito_ok
			addi	sp, sp, -4
			sw	ra, 0(sp)
			jal	ra, DesenhaTela
			lw	ra, 0(sp)
			addi	sp, sp, 4
			ret
		
	
	
	DK_VAI_PARA_BRACO_BAIXO:
	
		sw	t2, 20(s0)	#atualiza o state
		sw	t0, 24(s0)	#atualiza o state anterior
		#a0 e a1 ja foram carregados anteriormente
		la	a2, macaco_braco_baixo_ok
		addi	sp, sp, -4
		sw	ra, 0(sp)
		jal	ra, DesenhaTela
		lw	ra, 0(sp)
		addi	sp, sp, 4
		ret
	
	
	
DesenhaTela:
# a0 - x inicial da imagem
# a1 - y inicial da imagem
# a2 - endereco imagem	
	li s1,0xFF000000	# Frame0
	li t0, 320
	mul t0, t0, a1 		#y inicial
	add t0, t0, a0		
	add s1, s1, t0
	mv t0, a2		# endereï¿½o da imagem
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


