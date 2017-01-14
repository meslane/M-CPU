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
    PC = address ;
    MDR = memory[PC];
    jmpHld = 1;
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

unsigned short combine(unsigned char a, unsigned char b) //high, low
{
    a = (unsigned short)a << 8;
    (unsigned short)b;
    
    unsigned char out;
    out = (a|b);
    return out;
}

char spCheck() 
{
    char a;
    if (SP <= 16384 | SP >= 32016) {
        jump(trap[1]);
        a = 1;
    }
    return a;
}

void incPC() //increment PC and put info into MDR
{
    if (jmpHld == 0) {
        PC++;
        MDR = memory[PC];
    }
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
    else if (IR[0] >= 64 && IR[0] <= 127) { //get three bytes
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
    char temp;
    switch (IR[0]) {
        //one byte instructions
        case 0: //NOP
            return;
            break;
        case 1: //MOV ACCX (src, dest)
            X = *AP;
            break;
        case 2: //MOV ACCY 
            Y = *AP;
            break;
        case 3: //MOV ACCZ
            Z = *AP;
            break;
        case 4: //MOV ACCF
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
        case 15: //UNUSED/NOP
            return;
            break;
        case 16: //HLD X
            *BP = X;
            break;
        case 17: //HLD Y
            *BP = Y;
            break;
        case 18: //HLD Z
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
        case 27: //ACC HLD
            *AP = *BP;
            break;
        case 28: //MOV HLD X
            X = *BP;
            break;
        case 29: //MOV HLD Y
            Y = *BP;
            break;
        case 30: //MOV HLD Z
            Z = *BP;
            break;
        case 31: //HLT
            halt();
            break;
        //two byte instructions
        //Loading
        case 32: //LD ACC
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
        case 37: //INT A
            if (testBit(F, 7) == 0) {
                jump(vector[0]);
            } 
            else if (testBit(F, 7) != 0) {
                if (FETCH >= 1) { //mask bit accept 
                    return;
                }
                else {
                    jump(vector[0]);
                }
            }
            break;
        
        case 38: //INT B
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
        
        case 39: //INT C
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
        
        case 40: //INT D
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
        
        case 41: //INT E
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
        
        case 42: //INT F
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
        
        case 43: //INT G
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
        
        case 44: //INT H
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
        //end interrupts------------
        //three byte instructions--------------
        case 64: //WMOV ACC 
            writeData(AH, *AP); //write to RAM
            break;
        case 65: //RMOV ACC
            readData(AH, &*AP); //read from RAM
            break;
        case 66: //WMOV X
            writeData(AH, X);
            break;
        case 67: //RMOV X
            readData(AH, &X);
            break;
        case 68: //WMOV Y
            writeData(AH, Y);
            break;
        case 69: //RMOV Y
            readData(AH, &Y);
            break;
        case 70: //WMOV Z
            writeData(AH, Z);
            break;
        case 71: //RMOV Z
            readData(AH, &Z);
            break;
        case 72: //WMOV F
            writeData(AH, Z);
            break;
        case 73: //RMOV F
            readData(AH, &F);
            break;
        case 74: //WMOV SP LOW (moves lowest byte of SP into memory)
            writeData(AH, SP&0xff);
            break;
        case 75: //WMOV SP HIGH (moves highest byte of SP into memory)
            writeData(AH, (SP >> 8)&0xff);
            break;
            //TODO: the other RMOVs for SP
        
        
        //Conditional Branching (Bits 4 and 7 are not used for branching)
        case 80: //JMP
            jump(AH);
            break;
        case 81: //JMP P
            if (testBit(F, 0) != 0) {jump(AH);}
            else {return;}
            break;
        case 82: //JMP O
            if (testBit(F, 1) != 0) {jump(AH);}
            else {return;}
            break;
        case 83: //JMP U
            if (testBit(F, 2) != 0) {jump(AH);}
            else {return;}
            break;
        case 84: //JMP Z
            if (testBit(F, 3) != 0) {jump(AH);}
            else {return;}
            break;
        case 85: //JMP UD1
            if (testBit(F, 5) != 0) {jump(AH);}
            else {return;}
            break;
        case 86: //JMP UD2
            if (testBit(F, 6) != 0) {jump(AH);}
            else {return;}
            break;
        case 87: //LD IX 
            IX = AH;
            break;
        case 88: //LD FX
            F = (AH >> 8)&0xff; //high
            X = AH&0xff; //low
            break;
        case 89: //LD YZ
            Y = (AH >> 8)&0xff;
            Z = AH&0xff;
            break;
        case 126: //JMP IX AH
            AH = IX + AH;
            jump(AH);
            break;
        case 127: //SETSTK
            SP = AH;
            spCheck();
            break;
        //end three byte instructions--------
        //other addressing (ONE BYTE)-------- //TODO; ADD IX CONDITIONAL BRANCHING
        case 128: //NOP
            return;
            break;
        case 129: //JMP IX
            jump(IX);
            break;
        case 130: //JMP IX ACC
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
        case 135: //MOV PC IX
            IX = PC;
            break;
        case 136: //MOV IX SP
            SP = IX;
            break;
        case 137: //MOV SP IX
            IX = SP;
            break;
        //Stack--------------
        case 138: //PUSH ACC
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = *AP;
            break;
        case 139: //POP ACC
            *AP = memory[SP];
            SP++;
            break;
        case 140: //PUSH X
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = X;
            break;
        case 141: //POP X
            X = memory[SP];
            SP++;
            break;
        case 142: //PUSH Y
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = Y;
            break;
        case 143: //POP Y
            Y = memory[SP];
            SP++;
            break;
        case 144: //PUSH Z
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = Z;
            break;
        case 145: //POP Z
            Z = memory[SP];
            SP++;
            break;
        //END STACK--------       
        //IX BRANCHING-----
        case 146: //IX JMP P
            if (testBit(F, 0) != 0) {jump(IX);}
            else {return;}
            break;
        case 147: //IX JMP O
            if (testBit(F, 1) != 0) {jump(IX);}
            else {return;}
            break;
        case 148: //IX JMP U
            if (testBit(F, 2) != 0) {jump(IX);}
            else {return;}
            break;
        case 149: //IX JMP Z
            if (testBit(F, 3) != 0) {jump(IX);}
            else {return;}
            break;
        case 150: //IX JMP UD1
            if (testBit(F, 5) != 0) {jump(IX);}
            else {return;}
            break;
        case 151: //IX JMP UD2
            if (testBit(F, 6) != 0) {jump(IX);}
            else {return;}
            break;
        //END IX BRANCHING
        //16 bit register stuff
        case 152: //MOV FX IX
            IX = combine(F, X);
            break;
        case 153: //MOV YZ IX
            IX = combine(Y, Z);
            break;
        case 154: //MOV FX SP
            SP = combine(F, X);
            break;
        case 155: //MOV YZ SP
            SP = combine(Y, Z);
            break;
        case 156: //MOV FX PC
            PC = combine(F, X);
            break;
        case 157: //MOV YZ PC
            PC = combine(Y, Z);
            break;
        case 158: //MOV IX FX
            F = (IX >> 8)&0xff; //high 
            X = IX&0xff; //low
            break;
        case 159: //MOV IX YZ
            Y = (IX >> 8)&0xff;
            Z = IX&0xff;
            break;
        case 160: //MOV SP FX
            F = (SP >> 8)&0xff;
            X = SP&0xff;
            break;
        case 161: //MOV SP YZ
            Y = (SP >> 8)&0xff;
            Z = SP&0xff;
            break;
        case 162: //MOV PC FX
            F = (PC >> 8)&0xff;
            X = PC&0xff;
            break;
        case 163: //MOV PC YZ
            Y = (PC >> 8)&0xff;
            Z = PC&0xff;
            break;
    }
}

void run() 
{
    fetch();
    decode();
    execute();
    incPC();
    jmpHld = 0;
}