#include <iostream>

struct Vector3
{
	float x, y, z;
};

extern "C" int normalizuj_wektory(Vector3* vecs, unsigned int count, float threshold);


int main() {
	const int N = 4;

    Vector3 data[N] = {
        { 10.0f, 0.0f, 0.0f },  
        { 0.1f, 0.1f, 0.1f },   
        { 3.0f, 4.0f, 0.0f },   
        { 0.0f, 0.0f, 0.0f }    
    };

    float threshold = 1.0f;

    normalizuj_wektory(data, N, threshold);

	return 0;
}