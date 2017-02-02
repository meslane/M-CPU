#include "VMFuncts.h"

#define MAX 65535
#define MIN 0

void insert()
{
    memory[0][0] = 0xf8000000;
}

void fetch(void)
{
    IR = memory[segment.RS][PC++]; //get word at PC location
}

void decode()
{
    wordSeg.opcode = (IR >> 27)&0x1f; //highest 5 bits
    wordSeg.r1 = (IR >> 24)&0x07; //next 3 bits (src register usually)
    wordSeg.r2 = (IR >> 21)&0x07; //next 3 bits (dest register usually)
    wordSeg.subop = (IR >> 16)&0x1f; //next 5 bits
    wordSeg.immediate = IR&0xffff;
}

void execute(void)
{
    switch (wordSeg.opcode) {
        case 0: //NOP (no operation
            return;
            break;
        /* Addressing operation format:  
        *  [opcode] [r1 (register to load or store to/from RAM)]
        *  [r2 (register to use if mode == 2 or 3)] [subop (mode)]
        *  
        *  Addressing modes:
        *  0 = immediate (given address
        *  1 = r2
        *  2 = r2 + immediate
        */
        case 1: //LDI (load immediate)
            loadReg(wordSeg.r1, wordSeg.immediate);
            break;
        case 2: //LDA (load data at address to register)
            loadA(wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
            break;
        case 3: //STA (store data in register at address)
            storeA(wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
            break;
        case 4: //GOTO (jump to given value)
            gotoA(wordSeg.r2, wordSeg.subop, wordSeg.immediate);
            break;
        case 5: //JMPIF C (jump to immediate value if condition designated by subop is met)
            jumpif(wordSeg.immediate, flags, 0);
            break;
        case 6: //JMPIF NC (jump if not carry)
            jumpif(wordSeg.immediate, flags, 1);
            break;
        case 7: //JMPIF N (jump if negative)
            jumpif(wordSeg.immediate, flags, 2);
            break;
        case 8: //JMPIF NN (jump if not negative)
            jumpif(wordSeg.immediate, flags, 3);
            break;
        case 9: //JMPIF Z (jump if zero)
            jumpif(wordSeg.immediate, flags, 4);
            break;
        case 10: //JMPIF NZ (jump if not zero)
            jumpif(wordSeg.immediate, flags, 5);
            break;
        case 11: //JMPIF P (jump if parity)
            jumpif(wordSeg.immediate, flags, 6);
            break;
        case 12: //JMPIF NP (jump if not parity)
            jumpif(wordSeg.immediate, flags, 7);
            break;
        case 13: //GSR (goto to immediate value and store PC state in RETURN register)
            gotoSubroutine(wordSeg.immediate);
            break;
        case 14: //RSR (return from subroutine, restore PC from RETURN)
            returnFromSubroutine();
            break;
        case 15: //INT (call interrupt)
            interrupt(wordSeg.subop);
            break;
        case 16: //MOV (move r1 to r2)
            move(wordSeg.r1, wordSeg.r2);
            break;
        case 17: //PUSH (push value in register to stack)
            push(wordSeg.r1);
            break;
        case 18: //POP (pop topmost stack value into register)
            pop(wordSeg.r1);
            break;
        //ALU operations
        case 19: //ADD
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, ADD);
            break;
        case 20: //ADC (Add with carry)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, ADC);
            break;
        case 21: //SUB
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, SUB);
            break;
        case 22: //SBB (Sub wtih borrow)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, SBB);
            break;
        case 23: //AND
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, AND);
            break;
        case 24: //OR
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, OR);
            break;
        case 25: //XOR
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, XOR);
            break;
        case 26: //LSHIFT
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, LSHIFT);
            break;
        case 27: //RSHIFT
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, RSHIFT);
            break;
        case 28: //LSG (switch memory segment by loading memory segment register)
            ldSegment(wordSeg.subop, wordSeg.immediate);
            break;
        case 29: //LSP (set stack by loading stack pointer)
            loadSp(wordSeg.immediate);
            break;
        case 31: //HALT (halt CPU)
            halt = 1;
            break;
    }
}

void run(void)
{
    fetch(); 
    decode();
    execute();     
}

void prexec(void)
{
    //set segment pointers to start values
    segment.RS = 0;
    segment.MS = 8;
    segment.SS = 15;
}

int main(int argc, char *argv[])
{
    prexec();
    insert();
    while(halt == 0) {
        printf("%i, %i, %i, %i, %i\n", wordSeg.opcode, wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
        run();
    }
    printf("VM safely halted at PC %i\n", PC);
    printf("A:%i B:%i C:%i D:%i E:%i X:%i Y:%i AP:%i\n",registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7]);
    exit(0);
}