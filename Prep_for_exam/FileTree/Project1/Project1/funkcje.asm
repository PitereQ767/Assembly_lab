.686
.model flat

public _size_of_files, _size_of_files_in_tree, _convert

extern _FindNextFileW@8:PROC, _FindFirstFileW@8:PROC

.data


.code

_size_of_files_in_tree PROC
	push ebp
	mov ebp, esp
	sub esp, 1200
	push edi
	push esi

	fldz

	mov edi, [ebp + 8]
	mov esi, [ebp + 12]
	lea ebx, [ebp - 1200]

petla:
	push ebx
	push edi
	call _FindNextFileW@8

	cmp eax, 0
	je koniec_rek

	cmp byte ptr [ebx + 44], 2eh
	je petla
	
	mov edx, [ebx]
	bt edx, 4
	jnc plik

	lea ecx, [ebp - 600]
kopiuj_rodzica:
	cmp word ptr [esi], 0
	je koniec_rodzica

	mov ax, [esi]
	mov [ecx], ax
	add esi, 2
	add ecx, 2
	jmp kopiuj_rodzica

koniec_rodzica:
	mov [ecx], word ptr 005ch
	add ecx, 2

	lea esi, [ebx + 44]
kopiuj_dziecko:
	cmp word ptr [esi], 0
	je koniec_dziecka

	mov ax, [esi]
	mov [ecx], ax
	add esi, 2
	add ecx, 2
	jmp kopiuj_dziecko

koniec_dziecka:
	push ecx ;zeby pozniej wpisac zero

	mov [ecx], word ptr 005ch
	add ecx, 2
	
	mov [ecx], word ptr '*'
	add ecx, 2

	mov [ecx], word ptr 0
	add ecx, 2

	lea ecx, [ebp - 1200]
	push ecx
	lea ecx, [ebp - 600]
	push ecx
	call _FindFirstFileW@8
	pop ecx
	mov word ptr [ecx], 0


	push ecx
	push eax
	call _size_of_files_in_tree
	add esp, 8

	faddp st(1), st(0) ;dodaj rozmiar katalogu do sumy g³ównej

	jmp petla

plik:
	mov edx, [ebx + 28]
	mov eax, [ebx + 32]

	push edx
	push eax
	fild qword ptr [esp]
	faddp st(1), st(0)
	add esp, 8
	jmp petla


koniec_rek:


	pop esi
	pop edi
	add esp, 1200
	pop ebp
	ret
_size_of_files_in_tree ENDP

_size_of_files PROC
	push ebp
	mov ebp, esp
	sub esp, 600
	push edi
	push esi

	fldz

	mov edi, [ebp + 8]
	mov esi, [ebp + 12]
	lea ebx, [ebp - 600]

petla:
	push ebx
	push edi
	call _FindNextFileW@8

	cmp eax, 0
	je koniec

	cmp byte ptr [ebx + 44], 2eh
	je petla
	
	mov edx, [ebx]
	bt edx, 4
	jnc plik

	push esi
	push edi
	call _size_of_files
	add esp, 8

	faddp st(1), st(0) ;dodaj rozmiar katalogu do sumy g³ównej

	jmp petla

plik:
	mov edx, [ebx + 28]
	mov eax, [ebx + 32]

	push edx
	push eax
	fild qword ptr [esp]
	faddp st(1), st(0)
	add esp, 8
	jmp petla

koniec:

	mov dword ptr [ebp - 4], 1048576
	fild dword ptr [ebp -4]
	fdivp

	pop esi
	pop edi
	add esp, 600
	pop ebp
	ret
_size_of_files ENDP

_convert PROC
	push ebp
	mov ebp, esp
	push esi
	push ebx
	push edi

	mov eax, [ebp + 8]
	mov edi, [ebp + 12]
	mov esi, [ebp + 16]
	dec esi
	mov [edi + esi], byte ptr 0
	dec esi

petla:
	cmp eax, 0
	je koniec

	mov ebx, eax
	and ebx, 00000007h
	sar eax, 3
	neg eax
	add bl, 30h
	mov [edi + esi], bl
	dec esi
	jmp petla

koniec:
	cmp esi, -1
	je koniec_2

	mov [edi + esi], byte ptr " "
	dec esi
	jmp koniec

koniec_2:

	pop edi
	pop ebx
	pop esi
	pop ebp
	ret
_convert ENDP

END