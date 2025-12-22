.686
.model flat
.XMM

public _sigmoid_inplace, _szybkie_razy_potega2

.data
	n dd ?
.code
_e_do_x PROC
	fchs
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

_sigmoid_inplace PROC
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]

	xor ebx, ebx

petla:
	cmp ebx, edi
	jge koniec
	fld qword ptr [esi + 8*ebx]
	call _e_do_x
	fld1
	faddp st(1), st(0)
	fld1
	fxch 
	fdivp st(1), st(0)

	fstp qword ptr [esi + 8*ebx]
	inc ebx
	jmp petla


koniec:


	pop ebx
	pop esi
	pop edi

	pop ebp

	ret

_sigmoid_inplace ENDP

_szybkie_razy_potega2 PROC
	push ebp
	mov ebp, esp
	push edi
	push esi
	push ebx

	mov esi, [ebp + 8]
	mov ebx, [ebp + 12]
	mov edi, [ebp + 16]
	mov ecx, [ebp + 20]

	movd xmm6, ebx

	mov eax, ecx

	shr ecx, 3

petla:
	movups xmm5, [esi]

	psllw xmm5, xmm6

	movups [edi], xmm5

	add esi, eax
	add edi, eax

	loop petla

	pop ebx
	pop esi
	pop edi
	pop ebp
	ret
_szybkie_razy_potega2 ENDP


END
