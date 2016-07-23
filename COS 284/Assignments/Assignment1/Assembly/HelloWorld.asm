; Program:  Print "Hello world!"
; Input:    None
; Output:   "Hello world!"
; Author:   Regan Koopmans

  section .data
    msg dw  "The quick brown fox jumps over the lazy dog.",0xa,0xd
    len equ $-msg

  section .text
    global _start

_start:
  mov eax,4
  mov ebx,1
  mov ecx,msg
  mov edx,len
  int 0x80

  mov eax,1
  mov ebx,0
  int 0x80
