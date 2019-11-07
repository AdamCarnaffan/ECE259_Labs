/* ================ 
   == sum-nums.s ==
   ================ */
.global _start

_start:
    LDR R0, =TEST_NUM ; Move test num into memory
    MOV R1, #0 ; Default R1 iterator to 0
    LDR R2, [R0, R1] ; Load R0 with the offset of R1's value
    MOV R7, #0 ; Default our sum bit to 0
    MOV R8, #0 ; Default our count bit to 0

ADD_LOOP:
    CMP R2, #-1 ; Compare current adding value to -1
    BEQ END ; Go to end if complete
    ADDGE R8, #1 ; Increment positive number counter if positive number
    ADD R7, R2 ; Add the current value to the sum
    ADD R1, #4 ; Increment the value of the iterator by 4
    LDR R2, [R0, R1] ; Load new value into R2
    B ADD_LOOP

END: B END ; End loop

TEST_NUM: .word 1,2,3,5,0xA,-1 ; Instantiate sum list

.end