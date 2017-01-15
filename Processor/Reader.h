#include "VM.h"

void readMem() 
{
    start:
    printf("\nEnter name of .mcpu file to load as ROM: ");
    char file[BUFSIZ];
    scanf("%s", file);
    
    FILE *fp;
    fp = fopen(file, "r");
    
    if (fp == NULL) {
        printf("\nERROR: ROM file not found in current directory\n");
        goto start;
    }
   
    unsigned char val;
    int i;
    int warn = 1;
    int warnb = 1;
    int warnca = 0;
    int warncb = 1;
    char a;
    char b;
    
    int entry;
    
    addrenter:
    printf("\nInput address entry point for this file (default 0, max 16382): ");
    scanf("%d", &entry);
    if (entry > 16382 | entry < 0) {
        printf("\nERROR: Entry point is out of range\n");
        goto addrenter;
    }
    
    for (i = entry; i < 16383; i++) { 
        fscanf(fp, "%d%*[^\n]\n", &memory[i]); 
        if (memory[i] == 31) {
            warn = 0;
        }
        if (memory[i] == 25) {
            warnb = 0;
        }
        if (memory[i] == 255) {
            warnca = 1;
        }
        if (memory[i] >= 58 && memory[i] <= 65) {
            warncb = 0;
        }
    }
    
    //error detector
    if (warn == 1 | warnb == 1 | (warnca == 0 && warncb == 0)) {
        printf("\n");
    
        if (warn == 1) {
            printf("WARNING: Machine code file does not contain a HALT instruction\n");
        }
   
        if (warnb == 1) {
            printf("WARNING: Machine code does not assign an accumulator\n");
        }
        
        if (warnca == 0 && warncb == 0) {
            printf("WARNING: Machine code refrences the stack but does not set it\n");
        }
        
        printf("Continue?: Y/N\n");
        a = getch();
        if (a == 'y' | a == 'Y') {
            goto success;
        }
        else {
            exit(0);
        }
    }
    //---------------
    
    success:
    printf("\nROM inserted successfully, load another file?: Y/N\n");
    b = getch();
    if (b == 'y' | b == 'Y') {
        goto start;
    }
    else {
        printf("\nMachine code fetching complete, press ENTER to run\n\n");
        getch();
        fclose(fp);
    }
}