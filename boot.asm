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

    

times 510 - ($ - $$) db 0
dw 0xAA55