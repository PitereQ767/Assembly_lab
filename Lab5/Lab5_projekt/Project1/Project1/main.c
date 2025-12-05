#include <stdio.h>

float srednia_harm(float* tablica, unsigned int n);
float e_do_x(float x);

int main() {
	//unsigned int n;
	//printf("Ile liczb chcesz wprowadzic: ");
	//scanf_s("%u", &n);

	//float* tab = malloc(n * sizeof(float));

	//for (int i = 0; i < n; i++) {
	//	scanf_s("%f", &tab[i]);
	//}

	//float wynik = srednia_harm(tab, n);
	//printf("Srednia harmoniczna wynosi: %f", wynik);


	//free(tab);

	float wynik = e_do_x(2.0);

	printf("Wynik: %f", wynik);

	return 0;
}