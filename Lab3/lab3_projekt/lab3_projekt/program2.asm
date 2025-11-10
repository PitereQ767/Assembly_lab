.686
.model flat

extern __write:PROC, _ExitProcess@4:PROC, __read:PROC

public _main


.data
	znaki db 12 dup (?)
	obszar db 12 dup (?)
	dziesiec db 10

.code
_wyswietl_EAX PROC
	pusha
	mov ebx, 10
	mov esi, 10

konwersja:
	mov edx, 0
	div ebx

	add dl, 30h
	mov znaki[esi], dl
	dec esi
	cmp eax, 0
	jne konwersja

wypeln:
	or esi, esi
	jz wyswietl
	mov byte PTR znaki[esi], 20h
	dec esi
	jmp wypeln

wyswietl:
	mov byte PTR znaki[0], 0ah
	mov byte PTR znaki[11], 0ah

	push 12
	push offset znaki
	push 1
	call __write
	add esp, 12

	popa

	ret
_wyswietl_EAX ENDP

_wczytaj PROC

	push dword PTR 12
	push offset obszar
	push dword PTR 0
	call __read
	add esp, 12

	ret
_wczytaj ENDP


_main PROC
	call _wczytaj

	mov eax, 0
	mov ebx, offset obszar
	mov esi, 0

petla:
	mov cl, obszar[esi]
	add esi, 1
	cmp cl, 0ah
	je enterbyl
	sub cl, 30h
	movzx ecx, cl

	mul dword PTR [dziesiec]
	add eax, ecx
	jmp petla

enterbyl:
	call _wyswietl_EAX


	

	push 0
	call _ExitProcess@4

_main ENDP

END