#include <stdio.h>
#include <stdlib.h>

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

void reader(char inputFile[BUFSIZ], char outputFile[BUFSIZ])
{
    FILE *inF;
    FILE *outF;
    
    inF = fopen(inputFile, "r");
    outF = fopen(outputFile, "w");
    
    char temp[20];
    char opcode[10];
    char r1;
    char r2;
    char subop;
    unsigned short immediate; 
    unsigned int output;
    
    while(!feof(inF)) {
        fscanf(inF, "%s",&temp); //TODO: analyse first string and branch into if satement 
        fscanf(inF, "%s %c %c %c %i%*[^\n]\n",&opcode,&r1,&r2,&subop,&immediate);
        
        
    }    
}

int main(void)
{
    
}