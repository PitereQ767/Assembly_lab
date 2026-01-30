#include <stdio.h>
#include <immintrin.h>

extern long long salt(wchar_t*, float);
extern __m128 mul64(long long a, long long b);
void gen_xi(struct int48* x, unsigned int C);

typedef struct int48 {
	long long x0 : 48;
}uint48;

#define A_CONST 44485709377909ULL  // 0x2875A2E7B175
#define MASK_48 0xFFFFFFFFFFFFULL


void check_verification(unsigned long long seed, int iterations) {
    unsigned long long x = seed;

    printf("\n--- WERYFIKACJA (C) ---\n");
    printf("Start (x0): %llu (0x%llX)\n", x, x);

    for (int i = 1; i <= iterations; i++) {
        x = (x * A_CONST); // Mno¿enie
        x = x & MASK_48;   // Modulo 2^48 (obciêcie)

        // Wypisz pierwszy i ostatni wynik dla kontroli
        if (i == 1 || i == iterations) {
            printf("Iteracja %d: 0x%llX\n", i, x);
        }
    }
    printf("-----------------------\n");
}

int  main() {
	uint48 x1;
	x1.x0 = salt(L"Winiary", 21.374);
	
	long long a = 100000000000LL;
	long long b = 500000LL;

	__m128 wynik = mul64(a, b);

	unsigned long long* czesci = (unsigned long long*) & wynik;


	printf("Wynik Low (dolne 64):  %llu\n", czesci[0]);
	printf("Wynik High (gorne 64): %llu\n", czesci[1]);

	check_verification(9600, 3);

	gen_xi(&x1, 3);

	return 0;
}