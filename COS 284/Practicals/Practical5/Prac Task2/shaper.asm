                                ; Practical 5 - Task 2
  ;; Program      : Shaper
  ;; Author       : Regan Koopmans
  ;; Description  : Defines a function that can
  ;; calculate area based on input

segment .data

  ;; Shape Names
3
triangle_name:    dq          "Triangle"
square_name:      dq          "Square"
rectangle_name:   dq          "Rectangle"
circle_name:      dq          "Circle"

  ;; Shape Formulas

triangle_form:    dq          "0.5*h*b"
square_form:      dq          "s^2"
rectangle_form:   dq          "h*w"
circle_form:      dq          "pi*r^2"

  ;; Useful Constants

zero:             dq          0.0
one:              dq          1.0
half:             dq          0.5
pi:               dq          3.141592654

segment .text

global shaper

  id        equ 0
  name      equ 4
  form      equ 23
  area      equ 96
  A         equ 104
  B         equ 112
  C         equ 120
  D         equ 128
  radius    equ 136

shaper:
  push  rbp
  mov   rbp,rsp

  ;; [Special case] Check if shape is circle

  movsd       xmm0,[rdi+radius]
  movsd       xmm1,[zero]
  ucomisd     xmm0,xmm1
  ja          circle



  ;; Determines the number of positive dimensions

  mov       rax,0
  mov       rcx,1

  mov       rdx,0
  movsd     xmm0,[rdi+A]
  ucomisd   xmm0,xmm1
  cmovg     rdx,rcx
  add       rax,rdx

  mov       rdx,0
  movsd     xmm0,[rdi+B]
  ucomisd   xmm0,xmm1
  cmovg     rdx,rcx
  add       rax,rdx

  mov       rdx,0
  movsd     xmm0,[rdi+C]
  ucomisd   xmm0,xmm1
  cmovg     rdx,rcx
  add       rax,rdx

  mov       rdx,0
  movsd     xmm0,[rdi+D]
  ucomisd   xmm0,xmm1
  cmovg     rdx,rcx
  add       rax,rdx

  mov       rcx,6

  ;; Sorting to make manipulation of numbers easier

sort:

  movsd     xmm0,[rdi+A]
  movsd     xmm1,[rdi+B]
  movsd     xmm2,[rdi+C]
  movsd     xmm3,[rdi+D]

swap1:
  ucomisd   xmm0,xmm1
  ja        swap2

  movsd     xmm4,xmm0
  movsd     xmm0,xmm1
  movsd     xmm1,xmm4

swap2:
  ucomisd   xmm1,xmm2
  ja        swap3

  movsd     xmm4,xmm1
  movsd     xmm1,xmm2
  movsd     xmm2,xmm4

swap3:
  ucomisd   xmm2,xmm3
  ja        continue

  movsd     xmm4,xmm2
  movsd     xmm2,xmm3
  movsd     xmm3,xmm4

continue:
  dec       rcx
  cmp       rcx,0
  jg        sort

  cmp       rax,4
  je        possible_square

traingle:

  ;; Purely to get the largest dimension in front
  ;; this being the hypoteneuse.

  movsd   xmm4,[half]
  mulsd   xmm0,xmm1             ; base*height
  mulsd   xmm0,xmm4            ; *0.5
  mulsd   xmm0,[half]
  movsd   [rdi+area],xmm0

  ;; Set name for triangle

  mov     rax,[triangle_name]
  mov     [rdi+name],rax

  ;; Set formula for triangle

  mov     rax,[triangle_form]
  mov     [rdi+form],rax

  jmp     exit

possible_square:

  ;; Set name for rectangle

  mov   rax,[rectangle_name]
  mov   [rdi+name],rax

  ;; Set formula for rectangle

  mov   rax,[rectangle_form]
  mov   [rdi+form],rax


  ;; Check for possibility of square

  ucomisd xmm0,xmm1
  jz      second_check
  mulsd   xmm0,xmm1
  movsd   [rdi+area],xmm0
  jmp     exit

second_check:
  ucomisd xmm1,xmm2
  jz      square

  ;; Case : if the two sides are not equal
  ;; (therefore the two critical sides)

  jmp   exit

square:

  ;; Set name for square

  mov   rax,[square_name]
  mov   [rdi+name],rax

  ;; Set formula for square

  mov   rax,[square_form]
  mov   [rdi+form],rax

  mulsd   xmm0,xmm0
  movsd   [rdi+area],xmm0

  jmp   exit

circle:
  movsd xmm0,[rdi+radius]
  movsd xmm1,[pi]
  mulsd xmm0,xmm0
  mulsd xmm0,xmm1
  movsd [rdi+area],xmm0

  ;; Set name for circle

  mov   rax,[circle_name]
  mov   [rdi+name],rax

  ;; Set formiula for circle

  mov   rax,[circle_form]
  mov   [rdi+form],rax

  jmp   exit

exit:

  leave
  ret
