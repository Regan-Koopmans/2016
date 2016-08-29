; Program :     Counter
; Description : Will Count 12 Characters in Base 36
; Author :      Regan Koopmans

  section   .data

  input       dq      0
  nullInput   dq      0
  asciiOffset dq      39
  newline     dq      0xa

  section   .text
  global    _start

_start:

    mov     rax,0
    mov     rdi,0
    mov     rdx,1
    mov     rsi,input
    syscall

    mov     rax,0
    mov     rdi,0
    mov     rdx,1
    mov     rsi,nullInput
    syscall

    mov     r10,0

count:

    mov     r9,0                      ;
    mov     r8,[input]                ; Reads from memory
    cmp     r8,58                     ; Checks for alpha
    cmovz   r9,[asciiOffset]
    add     qword [input],r9          ; adds the alpha offset

    cmp     r8,47
    jle     exit_no_nl
 

    cmp     r8,123
    je      exit

    cmp     r8,123
    jg     exit_no_nl

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,input
    syscall
 
    inc     qword [input]
    inc     r10
    cmp     r10,12
    jl     count

exit:

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,newline
    syscall

exit_no_nl:

    mov   rax,60
    mov   rdi,0
    syscall
