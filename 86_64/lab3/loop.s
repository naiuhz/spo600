.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     $start,%r15         /* loop index */

loop:

	mov    $48,%r14			/* moved 48 to r14*/
	add    %r15,%r14			/* added r15 to r14 */
	mov    %r14b,msg+6			/* added number after 'Loop' */
        mov    $len,%rdx                       /* message length */
        mov    $msg,%rsi                       /* message location */
        mov    $1,%rdi                         /* file descriptor stdout */
        mov    $1,%rax                         /* syscall sys_write */
        syscall

    inc     %r15                /* increment index */
    cmp     $max,%r15           /* see if we're done */
    jne     loop                /* loop if we're not */

    mov     $0,%rdi             /* exit status */
    mov     $60,%rax            /* syscall sys_exit */
    syscall

.section .data

        msg:    .ascii      "Loop:  \n"
        len = . - msg

