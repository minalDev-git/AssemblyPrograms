DOSSEG
.MODEL SMALL
.STACK 100H
.DATA
MSG DB 'MINAL SHAHID$'  ; String to print

.CODE
MAIN PROC
    ; Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 06H ;SCROLL WINDOW UP FUNCTION
	MOV AL, 10 ;LINES TO SCROLL
	MOV BH, 45H ;SETTING THE COLOR
	MOV CH, 12 ;SETTING THE UPPER ROW
	MOV CL, 32 ;SETTING THE LEFT-MOST COL
	MOV DH, 18 ;SETTING THE LOWER ROW
	MOV DL, 15 ;SETTING THE RIGHT-MOST COL
	INT 10H

    ; Set cursor position to write the text
    MOV AH, 02H   ; Function to set cursor position
    MOV BH, 0     ; Page number
    MOV DH, 13    ; Set the cursor row position
    MOV DL, 34    ; Set the cursor column position
    INT 10H

    ; Print the text
    MOV DX, OFFSET MSG
    MOV AH, 09H
    INT 21H

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
