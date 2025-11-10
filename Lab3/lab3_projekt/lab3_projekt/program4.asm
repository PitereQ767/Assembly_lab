.686
.model flat

public _main

extern _ExitProcess@4:PROC, __write:PROC, __read:PROC

.data
	dekoder db '0123456789ABCDEF'
	obszar db 12 dup (?)
	dziesiec db 10

.code
_wczytaj_do_EAX_hex PROC
	push ebx
	push ecx
	push esi
	sub esp, 12
	mov edi, esp

	push 10
	push edi
	push 0
	call __read
	add esp, 12

	mov eax, 0
	mov esi, 0

konwersja:
	mov cl, [edi]
	inc edi
	cmp cl, 0ah
	je byl_enter
	
	cmp cl, '0'
	jb konwersja
	cmp cl, '9'
	ja literka
	sub cl, 30h
zapis:
	shl eax, 4
	or al, cl
	jmp konwersja
literka:
	cmp cl, 'A'
	jb konwersja
	cmp cl, 'F'
	ja literka_2
	sub cl, 'A' - 10
	jmp zapis
literka_2:
	cmp cl, 'a'
	jb konwersja
	cmp cl, 'f'
	ja konwersja
	sub cl, 'a' - 10
	jmp zapis


byl_enter:
	
	add esp ,12
	pop esi
	pop ecx
	pop ebx

	ret
_wczytaj_do_EAX_hex ENDP



_main PROC
	call _wczytaj_do_EAX_hex

	
	push 0
	call _ExitProcess@4

_main ENDP

END