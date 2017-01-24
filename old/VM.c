#include "Reader.h"
void keyboard()
{
	char keypress = 0;
	
	if (kbhit()){ //if key is pressed
		keypress = _getch(); //record keypress
		memory[61440] = keypress; //send data to MMIO port
		hardwareInt(0, 1); //Trigger interrupt on line 0
	}
}

void hardware()
{
	keyboard(); //port 0
}

int main(void) 
{
	int line;
    //pre-execution
    readMem();
    //hideCursor();
	printf("\n\n======================================================\n\n");

    //execution  
    while (1) {
        hardware();
		run();
        //output();
		registerDump();
    }
}