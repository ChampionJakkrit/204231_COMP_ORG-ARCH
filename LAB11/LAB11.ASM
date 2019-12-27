TITLE SUM DIGIDS PROGRAM
.MODEL SMALL
.STACK 100H
.DATA
MSG DB "?", "$"
CR EQU 0DH
LF EQU 0AH
N1 DB "?"
N2 DB "?"
NEWLINE DB CR, LF, "$"
.CODE
MAIN PROC
; initition DS
	MOV AX, @DATA
	MOV DS, AX
; display MSG
	LEA DX, MSG
	MOV AH, 9
	INT 21H
; input user
	MOV AH, 1
	INT 21H
	MOV N1, AL
	MOV AH, 1
	INT 21H
	MOV N2, AL
; display on the next line
	LEA DX, NEWLINE
	MOV AH, 9
	INT 21H
; N1 + n2
	MOV AL, N2
	ADD N1, AL
	SUB N1, 30H 
; display N1 + N2
	MOV AH, 2
	MOV DL, N1
	INT 21H
; return to DOS
	MOV AH, 4CH
	INT 21H
MAIN ENDP
	END MAIN