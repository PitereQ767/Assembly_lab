.686
.model flat

extern _ExitProcess@4:PROC, _MessageBoxW@16:PROC

public _main

.data
	siedemnascie dd 17
	dekoder db '0123456789ABCDEFG'
	tytul dw 'w', 'y', 'n', 'i', 'k', 0

.code
_wyswietl_EAX_b17 PROC
	pusha
	sub esp, 24
	mov edi, esp

	mov esi, 20

	test eax, 80000000h     
	jz dodatnia
	
	mov word ptr [edi][0], '-'
	neg eax
	jmp petla

dodatnia:
	mov word ptr [edi][0], 0ah

petla:
	mov edx, 0
	div dword ptr siedemnascie
	movzx bx, dekoder[edx]
	mov [edi][esi], bx
	sub esi, 2

	cmp eax, 0
	jne petla

spacje:
	or esi, esi
	jz koniec
	mov word ptr [edi][esi], 20h
	sub esi, 2
	jmp spacje

koniec:
	mov word ptr [edi][22], 0

	push 4
	push offset tytul
	push edi
	push 0
	call _MessageBoxW@16

	add esp, 28

	popa
	ret
_wyswietl_EAX_b17 ENDP

_main PROC
	mov eax, 288
	;call _wyswietl_EAX_b17

	mov eax, -1234567890
	call _wyswietl_EAX_b17

_main ENDP

END

