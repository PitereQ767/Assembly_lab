#include <stdio.h>
#include <locale.h>

int roznica(int* odejmna, int** odejmnik);
int* kopia_tablicy(int tab1[], unsigned int n);
char* komunikat(char* tekst);
int* szukaj_elem_min(int tablica[], int n);
void szyfruj(char* tekst);
unsigned int kwadrat(unsigned int a);
unsigned char iteracja(unsigned char a);
void zadanie8();


int main() {
	setlocale(LC_ALL, "Polish");

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

	printf("\n------------------Zadanie3------------------\n");
	char* tekst = "AKO³up";
	char* tekst_2 = komunikat(tekst);
	printf("Wynik: %s", tekst_2);


	printf("\n------------------Zadanie4------------------\n");
	int pomiary[7] = { 3, 2, 6, 7, 9, 4, 1 }, * wsk_2;
	wsk_2 = szukaj_elem_min(pomiary, 7);
	printf("Element minimalny = %d", *wsk_2);

	printf("\n------------------Zadanie5------------------\n");
	char tekst_szyfr[] = "To jest jakis tekst";
	szyfruj(tekst_szyfr);
	printf("Zaszyfrowany tekst: %s", tekst_szyfr);

	printf("\n------------------Zadanie6------------------\n");
	unsigned int x = 65000;
	unsigned int y = kwadrat(x);
	printf("Wynik rekurencyjnej funkcji kwadrat wynosi: %u", y);

	printf("\n------------------Zadanie7------------------\n");
	char w = iteracja(32);
	printf("Znak : %c", w);

	printf("\n------------------Zadanie8------------------\n");
	zadanie8();



	return 0;
}