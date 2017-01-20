#include "Reader.h"

int main(void) 
{
    //pre-execution
    readMem();
    hideCursor();
    printf("\n\n");
	printf("======================================================\n");

    //execution  
    while (1) {
        run();
        output();
    }
}

//TODO: add log file and printing
