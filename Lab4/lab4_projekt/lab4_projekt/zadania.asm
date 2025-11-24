.686
.model flat

public _dot_product
public _small_power

.data
	n dd ?


.code
_dot_product PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	mov ecx, [ebp + 16]
	;dec ecx
	mov n, ecx
	mov ecx, 0
	
	mov ebx, 0 ;wynik

petla:
	mov eax, [esi][4*ecx]
	imul dword ptr [edi][4*ecx]
	add ebx, eax
	add ecx, 1
	cmp ecx, n
	jne petla

	mov eax, ebx

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_dot_product ENDP

_small_power PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp + 8] ;m
	mov edi, [ebp + 12]; n

	cmp esi, 8
	jae koniec_funkcji

	cmp edi, 12
	jae koniec_funkcji

	cmp edi, 0
	je koniec_rekurencji


	dec edi
	push edi
	push esi
	call _small_power
	add esp, 8

	mul esi

	jmp wyjscie
koniec_rekurencji:
	mov eax, 1
	jmp wyjscie

koniec_funkcji:
	mov eax, -1

wyjscie:

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_small_power ENDP

END