#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN 0
#define MAX 65535

typedef enum {
    NOP, 
    LDI, 
    LDA,
    STA,
    GOTO,
    JUMPIFC,
    JUMPIFNC,
    JUMPIFN,
    JUMPIFNN,
    JUMPIFZ,
    JUMPIFNZ,
    JUMPIFP,
    JUMPIFNP,
    GSR,
    RSR,
    INT,
    MOV,
    PUSH,
    POP,
    ADD,
    ADC,
    SUB,
    SBB,
    AND,
    OR, 
    XOR,
    LSHIFT,
    RSHIFT,
    LSG,
    LSP,
    SETF,
    HALT
} instruction;

typedef enum {
    A,
    B,
    C,
    D,
    E,
    X,
    Y,
    Z
} reg; //register but that's a reserved C keyword 

char getReg(char fileInput) //take ascii char and return file array position
{
    char out;
    if (fileInput >= 65 && fileInput <= 69) {
        out = fileInput - 65;
    }
    else if (fileInput >= 88 && fileInput <= 90) {
        out = fileInput - 83;
    }
    else if (fileInput >= 97 && fileInput <= 101) {
        out = fileInput - 97;
    }
    else if (fileInput >= 120 && fileInput <= 122) {
        out = fileInput - 115;
    }
    else {
        printf("SYNTAX ERROR\n");
        exit(1);
    }
}

void reader(char inputFile[BUFSIZ], char outputFile[BUFSIZ])
{
    FILE *inF;
    FILE *outF;
    
    inF = fopen(inputFile, "r");
    outF = fopen(outputFile, "w");
    
    char temp[20];
    char opcodeStr[10];
    char opcode;
    char r1;
    char r2;
    char subop;
    unsigned short immediate; 
    unsigned int output;
    
    while(!feof(inF)) { //TODO: !feof bad, replace it 
        fscanf(inF, "%s",&temp); //analyse first string and branch into if statement 
            printf("%s\n", temp);
            if (strcmp(temp, "NOP") == 0 || strcmp(temp, "nop") == 0) {
                fprintf(outF, "%i\n", 0);
            }
            else if (strcmp(temp, "LDI") == 0 || strcmp(temp, "ldi") == 0) { //BROKEN as of now
                opcode = LDI; //opcode 1
                fscanf(inF," %c %d", &r1, &immediate); //get r1 and immediate
                printf("R1: %i\n", r1);
                printf("I: %i\n", immediate);
                r1 = getReg(r1);
                r2 = 0;
                subop = 0;
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }        
    }
    fclose(inF);
    fclose(outF);
}

int main(int argc, char *argv[])
{
    reader(argv[1], argv[2]);
}