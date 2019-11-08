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


COUNT_ONES:
    MOV R0, #0 ; Set the counter for the number of 1s to zero

WORD_LOOP:
    CMP R1, #0 ; loop until the data contains no more 1’s
    BEQ CHECK_WORD ; Go back to the iterator evaluation
    LSR R2, R1, #1 ; perform SHIFT, followed by AND
    AND R1, R1, R2
    ADD R0, #1 ; count the string lengths so far
    B WORD_LOOP ; go back to the top of the word

END: B END ; End loop

TEST_NUM: .word 0x103fe00f, 0x1111FF, 0xA4523E ; Test Case

.end


/* ==========================
   == count1s_lead_trail.s ==
   ========================== */

; Same code but add subroutines for LEADING & TRAILING