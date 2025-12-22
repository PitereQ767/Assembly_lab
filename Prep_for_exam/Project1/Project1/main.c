#include <stdio.h>

int roznica(int* odejmna, int** odejmnik);
int* kopia_tablicy(int tab1[], unsigned int n);


int main() {
	printf("\n------------------Zadanie1------------------\n");
	int a, b, * wsk, wynik;
	wsk = &b;
	a = 21;
	b = 25;
	wynik = roznica(&a, &wsk);

	printf("Wynik: %d", wynik);

	printf("\n------------------Zadanie2------------------\n");
	int tab[3] = {1, 2, 3};
	int* tab2 = kopia_tablicy(tab, 3);
	for (int i = 0; i < 3; i++) {
		printf("%d ", tab2[i]);
	}

	return 0;
}