; boot.asm - bootloader that prints message and waits for a keypress

[BITS 16]
[ORG 0x7C00]

start:
    ; Setup segments
    xor ax, ax       ; AX = 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    ; Clear screen
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    ; Print welcome message
    mov si, hello_msg
    call print_string

    ; Wait for key press
    call wait_key

    ; Print "You pressed: "
    mov si, pressed_msg
    call print_string

    ; Print the pressed key (in AL from wait_key)
    mov ah, 0x0E        ; BIOS teletype output
    int 0x10

    ; Hang
    jmp $

; -----------------------------
; print_string - prints null-terminated string at [SI]
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

; -----------------------------
; wait_key - waits for a keypress, result in AL
wait_key:
    xor ah, ah         ; AH = 0 (wait for keypress)
    int 0x16           ; BIOS keyboard interrupt
    ret

; -----------------------------
; Data
hello_msg   db 'Hello, Kernel World!', 0
pressed_msg db 13, 10, 'You pressed: ', 0  ; 13,10 = newline

; -----------------------------
; Padding
times 510-($-$$) db 0
dw 0xAA55
