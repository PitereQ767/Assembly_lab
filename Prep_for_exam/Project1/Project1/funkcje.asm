.686
.model flat

public _roznica, _kopia_tablicy, _komunikat, _szukaj_elem_min, _szyfruj, _kwadrat, _iteracja, _zadanie8

extern _malloc:PROC

.data
	cztery dd 4

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
	push esi
	push edi

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]
	
	mov edi, ecx
	imul edi, 4

	push edi
	push ecx
	call _malloc
	pop ecx
	add esp, 4

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
	
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_kopia_tablicy ENDP

_komunikat PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi

	mov ebx, [ebp + 8]

	xor ecx, ecx

licznik:
	mov eax, [ebx + ecx]
	cmp eax, 0
	je koniec_liczenia
	inc ecx
	jmp licznik


koniec_liczenia:
	inc ecx
	push ecx
	call _malloc
	pop ecx

	xor edi, edi
petla:
	cmp edi, ecx
	je koniec
	movzx edx, byte ptr [ebx + edi]
	mov [eax + edi], dl
	inc edi
	jmp petla

koniec:
	dec ecx
	mov byte ptr [eax + ecx], 'B'
	inc ecx
	mov word ptr [eax + ecx], '³'
	inc ecx
	mov word ptr [eax + ecx], '¹'
	inc ecx
	mov byte ptr [eax + ecx], 'd'
	inc ecx
	mov byte ptr [eax + ecx], 0
	inc ecx
	
	pop edi
	pop ebx
	pop ebp
	ret
_komunikat ENDP

_szukaj_elem_min PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]

	xor edi, edi

	mov eax, ebx ;uznajemy ze pierwszy jest najmniejszy
	inc edi

petla:
	cmp edi, ecx
	jge koniec
	mov edx, [ebx + 4*edi]
	cmp [eax], edx
	jbe mniejsza

	lea eax, [ebx + 4*edi]

mniejsza:
	inc edi
	jmp petla


koniec:
	
	pop edi
	pop ebx
	pop ebp
	ret
_szukaj_elem_min ENDP

_szyfruj PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi


	mov ebx, [ebp + 8]
	mov edx, 52525252h

petla:
	cmp byte ptr [ebx], 0
	je koniec
	xor [ebx], dl

	bt edx, 30
	setc al
	bt edx, 31
	setc cl

	xor al, cl

	cmp al, 0
	je zgadza_sie
	stc
	jmp koniec_por
zgadza_sie:
	clc
koniec_por:
	rcl edx, 1
	inc ebx
	jmp petla


koniec:

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_szyfruj ENDP

_kwadrat PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ecx, [ebp + 8]

	cmp ecx, 1
	je koniec

	cmp ecx, 0
	je koniec

	push ecx
	sub ecx, 2
	push ecx
	call _kwadrat
	add esp, 4
	pop eax
	mul cztery
	sub eax, 4
	add ecx, eax

	


koniec:
	mov eax, ecx

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_kwadrat ENDP

_iteracja PROC 
	push ebp 
	mov ebp, esp 
	mov al, [ebp+8] 
	sal al, 1 
	jc zakoncz 
	inc al 
	push eax
	call _iteracja 
	add esp, 4 
	pop ebp 
	ret 
	zakoncz: 
	rcr al, 1 
	pop ebp 
	ret 
_iteracja ENDP 

_zadanie8 PROC
	push ebp
	mov esp, ebp
	push esi
	push edi
	push ebx

	mov ebx, 00000080h

	shr ebx, 7

	cmp ebx, 0
	je zero
	stc
	jmp koniec

zero:
	clc

koniec:

	pop ebx
	pop edi
	pop esi
	pop ebx
	ret
_zadanie8 ENDP


END