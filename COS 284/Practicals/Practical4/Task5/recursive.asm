    section .data

    section .text
    global recursive

x       equ     8
y       equ     16
z       equ     24
ret1    equ     32
ret2    equ     40
ret3    equ     48

recursive:
    push    rbp
    mov     rbp,rsp


    ; if (x >= y) return z

base_case:

    cmp     rdi,rsi
    jg      recursive_call
    mov     rax,rdx
    leave
    ret

    ; else

recursive_call:

    ; Saving the local versions of x y z

    sub     rsp,56
    mov     [rsp+x],rdi
    mov     [rsp+y],rsi
    mov     [rsp+z],rdx

    ; First recursive call.
    mov     rdi,[rsp+x]
    mov     rsi,[rsp+y]
    mov     rdx,[rsp+z]
    dec     rdi
    call    recursive           ; recurse (x-1,y,z)
    mov     [rsp+ret1],rax


    ; Second recursive call.

    mov     rdi,[rsp+y]
    dec     rdi
    mov     rsi,[rsp+z]
    mov     rdx,[rsp+x]
    call    recursive
    mov     [rsp+ret2],rax


    ; Third recursive call.

    mov     rdi,[rsp+z]
    dec     rdi
    mov     rsi,[rsp+x]
    mov     rdx,[rsp+y]
    call    recursive
    mov     [rsp+ret3],rax


    mov     rdi,[rsp+ret1]
    mov     rsi,[rsp+ret2]
    mov     rdx,[rsp+ret3]
    call    recursive
    
    add     rsp,56
    leave
    ret
