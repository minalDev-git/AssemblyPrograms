DOSSEG
.MODEL SMALL
.STACK 100H
.DATA
;ARRAY TO STORE THE INPUT STRING
STRING DB 100 DUP('$')
STRING2 DB 100 DUP('$')
COUNT DW 0
.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX
MOV SI,OFFSET STRING
L1:
MOV AH,1
INT 21H
;KEEP TAKING INPUT UNTIL ENTER KEY IS PRESSED
CMP AL,13
JE REVERSE
;INPUT IS STORED
MOV [SI],AL
INC SI
INC COUNT
JMP L1
;TAKING SECOND INPUT
MOV SI,OFFSET STRING
MOV COUNT,0
L4:
MOV AH,1
INT 21H
CMP AL,13
JE REVERSE 
MOV [SI],AL
INC SI
INC COUNT
JMP L4
REVERSE:
;LOOP TO REVERSE THE STRING
MOV CX,COUNT
MOV SI,OFFSET STRING
L2:
MOV BX,[SI]
PUSH BX
INC SI
LOOP L2
;LOOP TO PRINT THE REVERSED STRING
MOV CX,COUNT
L3:
POP DX
MOV AH,2
INT 21H
LOOP L3
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN





