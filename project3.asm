TITLE project3 (project3.asm)

; J. Diaz  (N00794717@students.ncc.edu)
; CSC 250
; Project 3: Advanced Statistical Analysis
; Due 4/11/16 11:59 pm
; project3.asm

 INCLUDE c:\csc250\irvine\irvine32.inc
 INCLUDELIB c:\csc250\irvine\irvine32.lib
 INCLUDELIB c:\csc250\masm32\lib\user32.lib
 INCLUDELIB c:\csc250\masm32\lib\kernel32.lib
 
; Procedures
 EXTERN Input:PROTO, array:PTR REAL8
 EXTERN Mean:PROTO, array:PTR REAL8, array_size: DWORD
 EXTERN StandardDeviation:PROTO, array:PTR REAL8, array_size: DWORD
 EXTERN Output: PROTO, array_size: DWORD, mean__:PTR REAL8, standard__Deviation:PTR REAL8
 
 .data
 array REAL8 10 DUP(101.0)
 array_size DWORD ? 
 mean_ REAL8 ?
 standard_Deviation REAL8 ?
 
 ; Main
 ; Calls the procedures listed above
 .code
 main PROC
	finit
	
	INVOKE Input, ADDR array
	mov array_size, eax
	cmp array_size, 1 
	ja skipexception ; if only one entry has been entered
	fld REAL8 PTR [array]
	fstp mean_
	fldz
	fstp standard_Deviation
	jmp exception
	
	skipexception:
	; call to get Mean
	INVOKE Mean, ADDR array, array_size

	fld REAL8 PTR [eax]	
	fstp mean_
	
	; call to get Standard Deviation
	INVOKE StandardDeviation, ADDR array, array_size
	
	fld REAL8 PTR[eax]
	fstp standard_Deviation
	
	exception:
	INVOKE Output, array_size, ADDR mean_, ADDR standard_Deviation
	
	exit
main ENDP
END main