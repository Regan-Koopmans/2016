<!-- $theme: gaia
template:gaia-->

COS 284 : Computer Organisation and Architecture
===
---
<!-- $theme: gaia
template : normal -->

# Example 

This program simply starts and exits:

```asm
section .text
global _start

_start:
	mov eax,1
	mov ebx,5
	int 0x80

```

---

# Example

- `sample .text` - portion of the source that is instructions
- `global _start` - tells the linker about _start
- `mov eax,1` - sets the sys_call number (1=exit)
- `mov ebx,5` - sets return value of program.
- `int 0x80` - system call

---

# Data Representations

