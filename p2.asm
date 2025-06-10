.model small
.stack 100h

.data
    msg db 'Fib of $'
    msg2 db ' = $'
    newline db 13,10,'$'
    n dw 7         ; Calculate Fib(7) by default
    res dw ?     ; Stores the result

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; to Calculate Fibonacci(n) mov n to ax and call procedure
    mov ax, n 
    call CAL_fib
    mov res, ax   ;mov final answer in res
    
    ; Display result using print_answer procedure along with msgs
    call print_answer
    
    ; Exit program
    mov ah, 4ch
    int 21h
main endp

; Recursive Fibonacci procedure 
CAL_fib proc
    cmp ax, 2      ;if n i<=2 goto base case
    jle base_case   
    ;if n>2  Recursive case: Fib(n) = Fib(n-1) + Fib(n-2)
    push ax          ; Save n
    sub ax,1          ; n-1
    call CAL_fib   ; Calculate Fib(n-1)
    push ax          ; Save Fib(n-1)
    
    pop bx           ; BX = Fib(n-1)
    pop ax           ; Restore original n
    push bx          ; Save Fib(n-1)
    sub ax, 2        ; n-2
    call CAL_fib  ; Calculate Fib(n-2)
    
    pop bx           ; BX = Fib(n-1)
    add ax, bx       ; AX = Fib(n-1) + Fib(n-2)
    ret
    
base_case:
    cmp ax, 0
    je if_fib_zero  ;if n=0
    mov ax, 1        ; Fib(1)=1, Fib(2)=1
    ret
if_fib_zero:
    mov ax, 0
    ret
CAL_fib endp

; Display result 
print_answer proc
    push ax
    push bx
    push cx
    push dx
    
    mov ah, 09h
    lea dx, msg
    int 21h
    
    mov ax, n   ;print the number whose fabonacci we have to calculate using print_num
    call print_num
    
    lea dx, msg2
    mov ah, 09h
    int 21h
    
    mov ax, res  ;load the final answer into ax and print using print_num
    call print_num
    
    lea dx, newline
    mov ah, 09h
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_answer endp

; Print number in AX 
print_num proc
    push ax
    push bx
    push cx
    push dx
    
    mov cx, 0
    mov bx, 10
    
divide_loop:
    mov dx,0
    div bx
    push dx
    inc cx
    cmp ax,0
    jnz divide_loop
    
print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num endp

end main