; Accepts 6 floating point inputs

    section .bss

    section .data

matrix_1_1          dq      0
matrix_1_2          dq      0
matrix_2_1          dq      0
matrix_2_2          dq      0
matrix_1_norm       dq      0
matrix_2_norm       dq      0
result_dub          dq      0
result              dq      0

msg                 dq      "The dot product of (%.2f,%.2f) and (%.2f,%.2f) is "
result_msg          dq      "(%.2f)"
newline             dq      0xa

    section .text
    global dotProduct
    extern printf       ; "Imports" the c function
    extern putchar

dotProduct:
    push    rbp
    mov     rbp,rsp

    cvtss2sd    xmm0,xmm0
    cvtss2sd    xmm1,xmm1
    cvtss2sd    xmm2,xmm2
    cvtss2sd    xmm3,xmm3
    cvtss2sd    xmm4,xmm4
    cvtss2sd    xmm5,xmm5

    movsd       [matrix_1_1],xmm0
    movsd       [matrix_1_2],xmm1
    movsd       [matrix_1_norm],xmm2
    movsd       [matrix_2_1],xmm3
    movsd       [matrix_2_2],xmm4
    movsd       [matrix_2_norm],xmm5

    movsd       xmm0,[matrix_1_1]
    movsd       xmm1,[matrix_1_2]
    movsd       xmm2,[matrix_2_1]
    movsd       xmm3,[matrix_2_2]

    ; Print first part of prompt
    mov     rax,4
    mov     rdi,msg
    call    printf
    ; Normalise

    movsd       xmm0,[matrix_1_1]
    movsd       xmm1,[matrix_1_2]
    movsd       xmm2,[matrix_1_norm]
    movsd       xmm3,[matrix_2_1]
    movsd       xmm4,[matrix_2_2]
    movsd       xmm5,[matrix_2_norm]

    divsd       xmm0,xmm2
    divsd       xmm1,xmm2

    divsd       xmm3,xmm5
    divsd       xmm4,xmm5

    mulsd       xmm0,xmm3
    mulsd       xmm1,xmm4

    ; Two results should now be stored in xmm0 and xmm1

    addsd       xmm0,xmm1

    ; Final result should now reside in xmm0

    ; Print result of prompt

    mov         rdi,result_msg
    mov         rax,1
    call        printf

    mov     rdi,newline
    mov     rax,0
    call    printf

    pop rbp
    mov rax,0
    ret
