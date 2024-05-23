.model small
.stack 100h

.data
    msg1 db 10, 13, "Enter any number up to 4 digits: $"
    msg2 db 10, 13, "The number is even.$"
    msg3 db 10, 13, "The number is odd.$"

.code
main:
    mov ax, @data
    mov ds, ax

    ; Print message asking for input
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Read input digits (up to 4 digits)
    mov cx, 4        ; Counter for the loop
    xor bx, bx       ; bx will hold the value of the number
    xor dx, dx       ; dx will hold the current digit position

input_loop:
    ; Read a single character
    mov ah, 01h
    int 21h

    ; Convert ASCII character to digit
    sub al, 30h

    ; Add the new digit to the number
    shl bx, 1        ; Shift bx to the left
    shl dx, 1        ; Shift dx to the left
    add bx, dx       ; Add dx to bx
    add dx, ax       ; Add the new digit to dx

    loop input_loop

    ; Check if the number is even or odd
    test dx, 1       ; Test the least significant bit
    jnz odd          ; Jump if it's odd

    ; If the LSB is 0, it's even
    mov ah, 09h
    lea dx, msg2
    int 21h
    jmp done

odd:
    ; If the LSB is 1, it's odd
    mov ah, 09h
    lea dx, msg3
    int 21h

done:
    mov ah, 4Ch      ; Exit program
    int 21h
end main
