    section .data

input   dw      0
store   dw      0

    section .text
    global _start


_start:

    mov     rax,0       ; System call number 0 -> read 
    mov     rdx,2       ; Read 2 characters (null character)
    mov     rsi,store   ; Store them in "store"
    syscall

    mov     rax,0
    mov     rsi,input
    syscall

    mov     rax,1       ; System call number 1 -> write
    mov     rdx,2       ; Write 1 characters.
    mov     rdi,0
    syscall

    mov     rax,1
    mov     rsi,store
    syscall

    mov     rax,60
    mov     rdi,0
    syscall
