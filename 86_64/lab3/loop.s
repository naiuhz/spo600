.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 35                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     $start,%r15         /* loop index */

loop:

	mov    $10,%r13			/* moved 10 to r13 */
	mov    %r15,%rax		/* moved r15 to rax */
	mov    $48,%r14			/* moved 48 to r14*/
	mov    $0,%rdx			/* moved 0 to rdx */

	div    %r13			/* divided rax by r13 (loop index by 10) */
	add    %r14,%rax		/* added r14 to rax (48 to the quotient of the division */
	mov    %rax,%r13		/* moved rax to r13 so I can then move only one byte to msg */
	mov    %r13b,msg+6

	add    %r14,%rdx		/* added r15 to r14 */
	mov    %rdx,%r13		/* moved rdx to r13 so I can then move only one byte to msg */
	mov    %r13b,msg+7		/* added number after 'Loop' */
        mov    $len,%rdx                /* message length */
        mov    $msg,%rsi                /* message location */
        mov    $1,%rdi                  /* file descriptor stdout */
        mov    $1,%rax                  /* syscall sys_write */
        syscall

    inc     %r15                /* increment index */
    cmp     $max,%r15           /* see if we're done */
    jne     loop                /* loop if we're not */

    mov     $0,%rdi             /* exit status */
    mov     $60,%rax            /* syscall sys_exit */
    syscall

.section .data

        msg:    .ascii      "Loop:    \n"
        len = . - msg

