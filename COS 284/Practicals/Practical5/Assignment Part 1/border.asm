                                ; Assignment 5 - Task 1

  ;; Program      : Border
  ;; Author       : Regan Koopmans
  ;; Description  : Defines a function in which
  ;; takes a bitmap, adds a border, and writes this
  ;; to a destination file.


  ;; Next big thing : Gettings the dimensions
  ;; dynamically from file header


segment .data

source_name:                      dq    0
source_file:                      dq    0
source_size:                      dq    0
source_addr:                      dq    0
destination_name:                 dq    0
destination_file:                 dq    0

counter:                          dq    0
row_counter:                      dq    0
col_counter:                      dq    0
col_max:                          dq    0
row_max:                          dq    0
pixel:                            dq    0
pixel_size:                       dq    0

file_mode_read:                   dq    "r"
file_mode_write_or_create:        dq    "w+"
black_pixel:                      db    0

  ;; Imported functions

extern fopen                    ; used for opening the file
extern fclose
extern fseek
extern ftell

extern open
extern close

extern fgetc
extern fputc
extern printf
extern feof

extern mmap
extern munmap

segment .text
global border

border:

  push rbp
  mov  rbp,rsp

  mov  [source_name],rdi
  mov  [destination_name],rsi

  ;; Open source

  mov   rdi,[source_name]
  mov   rsi,file_mode_read
  call  fopen

  mov   [source_file],rax

  ;; Determine source size

  mov  rdi,[source_file]
  mov  rsi,0
  mov  rdx,2                    ; 2 = SEEK_END
  call fseek

  mov  rdi,[source_file]
  call ftell
  mov  [source_size],rax

  mov  rdi,[source_file]
  call fclose

  ;; int file_handle = open(source_name,O_RDONLY);

  mov  rdi,[source_name]
  mov  rsi,0                    ; 0 = O_RDONLY
  call open

  mov  [source_file],rax

  ;; Memory map source

  mov   rdi,0
  mov   rsi,[source_size]
  mov   rdx,1                   ; 1 = PROT_READ
  mov   rcx,1                   ; 1 = MAP_SHARED
  mov   r8,[source_file]
  mov   r9,0
  call  mmap

  mov   [source_addr],rax

  ;; Open destination

  mov   rdi,[destination_name]
  mov   rsi,file_mode_write_or_create
  call  fopen
  mov   [destination_file],rax

  mov   rax,[source_addr]
  mov   rbx,0
  mov   bx,[rax+18]
  mov   [col_max],bx
  mov   bx,[rax+22]
  mov   [row_max],bx
  mov   bl,[rax+28]

  ;; Write loop (copies file verbatim)

while:
  mov   rax,[counter]
  mov   rcx,0
  mov   rbx,[source_addr]
  mov   cl,[rbx+rax]

  mov   rax,[counter]
  cmp   rax,54
  jle   put_norm_no_inc

  ;; First row in image

  mov   rax,[row_counter]
  cmp   rax,0
  je    put_black

  ;; Last row in image

  mov   rax,[row_counter]
  mov   rbx,[row_max]
  cmp   rax,rbx
  je    put_black

  ;; First pixel in row

  mov   rax,[col_counter]
  mov   rbx,0
  cmp   rax,rbx
  je    put_black

  ;; Last pixel in row

  jmp   put_norm



put_black:
  mov   rcx,[black_pixel]

put_norm:

  mov   rdi,rcx
  mov   rsi,[destination_file]
	call  fputc

  inc   qword   [counter]

  inc   qword   [col_counter]
  mov   rax,[col_counter]
  mov   rbx,[col_max]
  cmp   rax,rbx
  jl    continue
  mov   rax,0
  mov   [col_counter],rax
  inc   qword   [row_counter]
  jmp   continue

put_norm_no_inc:
  inc   qword   [counter]
  mov   rdi,rcx
  mov   rsi,[destination_file]
  call  fputc

continue:
  mov   r8,[counter]
  mov   r9,[source_size]
  cmp   r8,r9
  jl  while

  ;; Unmap source

  mov   rdi,[source_addr]
  mov   rsi,[source_file]
  call  munmap

  ;; Close source

  mov   rdi,[source_file]
  call  close

  ;; Close destination

  mov   rdi,[destination_file]
  call  fclose

  leave
  ret
