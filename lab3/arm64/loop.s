.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    	mov    x20,start         /* loop index */

loop:

	add    x19, x20,48 			/* add 48 to x20 and store in x19*/
	adr    x21, msg                        /* putting the address of msg into x21 */
	strb   w19, [x21,6]                      /* store one byte from w19 to x21 plus an offset of 6 */
	mov    x2,len                      /* message length syscall args*/
	adr    x1,msg                       /* message location syscall args*/
	mov    x0,1                         /* file descriptor stdout syscall args*/
	mov    x8,64                        /* syscall sys_write */
	svc    0

	add     x20,x20,1                /* increment index */
	mov	x22,max
	cmp     x20,x22           /* see if we're done */
	b.ne    loop                /* loop if we're not */

	mov     x0,0             /* exit status */
	mov     x8,93            /* syscall sys_exit */
	svc     0

.section .data

        msg:    .ascii      "Loop:  \n"
        len = . - msg

