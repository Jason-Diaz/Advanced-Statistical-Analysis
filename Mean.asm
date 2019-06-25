TITLE Mean (Mean.asm)

INCLUDE c:\csc250\irvine\irvine32.inc

; J. Diaz  (N00794717@students.ncc.edu)
; CSC 250
; Project 3: Advanced Statistical Analysis
; Due 4/11/16 11:59 pm
; Mean.asm

.data
Mean_ REAL8 ?

; Mean
; procedure that accepts the address of an array of
; numbers, and how many values it contains as stack parameters.
; The procedure must then calculate the mean of
; these numbers, and return a reference to the mean (as a REAL8) in EAX.
.code
Mean PROC USES ebx ecx esi, array:PTR REAL8, array_size: DWORD

	mov ecx, array_size
	mov esi, array
	mov ebx, TYPE REAL8
	
	fld REAL8 PTR[esi] ; loads array on to FPU stack
	dec ecx
	; loop that adds all values in array
	additionLoop:
	add esi, ebx
	fadd REAL8 PTR[esi]
	;add esi, ebx
	loop additionLoop
	
	FIDIV array_size ; divideds by the amount of numbers in the array
	fst Mean_
	mov eax, OFFSET Mean_ ; address of the mean
	ret
Mean ENDP
END