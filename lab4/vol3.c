#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include "vol.h"

// Function to scale a sound sample using a volume_factor
// in the range of 0.00 to 1.00.
static inline int16_t scale_sample(int16_t sample, int16_t volume_factor) {
	return (volume_factor * sample) >> 8;
}

int main() {

	// timer
	clock_t start, end;
	double cpu_time_used;

	// Allocate memory for large in and out arrays
	int16_t*	in;
	int16_t*	out;
	in = (int16_t*) calloc(SAMPLES, sizeof(int16_t));
	out = (int16_t*) calloc(SAMPLES, sizeof(int16_t));

	int		x;
	int		ttl = 0;

	// Seed the pseudo-random number generator
	srand(-1);

	// Fill the array with random data
	for (x = 0; x < SAMPLES; x++) {
		in[x] = (rand()%65536)-32768;
	}
	
	int16_t vol_factor = (0.75 * 256);

	start = clock();

	// ######################################
	// This is the interesting part!
	// Scale the volume of all of the samples
	for (x = 0; x < SAMPLES; x++) {
		out[x] = scale_sample(in[x], vol_factor);
	}
	// ######################################

	end = clock();
	cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	// Sum up the data
	for (x = 0; x < SAMPLES; x++) {
		ttl = (ttl+out[x])%1000;

		if (x<5) {
			printf("%d\n", out[x]);
		}
	}

	// Print the sum
	printf("Result: %d\n", ttl);
	printf("It took %f\n", cpu_time_used);
	return 0;

}

