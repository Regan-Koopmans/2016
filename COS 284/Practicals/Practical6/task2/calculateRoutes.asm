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


  call    addAllRoutesDirectNeighbours

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
  sub     rsp, 48

  cmp     rdi, 0
  jne     node_not_null
  leave
  ret

node_not_null:
  mov     [rsp], rdi
  call    appendToArray
  mov     rdi, [rsp]

  mov     rdx, [rdi + 16]       ; Number of links
  mov     rbx, [rdi + 8]        ; start of the links array
  mov     rcx, 0
  mov     [rsp+8], rcx
  mov     [rsp+16], rbx

addNodes_loop:
  mov     rbx, [rsp+16]
  mov     rcx, [rsp+8]
  imul    rcx, 16
  mov     rdi, [rbx+rcx]
  mov     [rsp+32],rdi
  call    contains

  mov     rdi,[rsp+32]

  cmp     rax,0
  jne     do_not_add_node
  call    addNodes

do_not_add_node:
  mov     rdi, [rsp]
  inc     dword   [rsp + 8]

  mov     rcx, [rsp + 8]
  mov     rdx, [rdi + 16]
  cmp     rcx, rdx
  jl     addNodes_loop

  add     rsp, 48
  leave
  ret


addRoutesDirectNeighbours:
  push  rbp
  mov   rbp, rsp

  mov   [current_node], rdi
  mov   rax, [rdi+24]
  cmp   rax, 0
  je    dont_free_existing_routes

  mov   rdi, rax
  call  free

dont_free_existing_routes:

  mov   rax, [rdi+16]           ; Number of links
  inc   rax
  imul  rax, 24                 ; Each route is 24 bytes
  mov   rdi, rax
  call  malloc

  mov   [new_array], rax
  mov   rdi, [current_node]
  mov   rdx, [rdi+16]
  mov   rbx, [rdi+8]
  mov   rcx, 0
aRDN_while:

  mov   r8, rcx
  imul  r8, 16
  mov   r9, [rbx+r8]
  add   r8, 8
  mov   r10, [rbx+r8]

  mov   r8, rcx
  imul  r8, 24
  mov   [rax+r8], r9
  add   r8, 8
  mov   [rax+r8], r10
  add   r8, 8
  mov   [rax+r8], r9

  inc   rcx
  cmp   rcx, rdx
  jl    aRDN_while

  ;; Place link to one's self

  mov   r10, [current_node]
  mov   r11, 0
  mov   r8, rcx
  imul  r8, 24
  mov   [rax+r8], r10
  add   r8,8
  mov   [rax+r8], r11
  add   r8,8
  mov   [rax+r8], r10
  inc   rcx

  mov   rdi, [current_node]
  mov   rax, [new_array]
  mov   [rdi+24], rax
  mov   [rdi+32], rcx

  leave
  ret


addAllRoutesDirectNeighbours:
  push  rbp
  mov   rbp, rsp
  sub   rsp, 32

  mov   r8, [node_array]
  mov   r9, 0
  mov   r10, [node_array_size]

aARDN_while:                     ; Loops through all nodes
  mov   rdi, [r8+8*r9]
  mov   [rsp+0], r8
  mov   [rsp+8], r9
  mov   [rsp+16], r10

  call  addRoutesDirectNeighbours

  mov    r8,  [rsp+0]
  mov    r9,  [rsp+8]
  mov    r10, [rsp+16]
  inc    r9
  cmp    r9, r10
  jl     aARDN_while

  add    rsp, 32

  leave
  ret
