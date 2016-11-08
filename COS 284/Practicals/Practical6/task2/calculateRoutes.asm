  ;; Program:     calculateRoutes
  ;; Author:      Regan Koopmans
  ;; Description: Defines a function, and helper functions,
  ;;              that determine theshortest paths from that
  ;;              node to all others

  section .data

inf:                    dq  99999999999999999.0
node_array:             dq  0
node_array_size:        dq  0
current_node:           dq  0
new_array:              dq  0
counter:                dq  0
has_route_to:		        dq  0
has_route_from: 	      dq  0

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

  mov     rax, 0
  mov     [node_array], rax
  mov     [node_array_size], rax

  call    addNodes              ; After calling this we should have a complete
                                ; list of nodes


  call    addAllRoutesDirectNeighbours
  mov     rax, [node_array_size]
  mov     rcx, 0
  mov     [counter],rcx

cR_while:

  call    updateAllRoutes
  inc     qword [counter]
  mov     rcx, [counter]
  mov     rdx, [node_array_size]
  cmp     rcx, rdx
  jl      cR_while


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
  mov     rbx, [rdi+8]
  cmp     rbx, 0
  jne     has_links
  leave
  ret


has_links:
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

  cmp   rdi, 0
  jne   not_null
  leave
  ret

not_null:

  mov   [current_node], rdi
  mov   rax, [rdi+24]
  cmp   rax, 0
  je    dont_free_existing_routes

  mov   rdi, rax
  call  free

dont_free_existing_routes:

  mov   rdi, [current_node]
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


appendToRoutes:       ; rsi=to, rdi=from, r12=next
  push 	rbp
  mov 	rbp, rsp

;;;;;;;;;;;;;;;;;;;;;;;;; Purely for error resistance

  cmp   rdi, 0
  jne   rdi_not_null
  leave 
  ret

rdi_not_null  
  cmp   rsi, 0
  jne   neither_null
  leave
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Check for presence of route

neither_null:
  cmp   rsi, rdi
  jne   to_from_not_equal
  leave 
  ret

to_from_not_equal:


  mov   rax, [rdi+24]
  cmp   rax, 0
  je    allocate_new            ;; Jump if routes are null
  mov   rbx, [has_route_to]
  mov   rcx, 0
  mov   rdx, [rdi+32]

aRC_while:
  mov   r8, [rax]
  cmp   r8, rsi
  jne   aRC_continue

  movsd   xmm0, [rax+8]           ; now holds the current distance of this path
  addsd   xmm3, xmm1
  ucomisd xmm0, xmm3
  jb   do_not_replace_route

  mov   r8, 1
  movsd [rax+8], xmm3         ; Change the length
  mov   [rax+16], r9

do_not_replace_route:
  leave
  ret

aRC_continue:
  inc   rcx
  add   rax, 24
  cmp   rcx, rdx
  jl    aRC_while

allocate_new:

  mov   rax, [rdi]
  mov   [current_node], rdi
  add   rax, 24
  mov   rdi, rax
  call  malloc
  mov   [new_array], rax

  mov   rdi, [current_node]
  mov   rax, [new_array]
  mov   r8, [rdi+24]
  mov   rcx, 0
  mov   rdx, [rdi+32]

aTR_while:
  mov   r9, [r8]
  mov   [rax], r9
  add   r8, 8
  add   rax, 8

  mov   r9, [r8]
  mov   [rax], r9
  add   r8, 8
  add   rax, 8

  mov   r9, [r8]
  mov   [rax], r9
  add   r8, 8
  add   rax, 8

  inc   rcx
  cmp   rcx, rdx
  jl    aTR_while
  
  mov   r9, [has_route_to]
  mov   [rax], r9
  add   r8, 8
  add   rax, 8

  mov   r9, [inf]
  mov   [rax], r9
  add   r8, 8
  add   rax, 8

  mov   r9, r12
  mov   [rax], r12
  add   r8, 8
  add   rax, 8   

  mov   rax, [new_array]
  mov   [rdi+24], rax
  inc   qword [rdi+32]
  mov   rdi, [current_node]

  leave
  ret

hasRoute:
  push 	rbp
  mov 	rbp, rsp
  sub 	rsp, 8

  mov 	[has_route_from], rdi
  mov 	[has_route_to]  , rsi

  mov 	rcx, 0
  mov 	rdx, [rdi + 16]
  mov 	[rsp], rcx
  mov 	r8,  [rdi + 8]

hasRoute_loop:
  mov   r8, [rdi+8]
  imul 	rcx,16
  mov 	r9, [r8+rcx]		; This gives us the node at link[rcx]. r9 now has some neighbour
  add 	rcx, 8
  movsd xmm1, [r8+rcx]    ; Contains distance to this neighbour
  mov 	r10, [r9 + 24]		; r10 now contains routes array of some neighbour
  mov 	r11, 0
  mov 	r13, [r9 + 32]

for_neighbour_loop:

  mov 	rax,r11
  imul 	rax, 24
  mov 	r12, [r10+rax]
  cmp 	rsi, r12
  jne 	not_equal_target  
  add   rax, 8
  movsd xmm3, [r10+rax]
  mov   rdi, [has_route_from]
  mov   rsi, [has_route_to]
  call 	appendToRoutes

not_equal_target:

  inc 	r11
  cmp 	r11, r13 
  jl 	for_neighbour_loop

  inc 	qword 	[rsp]
  mov 	rcx, [rsp]
  mov 	rdx, [rdi + 16]  
  cmp 	rcx, rdx
  jl	hasRoute_loop  

  add 	rsp, 8
  leave
  ret

  ;; Helper function : updates routes for given node, where the magic happens

updateRoutes:
  push  rbp
  mov   rbp, rsp
  sub 	rsp, 8


  mov	rcx, 0 			; Counter used for looping through neighbours
  mov 	[rsp], rcx
  mov 	rdx, [node_array_size]
  mov 	[current_node], rdi

uR_while:
  mov 	rax, [node_array]
  mov 	rdi, [current_node]
  mov 	rsi, [rax+8*rcx]
  call 	hasRoute  
 
  inc	qword [rsp]
  mov 	rcx, [rsp]
  mov 	rdx, [node_array_size]
  cmp 	rcx, rdx
  jl	uR_while	

  add 	rsp, 8
  leave
  ret

  ;; Helper function : for each node, calls updateRoutes

updateAllRoutes:
  push  rbp
  mov   rbp, rsp

  sub   rsp, 8
  mov   rcx, 0
  mov   [rsp], rcx
  mov   rax, [node_array]
  cmp   rax, 0
  jne   uR_while
  leave
  ret

uAR_while:
  mov   rax, [node_array]
  mov   rdi, [rax+8*rcx]
  call  updateRoutes

  inc   qword   [rsp]
  mov   rcx, [rsp]
  mov   rdx, [node_array_size]
  cmp   rcx, rdx
  jl    uAR_while


  leave
  ret
