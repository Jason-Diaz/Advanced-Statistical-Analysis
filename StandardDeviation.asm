TITLE StandardDeviation (StandardDeviation.asm)

; J. Diaz  (N00794717@students.ncc.edu)
; CSC 250
; Project 3: Advanced Statistical Analysis
; Due 4/11/16 11:59 pm
; StandardDeviation.asm

INCLUDE c:\csc250\irvine\irvine32.inc

; procedure
EXTERN Mean:PROTO, array:PTR REAL8, array_size: DWORD

.data
index REAL8 ?
Mean_ REAL8 ?
squared REAL8 0.0
Standard_Deviation REAL8 ?

; StandardDeviation
; procedure that accepts the address of an array of
; numbers and its effective size as stack parameters,
; and returns a reference to the standard deviation of the data.
; Returns a reference to the standard deviation (as a REAL8) in EAX.
.code
StandardDeviation PROC, array:PTR REAL8, array_size: DWORD

	INVOKE Mean, array, array_size ; call to get mean
	fld REAL8 PTR [eax]
	fstp Mean_ ; store mean in Mean_
	mov esi, array
	mov ecx, array_size
	
	; loop that subtracts the index in of the array by the mean
	; then squares the diffrence
StandardDeviationLoop:
	fld REAL8 PTR [esi]
	fstp index
	fld index
	FSUB Mean_
	FMUL ST(0),ST(0)
	add esi, TYPE REAL8
	fadd squared
	fstp squared
loop StandardDeviationLoop

fld squared ; squares result
fidiv array_size ; divideds by the array size
fsqrt ; squares the result
fstp Standard_Deviation
mov eax, OFFSET Standard_Deviation ; address of the standard deviation

	ret
StandardDeviation ENDP
END