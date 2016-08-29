	section .data

number1 	dq 	0
number2 	dq 	0
numInput1	dq 	0
numInput2	dq 	0
dummyRead	dq	0
operand		dq	0

newline 	db	0xa

	section .text
	global _start

_start:

	mov 	rax,0	    ; Get input string
	mov 	rdx,6
	mov 	rdi,0
	mov 	rsi,numInput1
	syscall

	mov 	rax,0
	mov 	rdx,1
	mov 	rdi,0
	mov 	rsi,dummyRead	
	syscall

	mov 	rax,0
	mov 	rdx,1
	mov 	rdi,0
	mov 	rsi,operand
	syscall

	mov 	rax,0
	mov 	rdx,1
	mov 	rdi,0
	mov 	rsi,dummyRead
	syscall

	mov 	rax,0
	mov 	rdx,6
	mov 	rdi,0
	mov 	rsi,numInput2
	syscall

	mov 	rax,0
	mov 	rdx,2
	mov	rdi,0 
	mov 	rsi,dummyRead	
	
	mov 	r9,6	

convertNum1:

	mov r8,[numInput1]
	
	mov 	rax,1
	mov 	rdx,6
	mov 	rdi,1
	mov 	rsi,numInput1
	syscall

	mov 	rax,1
	mov 	rdx,1
	mov 	rdi,1
	mov 	rsi,newline
	syscall

	mov 	al,[numInput1]		; Converting from ASCII to decimal
	sub	al,48	

	movzx 	r12,al
	
	mov 	rax,1 			; Multiplying correct power of 10	
	mov 	r10,r9	
	sub	r10,1		
	mov 	rdx,10			; Register I will use to multiply with	
num1_mul10:
	cmp 	r10,0		
	je	end_mul10
	mul	rdx		
	dec 	r10	
	cmp	r10,0
	jg	num1_mul10

end_mul10:
	mul 	r12
	add  [number1],rax

	ror  qword [numInput1],8 	; Rotate 8 to next character

	dec 	r9	
	cmp	r9,0
	jg 	convertNum1

exit:

	mov 	rax,[number1]

	mov 	rax,1
	mov 	rdx,1
	mov	rdi,1
	mov 	rsi,operand
	syscall

	mov 	rax,60
	mov 	rdi,0
	syscall
