#include "Reader.h"

int main(void) 
{
    //pre-execution
    readMem();
    printf("\n\n");

    //execution  
    while (1) {
        run();
        registerDump();
        output();
    }
}

//TODO: add log file and printing
