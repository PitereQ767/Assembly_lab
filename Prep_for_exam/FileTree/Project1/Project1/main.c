#include <stdio.h>
#include <Windows.h>

extern double size_of_files(int handle, wchar_t* parent_path);
extern double size_of_files_in_tree(int handle, wchar_t* parent_path);
extern void convert(int liczba, char* wyjscie, int size);

int main() {
	WIN32_FIND_DATA FindFileData;
	int handle = FindFirstFile(L"C:\\Users\\ratko\\Documents\\Studia\\pomoc\\*", &FindFileData);
	double rozmiar = size_of_files_in_tree(handle, L"C:\\Users\\ratko\\Documents\\Studia\\pomoc");

	printf("Laczny rozmiar: %f\n", rozmiar);

	int liczba = -15;
	char wyjscie[128];
	convert(liczba, wyjscie, 128);
	printf("Liczba w (-8): %s", wyjscie);

	return 0;
}