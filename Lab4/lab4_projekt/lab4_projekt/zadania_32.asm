.686
.model flat

public _liczba_sciezek_2

.code
_liczba_sciezek_2 PROC
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov eax, [ebp+8]   
    mov ebx, [ebp+12]  
    
    cmp eax, 12
    ja za_duza
    cmp ebx, 12
    ja za_duza
    
    cmp eax, 0
    je jeden
    cmp ebx, 0
    je jeden
    
    dec eax            
    push ebx           
    push eax           
    call _liczba_sciezek_2
    add esp, 8         
    mov esi, eax       
    

    mov eax, [ebp+8]   
    mov ebx, [ebp+12]  
    dec ebx            
    push ebx           
    push eax          
    call _liczba_sciezek_2
    add esp, 8         
    
    add eax, esi       
    jmp koniec
    
jeden:
    mov eax, 1
    jmp koniec
    
za_duza:
    mov eax, -1
    
koniec:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
_liczba_sciezek_2 ENDP

END


