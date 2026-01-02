#include <stdio.h>
#include <locale.h>
#include <windows.h>

int roznica(int* odejmna, int** odejmnik);
int* kopia_tablicy(int tab1[], unsigned int n);
char* komunikat(char* tekst);
int* szukaj_elem_min(int tablica[], int n);
void szyfruj(char* tekst);
unsigned int kwadrat(unsigned int a);
unsigned char iteracja(unsigned char a);
void zadanie8();
void zadanie9();
void zadanie10();
double konwerter(float* wejscie, float* wyjscie);
float pole_kola(float* pr);
float avg_wd(int n, void* tablica, void* wagi);
unsigned int liczba_procesorow();
unsigned __int64 sortowanie(unsigned __int64* tab1, unsigned int n);
wchar_t* ASCII_na_UTF16(char* znaki, int n);


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

	printf("\n------------------Zadanie9------------------\n");
	zadanie9();

	printf("\n------------------Zadanie9------------------\n");
	zadanie10();

	printf("\n------------------Zadanie13------------------\n");
	float liczba_f32 = -0.25;
	double wynik_double = 0.0;
	konwerter(&liczba_f32, &wynik_double);
	printf("Liczba w fomracie double: %f", wynik_double);

	printf("\n------------------Zadanie14------------------\n");
	float r = 0.5;
	float pole = pole_kola(&r);
	printf("Pole kola wynosi: %f", pole);

	printf("\n------------------Zadanie15------------------\n");
	float tablica[5] = { 3.14f, 4.2f, 15.39f, 43.2f, 7.0f };
	float wagi[5] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };
	float srednia = avg_wd(5, tablica, wagi);
	printf("Srednia to %f", srednia);

	printf("\n------------------Zadanie16------------------\n");
	unsigned int procesory = liczba_procesorow();
	printf("Liczba procesorow wynosi: %u", procesory);

	printf("\n------------------Zadanie17------------------\n");
	unsigned __int64 tab_1[6] = { 5, 4, 7, 6, 8, 9 };
	unsigned __int64 najwieksza = sortowanie(tab_1, 6);
	printf("Tablica po sortowaniu: ");
	for (int i = 0; i < 6; i++) {
		printf("%I64u ", tab_1[i]);
	}
	printf("\nNajwiekszy element: %I64u", najwieksza);

	printf("\n------------------Zadanie18------------------\n");
	char* znaki = "abcdefghij";
	wchar_t* wskaznik = ASCII_na_UTF16(znaki, 10);
	MessageBoxW(0, wskaznik, L"Tytlul", 4);

	return 0;
}