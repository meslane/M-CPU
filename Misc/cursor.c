#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>

void hideCursor()
{
    HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO cursor;
    cursor.dwSize = 10;
    cursor.bVisible = FALSE;
    SetConsoleCursorInfo(console, &cursor);
}

void showCursor()
{
    HANDLE console = GetStdHandle(STD_OUTPUT_HANDLE);
    CONSOLE_CURSOR_INFO cursor;
    cursor.dwSize = 10;
    cursor.bVisible = TRUE;
    SetConsoleCursorInfo(console, &cursor);
}

int main(void) 
{
	start:
	printf("Hide or show cursor? S/H\n");
	char a = _getch();
	if (a == 's' | a == 'S') {
		showCursor();
	}
	else if (a == 'h' | a == 'H') {
		hideCursor();
	}
	else {
		goto start;
	}
}