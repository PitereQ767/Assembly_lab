.686
.XMM
.model flat

public _dodaj_SSE, _pierwiastek_SSE, _odwrotnosc_SSE, _dodawanie_16

.code
	_dodaj_SSE PROC
		push ebp
		mov ebp, esp
		push ebx
		push esi
		push edi

		mov esi, [ebp + 8]
		mov edi, [ebp + 12]
		mov ebx, [ebp + 16]

		movups xmm5, [esi]
		movups xmm6, [edi]

		addps xmm5, xmm6

		movups [ebx], xmm5

		pop edi
		pop esi
		pop ebx

		pop ebp

		ret
	_dodaj_SSE ENDP

	_pierwiastek_SSE PROC
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov edi, [ebp + 8]
		mov ebx, [ebp + 12]

		movups xmm6, [edi]

		sqrtps xmm5, xmm6

		movups [ebx], xmm5



		pop ebx
		pop esi
		pop edi
		pop ebp
		ret
	_pierwiastek_SSE ENDP

	_odwrotnosc_SSE PROC
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov esi, [ebp + 8]
		mov ebx, [ebp + 12]

		movups xmm6, [esi]
		rcpps xmm5, xmm6

		movups [ebx], xmm5


		pop ebx
		pop esi
		pop edi
		pop ebp
				


		ret
	_odwrotnosc_SSE ENDP

	_dodawanie_16 PROC
		push ebp
		mov ebp, esp
		push edi
		push esi
		push ebx

		mov esi, [ebp + 8]
		mov edi, [ebp + 12]
		mov ebx, [ebp + 16]

		movups xmm6, [esi]
		movups xmm5, [edi]
		paddsb xmm5, xmm6

		movups [ebx], xmm5


		pop ebx
		pop esi
		pop edi
		pop ebp

		ret
	_dodawanie_16 ENDP

END