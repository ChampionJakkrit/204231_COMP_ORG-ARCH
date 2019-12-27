TITLE AVERAGE ARRAY DIGITS
.MODEL SMALL
.STACK 100H
.DATA
AVG DW ?
CLASS DB "MARY ALLEN  ", 67, 45, 98, 33
	  DB "SCOTT BAYLIS", 20, 56, 87, 44
	  DB "GEORGE FRANK", 62, 52, 49, 40
	  DB "SAM WONG    ", 68, 74, 62, 50
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF, "$"
.CODE
MAIN PROC
; initiation DS
	MOV AX, @DATA
	MOV DS, AX
	
	XOR BX, BX
REPEAT_LOOP:
; name long 12 index *CX = counter*
	MOV CX, 12
FOR_LOOP:
; display name
	MOV AH, 2
	MOV DL, CLASS[BX]
	INT 21H
	INC BX
	LOOP FOR_LOOP
	
; clear AX = 0
	XOR AX, AX
; digits have 4 number
	MOV CX, 4
FOR_SUM:
; cal sum digits
	ADD AL, CLASS[BX]
	INC BX
	LOOP FOR_SUM
; CWD = AL -> AX
	CWD
	
	XOR CX, CX
; cal div digits for average
	MOV CX, 4
; AX = sum // CX = 4
	DIV CX
	CALL OUTDEC
	
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	
	CMP BX, 64
	JNE REPEAT_LOOP
	
; retuen to DOS
	MOV AH, 4CH
	INT 21H

MAIN ENDP
	INCLUDE OUTDEC.ASM
	END MAIN