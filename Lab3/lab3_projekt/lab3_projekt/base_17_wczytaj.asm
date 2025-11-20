.686
.model flat

extern _ExitProcess@4:PROC, __read:PROC


public _main

.data
	siedemnascie db 17

.code
_wczytaj_EAX_b17 PROC
	push edi
	push esi
	push ecx

	sub esp, 12
	mov edi, esp

	push 10
	push edi
	push 0
	call __read
	add esp, 12

	mov esi, 0
	mov eax, 0

konwersja:
	mov cl, [edi][esi]
	inc esi
	cmp cl, 0ah
	je byl_enter

	cmp cl, '0'
	jb konwersja
	cmp cl, '9'
	ja literka
	sub cl, 30h
	jmp zapis

literka:
	cmp cl, 'a'
	jb konwersja
	cmp cl, 'g'
	ja konwersja
	sub cl, 'a' - 10

zapis:
	mul dword ptr siedemnascie
	movzx ecx, cl
	add eax, ecx
	jmp konwersja

byl_enter:

	add esp, 12
	pop ecx
	pop esi
	pop edi

	ret
_wczytaj_EAX_b17 ENDP

_main PROC
	call _wczytaj_EAX_b17

	push 0
	call _ExitProcess@4

_main ENDP

END
