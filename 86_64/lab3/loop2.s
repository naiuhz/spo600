.text
.globl _start
	
start = 0		/* starting value for the loop index; note that this is a symbol (constant), not a variable */          
max = 35		/* loop exits when the index hits this number (loop condition is i<max) */                              
                                                                                                                                       
_start:                                                                                                                                
    mov    $start,%r15  /* loop index */                                                                                        
                                                                                                                                       
loopsg:                                                                                                                                
                                                                                                                                       
        cmp    $9,%r15                  /* compare loop index to 9 */                                                                  
        jg     loopmd                   /* jump to loopmd if r15 is greather than 9 */                                                 
        mov    $48,%r14                 /* move 48 to r14*/                                                                            
        add    %r15,%r14                /* add r15 to r14 */                                                                           
        mov    %r14b,msg+7              /* add number after 'Loop' */                                                                  
        mov    $len,%rdx                /* message length */                                                                           
        mov    $msg,%rsi                /* message location */                                                                         
        mov    $1,%rdi                  /* file descriptor stdout */                                                                   
        mov    $1,%rax                  /* syscall sys_write */                                                                        
        syscall                                                                                                                        
        jmp    check                    /* jump to check */                                                                            
                                                                                                                                       
loopmd:                                                                                                                                
                                                                                                                                       
        mov    $10,%r13                 /* move 10 to r13 */                                                                           
        mov    %r15,%rax                /* move r15 to rax */                                                                          
        mov    $48,%r14                 /* move 48 to r14*/                                                                            
        mov    $0,%rdx                  /* move 0 to rdx */                                                                            
                                                                                                                                       
        div    %r13                     /* divide rax by r13 (divide loop index by 10) */                                              
        add    %r14,%rax                /* add r14 to rax (add 48 to the quotient of the division */                                   
        mov    %rax,%r13                /* move rax to r13 so I can then move only one byte to msg */                                  
        mov    %r13b,msg+6              /* add firs digit after 'Loop' */                                                              
                                                                                                                                       
        add    %r14,%rdx                /* add r15 to r14 */                                                                           
        mov    %rdx,%r13                /* move rdx to r13 so I can then move only one byte to msg */                                  
        mov    %r13b,msg+7              /* add second digit after 'Loop' */                                                            
        mov    $len,%rdx                /* message length */                                                                           
        mov    $msg,%rsi                /* message location */                                                                         
        mov    $1,%rdi                  /* file descriptor stdout */                                                                   
        mov    $1,%rax                  /* syscall sys_write */                                                                        
        syscall                                                                                                                        
                                                                                                                                       
check:                                                                                                                                 
        inc     %r15                    /* increment index */                                                                          
        cmp     $max,%r15               /* see if we're done */                                                                        
        jne     loopmd                  /* loop if we're not */                                                                        
                                                                                                                                       
        mov     $0,%rdi                 /* exit status */                                                                              
        mov     $60,%rax                /* syscall sys_exit */                                                                         
        syscall                                                                                                                        
                                                                                                                                       
.section .data                                                                                                                         
                                                                                                                                       
        msg:    .ascii      "Loop:    \n"                                                                                              
        len = . - msg
	
