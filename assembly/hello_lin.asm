section .data 
 msg db "hello, world",0xa ; string to print, 0xa is newline
 len equ $ - msg ; length of the string

section .text
global _start ; entry point for the program

_start:

mov eax, 4; ; syscall number for sys_write
mov ebx, 1  ; file descriptor 1 is stdout

; 0 stdin , 1 stout ;2 error
mov ecx, msg ; pointer to the string
mov edx , len
int 0x80 ; call kernel

; exit system call 
mov eax, 1 ; syscall number for sys_exit
xor ebx, ebx ; exit code 0
int 0x80 ; call kernel
