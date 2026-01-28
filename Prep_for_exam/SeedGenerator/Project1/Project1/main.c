#include <stdio.h>
#include <immintrin.h>

extern long long salt(wchar_t*, float);
extern __m128 mul64(long long a, long long b);

typedef struct int48 {
	long long x0 : 48;
}uint48;

int  main() {
	uint48 x1;
	x1.x0 = salt(L"Winiary", 21.374);
	
	long long a = 100000000000LL;
	long long b = 500000LL;

	__m128 wynik = mul64(a, b);

	unsigned long long* czesci = (unsigned long long*) & wynik;


	printf("Wynik Low (dolne 64):  %llu\n", czesci[0]);
	printf("Wynik High (gorne 64): %llu\n", czesci[1]);

	return 0;
}