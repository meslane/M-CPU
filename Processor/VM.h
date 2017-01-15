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
    * 4: Unused
    * 5: User-defined (unused)
    * 6: User-defined (unused)
    * 7: Interrupt Mask Flag
    */

    if (out % 2 == 1) { //Parity
        F = ((0 << F) | 1);
    } 
    if (out > MAX) { //Overflow
        F = ((1 << F) | 1);
    }
    if (out < MIN) { //Underflow
        F = ((2 << F) | 1);
    }
    if (out == 0) { //Zero
        F = ((3 << F) | 1);
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

unsigned char testBitZero(unsigned char byte, unsigned char nval)
{
    unsigned char out = (byte & nval);
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
    else {
        MAR = address;
        MDR = memory[MAR];
        *reg = MDR;
    }
} //because this is C after all

void writeData(unsigned short address, unsigned char reg) //write byte to address (2 incs)
{
    if (address < 16383) {
        jump(trap[0]);
    }
    else {
        MAR = address;
        MDR = reg;
        memory[MAR] = MDR;
    }
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
    
    if (IR[0] <= 127) { //get one byte
        WM = 1;
        return;
    }
    else if (IR[0] <= 192) { //get two bytes
        WM = 2;
        incPC();
        IR[1] = MDR;
        return;
    }
    else if (IR[0] > 192) { //get three bytes
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
    //One-byte operations
        case 0: //NOP
            return;
            break;
        case 1: //MOV ACC X (src, dest)
            X = *AP;
            break;
        case 2: //MOV ACC Y 
            Y = *AP;
            break;
        case 3: //MOV ACC Z
            Z = *AP;
            break;
        case 4: //MOV ACC F
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
        case 16: //MOV X B
            *BP = X;
            break;
        case 17: //MOV Y B
            *BP = Y;
            break;
        case 18: //MOV Z B
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
    //MORE MOV
        case 27: //MOV B A
            *AP = *BP;
            break;
        case 28: //MOV B X
            X = *BP;
            break;
        case 29: //MOV B Y
            Y = *BP;
            break;
        case 30: //MOV B Z
            Z = *BP;
            break;
    //HALT
        case 31: //HLT
            halt();
            break;
    //OTHER MOV
        case 32: //MOV IX PC
            PC = IX;
            break;
        case 33: //MOV PC IX
            IX = PC;
            break;
        case 34: //MOV IX SP
            SP = IX;
            break;
        case 35: //MOV SP IX
            IX = SP;
            break;
        case 36: //MOV IY PC
            PC = IY;
            break;
        case 37: //MOV PC IY
            IY = PC;
            break;
        case 38: //MOV IY SP
            SP = IY;
            break;
        case 39: //MOV SP IY
            IY = SP;
            break;
        case 40: //MOV IX IY
            IY = IX;
            break;
        case 41: //MOV IY IX
            IX = IY;
            break;
        case 42: //MOV PC SP
            SP = PC;
            break;
        case 43: //MOV SP PC
            PC = SP;
            break;
    //16 bit MOV
        case 44: //MOV FX IX
            IX = combine(F, X);
            break;
        case 45: //MOV YZ IX
            IX = combine(Y, Z);
            break;
        case 46: //MOV FX SP
            SP = combine(F, X);
            break;
        case 47: //MOV YZ SP
            SP = combine(Y, Z);
            break;
        case 48: //MOV FX PC
            PC = combine(F, X);
            break;
        case 49: //MOV YZ PC
            PC = combine(Y, Z);
            break;
        case 50: //MOV IX FX
            F = (IX >> 8)&0xff; //high 
            X = IX&0xff; //low
            break;
        case 51: //MOV IX YZ
            Y = (IX >> 8)&0xff;
            Z = IX&0xff;
            break;
        case 52: //MOV IY FX
            F = (IY >> 8)&0xff;
            X = IY&0xff;
            break;
        case 53: //MOV IY YZ
            Y = (IY >> 8)&0xff;
            Z = IY&0xff;
            break;
        case 54: //MOV SP FX
            F = (SP >> 8)&0xff;
            X = SP&0xff;
            break;
        case 55: //MOV SP YZ
            Y = (SP >> 8)&0xff;
            Z = SP&0xff;
            break;
        case 56: //MOV PC FX
            F = (PC >> 8)&0xff;
            X = PC&0xff;
            break;
        case 57: //MOV PC YZ
            Y = (PC >> 8)&0xff;
            Z = PC&0xff;
            break;
    //STACK
        case 58: //PUSH ACC
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = *AP;
            break;
        case 59: //POP ACC
            *AP = memory[SP];
            SP++;
            break;
        case 60: //PUSH X
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = X;
            break;
        case 61: //POP X
            X = memory[SP];
            SP++;
            break;
        case 62: //PUSH Y
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = Y;
            break;
        case 63: //POP Y
            Y = memory[SP];
            SP++;
            break;
        case 64: //PUSH Z
            SP--;
            temp = spCheck();
            if (temp == 1) {
                break;
            }
            memory[SP] = Z;
            break;
        case 65: //POP Z
            Z = memory[SP];
            SP++;
            break;
    //INC
        case 66: //INC ACC
            (*AP)++;
            break;
        case 67: //INC HLD
            (*BP)++;
            break;
        case 68: //INC X
            X++;
            break;
        case 69: //INC Y
            Y++;
            break;
        case 70: //INC Z
            Z++;
            break;
        case 71: //INC IX
            IX++;
            break;
        case 72: //INC IY
            IY++;
            break;
    //DEC
        case 73: //DEC ACC
            (*AP)--;
            break;
        case 74: //DEC HLD
            (*BP)--;
            break;
        case 75: //DEC X
            X--;
            break;
        case 76: //DEC Y
            Y--;
            break;
        case 77: //DEC Z
            Z--;
            break;
        case 78: //DEC IX
            IX--;
            break;
        case 79: //DEC IY
            IY--;
            break;
    //BRANCHING
        case 80: //JMP
            jump(AH);
            break;
        case 81: //JMP P
            if (testBit(F, 0) != 0) {jump(AH);} //parity
            else {return;}
            break;
        case 82: //JMP O
            if (testBit(F, 1) != 0) {jump(AH);} //Overflow
            else {return;}
            break;
        case 83: //JMP U
            if (testBit(F, 2) != 0) {jump(AH);} //Underflow
            else {return;}
            break;
        case 84: //JMP Z
            if (testBit(F, 3) != 0) {jump(AH);} //Zero
            else {return;}
            break;
        case 85: //JMP UD1
            if (testBit(F, 5) != 0) {jump(AH);} //User-defined
            else {return;}
            break;
        case 86: //JMP UD2
            if (testBit(F, 6) != 0) {jump(AH);} //User-defined
            else {return;}
            break;
    //inverse conditional branching
        case 87: //JMP NP
            if (testBitZero(F, 1) == 0) {jump(AH);} //parity
            else {return;}
            break;
        case 88: //JMP NO
            if (testBitZero(F, 2) == 0) {jump(AH);} //Overflow
            else {return;}
            break;
        case 89: //JMP NU
            if (testBitZero(F, 4) == 0) {jump(AH);} //Underflow
            else {return;}
            break;
        case 90: //JMP NZ
            if (testBitZero(F, 8) == 0) {jump(AH);} //Zero
            else {return;}
            break;
        case 91: //JMP NUD1
            if (testBitZero(F, 32) == 0) {jump(AH);} //User-defined
            else {return;}
            break;
        case 92: //JMP NUD2
            if (testBitZero(F, 64) == 0) {jump(AH);} //User-defined
            else {return;}
            break;
    //Indexed addressing
        case 93: //IX MST ACC
            writeData(IX, *AP); //write to RAM
            break;
        case 94: //IX MLD ACC
            readData(IX, &*AP); //read from RAM
            break;
        case 95: //IX MST X
            writeData(IX, X); 
            break;
        case 96: //IX MLD X
            readData(IX, &X); 
            break;
        case 97: //IX MST Y
            writeData(IX, Y); 
            break;
        case 98: //IX MLD Y
            readData(IX, &Y); 
            break;
        case 99: //IX MST Z
            writeData(IX, Z); 
            break;
        case 100: //IX MLD Z
            readData(IX, &Z); 
            break;
        case 101: //IX MST F
            writeData(IX, F); 
            break;
        case 102: //IX MLD F
            readData(IX, &F); 
            break;
    //Index + Base addressing
        
        
        
        //two-byte instructions
        case 128: 
         
    }
}

void run() 
{
    fetch();
    decode();
    execute();
    incPC();
    jmpHld = 0;
    ticks++;
}