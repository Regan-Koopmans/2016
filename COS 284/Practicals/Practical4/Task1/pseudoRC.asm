; Accepts three integers
; Divide the first integer by the second integer
; Returns 0 or 1 to indicate if result equals third parameter

    section .data

parameter1     dq       0
parameter2     dq       0
parameter3     dq       0


    section .text
    global pseudoRC             ; Tells the linker that this function exists 

pseudoRC:
    mov     [parameter1],rdi
    mov     [parameter2],rsi
    mov     [parameter3],rdx

    mov     rax,[parameter2]
    cmp     rax,0
    je      div_by_0

    ; Perform the division

    mov     rax,[parameter1]
    mov     rdx,0
    div     qword [parameter2]

    mov     r9,[parameter3]

    mov     r8,0
    mov     r10,1
    cmp     rdx,r9
    cmove   r8,r10

    mov     rax,r8
    ret

div_by_0:
    mov     rax,0
    ret
