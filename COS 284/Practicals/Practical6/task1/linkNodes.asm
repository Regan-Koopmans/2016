  section .data

first_node:     dq  0
second_node     dq  0
weight:         dq  0
new_array:      dq  0

  section .text

  global linkNodes

  ;; Imported functions

  extern malloc
  extern free

linkNodes:
  push  rbp
  mov   rbp,rsp

  ;; Preserve parameters

  mov   [first_node], rdi
  mov   [second_node], rsi

  ;; Allocate an array 1 greater than the current amount

  mov   rax, 0
  mov   rax, [first_node]
  mov   rdi, [rax+16]
  imul  rdi, 16
  add   rdi, 16
  call  malloc

  mov   [new_array], rax

  ;; Copy old data into new array

  mov   rax, [first_node]
  mov   rax, [rax+8]
  mov   rbx, [new_array]
  mov   rdx, [first_node]
  mov   rcx, [rdx+16]

while_first_node:
  cmp   rcx,0
  jle   continue_first_node

  mov   r8, [rax]
  mov   [rbx],r8

  add   rax, 8
  add   rbx, 8

  mov   r8, [rax]
  mov   [rbx], r8

	add   rax, 8
	add   rbx, 8

  dec   rcx
  jmp   while_first_node

continue_first_node:

  ;; Copy single new entry

  mov   rax, [second_node]
  mov   [rbx],rax
  movsd [rbx+8], xmm0


  ;; Free old array

  mov   rax, [first_node]
  mov   rdi, [rax+8]
  call  free

  ;; Place pointer to new array

  mov   rax, [first_node]
	mov   rbx, [new_array]
	mov   [rax+8],rbx

  ;; Increase number of links

  mov   rbx, [first_node]
  inc   qword [rbx+16]

                                ; Second node

  mov   rax, 0
	mov   rax, [second_node]
	mov   rdi, [rax+16]
  imul  rdi, 16
	add   rdi, 16
	call  malloc

	mov   [new_array], rax

	;; Copy old data into new array

	mov   rax, [second_node]
  mov   rax, [rax+8]
	mov   rbx, [new_array]
  mov   rdx, [second_node]
  mov   rcx, [rdx+16]

while_second_node:
	cmp   rcx,0
	jle   continue_second_node

	mov   r8, [rax]
	mov   [rbx],r8

	add   rax, 8
	add   rbx, 8

	mov   r8, [rax]
	mov   [rbx], r8

	add   rax, 8
	add   rbx, 8

	dec   rcx
	jmp   while_second_node

continue_second_node:

	  ;; Copy single new entry

	mov   rax, [first_node]
  mov   [rbx],rax
	movsd [rbx+8], xmm0

  ;; Free old array

	mov   rax, [second_node]
	mov   rdi, [rax+8]
	call  free

	  ;; Place pointer to new array

	mov   rax, [second_node]
	mov   rbx, [new_array]
	mov   [rax+8],rbx

	  ;; Increase number of links

	mov   rbx, [second_node]
	inc   qword [rbx+16]

  leave
  ret
