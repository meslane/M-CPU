#include "Reader.h"

int main(void) 
{
    //pre-execution
    readMem();
    hideCursor();
	system("CLS");
	printf("\n");

    //execution  
    while (1) {
        run();
        output();
    }
}

//TODO: add log file and printing
