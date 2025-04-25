global _main
extern _printf

section .data
    message db "Hello, Assembly world!", 0xA ,0
section .text
    _main:
    push message 
    call _printf

    add esp, 4 ; clean up the stack

    xor eax, eax
    ret