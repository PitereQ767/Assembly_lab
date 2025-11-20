#include<stdio.h>
#include<stdlib.h>

#define ROZMAIR 5

extern int szukaj4_max(int a, int b, int c, int d);
extern void plus_jeden(int* a);
extern void liczba_przeciwna(int* a);
extern void odejmij_jeden(int** a);
extern void przestaw(int tab1[], int n);

int losuj_0_20() {
	return rand() % 21;
}

void wypisz_tablice(int* tab, int n) {
	for (int i = 0; i < n; i++) {
		printf("%d ", tab[i]);
	}
	return 0;
}

int main() {
	//int x, y, z, p, wynik;
	//printf("Prosze podaj 4 liczby calkowite: ");
	//scanf_s("%d %d %d %d", &x, &y, &z, &p);
	//
	//wynik = szukaj4_max(x, y, z, p);

	//printf("\n Sposrod podanych liczb %d %d %d %d najwieksza jest %d \n", x, y, z, p, wynik);
	//int x;
	//printf("Prosze podaj liczbe: ");
	//scanf_s("%d", &x);
	////plus_jeden(&x);
	//liczba_przeciwna(&x);
	//printf("Twoja liczba przeciwna: %d", x);

	//int k;
	//int* wsk;
	//wsk = &k;
	//printf("Prosze podaj liczbe: ");
	//scanf_s("%d", &k);
	//odejmij_jeden(&wsk);
	//printf("Twoja liczba po odjeciu jeden: %d", k);

	int n = ROZMAIR;
	int tab[10];

	for (int i = 0; i < ROZMAIR; i++) {
		tab[i] = losuj_0_20();
	}
	printf("Wylosowana tablica: \n");
	wypisz_tablice(tab, n);
	printf("\n----------------------------------------\n");

	for (int i = n; i > 1; i--) {
		przestaw(tab, i);

		printf("\nPo przestawieniu: %d\n", i);
		wypisz_tablice(tab, n);
	}
	printf("\n----------------------------------------\n");
	printf("\nTalica po przestawieniu: \n");
	wypisz_tablice(tab, n);

	return 0;
}