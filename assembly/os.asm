; boot.asm
[BITS 16]
[ORG 0x7C00]

start:
    ; Setup segments
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Clear screen
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Welcome message
    mov si, hello_msg
    call print_string

console_loop:
    ; Print prompt
    mov si, prompt
    call print_string

read_loop:
    ; Wait for key
    xor ax, ax
    int 0x16         ; Wait for keystroke → result in AL

    cmp al, 13        ; Enter key?
    je new_line

    ; Echo key to screen
    mov ah, 0x0E
    int 0x10
    jmp read_loop

new_line:
    ; Move to next line
    mov ah, 0x0E
    mov al, 13        ; Carriage return
    int 0x10
    mov al, 10        ; Line feed
    int 0x10

    jmp console_loop

; Function: print_string
print_string:
    pusha
.print_loop:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp .print_loop
.done:
    popa
    ret

; Messages
hello_msg db 'Simple Console Bootloader', 13, 10, 0
prompt     db '>', 0

; Bootloader padding
times 510-($-$$) db 0
dw 0xAA55
