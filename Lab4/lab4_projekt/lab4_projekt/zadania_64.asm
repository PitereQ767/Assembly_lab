public szukaj64_max
public suma_siedmiu_liczb
public sum

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

sum PROC
	push rbp
	mov rbp, rsp
	push rbx
	push rdi
	push rsi

	xor rax, rax ;wynik

	cmp rcx, 0
	je done
	cmp rcx, 1
	je rejestry_1
	cmp rcx, 2
	je rejestry_2
	cmp rcx, 3
	je rejestry_3

	jmp stos_1

rejestry_1:
	add rax, rdx
	jmp done
rejestry_2:
	add rax, rdx
	add rax, r8
	jmp done
rejestry_3:
	add rax, rdx
	add rax, r8
	add rax, r9
	jmp done

stos_1:
    add rax, rdx
    add rax, r8
    add rax, r9

    mov rbx, 0           
    mov rsi, rcx
    sub rsi, 3           

stos_petla:
    cmp rbx, rsi
    jge done
    mov rdx, [rbp + 48 + rbx*8]
    add rax, rdx
    inc rbx
    jmp stos_petla


done:
	pop rsi
	pop rdi
	pop rbx
	pop rbp
	ret
sum ENDP
END