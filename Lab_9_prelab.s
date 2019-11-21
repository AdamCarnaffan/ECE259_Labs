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
    LDR R5, [R8] ; Get the list length into R5 (Probably don't need to store)
    SUB R9, R5, #1 ; Make a value for iterations (1 less than count)
    MOV R6, #0 ; Get first iterator
    MOV R7, #0 ; Get second iterator
    ADD R8, #4 ; Shift selector to first list item

SORT_LOOP: 
    CMP R6, R9
    ADDEQ R7, #1 ; Iterate the external iterator
    MOVEQ R6, #0 ; Reset first iterator
    CMP R7, R9
    BEQ END ; Dip to the end if r6 has completed its iterations
    MOV R1, R6, LSL #2 ; Get the number of addresses by which to shift R0
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

/* ===================
   == led_bouncer.s ==
   =================== */

.text
.global _start

_start:
	LDR R9, =0xFF200050 ; Store address of KEY[0]
    LDR R7, =0xFF200000 ; Store address of LEDR[0]
	LDR R8, =0xFFFEC600 ; Store address of Timer
	LDR R0, =500000000 ; Clock control value
	STR R0, [R8] ; Push to load timer
	MOV R0, #0b011
	STR R0, [R8, #8] ; Write control
	MOV R2, #1
	STR R2, [R1]
	MOV R3, #0x84 ; Store first LED values
	MOV R4, #0 ; Director
	MOV R5, #0 ; Holder

SHIFT:
	; Check hold
	CMP R5, #1
	BEQ DELAY
	; Check first 4 bits direction change
	MOV R0, #0x1F
	AND R0, R0, R3
	CMP R0, #1
	MOVEQ R4, #1 ; Set to left
	CMP R0, #0x10
	MOVEQ R4, #0 ; Set to right
	; MAKE LEFT SIDE SHIFT
	MOV R1, #0x3E0
	AND R1, R1, R3
	CMP R4, #0
	LSLEQ R1, #1
	LSRNE R1, #1
	; MAKE RIGHT SIDE SHIFT
	MOV R0, #0x1F
	AND R0, R0, R3
	CMP R4, #0
	LSLNE R0, #1
	LSREQ R0, #1
	; SAVE PRODUCT
	ADD R3, R0, R1 ; Concatonate bits
	
DISPLAY:
	STR R3, [R7] ; SET LEDs

DELAY: 
	LDR R0, [R9] ; Read Key Status
	CMP R0, #0
	BNE KEY_WAIT ; Jump to key handler on press
	LDR R0, [R8, #0xC] ; Read Status
	CMP R0, #0
	BEQ DELAY
	STR R0, [R8, #0xC] ; Write Status
	B SHIFT

KEY_WAIT:
	LDR R0, [R9] ; Read Key Status
	CMP R0, #0
	EOREQ R5, R5, #1 ; Flip holder
	BEQ DELAY
	B KEY_WAIT

END: B END ; Da end loop brah

.end