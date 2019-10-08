// vol_inline.c :: volume scaling in C using AArch64 SIMD
// Chris Tyler 2017.11.29-2019.10.02 - Licensed under GPLv3.
// For the SIMD lab in the Seneca College SPO600 Course

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "vol.h"

int main() {

	int16_t*		data;		// input array
	int16_t*		limit;		// end of input array

	// these variables will be used in our assembler code, so we're going
	// to hand-allocate which register they are placed in
	// Q: what is an alternate approach?
	register int16_t*	cursor 		asm("r20");	// input cursor
	register int16_t	vol_int		asm("r22");	// volume as int16_t

	int			x;		// array interator
	int			ttl =0 ;	// array total

	data=(int16_t*) calloc(SAMPLES, sizeof(int16_t));

	srand(-1);
	printf("Generating sample data.\n");
	for (x = 0; x < SAMPLES; x++) {
		data[x] = (rand()%65536)-32768;
	}

// --------------------------------------------------------------------

	cursor = data;
	limit = data+ SAMPLES ;

	// set vol_int to fixed-point representation of 0.75
	// Q: should we use 32767 or 32768 in next line? why?
	vol_int = (int16_t) (0.75 * 32767.0);

	printf("Scaling samples.\n");

	// Q: what does it mean to "duplicate" values in the next line?
	__asm__ ("dup v1.8h,%w0"::"r"(vol_int)); // duplicate vol_int into v1.8h

	while ( cursor < limit ) {
		__asm__ (
			"ldr q0, [%[cursor]], #0 	\n\t"
			// load eight samples into q0 (v0.8h)
			// from in_cursor

			"sqdmulh v0.8h, v0.8h, v1.8h	\n\t"
			// multiply each lane in v0 by v1*2
			// saturate results
			// store upper 16 bits of results into
			// the corresponding lane in v0
		
			// Q: Why is #16 included in the str line
			// but not in the ldr line?	

			"str q0, [%[cursor]],#16		\n\t"
			// store eight samples to [cursor]
			// post-increment cursor by 16 bytes
			// and store back into the pointer register

			// Q: What do these next three lines do?
			: [cursor]"+r"(cursor) 
			: "r"(cursor)
			: "memory"
			);
	}

// --------------------------------------------------------------------

	printf("Summing samples.\n");
	for (x = 0; x < SAMPLES; x++) {
		ttl=(ttl+data[x])%1000;
	}

	// Q: are the results usable? are they correct?
	printf("Result: %d\n", ttl);

	return 0;

}

