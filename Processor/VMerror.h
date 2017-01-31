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
            printf("ERROR: subop is not in defined range\n");
            break;
        case 2: //invalid register number
            printf("ERROR FATAL: designated register does not exist\n");
            exit(1);
            break;
        case 3: //store into ROM
            printf("ERROR FATAL: attempt to write into ROM space\n");
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
    }
    return errnum;
}

void testInstruction(char opcode, char r1, char r2, char subop) {
    if (r1 >= 8 || r2 >= 8) {
        error(2);
    }
}