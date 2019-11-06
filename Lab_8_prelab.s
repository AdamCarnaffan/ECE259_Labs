/* =============== 
   == count1s.s ==
   =============== */

.text
.global _start

_start:
    LDR R1, TEST NUM ; load the data word into R1
    MOV R0, #0 ; R0 will hold the result

LOOP: CMP R1, #0 ; loop until the data contains no more 1’s
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


/* ==========================
   == count1s_lead_trail.s ==
   ========================== */

; Same code but add subroutines for LEADING & TRAILING