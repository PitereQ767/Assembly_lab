#include <stdio.h>

float dodaj_SSE(float*, float *, float *);
float pierwiastek_SSE(float*, float*);
float odwrotnosc_SSE(float*, float*);

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

	return 0;
}