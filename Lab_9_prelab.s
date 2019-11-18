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
    LDR R2, =LIST ; Load the list into R2
    LDR R5, R2 ; Get the list length into R5
    MOV R6, #0 ; Get first iterator
    MOV R7, #0 ; Get second iterator
    ADD R2, #4 ; Shift selector to first list item

SORT_LOOP: 
    CMP R6, R5
    MOVEQ END ; Dip to the end if r6 has completed its iterations
    MUL R1, #4, R6 ; Get the number of addresses by which to shift R0
    MOV R0, [R2, R1]
    

SWAP:



END: B END

LIST: .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33 ; Word count, followed by the list of words

.end