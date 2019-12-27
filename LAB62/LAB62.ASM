TITLE CONVERSE MONEY
.MODEL SMALL
.STACK 100H
.DATA
HALF_DOLLAR DB ?
QUARTER DB ?
DIME DB ?
NICKEL DB ?
PENNY DB ?
MSG1 DB " half-dollar", '$'
MSG2 DB " quarter", '$'
MSG3 DB " dime", '$'
MSG4 DB " nickel", '$'
MSG5 DB " penny", '$'
MSG6 DB "use input between 0 to 99", '$'
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
; clear AH = 0	
	XOR AH, AH
; 0 <= input*cents* <= 99
	CMP AL, 99
	JG SKIP
	CMP AL, 0
	JL SKIP

; find 1 half-dollat = 50 cents
	MOV BL, 50
	DIV BL
	MOV HALF_DOLLAR, AL
; use Catalyst to find 1 quarter = 25 cents
	MOV AL, AH
	XOR AH, AH
	MOV BL, 25
	DIV BL
	MOV QUARTER, AL
; use Catalyst to find 1 dime = 10 cents
	MOV AL, AH
	XOR AH, AH
	MOV BL, 10
	DIV BL
	MOV DIME, AL
; use Catalyst to find 1 nickel = 5 cents
	MOV AL, AH
	XOR AH, AH
	MOV BL, 5
	DIV BL
	MOV NICKEL, AL
; use Catalyst to find 1 penny = 1 cent
	MOV AL, AH
	XOR AH, AH
	MOV BL, 1
	DIV BL
	MOV PENNY, AL
	
	JMP OUTPUT
	
SKIP:
	MOV AH, 9
	LEA DX, MSG6
	INT 21H
	JMP EXIT

OUTPUT:
; output half-dollat
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	XOR AH, AH
	MOV AL, HALF_DOLLAR
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG1
	INT 21H
; output quarter
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AL, QUARTER
	XOR AH, AH
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG2
	INT 21H
; output dime
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AL, DIME
	XOR AH, AH
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG3
	INT 21H
; output nickel
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AL, NICKEL
	XOR AH, AH
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG4
	INT 21H
; output penny
	MOV AH, 9
	LEA DX, NEWLINE
	INT 21H
	MOV AL, PENNY
	XOR AH, AH
	CALL OUTDEC
	MOV AH, 9
	LEA DX, MSG5
	INT 21H

EXIT:
	
; return to DOS
	MOV AH, 4CH
	INT 21H
MAIN ENDP
	INCLUDE INDEC.ASM
	INCLUDE OUTDEC.ASM
	END MAIN