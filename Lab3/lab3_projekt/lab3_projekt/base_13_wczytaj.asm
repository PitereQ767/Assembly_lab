.686
.model flat

extern _ExitProcess@4:PROC, __read:PROC

public _main

.data
	dekoder db '0123456789ABC'
	trzynascie dd 13

.code
_wczytaj_EAX_b13 PROC
	push ebx
	push ecx
	push edi
	push esi

	sub esp, 12
	mov edi, esp

	push 10
	push edi
	push 0
	call __read
	add esp, 12

	mov esi, 0
	mov eax, 0

petla:
	mov cl, [edi][esi]
	inc esi
	cmp cl, 0ah
	je byl_enter
	
	cmp cl, '0'
	jb petla
	cmp cl, '9'
	ja literka
	sub cl, 30h
	jmp zapis

literka:
	cmp cl, 'A'
	jb petla
	cmp cl, 'C'
	ja literka_2
	sub cl, 'A' - 10
	jmp zapis

literka_2:
	cmp cl, 'a'
	jb petla
	cmp cl, 'c'
	ja petla
	sub cl, 'a' - 10
	jmp zapis
	

zapis:
	mul dword ptr trzynascie
	movzx ecx, cl
	add eax, ecx
	jmp petla
	

byl_enter:
	

	add esp, 12
	pop esi
	pop edi
	pop ecx
	pop ebx

	ret

_wczytaj_EAX_b13 ENDP

_main PROC
	
	call _wczytaj_EAX_b13

	push 0
	call _ExitProcess@4

_main ENDP


END

