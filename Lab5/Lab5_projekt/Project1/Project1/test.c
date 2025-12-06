#include <windows.h>
#include <stdio.h>

DWORD WINAPI worker(LPVOID arg) {
    int id = *(int*)arg;

    // Sprawdü na jakim rdzeniu (Windows API)
    DWORD cpu = GetCurrentProcessorNumber();
    printf("Watek %d wykonuje sie na Core %u\n", id, cpu);

    // Symulacja pracy
    Sleep(1000);  // Sleep w milisekundach (Windows)

    // Sprawdü ponownie
    cpu = GetCurrentProcessorNumber();
    printf("Watek %d teraz na Core %u\n", id, cpu);

    return 0;
}

int main() {
    HANDLE threads[4];
    int ids[4] = { 0, 1, 2, 3 };

    printf("Tworze 4 watki (Windows)...\n");

    for (int i = 0; i < 4; i++) {
        threads[i] = CreateThread(
            NULL,           // Domyúlne atrybuty bezpieczeÒstwa
            0,              // Domyúlny rozmiar stosu
            worker,         // Funkcja wπtku
            &ids[i],        // Argument
            0,              // Rozpocznij natychmiast
            NULL            // Nie potrzebujÍ ID wπtku
        );
    }

    // Czekaj na wszystkie wπtki
    WaitForMultipleObjects(4, threads, TRUE, INFINITE);

    // Zamknij uchwyty
    for (int i = 0; i < 4; i++) {
        CloseHandle(threads[i]);
    }

    printf("Gotowe!\n");
    return 0;
}