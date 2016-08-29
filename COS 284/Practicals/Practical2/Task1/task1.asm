    section .data

input   dq      0
newline db 	0xa

    section .text
    global _start

_start:

    mov     rax,0       ; System call number 0 -> read 
    mov     rdi,0
    mov     rdx,12
    mov     rsi,input
    syscall

    mov     rax,1       ; System call number 1 -> write
    mov     rdi,1
    mov     rdx,12
    mov     rsi,input
    syscall

    mov     rax,60
    mov     rdi,0
    syscall
