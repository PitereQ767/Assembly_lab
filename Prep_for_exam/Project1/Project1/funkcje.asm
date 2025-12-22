.686
.model flat

public _roznica, _kopia_tablicy

extern _malloc:PROC

.data

.code
_roznica PROC
	push ebp
	mov ebp, esp
	push ebx

	mov eax, [ebp + 8]
	mov ebx, [eax] ; ebx = a

	mov eax, [ebp + 12]
	mov edx, [eax]
	mov eax, [edx]

	sub ebx, eax

	mov eax, ebx

	pop ebx
	pop ebp
	ret
_roznica ENDP

_kopia_tablicy PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]

	push ecx
	call _malloc
	pop ecx

	mov edi, 0
petla:
	cmp edi, ecx
	je koniec
	lea edx, [ebx + 4*edi]
	mov esi, [edx]
	test esi, 1
	jnz zero
	mov [eax + 4*edi], esi
	jmp koniec_petli

zero:
	mov dword ptr [eax + 4*edi], 0

koniec_petli:
	inc edi
	jmp petla

koniec:
	

	pop ebx
	pop ebp
	ret
_kopia_tablicy ENDP


END