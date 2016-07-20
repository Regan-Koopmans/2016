; This is me practising assembly

  segment .data

message db "Hello world!",0 ; Data byte.
newline db  0xa,0xd

  segment .text ; Tells the assembler that this is where instructions are.
  global _start ; Tells the linker that start is a thing.

_start:
  mov eax,4         ; Place the instruction (sys_write) in eax
  mov ebx,1         ; Argument, file handle
  mov ecx,message   ; Load the message into ecx
  mov edx,12        ; Load the message length into edx
  int 0x80          ; Call the Kernel

  mov eax,4         ; Place the instruction (sys_write) in eax
  mov ebx,1         ; Argument, file handle
  mov ecx,newline   ; Load the message into ecx
  mov edx,2
  int 0x80          ; Call the Kernel

  mov eax,1         ; System call number (sys_exit)
  mov ebx,0         ; Exit code
  int 0x80          ; Call the Kernel
