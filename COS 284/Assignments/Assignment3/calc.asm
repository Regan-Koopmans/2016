	section .data

number1 			dq 	0
number2 			dq 	0
result	 			dq	0
numInput1			dq 	0
numInput2			dq 	0
dummyRead			dq	0
operand				dq	0
character 			dq	0
remainder			dq 	0
positive			dq	43
negative 			dq	45
newline 			dq 	0x0a
error_message			dq  	"ERROR"
remainder_message		dq 	" r "

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
	syscall



	mov 	r9,6
convertNum1:

	mov 	r8,[numInput1]
	mov 	al,[numInput1]		; Converting from ASCII to decimal
	sub	al,48
	movzx 	r12,al
	mov	rax,1 			; Multiplying correct power of 10
	mov 	r10,r9
	sub	r10,1
	mov	r11,10			; Register I will use to multiply with

num1_mul10:
	cmp 	r10,0
	je	num1_end_mul10
	mul	r11
	dec 	r10
	cmp	  r10,0
	jg	   num1_mul10

num1_end_mul10:
	mul 	r12
	add  [number1],rax
	ror  qword [numInput1],8 	; Rotate 8 to next character
	dec 	r9
	cmp	r9,0
	jg 	convertNum1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov 	r9,6

convertNum2:
	mov r8,[numInput2]
	mov 	al,[numInput2]		; Converting from ASCII to decimal
	sub	    al,48
	movzx 	r12,al
	mov 	rax,1 			; Multiplying correct power of 10
	mov 	r10,r9
	sub	   r10,1
	mov 	r11,10			; Register I will use to multiply with

num2_mul10:
	cmp 	r10,0
	je	num2_end_mul10
	mul	r11
	dec 	r10
	cmp	r10,0
	jg	num2_mul10

num2_end_mul10:
	mul 	r12
	add  [number2],rax
	ror  qword [numInput2],8 	; Rotate 8 to next character
	dec 	r9
	cmp	r9,0
	jg 	convertNum2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	mov 	rax,[operand]
	cmp		rax,43
	je 		add_numbers

	cmp		rax,45
	je 		subtract_numbers

	cmp		rax,42
	je 		multiply_numbers

	cmp		rax,47
	je 		divide_numbers

add_numbers:
	mov 	rax,[number1]
	mov 	[result],rax
	mov 	rax,[number2]
	add   	qword	[result],rax
	jmp 	print_sign

subtract_numbers:
	mov 	rax,[number1]
	mov 	[result],rax
	mov 	rax,[number2]
	sub   qword 	[result],rax
	jmp 	print_sign

multiply_numbers:
	mov 	rax,[number1]
	mul   qword [number2]
	mov 	[result],rax
	jmp 	print_sign

divide_numbers:
	mov 	rax,[number1]
	div   qword [number2]
	mov 	[result],rax
	mov 	[remainder],rdx
	jmp 	print_sign

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_sign:
	mov 	rax,[result]
	cmp 	rax,0
	jl 	print_sign_negative
	mov 	rax,1
	mov 	rdi,1
	mov 	rdx,1
	mov 	rsi,positive
	syscall
	jmp 	display

print_sign_negative:
	mov 	rax,[result]
	cmp	rax,0
	jge	display
	mov 	rax,1
	mov 	rdx,1
	mov		rdi,1
	mov  	rsi,negative
	syscall

display:

	mov 	r8,1000000000000
	mov 	rax,[result]
	mov 	rdx,0
	div 	r8
	cmp 	rax,0
	jg	overflow

	mov 	rax,[result]
	cmp 	rax,0
	jge	display_loop
	neg 	rax
	mov 	[result],rax

display_loop:
	mov 	r10,10
	mov 	rax,r8
	mov 	rdx,0
	div 	r10
	mov 	r8,rax

	mov 	rax,[result]
	mov 	rdx,0
	div 	r8

	mov 	[result],rdx
	add 	rax,48
	mov 	[character],rax

	mov 	rax,1
	mov 	rdx,1
	mov	rdi,1
	mov  	rsi,character
	syscall

	cmp 	r8,1
	jg 	display_loop
	jmp 	print_remainder

overflow:
	mov 	rax,1
	mov 	rdx,5
	mov	rdi,1
	mov  	rsi,error_message
	syscall
	jmp 	exit

print_remainder:
	mov 	rax,[remainder]
	cmp 	rax,0
	je	exit
	mov 	rax,1
	mov 	rdi,1
	mov 	rdx,4
	mov 	rsi,remainder_message
	syscall	

	add  qword [remainder],48
	mov 	rax,1
	mov 	rdx,1
	mov 	rdi,1
	mov 	rsi,remainder
	syscall

exit:
	mov 	rax,1
	mov 	rdx,1
	mov	rdi,1
	mov  	rsi,newline
	syscall

	mov 	rax,60
	mov 	rdi,0
	syscall
