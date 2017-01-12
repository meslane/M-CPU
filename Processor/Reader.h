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
    }
    
    //error detector
    if (warn == 1) {
        printf("\nWARNING: Machine code file does not contain a HALT instruction, proceed?: Y/N\n");
        a = getch();
        if (a == 'y' | a == 'Y') {
            goto warnb;
        }
        else {
            exit(0);
        }
    }
    
    warnb:
    if (warnb == 1) {
        printf("\nWARNING: Machine code does not assign an accumulator, proceed?: Y/N\n");
        a = getch();
        if (a == 'y' | a == 'Y') {
            goto success;
        }
        else {
            exit(0);
        }
    }
    else {
        goto success;
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