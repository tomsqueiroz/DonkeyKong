.data
.include "mario_correndo_direita_1.s"
.include "mario_correndo_direita_2.s"
.include "mario_correndo_direita_3.s"
.include "mario_correndo_esqueda_1.s"
.include "mario_correndo_esqueda_2.s"
.include "mario_correndo_esqueda_3.s"
.include "mario_subindo_escada_1.s"
.include "mario_subindo_escada_2.s"




.text
controle_estado_mario:
# mario vai ter 60(s0) -> x || 64(s0) -> y || 68(s0) -> state || 72(s0) -> state anterior ||  76(s0) -> em que degrau está || 80(s0) -> input usuario 			
		
		lw	t0, 60(s0)	#posicao X
		lw	t1, 64(s0)	#posicao Y
		lw	t2, 68(s0)	#state
		lw	t3, 72(s0)	#state_anterior
		lw	t4, 76(s0)	#altura
		lw	t5, 80(s0)	#input_usuario
		
		#falta fazer teste de altura 1
		#############ALTURA 1##################
		
		#teste de input - cima
		li	t6, CONST_INPUT_CIMA
		beq	t5, t6, INPUT_CIMA_ESTADO
		
		#teste de input - baixo
		li	t6, CONST_INPUT_BAIXO
		beq	t5, t6, INPUT_BAIXO_ESTADO
						
		#teste de input - esquerda
		li	t6, CONST_INPUT_ESQUERDA
		beq	t5, t6, INPUT_ESQUERDA_ESTADO			
		
		#teste de input - cima
		li	t6, CONST_INPUT_DIREITA
		beq	t5, t6, INPUT_DIREITA_ESTADO
		
		#teste de input - espaco
		li	t6, CONST_INPUT_ESPACO
		#beq	t5, t6, INPUT_ESPACO_ESTADO
		
		ret
		
		INPUT_CIMA_ESTADO:
		
			#testes para ver se está em uma escada	---------- altura 1 ----------#
			li 	s1, END_X_ALTURA1_ESCADA1
			addi	s11, s1, CONST_OFFSET_SUBIR_ESCADA
			addi	s10, s1, -CONST_OFFSET_SUBIR_ESCADA
			bgt 	t0, s11, NAO_ALTERA_POSICAO_MARIO_ESTADO 	#se posicao for maior que escada.pos + offset, nao altera marioa
			blt	t0, s10, NAO_ALTERA_POSICAO_MARIO_ESTADO
				#aqui significa que mario pode subir ou descer escada
				li	s1, CONST_MARIO_ESTADO_ESCADA1
				beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO2
				li	s1, CONST_MARIO_ESTADO_ESCADA2
				beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO2
	
				ret																											
			#testes para parar o mario olhando para direita
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA1
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA2
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA3
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_PARADO_DIREITA
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			#testes para parar o mario olhando para esquerda
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA1
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA2
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA3
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_PARADO_ESQUERDA
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			#testes escada 
			
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO2
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO1
			
			ret
			
			MARIO_VAI_PARA_ESCADA_ESTADO1:
					#atualiza estado anterior e estado atual
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_ESCADA1
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_subindo_escada_1
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
			
			MARIO_VAI_PARA_ESCADA_ESTADO2:
					#atualiza estado anterior e estado atual
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_ESCADA2
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_subindo_escada_2
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret		
					
			
			
			
			
			MARIO_PARADO_ESQUERDA1:
					#atualiza estado anterior e estado atual
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_PARADO_ESQUERDA
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_esqueda_1 #ALTERAR PARA VALOR COM SPRITE PARADO
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
			
			
			
			
			
			MARIO_PARADO_DIREITA1:
					#atualiza estado anterior e estado atual
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_PARADO_DIREITA
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_direita_1 #ALTERAR PARA VALOR COM SPRITE PARADO
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
			
		
		
		
		
		
		INPUT_BAIXO_ESTADO:
			
			#testes para parar o mario olhando para direita
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA1
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA2
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA3
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			li	s1, CONST_MARIO_PARADO_DIREITA
			beq	t2, s1, MARIO_PARADO_DIREITA1
			
			#testes para parar o mario olhando para esquerda
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA1
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA2
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA3
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			
			li	s1, CONST_MARIO_PARADO_ESQUERDA
			beq	t2, s1, MARIO_PARADO_ESQUERDA1
			#testes escada 
			
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO2
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			beq	t2, s1, MARIO_VAI_PARA_ESCADA_ESTADO1
			
			ret
			
					
					
			
		
			
		
		
		INPUT_ESQUERDA_ESTADO:
			
			#condicao se não estiver em uma escada, não mexer mario
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO_ESTADO
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			beq	t2, s1, NAO_ALTERA_POSICAO_MARIO
			## fim condicao ##
			
				#se o estado for mario parado, corre para ESQUERDA 1
				li	s1, CONST_MARIO_PARADO_ESQUERDA
				beq	t2, s1, MARIO_CORRE_ESQUERDA_1
				
				li	s1, CONST_MARIO_PARADO_DIREITA
				beq	t2, s1, MARIO_CORRE_ESQUERDA_1
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA1
				beq	t2, s1, MARIO_CORRE_ESQUERDA_2
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA2
				beq	t2, s1, MARIO_CORRE_ESQUERDA_3
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA3
				beq	t2, s1, MARIO_CORRE_ESQUERDA_1
				
				ret
			
				MARIO_CORRE_ESQUERDA_1:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA1
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_esqueda_1
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
					
				MARIO_CORRE_ESQUERDA_2:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA2
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_esqueda_2
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
					
				MARIO_CORRE_ESQUERDA_3:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_ESQUERDA3
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_esqueda_3
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
		
		
		INPUT_DIREITA_ESTADO:
			
			#condicao se não estiver em uma escada, não mexer mario
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO_ESTADO
			
				#se o estado for mario parado, corre para direita 1
				li	s1, CONST_MARIO_PARADO_DIREITA
				beq	t2, s1, MARIO_CORRE_DIREITA_1
				
				li	s1, CONST_MARIO_PARADO_DIREITA
				beq	t2, s1, MARIO_CORRE_DIREITA_1
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA1
				beq	t2, s1, MARIO_CORRE_DIREITA_2
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA2
				beq	t2, s1, MARIO_CORRE_DIREITA_3
				
				li	s1, CONST_MARIO_ESTADO_CORRENDO_DIREITA3
				beq	t2, s1, MARIO_CORRE_DIREITA_1
				
				ret
				
				MARIO_CORRE_DIREITA_1:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_DIREITA1
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_direita_1
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
					
				MARIO_CORRE_DIREITA_2:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_DIREITA2
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_direita_2
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
					
				MARIO_CORRE_DIREITA_3:
					sw	t2, 72(s0)
					li	t2, CONST_MARIO_ESTADO_CORRENDO_DIREITA3
					sw	t2, 68(s0)
					
					#parametros para printar na tela
					mv	a0, t0
					mv	a1, t1
					la	a2, mario_correndo_direita_3
					addi	sp, sp, -4
					sw	ra, 0(sp)
					jal	ra, DesenhaTela
					lw	ra, 0(sp)
					addi	sp, sp, 4
					ret
					
			
			
			NAO_ALTERA_POSICAO_MARIO_ESTADO:														
			ret
			
			
