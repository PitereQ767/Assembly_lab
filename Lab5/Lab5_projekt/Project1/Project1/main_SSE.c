#include <stdio.h>

float dodaj_SSE(float*, float *, float *);
float pierwiastek_SSE(float*, float*);
float odwrotnosc_SSE(float*, float*);
char dodawanie_16(char*, char*, char*);

int main() {
	float p[4] = { 4.0, 1.5, 9.0, 2.5 };
	float q[4] = { 0.25, -0.5, 1.0, -1.75 };
	float r[4];

	dodaj_SSE(p, q, r);
	printf("\n %f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n %f %f %f %f", q[0], q[1], q[2], q[3]);
	printf("\n %f %f %f %f", r[0], r[1], r[2], r[3]);

	printf("\n\nObliczanie pierwiastka");
	pierwiastek_SSE(p, r);
	printf("\n %f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n %f %f %f %f", r[0], r[1], r[2], r[3]);

	printf("\n\nOdwrotnosc");
	odwrotnosc_SSE(p, r);
	printf("\n %f %f %f %f", p[0], p[1], p[2], p[3]);
	printf("\n %f %f %f %f", r[0], r[1], r[2], r[3]);

	char liczby_A[16] = {-128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127};
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	char w[16];

	dodawanie_16(liczby_A, liczby_B, w);
	printf("\n\n Dodawanie_16");
	printf("\n %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", liczby_A[0], liczby_A[1], liczby_A[2], liczby_A[3], liczby_A[4], liczby_A[5], liczby_A[6], liczby_A[7], liczby_A[8], liczby_A[9], liczby_A[10], liczby_A[11], liczby_A[12], liczby_A[13], liczby_A[14], liczby_A[15]);
	printf("\n %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", liczby_B[0], liczby_B[1], liczby_B[2], liczby_B[3], liczby_B[4], liczby_B[5], liczby_B[6], liczby_B[7], liczby_B[8], liczby_B[9], liczby_B[10], liczby_B[11], liczby_B[12], liczby_B[13], liczby_B[14], liczby_B[15]);
	printf("\n %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d", w[0], w[1], w[2], w[3], w[4], w[5], w[6], w[7], w[8], w[9], w[10], w[11], w[12], w[13], w[14], w[15]);

	return 0;
}