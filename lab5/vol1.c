#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "vol.h"

// Function to scale a sound sample using a volume_factor
// in the range of 0.00 to 1.00.
static inline int16_t scale_sample(int16_t sample, float volume_factor) {
	return (int16_t) (volume_factor * (float) sample);
}

int main() {

	// Allocate memory for large in and out arrays
	int16_t*	data;
	data = (int16_t*) calloc(SAMPLES, sizeof(int16_t));

	int		x;
	int		ttl = 0;

	// Seed the pseudo-random number generator
	srand(1);

	// Fill the array with random data
	for (x = 0; x < SAMPLES; x++) {
		data[x] = (rand()%65536)-32768;
	}

	// ######################################
	// This is the interesting part!
	// Scale the volume of all of the samples
	for (x = 0; x < SAMPLES; x++) {
		data[x] = scale_sample(data[x], 0.75);
	}
	// ######################################

	// Sum up the data
	for (x = 0; x < SAMPLES; x++) {
		ttl = (ttl+data[x])%1000;
	}

	// Print the sum
	printf("Result: %d\n", ttl);

	return 0;

}

