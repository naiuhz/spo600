// vol_intrinsics.c :: volume scaling in C using AArch64 Intrinsics
// Chris Tyler 2019.10.02 - Licensed under GPLv3
// For the SIMD lab in the Seneca College SPO600 Course

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <arm_neon.h>
#include "vol.h"

int main() {

	int16_t*		data;		// data array
	int16_t*		limit;		// end of input array

	register int16_t*	cursor 		asm("r20");	// array cursor (pointer)
	register int16_t	vol_int		asm("r22");	// volume as int16_t

	int			x;		// array interator
	int			ttl =  0;	// array total

	data=(int16_t*) calloc(SAMPLES, sizeof(int16_t));

	srand(-1);
	printf("Generating sample data.\n");
	for (x = 0; x < SAMPLES; x++) {
		data[x] = (rand()%65536)-32768;
	}

// --------------------------------------------------------------------

	cursor = data; // Pointer to start of array
	limit = data + SAMPLES ;

	vol_int = (int16_t) (0.75 * 32767.0);

	printf("Scaling samples.\n");

	while ( cursor < limit ) {
		// Q: What do these intrinsic functions do? 
		// (See gcc intrinsics documentation)
		vst1q_s16(cursor, vqdmulhq_s16(vld1q_s16(cursor), vdupq_n_s16(vol_int)));

		// Q: Why is the increment below 8 instead of 16 or some other value?
		// Q: Why is this line not needed in the inline assembler version
		// of this program?
		cursor += 8;
	}

// --------------------------------------------------------------------

	printf("Summing samples.\n");
	for (x = 0; x < SAMPLES; x++) {
		ttl=(ttl+data[x])%1000;
	}

	// Q: Are the results usable? Are they accurate?
	printf("Result: %d\n", ttl);

	return 0;

}

