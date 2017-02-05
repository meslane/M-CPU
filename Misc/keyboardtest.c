#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>

int presses;
int loop;
int exitloop = 0;

void keyboard()
{
	unsigned short keypress = 0;
	
	if (kbhit()){
		keypress = _getch();
	
		if(keypress == 27) {
			exitloop = 1;
		}
        
        presses++;
		printf("%i\n", keypress);
	}
}

int main (void)
{
	while(exitloop == 0) {
		keyboard();
		loop++;
	}
	
	printf("\n\n%i,%i", loop, presses);
}