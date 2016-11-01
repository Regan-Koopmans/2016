  section .data

allocated_struct: dq    0
string:           dq    0
string_size:      dq    0
new_string:       dq    0


  section .text

  global allocateNode

  ;; Imported functions

  extern  malloc
  extern  strlen
  extern  strncpy

allocateNode:
  push  rbp
  mov   rbp,rsp

  mov   [string],rdi

  mov   rdi,40
  call  malloc

  ;; Set other struct values to 0.

  mov   rbx,0
  mov   [rax+8],rbx
  mov   [rax+16],rbx
  mov   [rax+24],rbx
  mov   [rax+32],rbx
  mov   [allocated_struct],rax

  ;; Determine String Length

  mov   rdi,[string]
  call  strlen
  mov   [string_size],rax

  ;; Allocate Array of Equal Size

  mov   rdi,rax
  call  malloc
  mov   [new_string],rax

  ;; Copy the parameter string into new string

  mov   rdi,[new_string]
  mov   rsi,[string]
  mov   rdx,[string_size]
  call  strncpy

  ;; Set the pointer for the struct string to new string

  mov   rax,[allocated_struct]
  mov   rbx,[new_string]
  mov   [rax],rbx

  leave
  ret
