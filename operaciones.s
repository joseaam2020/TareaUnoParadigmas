section .text
	global operaciones
	
operaciones:
	movzx ebx, al
	sub ebx, 30h	;convierte de ascii a hex
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
	jmp devolver

division:
	mov dx, 0
	idiv cx
	
devolver:
	ret
