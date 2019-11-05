/* ================ 
   == sum-nums.s ==
   ================ */
.global _start

_start:
    LDR R0, =TEST_NUM ; Move test num into memory
    MOV R1, #0 ; Default R1 iterator to 0
    LDR R2, [R0, R1] ; Load R0 with the offset of R1's value
    MOV R7, #0 ; Default our sum bit to 0

    CMP R2, #-1 ; Compare current adding value to -1
    ITE EQ
    BEQ END ; Go to end if empty
    BNE ADD_LOOP ; Go to add loop if values exist

CONTINUE_ADD:
    CMP R2, #-1 ; Compare current adding value to -1
    ITE EQ
    BEQ END ; Go to end when complete
    BNE ADD_LOOP; Go to add in another loop

ADD_LOOP:
    ADD R7, R2 ; Add the value
    ADD R1, #4 ; Iterate the index of the test sequence
    LDR R2, [R0, R1] ; Load R0 with the offset of R1's value
    B CONTINUE_ADD ; Go to Start

END: B END ; End loop

TEST_NUM: .word 1,2,3,5,0xA,-1 ; Instantiate sum list

.end