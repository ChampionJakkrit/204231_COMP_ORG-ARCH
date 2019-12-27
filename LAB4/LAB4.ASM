TITLE DISPLAY TEN ASCII
.MODEL SMALL
.STACK 100H 
.DATA
CR EQU 0DH
LF EQU 0AH
NEWLINE DB CR, LF, '$'
.CODE
MAIN PROC
; initiation DS
	MOV AX, @DATA
	MOV DS, AX
	
; BX = count 10 ascii
; DL = display ascii
	MOV AH, 2
	MOV BX, 10
	MOV CL, 80H
	
WHILE_:
; CL <= 0FFH go PRINT_LOOP
	CMP CL, 0FFH
	JLE PRINT_LOOP
	JMP EXIT
	
PRINT_LOOP:
	MOV AH, 2
	MOV DL, CL
	INT 21H
; space bar
	MOV DL, 20H
	INT 21H
; increase CL *next ascii*
	INC CL
; decrease count 
	DEC BX
; if count = 0 go newline
	CMP BX, 0
	JE PRINT_NEWLINE
	JMP WHILE_
	
PRINT_NEWLINE:
; newline
	LEA DX, NEWLINE
	MOV AH, 9
	INT 21H
; set count
	MOV BX, 10
	JMP WHILE_

EXIT:

; return to DOS
	MOV AH, 4CH
	INT 21H
MAIN ENDP
	END MAIN