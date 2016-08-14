    section .data

input   dw      0

    section .text
    global _start


_start:

    mov     rax,0       ; System call number 0 -> read 
    mov     rdi,1
    mov     rdx,11
    mov     rsi,input
    syscall

    mov     r8,[input]  ; Moves old read value to r8
    mov     rax,0
    mov     rdi,1
    mov     rdx,11
    syscall             ; Calls to get new value



    mov     rax,1       ; System call number 1 -> write
    mov     rdx,11
    syscall

    mov     rsi,[input]
    syscall


    mov     rax,60
    mov     rdi,0
    syscall
