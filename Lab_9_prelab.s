/* ===================
   == bubble_sort.s ==
   =================== */

/*

PLANNING

Take in list as L, with count c
for i = 0; i < c; i++
    for j = 0; j < c; c++
        if L[i] < L[j]
            store = L[i]
            L[i] = L[j]
            L[j] = store
return L

*/

.text
.global _start

_start:
    LDR R8, =LIST ; Load the list into R2
    LDR R5, R2 ; Get the list length into R5
    MOV R6, #0 ; Get first iterator
    MOV R7, #0 ; Get second iterator
    ADD R8, #4 ; Shift selector to first list item

SORT_LOOP: 
    CMP R6, R5
    MOVEQ END ; Dip to the end if r6 has completed its iterations
    MUL R1, #4, R6 ; Get the number of addresses by which to shift R0
    MOV R0, R8 ; Load the origin register with the origin address
    ADD R0, R1 ; Shift to the target register from the origin
    BL SWAP ; Make the check for a swap
    ; There's a return in R0 now ;)
    ADD R6, #1 ; Iterate R6
    B SORT_LOOP ; Make da loop

SWAP:
    LDR R1, [R0]
    LDR R2, [R0, #4]
    CMP R1, R2 ; Swap if R1 is bigger than R2
    STRGE R1, [R0, #4]
    STRGE R2, [R0]
    MOVGE R0, #1 ; Put 1 in the return if we do big swapz
    MOVLT R0, #0 ; Put 0 in the return if no swap occurs
    MOV PC, LR ; Go back to executing what we were before

END: B END

LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33 ; Word count, followed by the list of words

.end