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
    MOV AX, DATA_SEG
    MOV DS, AX  ; Load data segment
    
    LEA SI, morse_string

NEXT_CHAR:
    MOV AL, [SI]     ; Load character from string
    CMP AL, 0        ; Check if end of string
    JE EXIT          ; Exit if null terminator found
    
    CMP AL, '.'
    JE SHORT_BEEP
    CMP AL, '-'
    JE LONG_BEEP
    JMP SKIP_BEEP    ; Skip spaces

SHORT_BEEP:
    MOV CX, 300      ; Short duration
    MOV DX, 1000     ; Higher frequency (Hz)
    CALL BEEP
    JMP SKIP_BEEP

LONG_BEEP:
    MOV CX, 900      ; Longer duration
    MOV DX, 500      ; Lower frequency (Hz)
    CALL BEEP

SKIP_BEEP:
    INC SI           ; Move to next character
    JMP NEXT_CHAR

BEEP PROC
    ; Ensure DX is not zero
    CMP DX, 0
    JNE VALID_FREQ
    MOV DX, 440  ; Default to 440 Hz if DX is zero (A4 note)

VALID_FREQ:
    ; Compute latch count: 1.193182 MHz / frequency
    MOV AX, 1193  ; Use a scaled value to prevent 16-bit overflow
    MOV BX, DX
    DIV BX        ; AX = 1193 / frequency
    MOV BX, AX
    
    ; Send command byte (Timer 2, mode 3, LSB first, MSB second)
    MOV AL, 0B6h
    OUT 43h, AL

    ; Send LSB
    MOV AL, BL
    OUT 42h, AL

    ; Send MSB
    MOV AL, BH
    OUT 42h, AL

    ; Enable speaker (set bits 0 and 1 of port 61h)
    IN AL, 61h
    OR AL, 03h
    OUT 61h, AL

    ; Delay for the beep duration
    MOV CX, 40000
	DELAY_LOOP:
		LOOP DELAY_LOOP

    WAIT_LOOP:
        DEC DX
        JNZ WAIT_LOOP

    ; Disable speaker (clear bit 0 of port 61h)
    IN AL, 61h
    AND AL, 0FEh
    OUT 61h, AL

    RET
BEEP ENDP

EXIT:
    MOV AH, 4Ch  ; DOS exit
    INT 21h

CODE_SEG ENDS
    END START
