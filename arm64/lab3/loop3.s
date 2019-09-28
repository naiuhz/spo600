.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 31                        /* loop exits when the index hits this number (loop condition is i<max) */
divisor = 10
zero = 48
                                /* note: registers 19-28 are safe */
_start:
    mov     x20,start           /* loop index */

loop:
    mov     x2,len              /* message length syscall args*/
    adr     x1,message          /* message location syscall args*/

    mov     x28,divisor         /* store 10 (divisor) in x28 */
    udiv    x23,x20,x28         /* divide index (x20) by 10 (x28), store quotient into x23; remainer discarded */
    msub    x24,x23,x28,x20     /* store remainder (x20 - (x23 * x28)) into x24 */

    cmp     x23,0               /* check if quotient is 0 (i.e. single digit index) */
    b.eq    sloop               /* if so, branch to single digit loop */

    /* tens digit */
    add     x23,x23,zero        /* increase x23 (quotient) by 48 i.e. convert to ascii value */
    strb    w23,[x1,6]          /* copy 1 byte of w23 to message 6 bytes offset */

    /* ones digit */
sloop:
    add     x24,x24,zero        /* increase x24 (remainder) by 48 i.e. convert to ascii value */
    strb    w24,[x1,7]          /* copy 1 byte of w24 to message 7 bytes offset */
    mov     x0,1                /* file descriptor stdout syscall args*/
    mov     x8,64               /* syscall number is 8; write is 64 */
    svc     0                   /* perform a syscall */

    /* increment & check for exit */
    add     x20,x20,1           /* increment index */
    mov     x22,max             /* compare x22 and max value */

    cmp     x20,x22             /* see if we're done */
    b.lt    loop                /* branch to loop if less than */

    mov     x0,0                /* exit status */
    mov     x8,93               /* syscall sys_exit */
    svc     0

.section .data
    msg:    .ascii      "Loop:   \n"
    len = . - msg
