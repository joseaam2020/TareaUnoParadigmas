section .data
	menu db "Escoja una operacion:",0xa
	sumar db "1. Sumar",0xa
	restar db "2. Restar",0xa
	multiplicar db "3. Multiplicar",0xa
	dividir db "4. Dividir",0xa


section .text
	global imprime_menu

imprime_menu:
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, menu
	mov edx, 22
	int 0x80

	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, sumar
	mov edx, 9
	int 0x80
		
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, restar
	mov edx, 10
	int 0x80
	
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, multiplicar
	mov edx, 15
	int 0x80
	
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, dividir
	mov edx, 11
	int 0x80
	
	ret
