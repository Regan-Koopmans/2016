                                ; Assignment 5 - Task 2

  ;; Program      : Crop
  ;; Author       : Regan Koopmans
  ;; Description  : Defines a function in which
  ;; takes a bitmap, crops it to given dimensions,
  ;; and writes this to a destination file.

segment .data

  ;; MEMORY LABELS

  ;; File Labels

source_name:                      dq    0
source_file:                      dq    0
source_size:                      dq    0
source_addr:                      dq    0
destination_name:                 dq    0
destination_file:                 dq    0
destination_addr:                 dq    0
pixel:                            dq    0
skip_rest:                        dq    0

  ;; Loop Management Labels

counter:                          dq    0
row_counter:                      dq    0
col_counter:                      dq    0
col_max:                          dq    0
row_max:                          dq    0
crop_width:                       dq    0
crop_height:                      dq    0
start_pixel_array:                dq    0
pixel_array_size:                 dq    0

  ;; Constants

file_mode_read:                   dq    "r"
file_mode_write_or_create:        dq    "w+"

  ;; IMPORTED FUNCTIONS

extern fopen                    ; used for opening the file
extern fclose                   ; used for closing a file
extern fseek                    ; use for traversing a file
extern ftell                    ; used to determine location in file

extern open                     ; used to open a generic stream
extern close                    ; used to close a generic stream

extern fputc                    ; used to write a single byte to a file

extern mmap                     ; Used to map a file to a contiguous memory array
extern munmap                   ; Used to unmap a file that was previously 'mmapped'

segment .text
global crop

crop:
  push rbp
  mov  rbp,rsp

  mov  [source_name],rdi
  mov  [destination_name],rsi
  mov  [crop_width],rdx
  mov  [crop_height],rcx

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
  mov   rbx,[rax+10]
  mov   [start_pixel_array],rbx
  mov   rbx,[col_max]
  sub   rbx,[crop_width]
  mov   [skip_rest],rbx
  mov   rax,[col_max]
  mul   qword [row_max]
  mov   [pixel_array_size],rax

  mov   rax,[crop_width]
  mov   [col_counter],rax

while:                          ; This segment manages the central loop of the program
  mov   rax,[counter]           ; and determines whether
  mov   rcx,0
  mov   rbx,[source_addr]
  mov   rcx,[rbx+rax]
  mov   [pixel],rcx

  mov   rax,[counter]
  mov   rbx,18
  cmp   rax,rbx
  je    put_dimensions

  mov   rax,[counter]
  mov   rbx,[start_pixel_array]
  cmp   ax,bx
  jl    put_norm_no_inc

  mov   rax,[col_counter]
  mov   rbx,[crop_width]
  cmp   ax,bx
  jle    put_norm

  mov   rax,0
  mov   [col_counter],rax
  mov   rax,[skip_rest]
  add   qword [counter],rbx
  mov   rax,0

  jmp   while

put_dimensions:                 ; This segment writes the new cropped dimensions
  mov   rdi,[crop_width]        ; to the destination file.
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_width]
  shl   rdi,8
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_width]
  shl   rdi,16
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_width]
  shl   rdi,24
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_height]
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_height]
  shl   rdi,8
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_width]
  shl   rdi,16
  mov   rsi,[destination_file]
  call  fputc

  mov   rdi,[crop_width]
  shl   rdi,24
  mov   rsi,[destination_file]
  call  fputc

  mov   rax,26
  mov   [counter],rax
  jmp   while

put_norm:                       ; This segment prints a normal character

  mov   rdi,[pixel]
  mov   rsi,[destination_file]
  call  fputc

  inc   qword   [counter]
  inc   qword   [col_counter]

  jmp   continue

put_norm_no_inc:
  inc   qword   [counter]
  mov   rdi,[pixel]
  mov   rsi,[destination_file]
  call  fputc

continue:
  mov   rax,[counter]
  mov   rbx,[source_size]
  cmp   ax,bx
  jl    while

end:
  ;; Unmap source

  mov   rdi,[source_addr]
  mov   rsi,[source_size]
  call  munmap

  ;; Close source

  mov   rdi,[source_file]
  call  close

  ;; Close destination

  mov   rdi,[destination_file]
  call  fclose

  leave
  ret
