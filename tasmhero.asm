COD SEGMENT


ASSUME CS:COD, DS:COD, ES:COD, SS:COD

include heromacr.asm

ORG 100H

;MAIN()
MAIN	PROC

COMECO:
	
	ZERAR
	MODO_VIDEO
	CALL INICIALIZA_TELA
	ZERAR
	CALL PRINTA_TELA
	CALL MOVE_NOTA
	INT 20H
	 
  



MAIN ENDP
include heroproc.asm
COD ENDS
	END MAIN