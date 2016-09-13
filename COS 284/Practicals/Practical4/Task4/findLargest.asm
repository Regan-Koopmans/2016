    section .data

largest     dq      0

    section .text
    global findLargest

findLargest:
    push    rbp
    mov     rbp,rsp

    mov     rax,rdi


    cmp     rax,rsi
    cmovl   rax,rsi

    cmp     rax,rdx
    cmovl   rax,rdx

    cmp     rax,rcx
    cmovl   rax,rcx

    cmp     rax,r8
    cmovl   rax,r8

    cmp     rax,r9
    cmovl   rax,r9

    mov     r10,0
while:
    cmp     r10,14
    jge     continue
    mov     ebx,[rsp+16+8*r10]
    
    cmp     eax,ebx
    cmovl   eax,ebx
    inc     r10
    jmp     while

continue:

    mov     rbp,rsp
    pop     rbp

    ret
