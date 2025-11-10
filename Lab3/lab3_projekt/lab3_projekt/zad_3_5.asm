.686
.model flat

public _main

extern _ExitProcess@4:PROC, __write:PROC, __read:PROC

.data
	dekoder db '0123456789ABCDEF'
	obszar db 12 dup (?)
	dziesiec db 10

.code
_wczytaj_do_EAX PROC
	push ebx
	push ecx
	push esi

	push 10
	push offset obszar
	push 0
	call __read
	add esp, 12

	mov eax, 0
	mov ebx, offset obszar
	mov esi, 0

konwersja:
	mov cl, [ebx][esi]
	cmp cl, 0ah
	je byl_enter
	sub cl, 30h
	movzx ecx, cl

	mul dword ptr dziesiec
	add eax, ecx
	add esi, 1
	jmp konwersja


byl_enter:
	

	pop esi
	pop ecx
	pop ebx

	ret
_wczytaj_do_EAX ENDP

_wyswietl_EAX_hex PROC
	pusha
	sub esp, 12
	mov edi, esp

	mov ecx, 8
	mov esi, 1

petla:
	rol eax, 4
	mov ebx, eax
	and ebx, 0000000fh
	mov dl, dekoder[ebx]

	cmp dl, 30h
	je zero

	;zapis liczby do wyniku
	mov [edi][esi], dl
	add esi, 1
	jmp koniec_petli
zero:
	mov byte ptr [edi][esi], 20h
	add esi, 1

koniec_petli:
	loop petla

	;dodanie znaku poczatka lini na poczatku i koncu cyfry
	mov byte ptr [edi][0], 0ah
	mov byte ptr [edi][9], 0ah

	push 10
	push edi
	push 1
	call __write

	add esp, 24

	popa
	ret
_wyswietl_EAX_hex ENDP


_main PROC
	call _wczytaj_do_EAX
	call _wyswietl_EAX_hex

	
	push 0
	call _ExitProcess@4

_main ENDP

END