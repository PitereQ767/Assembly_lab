.686
.model flat

extern _ExitProcess@4	:PROC
extern _MessageBoxW@16	:PROC
extern __write:PROC, __read:PROC

public _main


.data
	tekst_pocz db 'Prosze wpisac jakis tekst: ', 10
	tekst_pocz_k db ?

.code
_main PROC
	mov


_main ENDP

END