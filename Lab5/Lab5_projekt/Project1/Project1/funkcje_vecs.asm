.686
.model flat 

public _normalizuj_wektory


.data


.code
_normalizuj_wektory PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]	; dane
	mov ecx, [ebp + 12] ;ilosc
	mov ebx, [ebp + 16] ;threshold
	dec ecx

petla:
	fld dword ptr [esi  * ecx]

	pop ebx
	pop edi
	pop esi


	pop ebp
	
	ret
_normalizuj_wektory ENDP


END