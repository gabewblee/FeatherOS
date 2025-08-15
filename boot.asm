ORG 0
BITS 16

_start:
    jmp short start
    nop

times 33 db 0

start:
    jmp 0x7C0:boot

boot:
    cli: 
    mov ax, 0x7C0
    mov ds, ax
    mov es, ax

    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7C00
    sti:

    mov si, message
    call print

print:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    jmp print

done:
    ret

message: db "Welcome to FeatherOS", 0

times 510 - ($ - $$) db 0
dw 0xAA55