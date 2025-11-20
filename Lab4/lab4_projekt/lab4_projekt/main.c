#include<stdio.h>

extern int szukaj4_max(int a, int b, int c, int d);
extern int plus_jeden(int* a);

int main() {
	//int x, y, z, p, wynik;
	//printf("Prosze podaj 4 liczby calkowite: ");
	//scanf_s("%d %d %d %d", &x, &y, &z, &p);
	//
	//wynik = szukaj4_max(x, y, z, p);

	//printf("\n Sposrod podanych liczb %d %d %d %d najwieksza jest %d \n", x, y, z, p, wynik);
	int x;
	printf("Prosze podaj liczbe: ");
	scanf_s("%d", &x);
	plus_jeden(&x);
	printf("Twoja liczba zwiekszona o jeden: %d", x);

	return 0;
}