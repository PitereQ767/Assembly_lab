#include<stdio.h>

int dot_product(int tab1[], int tab2[], int n);
int small_power(unsigned int m, unsigned int n);

int main() {
	int wynik;
	int tab1[4] = { 1, 2, -3, 4 };
	int tab2[4] = { 1, -2, 3, 4 };
	int n = 4;
	//wynik = dot_product(tab1, tab2, n);
	//printf("Iloczyn skalarny liczb: %d", wynik);

	printf("%d\n", small_power(2, 2));
	printf("%d\n", small_power(7, 11));
	printf("%d\n", small_power(2, 9));
	printf("%d\n", small_power(5, 10));




	return 0;
}