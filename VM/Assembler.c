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

char getSr(char fileInput[2], unsigned long line)
{
    if (strcmp(fileInput, "RS") == 0 || strcmp(fileInput, "rs") == 0) { 
        return 0;
    }
    else if (strcmp(fileInput, "MS") == 0 || strcmp(fileInput, "ms") == 0) { 
        return 1;
    }
    else if (strcmp(fileInput, "SS") == 0 || strcmp(fileInput, "ss") == 0) {
        return 2;
    }
}

void testSubop(unsigned int subop, unsigned long line) 
{
    if (subop > 2) {
        printf("SYNTAX ERROR: line %d\n", line);
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
    char segR[2];
    char opcode;
    char r1;
    char r2;
    char r3;
    unsigned int subop; //cast to char after reading 
    unsigned int immediate; //cast to unsigned short after reading 
    unsigned int output;
    unsigned long line = 1;
    
    while(1) { 
        char opcode = 0, r1 = 0, r2 = 0; //set read values to zero just in case 
        unsigned int subop = 0, immediate = 0, output = 0;
        
        char scanReturn = fscanf(inF, "%s",&temp); //analyse first string and branch into if statement 
        if (scanReturn != EOF) { 
            //printf("%s\n", temp);
            if (strcmp(temp, "SEG") == 0 || strcmp(temp, "seg") == 0) { //addressing
                int seg;
                char stringTemp[20];
                int address;
                fscanf(inF, " %x %s %x%*[^\n]\n", &seg, &stringTemp, &address);
                if (strcmp(stringTemp, "ADDRESS") != 0 && strcmp(stringTemp, "address") != 0) {
                    printf("SYNTAX ERROR: line %d\n", line);
                    exit(1);
                }
                output = (seg << 16)|address;
                fprintf(outF, "fafaf\n"); //address escape
                fprintf(outF, "%x\n", output);
                fprintf(outF, "afafa\n");
            }
            else if (strcmp(temp, "NOP") == 0 || strcmp(temp, "nop") == 0) { //NOP
                fprintf(outF, "%x\n", 0);
            }
            else if (strcmp(temp, "LDI") == 0 || strcmp(temp, "ldi") == 0) { //LDI
                opcode = LDI; //opcode 1
                fscanf(inF," %c %x%*[^\n]\n", &r1, &immediate); //get r1 and immediate
                r1 = getReg(r1, line);
                r2 = 0;
                subop = 0;
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "LDA") == 0 || strcmp(temp, "lda") == 0) { //LDA
                opcode = LDA; //opcode 2
                fscanf(inF, " %c %c %x %x%*[^\n]\n", &r1, &r2, &subop, &immediate);
                testSubop(subop, line);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "STA") == 0 || strcmp(temp, "sta") == 0) {
                opcode = STA; //opcode 3
                fscanf(inF, " %c %c %x %x%*[^\n]\n", &r1, &r2, &subop, &immediate);
                testSubop(subop, line);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "GOTO") == 0 || strcmp(temp, "goto") == 0) {
                opcode = GOTO; //opcode 4
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFC") == 0 || strcmp(temp, "jumpifc") == 0) {
                opcode = JUMPIFC; //opcode 5
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFNC") == 0 || strcmp(temp, "jumpifnc") == 0) {
                opcode = JUMPIFNC; //opcode 6
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFN") == 0 || strcmp(temp, "jumpifn") == 0) {
                opcode = JUMPIFN; //opcode 7
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFNN") == 0 || strcmp(temp, "jumpifnn") == 0) {
                opcode = JUMPIFNN; //opcode 8
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFZ") == 0 || strcmp(temp, "jumpifz") == 0) {
                opcode = JUMPIFZ; //opcode 9
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFNZ") == 0 || strcmp(temp, "jumpifnz") == 0) {
                opcode = JUMPIFNZ; //opcode 10
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFP") == 0 || strcmp(temp, "jumpifp") == 0) {
                opcode = JUMPIFP; //opcode 11
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "JUMPIFNP") == 0 || strcmp(temp, "jumpifnp") == 0) {
                opcode = JUMPIFNP; //opcode 12
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "GSR") == 0 || strcmp(temp, "gsr") == 0) {
                opcode = GSR; //opcode 13
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "RSR") == 0 || strcmp(temp, "rsr") == 0) {
                opcode = RSR; //opcode 14
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "INT") == 0 || strcmp(temp, "int") == 0) {
                opcode = INT; //opcode 15
                fscanf(inF, " %x%*[^\n]\n", &subop);
                testSubop(subop, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "MOV") == 0 || strcmp(temp, "mov") == 0) {
                opcode = MOV; //opcode 16
                fscanf(inF, " %c %c%*[^\n]\n", &r1, &r2);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "PUSH") == 0 || strcmp(temp, "push") == 0) {
                opcode = PUSH; //opcode 17
                fscanf(inF, " %c%*[^\n]\n", &r1);
                r1 = getReg(r1, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "POP") == 0 || strcmp(temp, "pop") == 0) {
                opcode = POP; //opcode 18
                fscanf(inF, " %c%*[^\n]\n", &r1);
                r1 = getReg(r1, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "ADD") == 0 || strcmp(temp, "add") == 0) {
                opcode = ADD; //opcode 19
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "ADC") == 0 || strcmp(temp, "adc") == 0) {
                opcode = ADC; //opcode 20
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "SUB") == 0 || strcmp(temp, "sub") == 0) {
                opcode = SUB; //opcode 21
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "SBB") == 0 || strcmp(temp, "sbb") == 0) {
                opcode = SBB; //opcode 22
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "AND") == 0 || strcmp(temp, "and") == 0) {
                opcode = AND; //opcode 23
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "OR") == 0 || strcmp(temp, "or") == 0) {
                opcode = OR; //opcode 24
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "XOR") == 0 || strcmp(temp, "xor") == 0) {
                opcode = XOR; //opcode 25
                fscanf(inF, " %c %c %c%*[^\n]\n", &r1, &r2, &r3);
                r1 = getReg(r1, line);
                r2 = getReg(r2, line);
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "LSHIFT") == 0 || strcmp(temp, "lshift") == 0) {
                opcode = LSHIFT; //opcode 26
                fscanf(inF, " %c %c%*[^\n]\n", &r1, &r3);
                r1 = getReg(r1, line);
                r2 = 0; //only operates on one register
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "RSHIFT") == 0 || strcmp(temp, "rshift") == 0) {
                opcode = RSHIFT; //opcode 27
                fscanf(inF, " %c %c%*[^\n]\n", &r1, &r3);
                r1 = getReg(r1, line);
                r2 = 0;
                r3 = getReg(r3, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(r3 << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "LSG") == 0 || strcmp(temp, "lsg") == 0) {
                opcode = LSG; //opcode 29
                fscanf(inF, " %s %x%*[^\n]\n", &segR, &immediate);
                subop = getSr(segR, line);
                testSubop(subop, line);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "LSP") == 0 || strcmp(temp, "lsp") == 0) {
                opcode = LSP; //opcode 30
                fscanf(inF, " %x%*[^\n]\n", &immediate);
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "SETF") == 0 || strcmp(temp, "setf") == 0) {
                opcode = SETF;
                fscanf(inF, " %x%*[^\n]\n", &subop);
                if (subop > 11) {
                    printf("SYNTAX ERROR: line %d\n", line);
                    exit(1);
                }
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            else if (strcmp(temp, "HALT") == 0 || strcmp(temp, "halt") == 0) {
                opcode = HALT; //opcode 31
                output = (opcode << 27)|(r1 << 24)|(r2 << 21)|(subop << 16)|(immediate);
                fprintf(outF, "%x\n", output);
            }
            line++;
        }
        else {
            fclose(inF);
            fclose(outF);
            return;
        } 
    }
}

int main(int argc, char *argv[])
{
    reader(argv[1], argv[2]);
}