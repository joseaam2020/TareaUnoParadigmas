section .text
	global operaciones
	
operaciones:
	movzx ebx, al
	sub ebx, 30h	;convierte de ascii a hex

	cmp ebx, 1
	je suma
	
	cmp ebx, 2
	je resta

	cmp ebx, 3
	je multiplicacion
	
	cmp ebx, 4
	je division
suma:
	pop eax
	pop ecx
	pop edx
	sub ecx, edx
	xor edx, edx
	pop ebx
	pop edx
	pop esi
	sub edx, esi

	add eax, ebx
	xor esi, esi

	
	jmp devolver

resta:	
	pop ebx
	pop edx 
	pop eax
	pop ecx
	sub eax, ebx 
	jmp devolver

multiplicacion:
	pop ebx
	pop edx 
	pop eax
	pop ecx
	imul ebx
	jmp devolver

division:
	mov dx, 0
	pop ebx 
	pop ecx
	pop eax
	
	idiv bx

	
	
devolver:
	ret
