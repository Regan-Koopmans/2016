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

max_red:                          dq    00000111b
max_green:                        dq    00111000b
max_blue:                         dq    11000000b
max_selected:                     dq    0

file_mode_read:                   dq    "r"
file_mode_write_or_create:        dq    "w+"
black_pixel:                      db    0
start_pixel_array:                dq    0

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
global intensity

intensity:

  push rbp
  mov  rbp,rsp

  mov  [source_name],rdi
  mov  [destination_name],rsi

  mov   rax,0
  cmp   rdx,0
  cmove rax,[max_red]
  cmp   rdx,1
  cmove rax,[max_green]
  cmp   rdx,2
  cmove  rax,[max_blue]

  mov   [max_selected],rax
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
  mov   rbx,[rax+10]
  mov   [start_pixel_array],rbx


  ;; Write loop (copies file verbatim)

while:
  mov   rax,[counter]
  mov   rcx,0
  mov   rbx,[source_addr]
  mov   cl,[rbx+rax]

  mov   rax,[counter]
  mov   rbx,[start_pixel_array]
  cmp   ax,bx
  jl    put_norm_no_inc

put_norm:
  mov   rax,[max_selected]
  or    rcx,rax
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
