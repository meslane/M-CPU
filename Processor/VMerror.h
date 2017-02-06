#include <stdio.h>
#include <stdlib.h>

unsigned char error(unsigned char errnum)
{
     /*
     * ERROR = VM will not halt, but instruction is skipped
     * ERROR FATAL = VM will forcefully halt 
     */
    switch (errnum) {
        case 0: //no error
            break;
        case 1: //invalid subop
            printf("ERROR FATAL: subop is not in defined range\n");
            exit(1);
            break;
        case 2: //invalid register number
            printf("ERROR FATAL: designated register does not exist\n");
            exit(1);
            break;
        case 3: //store into ROM
            printf("ERROR FATAL: attempt to write into ROM segment\n");
            exit(1);
            break;
        case 4: //push SP onto stack
            printf("ERROR FATAL: cannot push SP onto stack\n");
            exit(1);
            break;
        case 5: //pop into SP
            printf("ERROR FATAL: cannot pop stack value into SP\n");
            exit(1);
            break;
        case 6: //segment out of range 
            printf("ERROR FATAL: nonexistent segment\n");
            exit(1);
    }
    return errnum;
}