.686
.model flat

public _roznica, _kopia_tablicy, _komunikat, _szukaj_elem_min, _szyfruj, _kwadrat, _iteracja, _zadanie8, _zadanie9, _zadanie10, _konwerter, _pole_kola, _avg_wd, _liczba_procesorow, _sortowanie, _ASCII_na_UTF16, _NWD, _miesz2float, _float_razy_float

extern _malloc:PROC, _GetSystemInfo@4:PROC


.data
	cztery dd 4
	naj_0 dd 0
	naj_1 dd 0
	e1 db 0
	e2 db 0
	m1 dd 0
	m2 dd 0

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
	mov ebp, esp
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
	pop ebp
	ret
_zadanie8 ENDP

_zadanie9 PROC
	push ebp
	mov ebp, esp
	push ebx
	
	mov edx, 0001004Ah

	bt edx, 6
	jnc w_dol

	add edx, 80h

w_dol:
	and edx, 0ffffff80h
	

	pop ebx
	pop ebp
	ret
_zadanie9 ENDP

_zadanie10 PROC
	push ebp
	mov ebp, esp
	push esi
	push edi

	mov esi, 00000101H
	mov edi, 00000080H

	bt edi, 31
	jc edi_wieksze

	mov eax, edi

	shl eax, 1

	cmp eax, esi

	jc koniec

edi_wieksze:
	clc
	
koniec:
	
	pop edi
	pop esi
	pop ebp
	ret
_zadanie10 ENDP

_konwerter PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	xor edx, edx
	xor eax, eax

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]

	mov ebx, [esi]
	test ebx, 80000000h
	jz dodatnia

	mov edx, 80000000h

dodatnia:
	shl ebx, 1
	shr ebx, 24
	sub bx, 127
	add bx, 1023
	shl ebx, 20
	or edx, ebx

	mov ebx, [esi]
	and ebx, 007fffffh

	shr ebx,3
	or edx, ebx

	mov ebx, [esi]
	and ebx, 00000007h

	or eax, ebx
	shl eax, 29


	mov [edi], eax
	mov [edi + 4], edx

	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_konwerter ENDP

_pole_kola PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]

	finit
	fld dword ptr [ebx]
	fld st(0)

	fmulp st(1), st(0) ;r^2
	fldpi
	fmulp st(1), st(0)

	pop ebx
	pop ebp
	ret
_pole_kola ENDP

_avg_wd PROC
	push ebp
	mov ebp, esp
	push esi
	push edi
	push ebx

	mov ecx, [ebp + 8]
	mov ebx, [ebp + 12] ;tablica
	mov edi, [ebp + 16] ;wagi

	xor esi, esi

	finit
	fldz
	fldz

petla:
	cmp esi, ecx
	je koniec
	fld dword ptr [ebx + 4*esi]
	fld dword ptr [edi + 4*esi]
	inc esi
	fmul st(1), st(0)
	faddp st(3), st(0)
	faddp st(1), st(0)
	jmp petla


koniec:
	fxch ;zamiana st(0) z st(1)
	fdivp st(1), st(0)
	
	pop ebx
	pop edi
	pop esi
	pop ebp
	ret
_avg_wd ENDP

_liczba_procesorow PROC
	push ebp
	mov ebp, esp

	sub esp, 36

	push ebx
	push edi
	push esi

	lea ebx, [ebp - 36]
	push ebx
	call  _GetSystemInfo@4

	mov eax, [ebx + 20]

	pop esi
	pop edi
	pop ebx
	add esp, 36
	pop ebp
	ret
_liczba_procesorow ENDP

_zamiana PROC
	push ebp
	mov ebp, esp
	push ebx
	push esi
	push edi
	push eax

	mov ebx, [ebp + 8]
	mov edi, [ebp + 12]

	;dolna czesc
	mov eax, [ebx]
	mov esi, [edi]

	mov [ebx], esi
	mov [edi], eax

	;gorna czesc
	mov eax, [ebx + 4]
	mov esi, [edi + 4]

	mov [ebx + 4], esi
	mov [edi + 4], eax

	pop eax
	pop edi
	pop esi
	pop ebx
	pop ebp
	ret
_zamiana ENDP

_sortowanie PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]
	sub ecx, 1

	xor edi, edi
	xor esi, esi

petla:
	cmp edi, ecx
	je koniec

	mov eax, [ebx + 8*edi]
	mov edx, [ebx + 8*edi + 4]
	inc edi
	cmp edx, [ebx + 8*edi + 4]
	ja zamiana

	cmp eax, [ebx + 8*edi]
	ja zamiana
	inc esi
	jmp petla
zamiana:
	lea eax, [ebx + 8*esi]
	lea edx, [ebx + 8*esi + 8]
	push eax
	push edx
	call _zamiana
	add esp, 8
	inc esi
	jmp petla

koniec:
	mov eax, [ebx + 8*ecx]
	mov edx, [ebx + 8*ecx + 4]

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_sortowanie ENDP

_ASCII_na_UTF16 PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]

	lea eax, [2*ecx]
	add eax, 2

	push ecx
	push eax
	call _malloc
	add esp, 4
	pop ecx

	mov edi, eax
	xor esi, esi

petla:
	cmp esi, ecx
	je koniec

	movzx ax, byte ptr [ebx + esi]
	mov [edi + 2*esi], ax
	inc esi

	jmp petla


koniec:

	mov ax, 0
	mov [edi + 2*esi], ax



	mov eax, edi

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_ASCII_na_UTF16 ENDP

_plus_jeden PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov eax, [ebp + 8]
	mov edx, [ebp + 12]

	;wpisanie mantysy do EDI:ESI
	mov esi, 0
	mov edi, 00100000h
	
	;obliczenie wykladnika
	mov ebx, edx
	shr ebx, 20
	sub ebx, 1023

	and edx, 000fffffh
	or edx, 00100000h


	;moj kod
	mov cl, bl
	shrd esi, edi, cl
	shr edi, cl

	clc
	add eax, esi
	adc edx, edi
	bt edx, 21
	jnc nie_przesun

	inc ebx
	shrd eax, edx, 1
	shr edx, 1

nie_przesun:
	and edx, 000fffffh
	add ebx, 1023
	shl ebx, 20
	or edx, ebx

	push edx
	push eax
	fld qword ptr [esp]
	add esp, 8


	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_plus_jeden ENDP

_NWD PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov esi, [ebp + 8]
	mov edi, [ebp + 12]
	xor eax, eax

	cmp esi, edi
	jne dalej
	mov eax, esi
	jmp koniec
dalej:
	cmp esi, edi
	jna dalej_2
	sub esi, edi
	push edi
	push esi
	call _NWD
	add esp, 8
	jmp koniec

dalej_2:
	sub edi, esi
	push edi
	push esi
	call _NWD
	add esp, 8
	

koniec:

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_NWD ENDP

_miesz2float PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp + 8]
	mov edi, 8
	xor esi, esi

znajdz_1:
	cmp edi, 32
	je koniec
	bt ebx, edi
	jc jedynka
	inc edi
	jmp znajdz_1
jedynka:
	mov esi, edi
	inc edi
	jmp znajdz_1

koniec:

	mov ecx, 23
	sub ecx, esi
	shl ebx, cl

	sub esi, 8
	add esi, 127
	shl esi, 24
	or ebx, esi

	push ebx
	fld dword ptr [esp]
	add esp, 4

	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_miesz2float ENDP

_float_razy_float PROC
	push ebp
	mov ebp, esp
	push ebx
	push edi
	push esi

	mov ebx, [ebp + 8] ;a
	mov eax, [ebp + 12] ;b

	mov edx, ebx
	and edx, 7f800000h
	shr edx, 23
	sub dl, 127
	mov e1, dl

	mov edx, eax
	and edx, 7f800000h
	shr edx, 23
	sub dl, 127
	mov e2, dl

	mov edx, ebx
	and edx, 007fffffh
	or edx, 00800000h ;dodanie ukrytej jedynki
	mov m1, edx

	mov edx, eax
	and edx, 007fffffh
	or edx, 00800000h
	mov m2, edx

	xor eax, eax
	xor edx, edx
	mov eax, m1
	mov ebx, m2
	mul ebx

	test edx, 00008000h
	jz no_overflow

	shrd eax, edx, 24
	inc byte ptr e1
	jmp pack

no_overflow:
	shrd eax, edx, 23

pack:
	and eax, 007fffffh

	movzx ebx, byte ptr e1
	movzx edx, byte ptr e2
	add ebx, edx

	add ebx, 127
	shl ebx, 23

	or eax, ebx

	push eax
	fld dword ptr [esp]
	add esp, 4


	pop esi
	pop edi
	pop ebx
	pop ebp
	ret
_float_razy_float ENDP
END