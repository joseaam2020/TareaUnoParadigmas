section .bss
	op1 resb 32	;guarda el primer operando
	op2 resb 32	;guarda el segundo operando
	opp resb 32	;guarda la seleccion de operacion
	res resb 32	;guarda el resultado			

section .data
	ind db "Ingrese su primer operando...",0xa
	ind2 db "Ingrese su segundo  operando...",0xa
	
section .text
	extern imprime_menu
	extern operaciones
	global _start

_start:
	mov ebp, esp
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, ind
	mov edx, 30
	int 0x80

	mov eax, 3	
	mov ebx, 0
	mov ecx, op1
	mov edx, 32	
	int 0x80	;lee el input y lo guarda en op1

	mov esi, op1	;mueve la direccion de op1 a esi
	xor eax, eax	;limpia el registro
	xor edx, edx
	xor ecx, ecx

conversion:	
	movzx eax, byte[esi]	;mueve el nuevo  byte a eax
	cmp eax, 0x0a		;verifica que termino el string
	je check_status		
	
	cmp eax, 0x2e
	je guarda_decimal
	
	sub eax, 48		;convierte de ascii a entero
	imul ebx, 10		;multiplica por 10 el acumulado (en ebx)
	add ebx, eax 		;agrega el nuevo digito

	inc esi
	add edx, 1
	add ecx, 1
	jmp conversion		;loop
	

guarda_decimal:
	push edx	;cantidad de numeros a la izquierda del punto
	mov edx, 0
	inc esi
	jmp conversion

check_status:
	cmp edx, ecx
	je sin_decimal	

	cmp edi, op2
	jne operador

	cmp edi, op2
	je operacion
	
sin_decimal:
	push edx
	mov edx, 0
	jmp check_status

operador:
	push ecx
	push ebx	;palabra convertida
	call imprime_menu
	
	mov eax, 3
	mov ebx, 0
	mov ecx, opp
	mov edx, 32
	int 0x80	;lee el input y lo guarda en opp
	
indicacion2:
	mov eax, 4	;syscall para imprimir las indicaciones
	mov ebx, 1
	mov ecx, ind2
	mov edx, 32
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, op2
	mov edx, 32
	int 0x80	;lee el input y lo guarda en op2
	
	mov esi, op2
	mov edi, op2
	xor eax, eax
	xor ecx, ecx
	xor edx, edx
	jmp conversion	;conversion del segundo operando

operacion:
	push ecx
	push ebx
	mov eax, [opp]	
	call operaciones
	jmp conversion_inversa 
	
conversion_inversa:	;convierte el valor de hex a ascii
	cmp eax, 2560 
	jae mayor

	mov ecx, 10
	div cl 
	movzx edx, ah	;se obtiene el primer digito de la conversion
	movzx ebx, al	;cociente de la division, se utiliza para conseguir los siguientes digitos
	
	add edx, 30h	;se le suma 30h o "0" para convertir a ascii
	push edx	;se guarda digito en stack
	
	mov eax, ebx	;compara para ver si se obtuvieron todos los digitos
	cmp eax, 0
	je term
	
	jmp conversion_inversa
mayor: 
	mov edx, 0
	mov ecx, 10
	div ecx
	
	add edx, 30h 
	push edx

	cmp eax, 0
	je term
	jmp mayor
		
term:
	pop edx		;se obtiene digito de stack
	
	mov [res], edx	;se pone digito en resultado para imprimirlo
	mov ecx, res
	mov edx, 2
       	mov ebx, 1
	mov eax,4
	int 0x80
	
 	cmp esp, ebp	 ;se compara para saber si stack esta vacia
	je exit

	jmp term
exit:
 
	mov eax, 1 	;exit del programa
	mov ebx, 0 
	int 0x80

