; Program : Hello
; Input   : None
; Output  : "My student number is U15043143"
; Author  : Regan Koopmans


  segment .data
    hello:  db  "My student number is U15043143",0xa,0xd

  segment .text
    global  _start

_start:
  mov eax,1
  mov edi,1
  mov edx,32
  lea rsi,[hello]
  syscall
  mov eax,60
  xor edi,  edi
  syscall