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
destination_name:                 dq    0
destination_file                  dq    0

counter:                          dq    0
row_counter:                      dq    0
col_counter:                      dq    0
col_max:                          dw    0
row_max:                          dw    0
pixel:                            dq    0


file_mode_read:                   dq    "r"
file_mode_write_or_create:        dq    "w+"
scan_format:                      dq    "%d"
black_pixel:                      db    0

  ;; Imported functions

extern fopen                    ; used for opening the file
extern fclose
extern fseek

extern fgetc
extern fputc
extern fputs
extern fscanf
extern printf
extern feof

segment .text
global border

border:

  push rbp
  mov  rbp,rsp

  mov  [source_name],rdi
  mov  [destination_name],rsi

                                ; Read from file

  ;; Open source

  mov   rdi,[source_name]
  mov   rsi,file_mode_read
  call  fopen

  mov   [source_file],rax

  ;; Open destination

  mov   rdi,[destination_name]
  mov   rsi,file_mode_write_or_create
  call  fopen

  mov   [destination_file],rax

  ;; Move to pixel array

  ;; Read pixel

read_pixel:

  ;; How do I know when its the pixel array?

  inc   qword   [counter]
  mov   rdi,[source_file]
  call  fgetc

  mov   rcx,[counter]
  cmp   rcx,18
  ;; je    get_dimensions

  mov   rcx,[counter]
  cmp   rcx,54
  jle   put_norm_no_inc

  mov   rcx,[row_counter]
  cmp   rcx,0
  je    put_black

  mov   rcx,[row_counter]
  cmp   rcx,[row_max]
  je    put_black

  mov   rcx,[col_counter]
  cmp   rcx,2
  jle    put_black

  mov   rcx,[col_counter]
  mov   rdx,[col_max]
  sub   rdx,3
  cmp   rcx,rdx
  jge   put_black
  jmp   put_norm

put_black:
  inc   qword    [col_counter]
  mov   rdi,[black_pixel]
  mov   rsi,[destination_file]
  call  fputc
  jmp   continue

get_dimensions:

  mov   rdi,[source_file]
  mov   rsi,scan_format
  mov   rdx,col_max
  call  fscanf

  mov   rdi,[source_file]
  mov   rsi,scan_format
  mov   rdx,row_max
  call  fscanf

  mov   rdi,scan_format
  mov   rsi,[col_max]
  call  printf

  jmp   continue

put_norm:
  inc   qword     [col_counter]
put_norm_no_inc:
  mov   rdi,rax
	mov   rsi,[destination_file]
	call  fputc

continue:

  mov   rcx,[col_counter]
  cmp   rcx,[col_max]
  jle   no_row_change

  mov   rax,0
  mov   [col_counter],rax
  inc   qword   [row_counter]

no_row_change:
  mov   rdi,[source_file]
  call  feof
  cmp   rax,0
  je    read_pixel

  ;; Close source

  mov   rdi,[source_file]
  call  fclose

  ;; Close destination

  mov   rdi,[destination_file]
  call  fclose

  leave
  ret
