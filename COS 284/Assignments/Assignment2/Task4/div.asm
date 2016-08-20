; Program :     : Multiplier
; Descripton    : Takes two positive integers, takes
                ; their difference and prints this to the
                ; console
; Author        : Regan Koopmans

    section .data

; VARIABLES

number1     dq      0
number2     dq      0
quot        dq      0
nullIn      dq      0

; CONSTANTS

newline     dq      0xa,0xd

    section .text
    global _start

_start:

    ; Reading

    mov     rax,0         ; Sets the system call number to 0  => read
    mov     rdx,1         ; Number of characters to read = 1
    mov     rdi,0         ; Set input stream to standard input
    mov     rsi,number1
    syscall

    mov     rax,0
    mov     rdx,1
    mov     rdi,0
    mov     rsi,nullIn
    syscall

    mov     rax,0
    mov     rdx,1
    mov     rdi,0
    mov     rsi,number2
    syscall

    mov     rax,0
    mov     rdx,1
    mov     rdi,0
    mov     rsi,nullIn
    syscall

    ; Converting

    sub    word     [number1],48
    sub    qword    [number2],48

    mov     rax,[number2]
    mov     rbx,[number1]
    mov     rdx,0
    div     rbx
    mov     [quot],rax

    ; Converting

    add     qword   [quot],48

    ; Printing

    mov     rax,1
    mov     rdx,1               ; Only print the first "half" of the character
    mov     rdi,1
    mov     rsi,quot
    syscall

    ; New Line

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,newline
    syscall

    ; Exiting

    mov     rax,60          ; Sets the system call number to 60 => exit
    mov     rdi,0        ; Sets the return value to 0
    syscall
