DOSSEG
.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC

	MOV AH,00H ;SET VIDEO MODE
	MOV AL,0DH ;resolution 320 x 200 graphics
	INT 10H ; SETTING INTERRUPT FOR GRAPHICS VIDEO MODE
	
	;ACESSING AND DISPLAYING A PIXEL
	MOV AH, 0CH;
	MOV AL, 04H ; COLOR: RED
	MOV CX,50 ; COLUMN # 0 TO 299
	MOV DX,50 ; ROW # 0 TO 199
	
	
	;LOOP TO DRWING THE VERTICAL LINE OF RIGHT ANGLED TRIANGLE
	L1:
	INT 10H
	INC DX
	CMP DX,100
	JE 	L2
	JMP L1
	
	;LOOP TO DRWING THE HORIZONTAL LINE OF RIGHT ANGLED TRIANGLE
	L2:
	INT 10H
	INC CX
	CMP CX,100
	JE 	L3
	JMP L2
	
	;LOOP TO DRWING THE SLANTED LINE OF RIGHT ANGLED TRIANGLE
	L3:
	INT 10H
	DEC CX
	DEC DX
	CMP DX,50
	JE 	SECOND_TRI
	JMP L3
	
	SECOND_TRI:
	MOV CX,110 ; COLUMN # 0 TO 299
	MOV DX,110 ; ROW # 0 TO 199
	
	;LOOP TO DRWING THE SLANTED LINE OF LEFT ANGLED TRIANGLE
	L5:
	INT 10H
	INC CX
	DEC DX
	CMP DX,60
	JE 	L6
	JMP L5
	
	;LOOP TO DRWING THE VERTICAL LINE OF LEFT ANGLED TRIANGLE
	L6:
	INT 10H
	INC DX
	CMP DX,110
	JE 	L7
	JMP L6
	
	;LOOP TO DRWING THE HORIZONTAL LINE OF LEFT ANGLED TRIANGLE
	L7:
	INT 10H
	DEC CX
	CMP CX,110
	JE 	THIRD_TRI
	JMP L7
	
	THIRD_TRI:
	MOV CX,100 ; COLUMN # 0 TO 299
	MOV DX,150 ; ROW # 0 TO 199
	
	;LOOP TO DRWING THE RIGHT SLANTED LINE OF EQUILATIRAL TRIANGLE
	L8:
	INT 10H
	DEC CX
	DEC DX
	CMP CX,70
	JE  L9
	JMP L8
	
	;LOOP TO DRWING THE LEFT SLANTED LINE OF EQUILATIRAL TRIANGLE
	L9:
	INT 10H
	DEC CX
	INC DX
	CMP DX,150
	JE  L10
	JMP L9
	
	;LOOP TO DRWING THE HORIZONTAL LINE OF EQUILATIRAL TRIANGLE
	L10:
	INT 10H
	INC CX
	CMP CX,100
	JE  END_PROG
	JMP L10
	
	END_PROG:
	MOV AH,4CH
	INT 21H
	
MAIN ENDP
END MAIN
