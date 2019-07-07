####PAR�METROS EST�TICOS DO JOGO - DONKEY KONG######

#CONFIGURAC�ES DO JOGO
#numero de barris verticais por barris horizontais
.eqv PROP_BARRIL_VERTICAL_HORIZONTAL 	3

.eqv CONST_INPUT_CIMA			119 	#valor de w em ascii
.eqv CONST_INPUT_BAIXO			125	#valor de s em ascii
.eqv CONST_INPUT_ESQUERDA		97 	#valor de a em ascii
.eqv CONST_INPUT_DIREITA		100 	#valor de d em ascii
.eqv CONST_INPUT_ESPACO			32 	#valor de space em ascii

.eqv CONST_INCREMENTO_POR_INPUT		3	



## par�metros para zerar###
.eqv END_X_TOPZERADO          160
.eqv END_Y_TOPZERADO          22

.eqv END_X_IZERADO            40
.eqv END_Y_IZERADO            23

.eqv END_X_IIZERADOCOMPLETO            241
.eqv END_Y_IIZERADOCOMPLETO            23

.eqv END_X_MZERADOCOMPLETO            210
.eqv END_Y_MZERADOCOMPLETO            39

.eqv END_X_BONUS5000	            230
.eqv END_Y_BONUS5000                38

.eqv END_X_LZERADO	            280
.eqv END_Y_LZERADO                  39

## par�metros de tela

.eqv END_VGA_INICIAL	              0xFF000000
.eqv END_VGA_FINAL                    0xFF012C00
.eqv END_X_FINAL		      310	#coloca-se uma margem de 10 bits

	#fase 1#
		.eqv END_Y_ALTURA1_FASE1_MIN	190
		.eqv END_Y_ALTURA1_FASE1_MAX	187
		.eqv END_X_ALTURA1_FASE1_MAX	310
		.eqv END_X_ALTURA1_FASE1_MIN	60
			


#par�metros de personagem - PRINCESS

.eqv CONST_PRINCESS_ESTADO_D			100 # 'd' em decimal ascii
.eqv CONST_PRINCESS_ESTADO_E			101 # 'e' em decimal ascii
.eqv CONST_PRINCESS_ENDERECO_X_FASE1			101 
.eqv CONST_PRINCESS_ENDERECO_Y_FASE1			23 


#par�metros de personagem - DK

.eqv CONST_DK_ESTADO_BRACO_BAIXO			97 # 'a' em decimal ascii
.eqv CONST_DK_ESTADO_BRACO_DIREITO			98 # 'b' em decimal ascii
.eqv CONST_DK_ESTADO_BRACO_ESQUERDO			99 # 'c' em decimal ascii
.eqv CONST_DK_ESTADO_BARRIL_ESQUERDA			100 # 'd' em decimal ascii
.eqv CONST_DK_ESTADO_BARRIL_CENTRO			101 # 'e' em decimal ascii
.eqv CONST_DK_ESTADO_BARRIL_DIREITA			102 # 'f' em decimal ascii
.eqv CONST_DK_ENDERECO_X_FASE1				40 
.eqv CONST_DK_ENDERECO_Y_FASE1				33 

#par�metros de personagem - MARIO
.eqv CONST_MARIO_ESTADO_1				1
.eqv CONST_MARIO_ESTADO_2				2
.eqv CONST_MARIO_ESTADO_3				3
.eqv CONST_MARIO_ESTADO_4				4
.eqv CONST_MARIO_ESTADO_5				5
.eqv CONST_MARIO_ESTADO_6				6
.eqv CONST_MARIO_ESTADO_7				7
.eqv CONST_MARIO_ESTADO_8				8
.eqv CONST_MARIO_ESTADO_9				9

.eqv CONST_MARIO_CONTROLE_PIXEL_P_CICLO			4
.eqv CONST_MARIO_ENDERECO_X_INICIAL_FASE1		60 
.eqv CONST_MARIO_ENDERECO_Y_INICIAL_FASE1		195

