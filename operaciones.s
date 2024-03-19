section .text
	global operaciones
	
operaciones:
	mov eax, edx

	cmp ebx, 1
	je suma
	
	cmp ebx, 2
	je resta

	cmp ebx, 3
	je multiplicacion
	
	cmp ebx, 4
	je division
suma:
	add eax, ecx
	jmp devolver

resta:	
	sub eax, ecx 
	jmp devolver

multiplicacion:
	imul ecx
	mov edx, 0
	mov ebx, 100
	idiv ebx
	jmp devolver

division:
	mov edx, 0
	idiv ecx
	
devolver:
	ret
