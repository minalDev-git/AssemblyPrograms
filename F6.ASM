DOSSEG
.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'START$'
MSG2 DB 'END$'
.CODE
MAIN PROC
;MOVES THE MEMORY ADDRESS OF @DATA INTO THE REGISTER
MOV AX,@DATA
;DATA SEGMENT INITIALIZED AS HEAP MEMORY
MOV DS,AX
MOV DX,OFFSET MSG1
MOV AH,9
INT 21H
MOV DX,10
MOV AH,2
INT 21H
MOV DX,13
MOV AH,2
INT 21H
;HOLDS THE STARTING ADDRESS OF THE STRING
MOV DX,OFFSET MSG2
MOV AH,9
INT 21H
MOV AH,4CH
INT 21H
MAIN ENDP
END MAIN
