#include "VMFuncts.h"

#define MAX 65535
#define MIN 0

void fetch(void)
{
    IR = memory[segment.RS][PC++]; //get word at PC location
}

void decode(void)
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
            interrupt(wordSeg.subop, flags);
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
        case 19: //ADD (Add r1 to r2 and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, ADD);
            break;
        case 20: //ADC (ADD with carry)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, ADC);
            break;
        case 21: //SUB (Subtract r2 from r1 and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, SUB);
            break;
        case 22: //SBB (SUB wtih borrow)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, SBB);
            break;
        case 23: //AND (AND r1 and r2 and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, AND);
            break;
        case 24: //OR (OR r1 and r2 and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, OR);
            break;
        case 25: //XOR (XOR r1 and r2 and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, XOR);
            break;
        case 26: //LSHIFT (Leftshift r1 by one bit and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, LSHIFT);
            break;
        case 27: //RSHIFT (Rightshift r1 by one bit and store in r3)
            ALU(wordSeg.r1, wordSeg.r2, wordSeg.subop, RSHIFT);
            break;
        //extra instructions
        case 28: //LSG (switch memory segment by loading memory segment pointers)
            ldSegment(wordSeg.subop, wordSeg.immediate);
            break;
        case 29: //LSP (set stack by loading stack pointer)
            loadSp(wordSeg.immediate);
            break;
        case 30: //SETF
            setFlag(wordSeg.subop, flags);
            break;
        case 31: //HALT (halt CPU)
            halt = 1;
            break;
    }
}

void run(char interruptStatus)
{
    if (interruptStatus == 0) {
        fetch(); 
        decode();
        execute();  
    }
    else {
        interrupt(interruptStatus-1, flags);
    }
}

void prexec(void)
{
    //set segment pointers to start values
    segment.RS = 0;
    segment.MS = 9;
    segment.SS = 8;
}

void postexec(void)
{
    printf("VM safely halted at PC %i\n", PC-1);
    printf("A:%i B:%i C:%i D:%i E:%i X:%i Y:%i Z:%i SP:%i RS:%i MS:%i SS:%i\n",registers[0],registers[1],registers[2],registers[3],registers[4],registers[5],registers[6],registers[7], SP, segment.RS, segment.MS, segment.SS);
    exit(0);
}

char testKeyboard(flag flags)
{
    unsigned short keypress;
    if (kbhit() && flags.I == 0){ //if key is pressed and interrupt is not being serviced 
		keypress = _getch(); //record keypress
        memory[15][255] = keypress;
        return 1; //0+1
	}
    else {
        return 0;
    }
}

void display(void)
{
    /*
    * 63 = output enable
    * 64 = data
    * 65 = clear
    */
    if (memory[15][64] != 0 && memory[15][63] != 0) {
        printf("%c", memory[15][64]);
        memory[15][64] = 0;
    }
    if (memory[15][65] != 0) {
        system("CLS");
        printf("============================\n");
    }
}

int main(int argc, char *argv[])
{
    char interrupt;
    prexec();
    reader();
    printf("============================\n");
    do {
        interrupt = testKeyboard(flags);
        run(interrupt);
        display();
        //printf("PC%i: %i, %i, %i, %i, %i\n", PC-1, wordSeg.opcode, wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
    } while(halt == 0);
    printf("\n============================\n");
    postexec();
}