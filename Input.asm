TITLE Input (Input.asm)

; J. Diaz  (N00794717@students.ncc.edu)
; CSC 250
; Project 3: Advanced Statistical Analysis
; Due 4/11/16 11:59 pm
; Input.asm

INCLUDE c:\csc250\irvine\irvine32.inc

.data
 prompt BYTE "Please enter a value: ",0
 space BYTE " ",0
 output BYTE "Please enter at least one valid entry",0
 output1 BYTE "The ",0
 output2 BYTE " data values are:",0
 temp REAL8 ?
 lowRange REAL8 -100.0
 highRange REAL8 100.0
 
; Input
; accepts the address of an array as a
; stack parameter, prompts the user to type in a series of signed 8-byte floating-point
; and store these values in the array. The procedure stop collecting data once 10 numbers have
; been entered, or upon reading a value outside the acceptable range, and then return
; in EAX the number of data values. Also this procedure verifies the user’s input
.code
Input PROC USES ebx ecx esi, array:PTR REAL8

	
	mov ecx, 10  ; highest amount of input accepted
	mov eax, 0
	mov edx, OFFSET prompt ; copies address of beginning of prompt in edx
	mov esi, array
	mov ebx, TYPE REAL8
	
	call Crlf
	; loop that accepts incoming values and stores them in the array
	inputLoop:
	call WriteString
	call ReadFloat
	fst temp 
	FCOM lowRange
	push eax
	fnstsw ax
	sahf
	pop eax
	jb noInput
	FCOM highRange
	push eax
	fnstsw ax
	sahf
	pop eax
	ja noInput
	fstp REAL8 PTR[esi] 
	add esi, ebx
	inc eax
	jmp continueloop
	
	noInput: ; exception if the users has entered the an invalid entry as their
	cmp ecx,10
	jne exitinputLoop
	inc ecx
	mov edx, OFFSET output ; copies address of beginning of part of the output in edx
    call WriteString
	call Crlf
	mov edx, OFFSET prompt 
	continueloop:
	loop inputLoop
	exitinputLoop:
	
	mov ecx, eax
	mov esi, array
	
	mov edx, OFFSET output1 ; copies address of part of the output in edx
    call WriteString
	call WriteDec ; amount of data values
	mov edx, OFFSET output2 ; copies address of part of output in edx
    call WriteString
	call Crlf
	
	mov edx, OFFSET space ; " "
	
	; loop that displays and verifies the users output
	displayInputLoop:
	fld REAL8 PTR[esi]
	call WriteFloat 
	call WriteString
	fstp temp
	add esi, ebx
	loop displayInputLoop
	
	ret
Input ENDP
END