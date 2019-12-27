TITLE DIV_MN
.MODEL SMALL
.STACK 100H
.DATA
M DW ?
N DW ?
Q DW ?
R DW ?
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF, '$'
.CODE
MAIN PROC
; iniation DS
	MOV AX, @DATA
	MOV DS, AX
; input
	CALL INDEC
	MOV M, AX
	;MOV AH, 9
	;LEA DX, NEWLINE
	;INT 21H
	CALL INDEC
	MOV N, AX
	;MOV AH, 9
	;LEA DX, NEWLINE
	;INT 21H
; print "0."
	MOV AH, 2
	MOV DL, "0"
	INT 21H
	MOV DL, "."
	INT 21H
; N = counter
	MOV CX, N
	
FOR_LOOP:	
	MOV BX, M
	MOV AX, 10
	MUL BX
	MOV M, AX
; M/N
	MOV AX, M
	MOV BX, N
	XOR DX, DX
	DIV BX
	MOV Q, AX
	MOV R, DX
; print Q
	MOV AX, Q
	CALL OUTDEC
; replace M by R
	MOV AX, R
	MOV M, AX
; loop N time
	DEC CX
	CMP CX, 0
	JNE FOR_LOOP

; return to DOS
	MOV AH, 4CH
	INT 21H

MAIN ENDP
	INCLUDE INDEC.ASM
	INCLUDE OUTDEC.ASM
	END MAIN