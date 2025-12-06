#include <stdio.h>

float softmax(float v[], float wynik[], unsigned int n);

int main() {
	//float v[3] = { 1.0f, 2.0f, 3.0f };
	//float wynik[3];
	//printf("\nWynik: %f %f %f", wynik[0], wynik[1], wynik[2]);

	float v[10] = { 0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 1.0f, 0.0f, -1.0f, 2.0f, 3.0f };
	float wynik[10];
	softmax(v, wynik, 10);
	printf("\nWynik: %f %f %f %f %f %f %f %f %f %f", wynik[0], wynik[1], wynik[2], wynik[3], wynik[4], wynik[5], wynik[6], wynik[7], wynik[8], wynik[9]);


	return 0;
}