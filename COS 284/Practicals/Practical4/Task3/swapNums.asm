    section .data

msg     dq      "The correct order is %.2f,%.2f,%.2f"
newline dq      0xa
temp    dq      0
num1 	dq 	0

    section .text
    global swapNums
    extern printf

swapNums:
    push    rbp
    mov     rbp,rsp
    mov     r8,5

    movss  xmm0,[rax]
    movss  xmm1,[rcx]
    movss  xmm2,[rdx]

    cvtss2sd    xmm0,xmm0
    cvtss2sd    xmm1,xmm1
    cvtss2sd    xmm2,xmm2

swap1:
    ucomisd 	xmm0,xmm1
    jbe		swap2
    movsd 	[temp],xmm0
    movsd 	xmm0,xmm1
    movsd 	xmm1,[temp] 

swap2:

    ucomisd 	xmm1,xmm2
    jbe 	continue	
    movsd 	[temp],xmm1
    movsd 	xmm1,xmm2
    movsd 	xmm2,[temp] 
	
continue:

    dec     r8
    cmp     r8,0
    jg      swap1

    cvtsd2ss xmm0,xmm0
    cvtsd2ss xmm1,xmm1
    cvtsd2ss xmm2,xmm2

    movss  [rax],xmm0
    movss  [rcx],xmm1
    movss  [rdx],xmm2 

    pop     rbp
    ret
