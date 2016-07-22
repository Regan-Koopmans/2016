; Program:  Print "Hello world!"
; Input:    None
; Output:   "Hello world!"
; Author:   Regan Koopmans

  section .data
    msg dw  "Hello world!"
    len equ $-msg

  section .text
    global _start

_start:
  mov eax,4
  mov ebx,len
  mov ecx,msg
  mov edx,0
  int 0x80

  mov eax,1
  mov ebx,0
  int 0x80
