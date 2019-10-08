#include <stdio.h>

// This is a very simple example of inline assembler.
// On AArch64, this code will calculate c=a+b then 
// print the value of c.
//
int main() {
	int a = 3;
	int b = 19;
	int c;

	// __asm__ ("assembley code template" : inputs : outputs : clobbers)
	__asm__ ("add %0, %1, %2" : "=r"(c) : "r"(a),"r"(b) );

	printf("%d\n", c);
}
