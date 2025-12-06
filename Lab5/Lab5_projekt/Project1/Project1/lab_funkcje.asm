.686
.model flat

public _softmax

.data
	suma dd 0.0

.code
_softmax PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]
	mov ebx, [ebp + 12]
	mov edi, [ebp + 16]
	dec edi
	mov eax, edi ; przechowujemy n - 1

	finit
petla:
	fld dword ptr [esi + 4*edi]
	fldl2e ;stos st(0) = log2e, st(1) = x
	fmulp st(1), st(0) ;stos st(0) = x * log2e
	fst st(1)
	frndint ;zaokraglenie wartosci do liczby calkowitej

	fsub st(1), st(0) ; stos: st(0) = (x * log2e)zaokraglone calkowite, st(1) = czesc ulamkowa (x * log2e)

	fxch ; stos: st(0) = czesc ulamkowa (x * log2e) , st(1) = (x * log2e)zaokraglone calkowite

	f2xm1 ;stos: st(0) = 2^ czesc ulamkowa (x * log2e) , st(1) = (x * log2e)zaokraglone calkowite
	fld1
	faddp st(1), st(0)

	fscale

	fld suma
	faddp st(1), st(0)
	fst suma

	fstp st(0)
	fstp st(0)

	dec edi
	cmp edi, 0
	jge petla

	mov edi, eax
petla_2:
	fld dword ptr [esi + 4*edi]
	fldl2e ;stos st(0) = log2e, st(1) = x
	fmulp st(1), st(0) ;stos st(0) = x * log2e
	fst st(1)
	frndint ;zaokraglenie wartosci do liczby calkowitej

	fsub st(1), st(0) ; stos: st(0) = (x * log2e)zaokraglone calkowite, st(1) = czesc ulamkowa (x * log2e)

	fxch ; stos: st(0) = czesc ulamkowa (x * log2e) , st(1) = (x * log2e)zaokraglone calkowite

	f2xm1 ;stos: st(0) = 2^ czesc ulamkowa (x * log2e) , st(1) = (x * log2e)zaokraglone calkowite
	fld1
	faddp st(1), st(0)

	fscale
	fstp st(1)

	fld suma
	fdivp st(1), st(0)

	fst dword ptr [ebx + 4*edi]
	dec edi
	cmp edi, 0
	jge petla_2



	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_softmax ENDP

END