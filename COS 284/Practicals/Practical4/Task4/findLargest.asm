    section .data

largest     dq      0

    section .text
    global findLargest

findLargest:
    push    rbp
    mov     rbp,rsp

    pop     r12

    pop     rbp
    ret
