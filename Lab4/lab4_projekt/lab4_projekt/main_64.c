#include<stdio.h>

extern __int64 szukaj64_max(__int64* tablica, __int64 n);
extern __int64 suma_siedmiu_liczb(__int64 v1, __int64 v2, __int64 v3, __int64 v4, __int64 v5, __int64 v6, __int64 v7);
extern __int64 sum(unsigned int n, ...);

int main() {
	__int64 wynik;
	wynik = sum(3, -3LL, -2LL, -1LL);
	printf("%I64d\n", wynik);
	wynik = sum(5, 1000000000000LL, 2LL, 3LL, 4LL, 5LL);  // 1000000000014
	printf("%I64d\n", wynik);
	wynik = sum(0);                                       // 0
	printf("%I64d\n", wynik);
	wynik = sum(1, -3LL);
	printf("%I64d\n", wynik);

	return 0;
}