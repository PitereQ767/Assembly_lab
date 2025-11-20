.686
.model flat

public _szukaj4_max 
public _plus_jeden
public _odejmij_jeden
public _przestaw

.data

.code

_szukaj4_max PROC
	push ebp
	mov ebp, esp

	mov eax, [ebp + 8]
	cmp eax, [ebp + 12]
	jge x_wieksza_y
	;y>x
	mov eax, [ebp + 12]
	cmp eax, [ebp + 16]
	jge y_wieksza_z
	mov eax, [ebp + 16]
	cmp eax, [ebp + 20]
	jge koniec
	mov eax, [ebp + 20]
	jmp koniec

y_wieksza_z:
	cmp eax, [ebp + 20]
	jge koniec
	mov eax, [ebp+20]
	jmp koniec

x_wieksza_y:
	cmp eax, [ebp + 16]
	jge x_wieksza_z
	mov eax, [ebp + 16]
	cmp eax, [ebp + 20]
	jge koniec
	mov eax, [ebp + 20]
	jmp koniec


x_wieksza_z:
	cmp eax, [ebp + 20]
	jge koniec
	mov eax, [ebp + 20]

koniec:
	pop ebp
	ret

_szukaj4_max ENDP

_plus_jeden PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov eax, [ebx]
	inc eax
	mov [ebx], eax

	pop ebx
	pop ebp
	ret
_plus_jeden ENDP

_liczba_przeciwna PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov eax, [ebx]
	neg eax
	mov [ebx], eax

	pop ebx
	pop ebp
	ret
_liczba_przeciwna ENDP

_odejmij_jeden PROC
	push ebp
	mov ebp, esp
	push ebx
	push ecx

	mov ebx, [ebp + 8]
	mov ecx, [ebx]
	mov eax, [ecx]
	dec eax
	mov [ecx], eax

	pop ecx
	pop ebx
	pop ebp
	ret
_odejmij_jeden ENDP

_przestaw PROC
	push ebp
	mov ebp, esp
	push ebx

	mov ebx, [ebp + 8]
	mov ecx, [ebp + 12]
	dec ecx

petla:
	mov eax, [ebx]
	cmp eax, [ebx + 4]
	jle gotowe

	mov edx, [ebx + 4]
	mov [ebx + 4], eax
	mov [ebx], edx


gotowe:
	add ebx, 4
	loop petla

	pop ebx
	pop ebp
	ret
_przestaw ENDP

END