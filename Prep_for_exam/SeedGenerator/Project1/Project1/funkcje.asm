.686
.model flat
.XMM

public _salt, _mul64

extern _GetComputerNameA@8:PROC

.data


.code
_salt PROC
	push ebp
	mov ebp, esp
	sub esp, 20
	push esi
	push edi
	push ebx

	mov ebx, [ebp + 8]

	xor ecx, ecx
ilosc_z:
	cmp byte ptr [ebx], 0
	je koniec_z
	inc ecx
	add ebx, 2
	jmp ilosc_z

koniec_z:
	lea edi, [ebp - 20]
	lea esi, [ebp - 4]

	push ecx
	push esi
	push edi
	call _GetComputerNameA@8
	pop ecx

	mov eax, [esi]
	sub eax, 2
	movzx edx, byte ptr [edi + eax]

	mov [esi], edx

	finit
	fild dword ptr [esi]
	fptan
	fdivp
	fabs
	fld dword ptr [ebp + 12]
	fmulp
	mov eax, 4023D70Ah
	push eax
	fld dword ptr [esp]
	add esp, 4
	fdivp
	fistp qword ptr [edi]

	mov eax, [ebp - 20]
	mov edx, [ebp - 16]

	mov ebx, edx

	shld edx, eax, cl

	shld eax, ebx, cl

	pop ebx
	pop edi
	pop esi
	add esp, 20
	pop ebp
	ret
_salt ENDP

_mul64 PROC
	push ebp
	mov ebp, esp
	sub esp, 16
	push esi
	push edi
	push ebx


	mov [ebp - 16], dword ptr 0
	mov [ebp - 12], dword ptr 0
	mov [ebp - 8], dword ptr 0
	mov [ebp - 4], dword ptr 0

	;B_low * A_low
	mov eax, [ebp + 8]
	mul dword ptr [ebp + 16]
	add [ebp - 16], eax
	add [ebp - 12], edx

	;A_high * B_low
	mov eax, [ebp + 12]
	mul dword ptr [ebp + 16]
	add [ebp - 12], eax
	adc [ebp - 8], edx
	adc [ebp - 4], dword ptr 0

	;A_low * B_high
	mov eax, [ebp + 8]
	mul dword ptr [ebp + 20]
	add [ebp - 12], eax
	adc [ebp - 8], edx
	adc [ebp - 4], dword ptr 0

	;A_high * B_high
	mov eax, [ebp + 12]
	mul dword ptr [ebp + 20]
	add [ebp - 8], eax
	adc [ebp - 4], edx

	movdqu xmm0, xmmword ptr [ebp - 16]

	pop ebx
	pop edi
	pop esi
	add esp, 16
	pop ebp
	ret
_mul64 ENDP


END