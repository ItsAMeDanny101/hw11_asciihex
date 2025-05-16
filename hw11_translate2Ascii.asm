
; CMSC 313 HW#11 Print out data in ASCII hex 32 bit
; by Daniel Jalali


global _start

section .data
rawData   db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A      ; These are the bytes to be printed
totalCountOfRawBytes   equ $ - rawData         ; here our assembly program will count 8 bytes


; This is where we make the printables lines havign 80 bytes
section .bss
outputPrint  resb 80                  ; this is our detination buffer of space


; Our code actually tsatarts here 
section .text

; pointers and loop counter set up stuff
_start:
    mov     esi, rawData                ; esi points to the next unread byte
    mov     edi, outputPrint            ; edi points to the next write location in the output
    mov     ecx, totalCountOfRawBytes   ; exc holds the remaining bytes left to process


; this is the main loop to process one byte at a time
.process_byte:
    cmp     ecx, 0             ; if any bytes left
    je      .finish            ; and if not it jumps to printing

    lodsb                      ; this loads the byte at esi into al 
    call    byteToAscii        ; this conversts al write two ASCII hex chars

    dec     ecx                ; one less byte to handle 
    jz      .add_newline       ; if it is the last byte add a new line here

    mov     byte [edi], ' '    ; this would give us the space between the bytes
    inc     edi                ; moves the output pointer past the space
    jmp     .process_byte      ; to loop back for another byte

; to add a new line afterthe last byte
.add_newline:
    mov     byte [edi], 0x0A   ; this would simply make a newline
    inc     edi

; writes the whole string and then exits
.finish:
    mov     edx, edi             ; edx would be at the end of the string pointer
    sub     edx, outputPrint     ; edx here is the byte count to write

    mov     eax, 4              ; syscall 4 to write
    mov     ebx, 1              ; 1 file descriptor
    mov     ecx, outputPrint    ; our pointer to buffer
    int     0x80                ; kernal

    ; linux syscall to exit
    mov     eax, 1
    xor     ebx, ebx
    int     0x80



; This is for the extar credit stuff Subroutine byteToAscii
; This will counver the byte in AL to two hex characters and store them at edi

byteToAscii:
    mov     ah, al              ; saves original byte in AH

    shr     al, 4               ; brings the upper 4 bits into the lower 4 bts
    call    hexDigitToAscii     ; makes 0-15 into ascii
    mov     [edi], al           ; stores char
    inc     edi                 ; the output pointer

    mov     al, ah             ; restores full byte
    and     al, 0x0F           ; isolates the low 4 bits
    call    hexDigitToAscii
    mov     [edi], al
    inc     edi
    ret

; This will map a 4 bit value 0-15 into al to its printable
; hex character and return that ascii code in al
hexDigitToAscii:
    cmp     al, 9              ;is it 0 to 9
    jbe     .digit              ; if yes the n0 to 9
    add     al, 55             ; if not then we add 55 to get A to F
    ret
.digit:
    add     al, 48             ; adds 48 to get 0 to 9
    ret
