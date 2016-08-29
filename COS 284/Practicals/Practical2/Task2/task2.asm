    section .data

input   dq      0
store   dq      0
newline db 	0x0a

    section .text
    global _start

_start:

    mov     rax,0       ; System call number 0 -> read 
    mov     rdx,2       ; Read 2 characters (null character)
    mov     rdi,0
    mov     rsi,store   ; Store them in "store"
    syscall

    mov     rax,0
    mov     rdx,2
    mov     rdi,0
    mov     rsi,input
    syscall

    mov     rax,1       ; System call number 1 -> write
    mov     rdx,1       ; Write 1 characters.
    mov     rdi,1
    syscall

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,newline
    syscall

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,store
    syscall

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,newline
    syscall

    mov     rax,60
    mov     rdi,0
    syscall
