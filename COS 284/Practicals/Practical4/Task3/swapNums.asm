    section .data

msg     dq      "The correct order is %.2f,%.2f,%.2f"
newline dq      0xa
temp    dq      0

    section .text
    global swapNums
    extern printf


swapNums:
    push    rbp
    mov     rbp,rsp
    mov     r8,4

loop:
    fcom

__swap1:

    fcom    xmm0,xmm1
    fjle    __swap2

__swap2:

    fcom xmm1,xmm2
    fjle    __continue

____continue:

    dec     r8
    cmp     r8,0
    je      loop

    pop     rbp
    ret
