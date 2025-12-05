.686
.model flat

public _main

.data
	wsp_a	dd	+2.0
	wsp_b	dd	-1.0
	wsp_c	dd	-15.0

	dwa		dd	2.0
	cztery	dd	4.0
	x1		dd	?
	x2		dd	?

.code
_main PROC
	finit
	fld wsp_a
	fld wsp_b
	fst st(2)

	fmul st(0), st(0)
	fld cztery
	; sytuacja na stosie: ST(0) = 4.0, ST(1) = b^2, ST(2) = a, 
	; ST(3) = b 

	fmul st(0), st(2)	;obliczenie 4*a
	fmul wsp_c			;obliczenie 4*a*c
	fsubp st(1), st(0)
	; sytuacja na stosie: ST(0) = b^2 - 4 * a * c, ST(1) = a, 
	; ST(2) = b 

	fldz

	; sytuacja na stosie: ST(0) = 0, ST(1) = b^2 - 4*a*c, ST(2) = a, ST(3) = b

	fcomi st(0), st(1)

	fstp st(0)

	ja delta_ujemna

	; sytuacja na stosie: ST(0) = b^2 - 4*a*c, ST(1) = a, ST(2) = b

	fxch st(1)

	; sytuacja na stosie: ST(0) = a, ST(1) = b^2 - 4*a*c, ST(2) = b

  	fadd st(0), st(0)
	fstp st(3)

	; sytuacja na stosie: ST(0) = b^2 - 4*a*c, ST(1) = b, ST(2) = 2*a

	fsqrt 

	fst st(3)

	; sytuacja na stosie: ST(0) = sqrt(b^2 - 4*a*c), ST(1) = b, ST(2) = 2*a, ST(3) = sqrt(b^2 - 4*a*c)

	fchs
	fsub st(0), st(1)
	fdiv st(0), st(2)
	fstp x1

	;sytuacja na stosie: ST(0) = b, ST(1) = 2 * a, ST(2) = sqrt(b^2 - 4 * a * c)

	fchs
	fadd st(0), st(2)
	fdiv st(0), st(1)
	fstp x2

	fstp st(0)
	fstp st(0)



delta_ujemna:

_main ENDP

END