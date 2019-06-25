TITLE Output (Output.asm)

; J. Diaz  (N00794717@students.ncc.edu)
; CSC 250
; Project 3: Advanced Statistical Analysis
; Due 4/11/16 11:59 pm
; Output.asm

INCLUDE c:\csc250\irvine\irvine32.inc

.data
 output1 BYTE "The mean of these ",0
 output2 BYTE " values is ",0
 output3 BYTE "The standard deviation of these ",0
 period BYTE ".",0
 Mean_ REAL8 ?
 Standard_Deviation REAL8 ?
 
; Output
; procedure that accepts the effective size of the input, a
; reference to the mean, and a reference to the standard deviation, and generates a
; nice-looking readable report. 
.code
Output PROC, array_size: DWORD,
	mean__:PTR REAL8,
	standard__Deviation:PTR REAL8
	
	finit	
	
	mov eax, mean__
	fld REAL8 PTR [eax] ; loads to FPU what the address in eax is, mean
	fstp Mean_
	
	mov eax, standard__Deviation
	fld REAL8 PTR [eax] ; loads to FPU what the address in eax is, mean
	fstp Standard_Deviation
	
	call Crlf
	mov edx, OFFSET output1 ; copies address of beginning output in edx
    call WriteString
	mov eax, array_size
	call WriteDec ; amount of data values
	mov edx, OFFSET output2 ; copies address of output in edx
    call WriteString
	fld Mean_ ; loads mean to FPU
	call WriteFloat 
	mov edx, OFFSET period ; copies address of output in edx
    call WriteString
	
	call Crlf
	
	mov edx, OFFSET output3 ; copies address of output in edx
    call WriteString
	mov eax, array_size
	call WriteDec ; amount of data values
	mov edx, OFFSET output2 ; copies address of output in edx
    call WriteString
	fld Standard_Deviation ; loads standard deviation to FPU
	call WriteFloat 
	mov edx, OFFSET period ; copies address of the end of output in edx
    call WriteString
	call Crlf
	
	ret
Output ENDP
END