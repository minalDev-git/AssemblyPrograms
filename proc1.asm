.model small
.stack 100h
.data
    arr1 db 11, 2, 3, 4, 5    ; First array
    arr2 db 13, 12, 15, 11, 10 ; Second array
    len db 5                   ; Length of arrays
    Msg db 13, 10, 'Sum array is: $'
    sumArray db 5 dup(?)       ; Reserve space for sum array with 5 elements

.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea si, arr1      ; SI points to arr1
    lea di, arr2      ; DI points to arr2
    lea dx, sumArray  ; DX points to sumArray
    mov cl, len
    dec cl             ; Loop len-1 times

SumLoop:
    mov al, [si]      ; Load element from arr1
    add al, [di]      ; Add corresponding element from arr2
    mov [dx], al      ; Store sum in sumArray
    inc si            ; Move to next element in arr1
    inc di            ; Move to next element in arr2
    inc dx            ; Move to next location in sumArray
    loop SumLoop

    ; Now print the sum array
    lea dx, Msg
    mov ah, 09h
    int 21h           ; Print message

    lea si, sumArray  ; SI points to sumArray
    mov cl, len
    dec cl             ; Loop len-1 times

PrintLoop:
    mov al, [si]      ; Load sum from sumArray
    cmp al, 10        ; Check if sum is >= 10
    jl print_unit     ; If less than 10, print unit part

    ; If sum is >= 10, split into tens and units
    mov ah, 0         ; Clear AH
    mov bl, 10        ; Set divisor to 10
    div bl            ; AL = quotient (tens), AH = remainder (units)

    ; Print tens digit
    add al, '0'       ; Convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Print units digit
    mov al, ah        ; Move remainder (units) to AL
    add al, '0'       ; Convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h
    jmp print_next    ; Jump to print next sum

print_unit:
    ; Sum is less than 10, just print the unit
    add al, '0'       ; Convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

print_next:
    inc si            ; Move to next element in sumArray
    loop PrintLoop    ; Repeat for all elements

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
