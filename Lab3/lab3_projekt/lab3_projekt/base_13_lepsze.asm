.686
.model flat

public _main

extern _ExitProcess@4:PROC, __write:PROC, __read:PROC

.data
	dekoder db '0123456789ABC'
	obszar db 12 dup (?)
	dziesiec db 10
	trzynascie dd 13

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

_wyswietl_EAX_b13 PROC
	pusha
	sub esp, 12
	mov edi, esp

	mov esi, 10

petla:
	mov edx, 0
	div dword ptr trzynascie
	movzx ebx, dekoder[edx]
	mov [edi][esi], bl
	dec esi

	cmp eax, 0
	jne petla

spacje:
	or esi, esi
	jz koniec
	mov byte ptr [edi][esi], 20h
	dec esi
	jmp spacje
	
koniec:
	;dodanie znaku poczatka lini na poczatku i koncu cyfry
	mov byte ptr [edi][0], 0ah
	mov byte ptr [edi][11], 0ah

	push 12
	push edi
	push 1
	call __write

	add esp, 24

	popa
	ret
_wyswietl_EAX_b13 ENDP


_main PROC
	mov eax, 144
	call _wyswietl_EAX_b13

	mov eax, 130
	call _wyswietl_EAX_b13

	mov eax, 1234567890
	call _wyswietl_EAX_b13

	
	push 0
	call _ExitProcess@4

_main ENDP

END