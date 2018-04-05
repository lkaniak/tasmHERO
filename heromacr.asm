PUSHES_POSICAO MACRO LINHA_NUM, N_VEZES, CHR
	LEA BX, [LINHA_NUM + 2]
	MOV CX,N_VEZES
	MOV AX, CHR
ENDM

TESTA_REGISTRADOR MACRO REGISTRADOR
	EMPILHA
	MOV CL, REGISTRADOR
	POSICIONA_E_ESCREVE 02h, CL, 0H, 05H
	DESEMPILHA
ENDM

EMPILHA_AX_CX_DX MACRO
	PUSH AX
	PUSH CX
	PUSH DX
ENDM

DESEMPILHA_AX_CX_DX MACRO
	POP DX
	POP CX
	POP AX
ENDM

EMPILHA_AX_BX_CX MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	
ENDM

DESEMPILHA_AX_BX_CX MACRO
	POP CX
	POP BX
	POP AX
ENDM

MOVER_PARA_DX MACRO
	PUSH BX
	MOV BX, DX
	MOV BYTE PTR [BX], AL
	POP BX
ENDM

GET_CHAR_DX MACRO
	PUSH BX
	MOV BX, DX
	MOV AL, [BX]
	POP BX
ENDM

GET_CHAR_DX_EM_AH MACRO
	PUSH BX
	MOV BX, DX
	MOV AH, [BX]
	POP BX
ENDM

INCREMENTA_STR_DX MACRO NUM
	PUSH BX
	MOV BX, DX
	ADD BX, NUM
	MOV DX, BX
	POP BX
ENDM


PULA_E_RETORNA MACRO
	MOV AH, 06H
	MOV DL, 0AH
	INT 21H
	MOV AH, 06H
	MOV DL, 0DH
	INT 21H
ENDM

ZERAR MACRO
	MOV AX, 0H
	MOV BX, 0H
	MOV CX, 0H
	MOV DX, 0H
ENDM
PULAR_LINHA MACRO
	MOV AH, 06H
	MOV DL, 0AH
	INT 21H
ENDM

EMPILHA MACRO
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
ENDM

DESEMPILHA MACRO
	POP DX
	POP CX
	POP BX
	POP AX
ENDM

EMPILHA_CX_BX MACRO
	PUSH BX
	PUSH CX
ENDM

EMPILHA_AX_BX MACRO
	PUSH AX
	PUSH BX
ENDM

DESEMPILHA_AX_BX MACRO
	POP BX
	POP AX
	
ENDM

DESEMPILHA_CX_BX MACRO
	POP CX
	POP BX
	
ENDM

INTERROMPE_SOM MACRO
	IN AL, 61h ; verifica qual o valor está na porta 61h
	AND AL, 11111100b ; "zera" os dois bits menos significativos
	OUT 61h, AL ; atualiza valor na porta 61h, fim reprodução
ENDM


SALVAR_NOTA_COR MACRO CLR, CHR 	;CARACTER (0) TEM QUE IR PARA AL ;TEMPO == 9000H
	MOV AH,CLR ; atributos do caractere 	;TEM QUE IR PARA BL
	MOV AL, CHR   ;'0' OU ' '	MOV DL, 13H
	
ENDM

SALVAR_VARIAVEIS MACRO NOTA, POS, CLR, CAR 
	MOV CX,NOTA
	MOV BL,POS ; coluna
	MOV AH,CLR ; atributos do caractere 	;TEM QUE IR PARA BL
	MOV AL,CAR ; caractere a ser escrito	;TEM QUE IR PARA AL
ENDM

POSICIONA_E_ESCREVE MACRO COR, CHR, LIN, COL ;ESCREVE(COLUNA, COR, CARACTERE)
	MOV DH,LIN ; LINHA
	MOV DL,COL ; COLUNA
	PUSH AX
	MOV AH,02h ; move o cursor
	MOV BH,00h ; página de vídeo 0
	INT 10h
	POP AX
	MOV BL,COR ; atributos do caractere
	MOV AL,CHR ; caractere a ser escrito
	MOV AH,09h ;
	MOV CX,1h ; número de vezes a escrever o caractere
	INT 10h
ENDM

RETORNO_DE_CARRO MACRO 
	MOV AH, 06H
	MOV DL, 0DH
	INT 21H
ENDM

PRINT MACRO MENSAGEM
	LEA DX, MENSAGEM
	MOV AH, 09H
	INT 21H 
ENDM

MODO_VIDEO MACRO
	MOV AX,03h ;ajusta o modo de vídeo
	INT 10h 
	MOV CX,0007h ; cursor em formato cheio
	INT 10h
ENDM

PRINT_CASA MACRO MENSAGEM, COLUNA, LINHA, CLR
	EMPILHA_CX_DX
	LEA BP, MENSAGEM
	MOV AH, 13H
	MOV AL, 01H
	MOV BL, CLR
	MOV BH, 00H
	MOV DH, LINHA
	MOV DL, COLUNA
	MOV CX, 03H
	INT 10H
	DESEMPILHA_CX_DX
ENDM

PRINT_S_TAM_FIXO MACRO COLUNA, LINHA, CLR
	MOV BP, BX
	MOV AH, 13H
	MOV AL, 01H
	MOV BL, CLR
	MOV BH, 00H
	MOV DH, LINHA
	MOV DL, COLUNA
	MOV CX, 03H ;TAM_STR (SEMPRE FIXO)
	INT 10H 
ENDM

PRINT_S MACRO COLUNA, LINHA, CLR, TAM_STR
	MOV BP, BX
	MOV AH, 13H
	MOV AL, 01H
	MOV BL, CLR
	MOV BH, 00H
	MOV DH, LINHA
	MOV DL, COLUNA
	MOV CX, TAM_STR
	INT 10H 
ENDM

TOCAR_NOTA MACRO NOTE
	MOV AL, 182
	OUT 43h, AL ;prepara a nota
	MOV AX, NOTE ; NOTA
	OUT 42h, AL ; manda byte menos significativo
	MOV AL, AH
	OUT 42h, AL ; manda byte mais significativo
	IN AL, 61h ; verifica qual o valor está na porta 61h
	OR AL, 00000011b ; "seta" os dois bits menos significativos
	OUT 61h, AL ; atualiza o valor na porta 61h ... reproduz
ENDM