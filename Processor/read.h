#include "Registers.h"

void reader()
{
    printf("Enter name of .mcpu file to load as ROM: ");
    char file[BUFSIZ];
    scanf("%s", file);
    
    FILE *fp;
    fp = fopen(file, "r");
    
    if (fp == NULL) {
        printf("ERROR: ROM file not found in current directory\n");
    }
    
    
}