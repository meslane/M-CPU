#include "Registers.h"

#define MAX 255
#define MIN 0

/*
* 0 - 16383 = EEPROM
* 16384 - 32767 = RAM
* 32000 - 32015 = OUTPUT
* 32016 - 65535 = UNUSED
*/
unsigned char memory[65535];
unsigned short trap[] = {0x08, 0x10, 0x18, 0x20}; //0 = Bad Address, 1 = Stack Overflow
unsigned short vector[] = {0x28, 0x30, 0x38, 0x40, 0x48, 0x50, 0x58, 0x60};

enum operations {NONE, ADD, SUB, AND, OR, XOR, NOT}; 

unsigned char ALU(unsigned char a, unsigned char b, char opcode) //arithmetic logic unit
{
    int out = MIN;
    
    switch(opcode) {
        case 1:
            out = a + b; //ADD
            break;
        case 2:
            out = a - b; //SUB
            break;
        case 3:
            out = a & b; //AND
            break;
        case 4:
            out = a | b; //OR
            break;
        case 5:
            out = a ^ b; //XOR
            break;
        case 6:
            out = ~a; //NOT
            break;
    }
   
   //conditional branching
    /*FLAGS:
    * 1 = true, 0 = false
    * Byte: |7|6|5|4|3|2|1|0|
    * 0: Parity
    * 1: Overflow
    * 2: Underflow
    * 3: Zero
    * 4: Clear Bit
    * 5: User-defined (unused)
    * 6: User-defined (unused)
    * 7: Interrupt Mask Flag
    */
    
    if ((F << 4) == 0) { //Clear Bit check
        F = 0;
    } 
    
    if (out % 2 == 1) { //Parity
        F = ((F << 0) | 1);
    } 
    if (out > MAX) { //Overflow
        F = ((F << 1) | 1);
    }
    if (out < MIN) { //Underflow
        F = ((F << 2) | 1);
    }
    if (out == 0) { //Zero
        F = ((F << 3) | 1);
    }

    //Overflow Handling
    if (out > MAX) {out = MAX;} 
    else if (out < MIN) {out = MIN;}
    
    return (unsigned char) out;
}

char testBit(unsigned char byte, char n)
{
    char out = byte & (1 << n);
    return out;
}

//Accumulator Handling
void assignAccumulator(char acc) {
    if (acc == 1) {
        AP = &A;
        BP = &AB;
    }
    else if (acc == 2) {
        AP = &AB;
        BP = &A;
    }
    else {
        AP = &A;
        BP = &AB;
    }
}

void jump(unsigned short address) //Jump PC to given address
{
    PC = address - 1;
    MDR = memory[PC];
}

//functions
void readData(unsigned short address, unsigned char *reg) { //new and improve getData with pointer
    if (address < 16383) {
        jump(trap[0]);
    }
    MAR = address;
    MDR = memory[MAR];
    *reg = MDR;
} //because this is C after all

void writeData(unsigned short address, unsigned char reg) //write byte to address (2 incs)
{
    if (address < 16383) {
        jump(trap[0]);
    }
    MAR = address;
    MDR = reg;
    memory[MAR] = MDR;
}

void spCheck() 
{
    if (SP <= 16384) {
        jump(trap[1]);
    }
}

void incPC() //increment PC and put info into MDR
{
    PC++;
    MDR = memory[PC];
}

void halt() 
{
    printf("\n\nCPU Safely halted at PC %d\n", PC);
    getch();
    exit(0);
}

void errorHalt(int flag) 
{
    printf("\n\nCPU Unsafely halted at PC %d with error code %d\n", PC, flag);
    getch();
    exit(flag);
}

/*
* INSTRUCTION HANDLING:
* Addressing: 24-bit word: stops at 3 fetch cycles
* Non-addressing: 16-bit word: stops at 2 fetch cycles
* Non-operand: 8-bit word: stops at 1 fetch cycle
*/

//instruction functions
void fetch() //instruction fetch function
{
    if (PC == 0) {
        MDR = memory[PC];
    } 
    
    IR[0] = MDR;
    
    if (IR[0] <= 31 | IR[0] >= 128) { //get one byte
        WM = 1;
        return;
    }
    else if (IR[0] <= 63) { //get two bytes
        WM = 2;
        incPC();
        IR[1] = MDR;
        return;
    }
    else if (IR[0] >= 64) { //get three bytes
        WM = 3;
        incPC();
        IR[1] = MDR;
        incPC();
        IR[2] = MDR;
        return;
    }
}

void decode() //decode stage
{   
    switch(WM) {
        case 1:
            return;
            break;
        case 2:
            FETCH = IR[1];
            break;
        case 3:
            AH = ((short)(IR[1] << 8) | IR[2]);
            break;
    }
}

void execute() //execute stage
{
    switch (IR[0]) {
        //one byte instructions
        case 0: //NOP
            return;
            break;
        case 1: //MOV AX (src, dest)
            X = *AP;
            break;
        case 2: //MOV AY 
            Y = *AP;
            break;
        case 3: //MOV AZ
            Z = *AP;
            break;
        case 4: //MOV AF
            F = *AP;
            break;
        case 5: //ACC X
            *AP = X;
            break;
        case 6: //MOV XY
            Y = X;
            break;
        case 7: //MOV XZ
            Z = X;
            break;
        case 8: //ACC Y
            *AP = Y;
            break;
        case 9: //MOV YX
            X = Y;
            break;
        case 10: //MOV YZ
            Z = Y;
            break;
        case 11: //ACC Z
            *AP = Z;
            break;
        case 12: //MOV ZX
            X = Z;
            break;
        case 13: //MOV ZY
            Y = Z;
            break;
        case 14: //ACC F
            *AP = F;
            break;
        case 15: //UNUSED
            return;
            break;
        case 16: //TLD X
            *BP = X;
            break;
        case 17: //TLD Y
            *BP = Y;
            break;
        case 18: //TLD Z
            *BP = Z;
            break;
        //ALU Operations
        case 19: //ADD
            *AP = ALU(*AP, *BP, ADD);
            break;
        case 20: //SUB
            *AP = ALU(*AP, *BP, SUB);
            break;
        case 21: //AND
            *AP = ALU(*AP, *BP, AND);
            break;
        case 22: //OR
            *AP = ALU(*AP, *BP, OR);
            break;
        case 23: //XOR
            *AP = ALU(*AP, *BP, XOR);
            break;
        case 24: //NOT
            *AP = ALU(*AP, *BP, NOT);
            break;
        //Accumulator Switching
        case 25: //SET A
            assignAccumulator(1);
            break;
        case 26: //SET AB
            assignAccumulator(2);
            break;
        case 27: //MOV TEMP A
            *AP = *BP;
            break;
        case 28: //MOV TEMP X
            X = *BP;
            break;
        case 29: //MOV TEMP Y
            Y = *BP;
            break;
        case 30: //MOV TEMP Z
            Z = *BP;
            break;
        case 31: //HLT
            halt();
            break;
        //two byte instructions
        //Loading
        case 32: //LD A
            *AP = FETCH;
            break;
        case 33: //LD X
            X = FETCH;
            break;
        case 34: //LD Y
            Y = FETCH;
            break;
        case 35: //LD Z
            Z = FETCH;
            break;
        case 36: //LD F
            F = FETCH;
            break;
        //Interrupts (software and hardware)
        /*Vectors:
        * 0: 0x08
        * 1: 0x10
        * 2: 0x18
        * 3: 0x20
        * 4: 0x28
        * 5: 0x30
        * 6: 0x38
        * 7: 0x40
        */
        case 37: //INT 0
            if (testBit(F, 7) == 0) {
                jump(vector[0]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[0]);
                }
            }
            break;
        
        case 38: //INT 1
            if (testBit(F, 7) == 0) {
                jump(vector[1]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[1]);
                }
            }
            break;
        
        case 39: //INT 2
            if (testBit(F, 7) == 0) {
                jump(vector[2]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[2]);
                }
            }
            break;
        
        case 40: //INT 3
            if (testBit(F, 7) == 0) {
                jump(vector[3]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[3]);
                }
            }
            break;
        
        case 41: //INT 4
            if (testBit(F, 7) == 0) {
                jump(vector[4]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[4]);
                }
            }
            break;
        
        case 42: //INT 5
            if (testBit(F, 7) == 0) {
                jump(vector[5]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[5]);
                }
            }
            break;
        
        case 43: //INT 6
            if (testBit(F, 7) == 0) {
                jump(vector[6]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[6]);
                }
            }
            break;
        
        case 44: //INT 7
            if (testBit(F, 7) == 0) {
                jump(vector[7]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) {
                    return;
                }
                else {
                    jump(vector[7]);
                }
            }
            break;
        //TRAPs 
        case 45: //TRP A
            jump(trap[0]);
            break;
        case 46: //TRP B
            jump(trap[1]);
            break;
        case 47: //TRP C
            jump(trap[2]);
            break;
        case 48: //TRP D
            jump(trap[3]);
            break;
        //end interrupts
        //three byte instructions //TODO; rename MMOV
        case 64: //WRI A
            writeData(AH, *AP);
            break;
        case 65: //REA A
            readData(AH, &*AP);
            break;
        case 66: //WRI X
            writeData(AH, X);
            break;
        case 67: //REA X
            readData(AH, &X);
            break;
        case 68: //WRI Y
            writeData(AH, Y);
            break;
        case 69: //REA Y
            readData(AH, &Y);
            break;
        case 70: //WRI Z
            writeData(AH, Z);
            break;
        case 71: //REA Z
            readData(AH, &Z);
            break;
        case 72: //WRI F
            writeData(AH, Z);
            break;
        case 73: //REA F
            readData(AH, &F);
            break;
        //Conditional Branching
        case 74: //JMP
            jump(AH);
            break;
        case 75: //JMP P
            if (testBit(F, 0) != 0) {jump(AH);}
            else {return;}
            break;
        case 76: //JMP O
            if (testBit(F, 1) != 0) {jump(AH);}
            else {return;}
            break;
        case 77: //JMP U
            if (testBit(F, 2) != 0) {jump(AH);}
            else {return;}
            break;
        case 78: //JMP Z
            if (testBit(F, 3) != 0) {jump(AH);}
            else {return;}
            break;
        case 79: //JMP UD1
            if (testBit(F, 5) != 0) {jump(AH);}
            else {return;}
            break;
        case 80: //JMP UD2
            if (testBit(F, 6) != 0) {jump(AH);}
            else {return;}
            break;
        //Stack
        case 81: //SETSTK
            SP = AH;
            spCheck();
            break;
        case 82: //PUSH A
            SP--;
            spCheck();
            memory[SP] = *AP;
            break;
        case 83: //POP A
            *AP = memory[SP];
            SP++;
            break;
        case 84: //PUSH X
            SP--;
            spCheck();
            memory[SP] = X;
            break;
        case 85: //POP X
            X = memory[SP];
            SP++;
            break;
        case 86: //PUSH Y
            SP--;
            spCheck();
            memory[SP] = Y;
            break;
        case 87: //POP Y
            Y = memory[SP];
            SP++;
            break;
        case 88: //PUSH Z
            SP--;
            spCheck();
            memory[SP] = Z;
            break;
        case 89: //POP Z
            Z = memory[SP];
            SP++;
            break;
        case 90: //JMP IX AH
            AH = IX + AH;
            jump(AH);
            break;
        //other addressing
        case 128: //LD IX //TODO: add other addressing modes
            IX = AH;
            break;
        case 129: //JMP IX
            jump(IX);
            break;
        case 130: //JMP IX A
            AH = IX + *AP;
            jump(AH);
            break;
        case 131: //JMP IX X
            AH = IX + X;
            jump(AH);
            break;
        case 132: //JMP IX Y
            AH = IX + Y;
            jump(AH);
            break;
        case 133: //JMP IX Z 
            AH = IX + Z;
            jump(AH);
            break;
        case 134: //MOV IX PC
            PC = IX - 1;
            break;
        case 135: //MOV IX PC
            IX = PC;
            break;
    }
}

void run() 
{
    fetch();
    decode();
    execute();
    incPC();
}