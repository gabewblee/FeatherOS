ORG 0x7C00
BITS 16

CODE equ gdtCode - gdtStart
DATA equ gdtData - gdtStart

; BIOS Parameter Block 
_start:
    jmp short start
    nop

times 33 db 0

start:
    jmp 0:boot

boot:
    cli
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

; Load Protected Mode
.loadProtected:
    cli
    lgdt[gdtr]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE:load32

; GDT Descriptor
gdtStart:
gdtNull:
    dd 0x0
    dd 0x0

gdtCode:
    dw 0xffff
    dw 0
    db 0
    db 0x9A
    db 11001111b
    db 0

gdtData:
    dw 0xffff
    dw 0
    db 0
    db 0x92
    db 11001111b
    db 0

gdtEnd:

gdtr:
    dw gdtEnd - gdtStart-1
    dd gdtStart
 
; Enter 32-bit protected mode
[BITS 32]
load32:
    mov ax, DATA
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp

    ; Enable A20 line
    in al, 0x92
    or al, 2
    out 0x92, al

    jmp $

times 510-($ - $$) db 0
dw 0xAA55