ORG 100h  ; COM program
STACK_SEG SEGMENT STACK
    DW 64 DUP(?)  ; Reserve 64 words (128 bytes) for the stack
STACK_SEG ENDS

DATA_SEG  SEGMENT
    morse_string DB '.-.-. ', 0  ; Morse code string (dot, dash, dot, dash, space)
DATA_SEG  ENDS

CODE_SEG  SEGMENT
    ASSUME CS:CODE_SEG, DS:DATA_SEG

START:

MOV AL, 0B6h   ; Command byte for Timer 2, mode 3
OUT 43h, AL

MOV AX, 1193   ; Frequency 1000 Hz
OUT 42h, AL    ; Send LSB
MOV AL, AH
OUT 42h, AL    ; Send MSB

IN AL, 61h     ; Enable PC speaker
OR AL, 03h
OUT 61h, AL

MOV CX, 5000   ; Delay
DELAY:
    LOOP DELAY

IN AL, 61h     ; Disable PC speaker
AND AL, 0FEh
OUT 61h, AL

MOV AH, 4Ch    ; Exit program
INT 21h

CODE_SEG ENDS
	END START