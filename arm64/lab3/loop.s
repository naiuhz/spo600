.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     r20,start         /* loop index */

loop:

	add    r19,r20,48                        /* added r20+48 to r19 */
	ldrb   msg+6,r19                      /* added number after 'Loop' */
	mov    x2,len                      /* message length */
	adr    x1,msg                       /* message location */
	mov    x0,1                         /* file descriptor stdout */
	mov    x8,64                        /* syscall sys_write */
	svc    0

	add     r20,r20,1                /* increment index */
	cmp     max,r20           /* see if we're done */
	b.ne    loop                /* loop if we're not */

	mov     x0,0             /* exit status */
	mov     x8,93            /* syscall sys_exit */
	svc     0

.section .data

        msg:    .ascii      "Loop:  \n"
        len = . - msg

