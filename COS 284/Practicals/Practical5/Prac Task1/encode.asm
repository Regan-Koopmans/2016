                                ; Practical 5 - Task 1

  ;; Program      : Encode
  ;; Author       : Regan Koopmans
  ;; Description  : Defines a function in which a given char array
  ;; parameter is outputted in its run-length encoded form.

  segment .data

input_array_ptr       dq    0
output_fmt            dq    "%c%d"
newline               dq    10
same_char_count	      dq    1
global_char_count     dq    1
prev_char             dq    0
array_size            dq    0

  segment .text

  ;; External Functions

  extern printf                 ; Prints formatted strings
  extern strlen                 ; Determines the length of the array
  extern putchar                ; Prints individual characters

  ;; Scope resolution

  global encode

encode:

  ;; Set up the stack frame
  push  rbp
  mov   rbp,rsp

  mov   [input_array_ptr],rdi
  mov   rbx,[input_array_ptr]
  mov   al,[rbx]
  mov   [prev_char],al

  mov   rdi,[input_array_ptr]
  call  strlen
  mov   [array_size],rax

while:

  inc   qword [input_array_ptr]

  ;; Find out whether past original array

  mov   r8,[global_char_count]
  mov   r9,[array_size]
  cmp   r8,r9
  jg    exit

  ;; Determine whether current char is equal to a previous one

  mov   rbx,[input_array_ptr]
  mov   al,[rbx]
  mov   dl,[prev_char]
  cmp   al,dl
  je   same_char

diff_char:

  ;; Load registers to print the character and repeating count

  lea   rdi,[output_fmt]
  mov   rsi,[prev_char]
  mov   rdx,[same_char_count]

	call printf

  mov   rbx,[input_array_ptr]
  mov   rax,[rbx]
  mov   [prev_char],rax

  ;; Set same counter to 1
  ;; Incrememt global character counter

  mov   qword [same_char_count],1
	inc   qword [global_char_count]
	jmp   while

same_char:
  mov   rcx,[same_char_count]
  cmp   rcx,9
  jge   diff_char

  inc   qword  [same_char_count]
  inc   qword  [global_char_count]
  jmp   while

exit:

  ;; Print final new line character

  mov  rdi,[newline]
  call putchar

  leave
  ret
