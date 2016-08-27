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
    mov     r8,[input]

count:
    mov     r9,0                      ;
    mov     r8,[input]                ; Reads from memory
    cmp     r8,58                     ; Checks for alpha
    cmovz   r9,[asciiOffset]
    add     qword [input],r9          ; adds the alpha offset

    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,input
    syscall

    inc     qword [input]
    cmp     r8,122
    je      exit

    inc     r10
    cmp     r10,12
    jne     count

exit:
    mov     rax,1
    mov     rdx,1
    mov     rdi,1
    mov     rsi,newline
    syscall

    mov   rax,60
    mov   rdi,0
    syscall
