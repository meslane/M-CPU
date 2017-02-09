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

char getReg(char fileInput, unsigned long line) //take ascii char and return file array position
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
    else if (fileInput == 78 || fileInput == 110 || fileInput == 48) {
        out = 0;
    }
    else {
        printf("SYNTAX ERROR: line %d\n", line);
        exit(1);
    }
    return out;
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
    unsigned int subop; //cast to char after reading 
    unsigned int immediate; //cast to unsigned short after reading 
    unsigned int output;
    unsigned long line = 1;
    
    while(1) { 
        char scanReturn = fscanf(inF, "%s",&temp); //analyse first string and branch into if statement 
        if (scanReturn != EOF) { 
            printf("%s\n", temp);
            if (strcmp(temp, "SEG") == 0 || strcmp(temp, "seg") == 0) { //addressing
                int seg;
                char stringTemp[20];
                int address;
                fscanf(inF, " %i %s %i%*[^\n]\n", &seg, &stringTemp, &address);
                if (strcmp(stringTemp, "ADDRESS") != 0 && strcmp(stringTemp, "address") != 0) {
                    printf("SYNTAX ERROR: line %d\n", line);
                    exit(1);
                }
                (unsigned short) seg;
                (unsigned short) immediate;
                output = (seg << 16)|address;
                fprintf(outF, "fafaf\n"); //address escape
                fprintf(outF, "%x\n", output);
                fprintf(outF, "afafa\n");
            }
            else if (strcmp(temp, "NOP") == 0 || strcmp(temp, "nop") == 0) { //NOP
                fprintf(outF, "%i\n", 0);
            }
            else if (strcmp(temp, "LDI") == 0 || strcmp(temp, "ldi") == 0) { //LDI
                opcode = LDI; //opcode 1
                fscanf(inF," %c %i%*[^\n]\n", &r1, &immediate); //get r1 and immediate
                (unsigned short)immediate;
                r1 = getReg(r1, line);
                r2 = 0;
                subop = 0;
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "LDA") == 0 || strcmp(temp, "lda") == 0) { //LDA
                opcode = LDA; //opcode 2
                fscanf(inF, " %c %c %i %i%*[^\n]\n", &r1, &r2, &subop, &immediate);
                if (subop > 2) {
                    printf("SYNTAX ERROR: line %d\n", line);
                    exit(1);
                }
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                (char) subop;
                (unsigned short)immediate;
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            line++;
        }
        else {
            return;
        } 
    }
    printf("%d\n", line);
}

int main(int argc, char *argv[])
{
    reader(argv[1], argv[2]);
}