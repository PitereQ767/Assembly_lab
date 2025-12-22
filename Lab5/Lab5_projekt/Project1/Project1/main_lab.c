#include <stdio.h>
#include <iomanip>



float softmax(float v[], float wynik[], unsigned int n);
void szybki_max(short int t_1[], short int t_2[], short int t_wynik[], int n);
float objetosc_stozka(unsigned int big_r, unsigned int small_r, float h);
float test(float a, float b);


int main() {
	//float v[3] = { 1.0f, 2.0f, 3.0f };
	//float wynik[3];
	//softmax(v, wynik, 3);
	//printf("\nWynik: %f %f %f", wynik[0], wynik[1], wynik[2]);

	//float v[10] = { 0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 1.0f, 0.0f, -1.0f, 2.0f, 3.0f };
	//float wynik[10];
	//softmax(v, wynik, 10);
	//printf("\nWynik: %f %f %f %f %f %f %f %f %f %f", wynik[0], wynik[1], wynik[2], wynik[3], wynik[4], wynik[5], wynik[6], wynik[7], wynik[8], wynik[9]);

	/*short int val1[16] = { 1, -1, 2, -2, 3, -3, 4, -4, 5, -5, 6, -6, 7, -7, -8, 8 };
	short int val2[16] = { -3, -2, -1, 0, 1, 2, 3, 4, 256, -256, 257, -257, 258, -258, 0, 0 };
	short int wynik[16];
	szybki_max(val1, val2, wynik, 16);
	printf("\nWynik: %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd %hd", wynik[0], wynik[1], wynik[2], wynik[3], wynik[4], wynik[5], wynik[6], wynik[7], wynik[8], wynik[9], wynik[10], wynik[11], wynik[12], wynik[13], wynik[14], wynik[15]);*/

	float wynik = objetosc_stozka(5, 3, 10.0);
	printf("\nWynik: %f", wynik);


	return 0;
}