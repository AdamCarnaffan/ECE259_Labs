/* =============== 
   == count1s.s ==
   =============== */

.text
.global _start

_start:
    LDR R1, TEST_NUM ; load the data word into R1
    MOV R0, #0 ; R0 will hold the result

LOOP: 
    CMP R1, #0 ; loop until the data contains no more 1’s
    BEQ END
    LSR R2, R1, #1 ; perform SHIFT, followed by AND
    AND R1, R1, R2
    ADD R0, #1 ; count the string lengths so far
    B LOOP


END: B END

TEST_NUM: .word 0x103fe00f

.end

/* =================== 
   == count1s_sub.s ==
   =================== */

; Same code but using subroutine

.text
.global _start

_start:
    LDR R6, =TEST_NUM ; Get the first index of the test list
    MOV R7, #0 ; Instantiate the word iterator
    MOV R5, #0 ; Store the longest strand of 1s 

CHECK_WORD:
    LDR R0, [R6, R7] ; Load the value of the register into the new register
    CMP R0, #-1 ; End on list delimiter
    BEQ END
    MOV R1, #0 ; Set the counter for the number of 1s to zero
    BL WORD_LOOP ; Move to the word initiator
    ADD R7, #4 ; Increment iterator
    CMP R5, R1 ; Compare longest in current word to longest longest
    MOVLE R5, R1 ; If R1 is big boi, make the swap
    B CHECK_WORD ; Continue looping word checks

WORD_LOOP:
    CMP R0, #0 ; loop until the data contains no more 1’s
    MOVEQ PC, LR ; Go back to the iterator evaluation
    LSR R2, R0, #1 ; perform SHIFT, followed by AND
    AND R0, R0, R2
    ADD R1, #1 ; count the string lengths so far
    B WORD_LOOP ; go back to the top of the word

END: B END ; End loop

TEST_NUM: .word 0x103fe00f, 0x1111FF, 0xA4523E, 0x1233AABE, 0x00000000, 0x12598AC1, 0xFFF111AA, 0xAA976612, 0xAABE0192, 0xFF145F02, -1 ; Test Case

.end


/* ==========================
   == count1s_lead_trail.s ==
   ========================== */

; Same code but add subroutines for LEADING & TRAILING

.text
.global _start

_start:
    LDR R6, =TEST_NUM ; Get the first index of the test list
    MOV R7, #0 ; Instantiate the word iterator
    MOV R8, #0 ; Store the longest 1 count
    MOV R9, #0 ; Store the longest leading 0 count
    MOV R10, #0 ; Store the longest trailing 0 count

CHECK_WORD:
    LDR R0, [R6, R7] ; Load the value of the register into the new register
    CMP R0, #-1 ; End on list delimiter
    BEQ END

    MOV R1, #0 ; Set the counter for the number of 1s to zero
    BL COUNT_ONES ; Move to the word initiator
    CMP R8, R1 ; Compare longest current word to longest longest
    MOVLE R8, R1 ; If R1 is big boi, make the swap

    LDR R0, [R6, R7] ; Reload state
    MOV R3, #0 ; Set iterator to 0 to verify a complete set of zeros
    MOV R1, #0 ; Set the counter for the number of leading to zero
    BL COUNT_LEADING ; Move to the leading counter
    CMP R9, R1 ; Compare longest current word to longest longest
    MOVLE R9, R1 ; If R1 is big boi, make the swap
    
    ; Dont reload state because we move from the end
    MOV R3, #0 ; Set iterator to 0 to verify a complete set of zeros
    MOV R1, #0 ; Set the counter for the number of  trailing to zero
    BL COUNT_TRAILING ; Move to the trailing counter
    CMP R10, R1 ; Compare longest current word to longest longest
    MOVLE R10, R1 ; If R1 is big boi, make the swap

    ADD R7, #4 ; Increment iterator
    B CHECK_WORD ; Continue looping word checks

COUNT_LEADING:
    ADD R3, #1 ; Increment number of bits counted
    CMP R0, #1 ; loop until the data contains no more 1’s
    MOVEQ PC, LR ; Go back to the iterator evaluation   
    LSR R2, R0, #1 ; perform SHIFT, followed by AND
    AND R0, R0, R2
    ADD R1, #1 ; count the string lengths so far
    CMP R3, #32 ; Check if value is greater than number of bits per word
    MOVGE PC, LR ; Go back to the iterator evaluation
    B COUNT_LEADING ; go back to the top of the word

COUNT_TRAILING:
    ADD R3, #1 ; Increment number of bits counted
    CMP R0, #1 ; loop until the data contains no more 1’s
    MOVEQ PC, LR ; Go back to the iterator evaluation   
    LSL R2, R0, #1 ; perform SHIFT, followed by AND
    AND R0, R0, R2
    ADD R1, #1 ; count the string lengths so far
    CMP R3, #32 ; Check if value is greater than number of bits per word
    MOVGE PC, LR ; Go back to the iterator evaluation
    B COUNT_TRAILING ; go back to the top of the word

COUNT_ONES:
    CMP R0, #0 ; loop until the data contains no more 1’s
    MOVEQ PC, LR ; Go back to the iterator evaluation
    LSR R2, R0, #1 ; perform SHIFT, followed by AND
    AND R0, R0, R2
    ADD R1, #1 ; count the string lengths so far
    B COUNT_ONES ; go back to the top of the word

END: B END ; End loop

TEST_NUM: .word 0x103fe00f, 0x1111FF, 0xA4523E, 0x1233AABE, 0x00000000, 0x12598AC1, 0xFFF111AA, 0xAA976612, 0xAABE0192, 0xFF145F02, -1 ; Test Case

.end