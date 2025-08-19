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
    lgdt[gdtDescriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE:load32

; GDT Descriptor
; Each entry is 8 bytes
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

gdtDescriptor:
    dw gdtEnd - gdtStart-1
    dd gdtStart

[BITS 32]
load32:
    mov eax, 1
    mov ecx, 100
    mov edi, 0x0100000
    call ataLbaRead
    jmp CODE:0x0100000

ataLbaRead:
    mov ebx, eax
    shr eax, 24
    or eax, 0xE0
    mov dx, 0x1F6
    out dx, al

    mov eax, ecx
    mov dx, 0x1F2
    out dx, al

    mov eax, ebx
    mox dx, 0x1F3
    out dx, al

    mov dx, 0x1F4
    mov eax, ebx
    shr eax, 8
    out dx, al

    mov dx, 0x1F5
    mov eax, ebx
    shr eax, 16
    out dx, al

    mov dx, 0x1F7
    mov al, 0x20
    out dx, al

.nextSector:
    push ecx

.tryAgain:
    mov dx, 0x1F7
    in al, dx
    test al, 8
    jz .tryAgain

    mov ecx, 256
    mov dx, 0x1F0
    rep insw
    pop ecx
    loop .nextSector
    ret

times 510 - ($ - $$) db 0
dw 0xAA55