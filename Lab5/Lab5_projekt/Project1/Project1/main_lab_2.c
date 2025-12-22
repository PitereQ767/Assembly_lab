#include <stdio.h>

void sigmoid_inplace(double v[], unsigned int n);
void szybkie_razy_potega2(short t_1[], short pow2, short t_wynik[], int n);

int main() {
	double v[3] = { 1.0, 2.0, 3.0 };
	sigmoid_inplace(v, 3);

	printf("\nWynik: %f %f %f\n", v[0], v[1], v[2]);

	double v_2[10] = { 0.0, 1.0, 2.0, 3.0, 4.0, 1.0, 0.0, -1.0, 2.0, 3.0 };
	sigmoid_inplace(v_2, 10);
	printf("\nWynik: %f %f %f %f %f %f %f %f %f %f\n", v_2[0], v_2[1], v_2[2], v_2[3], v_2[4], v_2[5], v_2[6], v_2[7], v_2[8], v_2[9]);

	short int val[16] = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 10 };
	short int pow2 = 3;
	short int wynik[16];
	szybkie_razy_potega2(val, pow2, wynik, 16);

	printf("\nWynik: %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd\n", wynik[0], wynik[1], wynik[2], wynik[3], wynik[4], wynik[5], wynik[6], wynik[7], wynik[8], wynik[9], wynik[10], wynik[11], wynik[12], wynik[13], wynik[14], wynik[15]);


	short int val_2[8] = { 1, 2, 3, 4, 5, 6, 7, 10 };
	short int pow2_2 = 4;
	short int wynik_2[8];
	szybkie_razy_potega2(val_2, pow2_2, wynik_2, 8);
	printf("\nWynik: %hd %hd %hd %hd %hd %hd %hd %hd\n", wynik_2[0], wynik_2[1], wynik_2[2], wynik_2[3], wynik_2[4], wynik_2[5], wynik_2[6], wynik_2[7]);

	return 0;
}