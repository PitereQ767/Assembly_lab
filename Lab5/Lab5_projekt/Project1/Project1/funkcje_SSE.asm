.686
.XMM
.model flat

public _dodaj_SSE, _pierwiastek_SSE, _odwrotnosc_SSE, _dodawanie_16, _int2float, _pm_jeden, _dodawanie_SSE

.data 
	tablica dd 4 dup (1.0)

	ALIGN 16
	tabl_A dd 1.0, 2.0, 3.0, 4.0
	tabl_B dd 2.0, 3.0, 4.0, 5.0
	liczba db 1
	ALIGN 16
	tabl_C dd 3.0, 4.0, 5.0, 6.0

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

	_int2float PROC
		push ebp
		mov ebp, esp
		push ebx
		push edi
		push esi

		mov esi, [ebp + 8]
		mov edi, [ebp + 12]

		cvtpi2ps xmm5, qword PTR [esi]

		movups [edi], xmm5


		pop esi
		pop edi
		pop ebx
		pop ebp

		ret
	_int2float ENDP

	_pm_jeden PROC
		push ebp
		mov ebp, esp
		push ebx
		push edi
		push esi

		mov esi, [ebp + 8]
		
		movups xmm5, [esi]
		movups xmm6, tablica

		addsubps xmm5, xmm6

		movups [esi], xmm5


		pop esi
		pop edi
		pop ebx
		pop ebp

		ret
	_pm_jeden ENDP

	_dodawanie_SSE PROC
		push ebp
		mov ebp, esp

		mov eax, [ebp + 8]

		movaps xmm2, tabl_A
		movaps xmm3, tabl_B
		movaps xmm4, tabl_C ;movaps wymaga wyrownananie adresow w pamieci, aby adres%16==0

		addps xmm2, xmm3
		addps xmm2, xmm4

		movups [eax], xmm2



		pop ebp

		ret
	_dodawanie_SSE ENDP

END