TITLE CONVERSE SECOND
.MODEL SMALL
.STACK 100H
.DATA
HOURS DW "?"
MINUTE DW "?"
SECOND DW "?"
MSG1 DB " Hours", "$"
MSG2 DB " Minute", "$"
MSG3 DB " Second", "$"
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF, '$'
.CODE
MAIN PROC
; initiation DS
	MOV AX, @DATA
	MOV DS, AX
	
; input
	CALL INDEC
; clear DX = 0
	XOR DX, DX
; find Hours
	MOV BX, 3600
	DIV BX
	MOV HOURS, AX
; use Catalyst find Minute
	MOV AX, DX
	XOR DX, DX
	MOV BX, 60
	DIV BX
	MOV MINUTE, AX
; use Catalyst is Second
	MOV SECOND, DX
	
; output Hours
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AX, HOURS
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG1
	INT 21H
; output Minute
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AX, MINUTE
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG2
	INT 21H
; output second
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AX, SECOND
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG3
	INT 21H
	
; return to DOS
	MOV AH, 4CH
	INT 21H
MAIN ENDP
	INCLUDE INDEC.ASM
	INCLUDE OUTDEC.ASM
	END MAIN