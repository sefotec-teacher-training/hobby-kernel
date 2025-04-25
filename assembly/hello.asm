    ; this is comment
    section .data
    ; data declaratin goes here 
    message db "this is my assembly program"

    section .bss
    ; uninitialized data goes here
    buffer resb 64

    section .text
    global _start ; entry point for the program

    _start:
    ;code instruction goes here
     ;.....

     ;exit program 
     mov eax, 1 ; syscall number for sys_exit
     xor ebx, ebx ; exit code 0
     int 0x80 ; call kernel


