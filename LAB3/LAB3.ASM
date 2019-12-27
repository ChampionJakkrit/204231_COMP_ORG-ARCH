TITLE DISPLAY TWO CHAR A-Z
.MODEL SMALL
.STACK 100H 
.DATA
MSG DB '?', '$'
CR EQU 0DH
LF EQU 0AH
N1 DB '?'
N2 DB '?'
NEWLINE DB CR, LF, '$'
.CODE
MAIN PROC

; initiation DS
	MOV AX, @DATA
	MOV DS, AX
; display '?'
	LEA DX, MSG
	MOV AH, 9
	INT 21H
; input user N1 = BH
	MOV AH, 1
	INT 21H
	MOV BH, AL
; input user N2 = BL
	MOV AH, 1
	INT 21H
	MOV BL, AL
; newline
	LEA DX, NEWLINE
	MOV AH, 9
	INT 21H
; if N1 <= N2 go SHOW
	CMP BH, BL
	JBE SHOW
	JMP ELSE_
; if N1 <= N2 display N1 first
SHOW:
	MOV AH, 2
	MOV DL, BH
	INT 21H
; display N2 second
	MOV AH, 2
	MOV DL, BL
	INT 21H
	JMP EXIT
; N1 > N2 display N2 first	
ELSE_:
	MOV AH, 2
	MOV DL, BL
	INT 21H
; display N1 second
	MOV AH, 2
	MOV DL, BH
	INT 21H
EXIT:
	
; return to DOS
	MOV AH, 4CH
	INT 21H
MAIN ENDP
	END MAIN