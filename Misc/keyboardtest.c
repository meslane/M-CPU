#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>

int loop;
int exitloop = 0;

void keyboard()
{
	char keypress = 0;
	
	if (kbhit()){
		keypress = _getch();
	
		if(keypress == 27) {
			exitloop = 1;
		}
	
		printf("%i\n", keypress);
	}
}

int main (void)
{
	while(exitloop == 0) {
		keyboard();
		loop++;
	}
	
	printf("\n\n%i", loop);
}