; Program :     : Adder
; Descripton    : Takes two positive integers, adds them together,
;                 adds another 4 and then prints
; Author        : Regan Koopmans

    section .data

; VARIABLES

number1     dq      0
number2     dq      0
nullIn      dq      0
sum         dq      4

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

    sub     qword   [number1],48
    sub     qword   [number2],48

    ; Adding

    add     r8,[number1]
    add     r8,[number2]
    add     [sum],r8

    ; Converting

    add     qword   [sum],48

    ; Printing

    mov     rax,1
    mov     rdx,1               ; Only print the first "half" of the character
    mov     rdi,1
    mov     rsi,sum
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
