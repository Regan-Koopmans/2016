; Program : Exits
; Input   : None
; Output  : None
; Author  : Regan Koopmans

  segment .text
  global _start

_start:
  mov eax,1   ; Calls the exit system call.
  mov ebx,0   ; Sets the return value to zero.
  int 0x80    ; Excecutes.
