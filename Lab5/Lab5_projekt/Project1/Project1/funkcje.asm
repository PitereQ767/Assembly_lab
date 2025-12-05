.686
.model flat

public _srednia_harm

.data
	n dd ?
	jeden dd +1.0
	wynik dd 0.0

.code
_srednia_harm PROC
	push ebp
	mov ebp,esp

	push esi
	push edi
	push ebx

	mov edi, [ebp + 12]
	mov n, edi
	mov ebx, [ebp + 8]
	mov esi, n
	dec esi

	finit

petla:
	fld dword ptr [ebx + esi*4]
	fld jeden
	fdiv st(0), st(1)
	fxch st(1)
	fstp st(0)
	fld wynik
	;stos st(0) = wynik, st(1) = ulamek
	faddp st(1), st(0)
	fstp wynik
	
	
	dec esi

	cmp esi, 0
	jge petla

koniec:
	fild n
	fld wynik
	fdivp st(1), st(0)


	pop ebx
	pop edi
	pop esi
	pop ebp

	ret

_srednia_harm ENDP

END