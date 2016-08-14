; Program :     : Adder
; Descripton    : Takes two positive integers, adds them together,
;                 adds another 4 and then prints
; Author        : Regan Koopmans

    section .data

; VARIABLES

number1     dq      0
number2     dq      0
sum         dq      4

; CONSTANTS

stdin       dq      0
stdout      dq      1
exit        dq      60
digit       dw      2
success     dw      0
error       dw      1
newline     dq      0xa,0xd

    section .text

    global _start

_start:

    ; Reading

    mov     rax,[stdin]         ; Sets the system call number to 0  => read
    mov     rdx,[digit]         ; Number of characters to read = 1
    mov     rdi,[stdin]         ; Set input stream to standard input
    mov     rsi,number1
    syscall

    mov     rax,[stdin]
    mov     rdx,[digit]
    mov     rdi,[stdin]
    mov     rsi,number2
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

    mov     rax,[stdout]
    mov     rdx,1               ; Only print the first "half" of the character
    mov     rdi,[stdout]
    mov     rsi,sum
    syscall

    ; New Line

    mov     rax,[stdout]
    mov     rdx,1
    mov     rdi,[stdout]
    mov     rsi,newline
    syscall

    ; Exiting

    mov     rax,[exit]          ; Sets the system call number to 60 => exit
    mov     rdi,[success]        ; Sets the return value to 0
    syscall
