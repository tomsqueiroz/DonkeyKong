.data

.text
##INCLUDES CONFIGURACOES##


controlePosicaoMario:
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
		beq	t5, t6, INPUT_CIMA
		
		#teste de input - baixo
		li	t6, CONST_INPUT_BAIXO
		beq	t5, t6, INPUT_BAIXO
						
		#teste de input - esquerda
		li	t6, CONST_INPUT_ESQUERDA
		beq	t5, t6, INPUT_ESQUERDA			
		
		#teste de input - cima
		li	t6, CONST_INPUT_DIREITA
		beq	t5, t6, INPUT_DIREITA
		
		#teste de input - espaco
		li	t6, CONST_INPUT_ESPACO
		#beq	t5, t6, INPUT_ESPACO
	
		INPUT_CIMA:
			#condicao se não estiver em uma escada, não mexer mario
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO
				#aqui significa que está em uma escada - testar valor de y
				li	s1, END_Y_ALTURA1_FASE2_MIN
				bge	t2, s1, NAO_ALTERA_POSICAO_MARIO	#salto para ver se a posicao eh maior que o max de y na fase1altura1 , ou seja, se eh possivel decrementar
					#aqui decrementa posicao y do mario
						addi	t1, t1, CONST_INCREMENTO_POR_INPUT
						sw	t1, 64(s0)
						ret
			
	
		
		INPUT_BAIXO:
			#condicao se não estiver em uma escada, não mexer mario
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			bne	t2, s1, NAO_ALTERA_POSICAO_MARIO
				#aqui significa que está em uma escada - testar valor de y
				li	s1, END_Y_ALTURA1_FASE1_MAX
				bge	t2, s1, NAO_ALTERA_POSICAO_MARIO	#salto para ver se a posicao eh maior que o max de y na fase1altura1 , ou seja, se eh possivel decrementar
					#aqui decrementa posicao y do mario
						addi	t1, t1, -CONST_INCREMENTO_POR_INPUT
						sw	t1, 64(s0)
						ret
	
	
	
	
	
	
	
	
		INPUT_ESQUERDA: 
			

			#condicao se estiver em uma escada para nao mexer se receber input_direita
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			beq	t2, s1, NAO_ALTERA_POSICAO_MARIO
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			beq	t2, s1, NAO_ALTERA_POSICAO_MARIO
			## fim condicao ##
			
			
			li	s2, END_X_ALTURA1_FASE1_MIN
			addi	s1, t0, -CONST_INCREMENTO_POR_INPUT
			blt	s1, s2, NAO_ALTERA_POSICAO_MARIO	#se x-inc < Fase-min nao alera posicao do mario	
				#altera posicao da coordenada x
				sw	s1, 60(s0)	#s1 possui valor de t0 menos incremento
				li	s1, END_Y_ALTURA1_FASE1_MAX
				bgt 	t4, s1, NAO_ALTERA_POSICAO_MARIO	#se for maior que 187, significa que nao esta pulando
					#aqui significa que está pulando
					
					li	t0, CONST_MARIO_ESTADO_PULO2
					beq	t2, t0, ESQUERDA_INCREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO3
					beq	t2, t0, ESQUERDA_INCREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO4
					beq	t2, t0, ESQUERDA_INCREMENT_MARIO_Y
					
					#ta descendo, entao diminui y
					
					li	t0, CONST_MARIO_ESTADO_PULO5
					beq	t2, t0, ESQUERDA_DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO6
					beq	t2, t0, ESQUERDA_DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO7
					beq	t2, t0, ESQUERDA_DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO8
					beq	t2, t0, ESQUERDA_DECREMENT_MARIO_Y
					
					ret
					
					ESQUERDA_INCREMENT_MARIO_Y:
						
						addi	t1, t1, CONST_MARIO_CONTROLE_PIXEL_P_CICLO
						#altera incrementa coordenada y
						sw	t1, 64(s0) 
						ret
						
					ESQUERDA_DECREMENT_MARIO_Y:
						addi	t1, t1, -CONST_MARIO_CONTROLE_PIXEL_P_CICLO
						#altera incrementa coordenada y
						sw	t1, 64(s0) 
						ret
							
		
		
		INPUT_DIREITA:
			#condicao se estiver em uma escada para nao mexer se receber input_direita
			li	s1, CONST_MARIO_ESTADO_ESCADA1
			beq	t2, s1, NAO_ALTERA_POSICAO_MARIO
			
			li	s1, CONST_MARIO_ESTADO_ESCADA2
			beq	t2, s1, NAO_ALTERA_POSICAO_MARIO
			## fim condicao ##
		
		
			li	s2, END_X_ALTURA1_FASE1_MAX
			addi	s1, t0, CONST_INCREMENTO_POR_INPUT
				
			bge	s1, s2, NAO_ALTERA_POSICAO_MARIO	#se x + incr > X max_ altura1 nao adiciona posicao	
				#altera posicao da coordenada x
				sw	s1, 60(s0)	#s1 possui valor de t0 mais incremento
				li	s1, END_Y_ALTURA1_FASE1_MAX
				bgt 	t4, s1, NAO_ALTERA_POSICAO_MARIO	#se for maior que 187, significa que nao esta pulando
					#aqui significa que está pulando
					
					li	t0, CONST_MARIO_ESTADO_PULO2
					beq	t2, t0, INCREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO3
					beq	t2, t0, INCREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO4
					beq	t2, t0, INCREMENT_MARIO_Y
					
					#ta descendo, entao diminui y
					
					li	t0, CONST_MARIO_ESTADO_PULO5
					beq	t2, t0, DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO6
					beq	t2, t0, DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO7
					beq	t2, t0, DECREMENT_MARIO_Y
					
					li	t0, CONST_MARIO_ESTADO_PULO8
					beq	t2, t0, DECREMENT_MARIO_Y
					
					
					INCREMENT_MARIO_Y:
						
						addi	t1, t1, CONST_MARIO_CONTROLE_PIXEL_P_CICLO
						#altera incrementa coordenada y
						sw	t1, 64(s0) 
						ret
						
					DECREMENT_MARIO_Y:
						addi	t1, t1, -CONST_MARIO_CONTROLE_PIXEL_P_CICLO
						#altera incrementa coordenada y
						sw	t1, 64(s0) 
						ret
					
											
			NAO_ALTERA_POSICAO_MARIO:														
			ret