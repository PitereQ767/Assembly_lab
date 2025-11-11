.686
.model flat 

public _main

extern _ExitProcess@4:PROC, __write:PROC

.data
	znaki db 12 dup (?)

.code
_wyswietl_EAX_b13 PROC
	pusha
	sub esp, 12
	mov edi, esp

	mov esi, 10
	mov ebx, 13

konwersja:
	mov edx, 0
	div ebx

	cmp dl, 9
	jbe cyfra

	add dl, 41h - 10
	jmp zapis

cyfra:
	add dl, 30h

zapis:
	mov [edi][esi], dl
	dec esi
	cmp eax, 0
	jne konwersja

dopelnienie:
	or esi, esi
	jz koniec
	mov byte ptr [edi][esi], 20h
	dec esi
	jmp dopelnienie

koniec:
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