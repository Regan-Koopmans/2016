  section   .data

hexChar1       dq      0
hexChar2       dq      0
nullInput      dq      0
asciiChar      dq      0
asciiOffset    dq      87
newline        dq      0xa

  section   .text
  global _start

_start:
  mov     r12,0

  mov     rax,0           ; Reads first part of number
  mov     rdi,0
  mov     rdx,1
  mov     rsi,hexChar1
  syscall

  mov     rax,0
  mov     rdi,0           ; Reads second part of number
  mov     rdx,1
  mov     rsi,hexChar2
  syscall

  mov     rax,0
  mov     rdi,0           ; Reads blank new line
  mov     rdx,1
  mov     rsi,nullInput
  syscall


  mov     r11,[asciiOffset]
  mov     r8 ,[hexChar1]
  mov     r10,48
  cmp     r8 ,r11
  cmovge  r10,r11
  sub     r8 ,r10

  mov     rax,16
  mul     r8
  add     r12,rax

  mov     r11,[asciiOffset]
  mov     r8 ,[hexChar2]
  mov     r10,48
  cmp     r8 ,97
  cmovge  r10,r11
  sub     r8 ,r10

  add     r12,r8
  mov     [asciiChar],r12

  mov     rax,1
  mov     rdi,1
  mov     rdx,1
  mov     rsi,asciiChar
  syscall

  mov     rax,1
  mov     rdi,1
  mov     rdx,1
  mov     rsi,newline
  syscall

  not byte  [asciiChar]

  mov     rax,[asciiChar]
  mov     r8,2
  mov     rdx,0
  div     r8
  mov     [asciiChar],rax

  mov     rax,1
  mov     rdi,1
  mov     rdx,1
  mov     rsi,asciiChar
  syscall

  mov     rax,1
  mov     rdi,1
  mov     rdx,1
  mov     rsi,newline
  syscall

  mov     rax,60
  mov     rdi,0
  syscall
