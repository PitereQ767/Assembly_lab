.686
.model flat
.xmm

public _softmax, _szybki_max

.data
	suma dd 0.0
	trzy dd 3
	dana dq 0

.code

_e_do_x PROC

	fldl2e
	fmulp st(1), st(0) ;st(0) = x * log2x
	fst st(1)

	frndint 

	fsub st(1), st(0); ;st(0) = czesc calkowita, st(1) = czesc ulamkowa

	fxch ;st(0) = czesc ulamkowa, st(1) = czesc calkowita

	f2xm1
	fld1
	faddp st(1), st(0)

	fscale
	
	fstp st(1)


	ret
_e_do_x ENDP
_softmax PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov esi, [ebp + 8]
	mov ebx, [ebp + 12]
	mov edi, [ebp + 16]
	
	xor ecx, ecx

petla:
	cmp ecx, edi
	jge koniec_sumy

	fld dword ptr [esi + 4*ecx]
	call _e_do_x
	fld suma
	faddp st(1), st(0)

	fst suma

	inc ecx
	jmp petla


koniec_sumy:
	xor ecx, ecx

petla_2:
	cmp ecx, edi
	jge koniec

	fld dword ptr [esi + 4*ecx]
	call _e_do_x
	fld suma
	fdivp st(1), st(0)
	fstp dword ptr [ebx + 4*ecx]

	inc ecx
	jmp petla_2


koniec:
	
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_softmax ENDP

_szybki_max PROC
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	mov ebx, [ebp + 16]
	mov ecx, [ebp + 20]

	movups xmm5, [esi]
	movups xmm6, [edi]

	pmaxsw xmm5, xmm6

	movups [ebx], xmm5

	movups xmm5, [esi + ecx]
	movups xmm6, [edi + ecx]

	pmaxsw xmm5, xmm6

	movups [ebx + ecx], xmm5



	pop ebx
	pop edi
	pop esi

	pop ebp
	ret
_szybki_max ENDP

_objetosc_stozka PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	lea esi, [ebp + 8] ;big_r
	lea edi, [ebp + 12] ;small_r
	lea ebx, [ebp + 16] ;h
	
	finit
	fild dword ptr [esi]
	fst st(1)
	fmul st(1), st(0)
	fild dword ptr [edi]
	fmul st(1), st(0) ;stos st(0)=small_r, st(1)=big_r * small_r, st(2) = big_r^2
	fld st(0)
	fmulp st(1), st(0) ;stos st(0)=small_r^2, st(1)=big_r * small_r, st(2) = big_r^2

	faddp st(1), st(0)
	faddp st(1), st(0) ;stos st(0) = samll_r^2 + samll_r*big_r + big_r^2

	fld dword ptr [ebx]
	fmulp st(1), st(0)

	fldpi
	fmulp st(1), st(0)

	fild trzy
	fdivp st(1), st(0)

	pop ebx
	pop edi
	pop esi

	pop ebp
	ret
_objetosc_stozka ENDP


END