	section .data

number1 							dq 	0
number2 							dq 	0
result	 							dq	0
numInput1							dq 	0
numInput2							dq 	0
dummyRead							dq	0
operand								dq	0
character 						dq	0
remainder							dq 	0
positive							dq	43
negative 							dq	45
newline 							dq 	0x0a
error_message					dq  	"ERROR"
remainder_message			dq 	" r "
was_division					db 	0

	section .text
	global _start

_start:

	mov 	rax,0
	mov	  [was_division],rax

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

	cmp 		al,0
	jl 			error 						; Not in range
	cmp 		al,9
	jg 			error

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

	cmp 		al,0
	jl 			error 						; Not in range
	cmp 		al,9
	jg 			error

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

	jmp 	error

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
	mov 	r8,[number2]
	cmp 	r8,0
	je 		error 						; DIVIDE BY 0
	div   qword [number2]
	mov 	[result],rax
	mov 	[remainder],rdx
	mov byte [was_division],1
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
	div 	r8						; Initial division (just to check for overflow)
	cmp 	rax,0
	jg	overflow

	mov 	rax,[result]
	cmp 	rax,0
	jge	display_loop
	neg 	rax
	mov 	[result],rax

display_loop:
	mov 	r10,10				; Making double sure that 10 is in r10
	mov 	rax,r8
	mov 	rdx,0
	div 	r10						; divide the Power of 10 selector by 10
	mov 	r8,rax

	mov 	rax,[result] 	; move result into rax
	mov 	rdx,0
	div 	r8						; Divide by that power of 10

	mov 	[result],rdx
	add 	rax,48
	mov 	[character],rax

	mov 	rax,1
	mov 	rdx,1
	mov		rdi,1
	mov  	rsi,character
	syscall

	cmp 	r8,1
	jg 	    display_loop
	jmp 	print_remainder

error:
	mov 	rax,1
	mov 	rdx,5
	mov	rdi,1
	mov  	rsi,error_message
	syscall
	jmp 	exit

print_remainder:
	mov 	rax,[was_division]
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
