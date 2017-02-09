#include "Registers.h"

typedef enum {ROMINSERT, ADDR} readState; 

void reader(char file[BUFSIZ])
{   
    FILE *fp;
    fp = fopen(file, "r");
    
    if (fp == NULL) {
        printf("ERROR FATAL: ROM file not found in current directory\n");
        exit(1);
    }
    
    unsigned int data;
    char segment;
    unsigned short address;
    
    char amode;
    readState mode = ROMINSERT;
    while(1) { //file reading
        char scanReturn = fscanf(fp, "%x%*[^\n]\n", &data); //read as hex ints and ignore everything else but \n
        
        if (scanReturn == EOF) return; //break from loop if EOF
        
        if (mode == ROMINSERT) { //put data into memory
            if (data == 0xfafaf) { //goto ADDR mode if entry token is found 
                mode = ADDR;
            }
            else {
                memory[segment][address] = data;
                address++;
            }
        }
        
        if (mode == ADDR) { //enter: fafaf, exit: afafa
            if (data != 0xfafaf && data != 0xafafa){ //if data is not entry token or exit token
                segment = (data >> 16);
                address = data&0xffff;            
            }
            else if (data == 0xafafa) {
                mode = ROMINSERT;   
            }
        }
    }
    fclose(fp);
}