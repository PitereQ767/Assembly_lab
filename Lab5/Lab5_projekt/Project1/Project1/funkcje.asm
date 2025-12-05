.686
.model flat

public _srednia_harm
public _e_do_x
public _nowy_exp

.data
	n dd ?
	jeden dd +1.0
	wynik dd 0.0

	x dd ?

	wynik_2 dd 0.0

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

_e_do_x PROC
	push ebp
	mov ebp, esp

	push ebx


	fld dword ptr [ebp + 8]
	fldl2e
	fmulp st(1), st(0) ; x * log2e

	fst st(1)

	frndint

	fsub st(1), st(0)

	;sytuacja na stosie: st(0) = czesc calkowita, st(1) = czesc ulamkowa

	fxch
	;po zmianie: st(0) = czesc ulamkowa, st(1) = czesc calkowita

	f2xm1
	fld1
	faddp st(1), st(0)

	;sytuacja na stosie: st(0) = 2^xlog2e ulamkowe, st(1) = x * log2e calkowite

	fscale 

	fstp st(1)

	;wynik w st(0)


	pop ebx
	pop ebp

	ret
_e_do_x ENDP

_nowy_exp PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi

	mov esi, 20
	fld dword ptr [ebp + 8]
	fld1
	;stos st(0) = 1, st(1) = x
	fld1
	;stos st(0)= 1 (wyraz), st(1) = suma, st(2) = x

	mov ecx, 1

petla:
	cmp ecx, 20
	jge koniec

	fld st(2) ; stos st(0)=x, st(1)=wyraz, st(2)=suma
	fmulp st(1), st(0) ; stos st(0) = wyraz * x, st(1) = suma
	
	push ecx
	fild dword ptr [esp]
	fdivp st(1), st(0)
	pop ecx ;stos st(0)= (wyraz*x)/n, st(1) = suma, st(2)=x

	fadd st(1), st(0)

	inc ecx
	jmp petla



koniec:
	fstp st(0)


	pop edi
	pop esi
	pop ebx
	pop ebp

	ret
_nowy_exp ENDP

END