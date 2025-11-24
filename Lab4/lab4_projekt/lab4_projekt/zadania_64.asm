public szukaj64_max
public suma_siedmiu_liczb

.code

szukaj64_max PROC
	push rbx
	push rsi

	mov rbx, rcx
	mov rcx, rdx

	mov rsi, 0

	mov rax, [rbx]

	dec ecx

ptl:
	inc rsi
	cmp rax, [rbx + 8*rsi]
	jge dalej
	mov rax, [rbx + 8*rsi]
dalej:
	loop ptl



	pop rsi
	pop rbx
	ret 
szukaj64_max ENDP

suma_siedmiu_liczb PROC
	push rbp
	mov rbp, rsp

	mov rax, rcx
	add rax, rdx
	add rax, r8
	add rax, r9
	add rax, [rbp + 48]
	add rax, [rbp + 56]
	add rax, [rbp + 64]


	pop rbp
	ret 
suma_siedmiu_liczb ENDP
END