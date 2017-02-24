#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

uint8_t error(uint8_t errnum)
{
     /*
     * ERROR = VM will not halt, but instruction is skipped
     * ERROR FATAL = VM will forcefully halt 
     */
    switch (errnum) {
        case 0: //no error
            break;
        case 1: //invalid vector
            printf("\nERROR FATAL: interrupt vector is out of range\n");
            exit(1);
            break;
        case 2: //invalid register number
            printf("\nERROR FATAL: designated register does not exist\n");
            exit(1);
            break;
        case 3: //store into ROM
            printf("\nERROR FATAL: attempt to write into ROM segment\n");
            exit(1);
            break;
        case 4: //push SP onto stack
            printf("\nERROR FATAL: cannot push SP onto stack\n");
            exit(1);
            break;
        case 5: //pop into SP
            printf("\nERROR FATAL: cannot pop stack value into SP\n");
            exit(1);
            break;
        case 6: //segment out of range 
            printf("\nERROR FATAL: nonexistent segment\n");
            exit(1);
        case 7: //call stack overflow
            printf("\nERROR FATAL: too many subroutine calls\n");
            exit(1);
        case 8: //call stack underflow
            printf("\nERROR FATAL: return without matching subroutine call\n");
            exit(1);
        case 9: //stack undererflow
            printf("\nERROR FATAL: stack underflow\n");
            exit(1);
        case 10: //stack overflow
            printf("\nERROR FATAL: stack overflow\n");
            exit(1);
    }
    return errnum;
}