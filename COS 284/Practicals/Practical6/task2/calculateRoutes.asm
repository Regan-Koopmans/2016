  ;; Program:     calculateRoutes
  ;; Author:      Regan Koopmans
  ;; Description: Defines a function, and helper functions,
  ;;              that determine theshortest paths from that
  ;;              node to all others

  section .data

node_array:             dq  0
node_array_size:        dq  0
current_node:           dq  0
new_array:              dq  0

rec_node        equ   0
rec_counter     equ   8
rec_num_links   equ   16

  section .text
  extern malloc
  extern free

  global calculateRoutes
  global contains
  global appendToArray
  global addNodes

  ;; Main function: calculates shortest routes to all other nodes

calculateRoutes:
  push    rbp
  mov     rbp, rsp

  call    addNodes              ; After calling this we should have a complete
                                ; list of nodes


  leave
  ret

  ;; Helper Function: determines if a node is in the node_array

contains:
  push    rbp
  mov     rbp, rsp

  cmp     rdi, 0
  jne     contains_not_null
  mov     rax, 1
  leave
  ret

contains_not_null:

  mov     rcx, 0
  mov     rbx, [node_array]
  mov     r10, [node_array_size]
  imul    r10, 8

  cmp     rbx, 0                ; check if array is null
  jne     contains_loop
  mov     rax, 0
  leave
  ret

contains_loop:
  mov     rdx, [rbx + rcx]
  cmp     rdi, rdx
  jne     not_equal
  mov     rax, 1
  leave
  ret

not_equal:
  add     rcx,8
  cmp     rcx, r10
  jl      contains_loop

  mov     rax, 0

  leave
  ret

  ;; Helper Function: dynamically adds to node_array

appendToArray:
  push    rbp
  mov     rbp, rsp

  mov     [current_node], rdi
  mov     rdi, [node_array_size]
  imul    rdi, 8               ; the size of a standard pointer
  add     rdi, 8
  call    malloc
  mov     [new_array], rax

  mov     rbx, [node_array]
  mov     rcx, 0
  mov     rdx, [node_array_size]

append_loop:
	cmp     rcx, rdx
	jge     append_continue

  mov     r10, [rbx]
  mov     [rax], r10

  add     rax, 8
  add     rbx, 8
  inc     rcx
  jmp     append_loop

append_continue:
  mov     rdx, [current_node]
  mov     [rax], rdx

  mov     rdi, [node_array]
  call    free

  mov     rax, [new_array]
  mov     [node_array], rax
  inc     qword [node_array_size]

  leave
  ret

  ;; Helper Function: A recursive function that traverses the graph

addNodes:
  push    rbp
  mov     rbp, rsp
  sub     rsp, 32

  cmp     rdi, 0
  jne     node_not_null
  leave
  ret

node_not_null:
  mov     [rsp+rec_node], rdi
  call    appendToArray
  mov     rdi, [rsp+rec_node]

  mov     rdx, [rdi + 16]       ; Number of links
  mov     rbx, [rdi + 8]        ; start of the links array
  mov     rcx, 0
  mov     [rsp+8], rcx
  mov     [rsp+rec_num_links], rbx

addNodes_loop:
  mov     rcx, [rsp+8]
  imul    rcx, 16
  mov     rdi, [rbx+rcx]
  call    contains

  cmp     rax,0
  jne     do_not_add_node
  call    addNodes

do_not_add_node:

  inc     qword   [rsp + 8]

  mov     rcx, [rsp + rec_counter]
  mov     rdx, [rsp + rec_num_links]
  cmp     rcx, rdx
  jle     addNodes_loop

  add     rsp, 32
  leave
  ret
