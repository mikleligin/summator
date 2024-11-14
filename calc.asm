section .data
	hello db 'Добро пожаловать в сумматор. Введите 2 числа', 0xa
	len equ $ - hello
	resMsg db 'Результат', 0xa
	lenResMsg equ $ - resMsg
section .bss
	num1 resb 8
	num2 resb 8
	result resb 10
section .text
	global _start

_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, hello
	mov edx, len
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, num1
	mov edx, 8
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, num2
	mov edx, 8
	int 80h


	mov esi, num1
	xor eax, eax

convert_num1:

	movzx ebx, byte [esi]
	cmp ebx, 0
	je done_convert_num1
	sub ebx, '0'
	imul eax, eax, 10
	add eax, ebx
	inc esi
	jmp convert_num1

done_convert_num1:
	mov esi, num2
	xor ebx, ebx

convert_num2:

	movzx edx, byte [esi]
	cmp edx, 0
	je done_convert_num2
	sub edx, '0'
	imul ebx, ebx, 10
	add ebx, edx
	inc esi
	jmp convert_num2

done_convert_num2:

	add eax, ebx


	mov ecx, result
	mov edi, 10
	xor edx, edx 
	mov ebx, eax
	add ebx, '0'
	mov esi, result + 9
	mov byte [esi], 0

convert_result:

	xor edx, edx
	div edi
	add dl, '0'
	dec esi
	mov [esi], dl
	test eax, eax
	jnz convert_result

	
	mov eax, 4
	mov ebx, 1
	mov ecx, resMsg
	mov edx, lenResMsg
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov edx, 10
	mov ecx, result
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h 
