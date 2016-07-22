; Program : Exits
; Input   : None
; Output  : None
; Author  : Regan Koopmans

  segment .data
    value1  dd  0.0
    value2  dd  -0.0
    value3  dd  0
    value4  dd  -0
    value5  dd  3.3651
    value6  dd  123.1
    value7  dd  -3.6
    value8  dd  1.5

  segment .text
  global  _start

_start:
  mov eax,1
  mov ebx,0
  int 0x80
