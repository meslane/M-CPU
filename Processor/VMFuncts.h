#include "read.h"
#include "VMerror.h"

word jump(halfword address) 
{
    PC = address;
    return PC;
}

void loadReg(byte rval, halfword immediate) //load register with immediate 
{
    registers[rval] = immediate; //set designated register equal to value
}

void loadA(byte r1, byte r2, byte subop, halfword immediate) //load register with data stored at immediate address
{
    switch(subop) {
        case 0:
            registers[r1] = memory[segment.MS][immediate]; //set r1 equal to data at immediate address
            break;
        case 1: 
            registers[r1] = memory[segment.MS][r2]; //set r1 equal to data at address in r2
            break;
        case 2:
            registers[r1] = memory[segment.MS][r2 + immediate]; //set r1 equal to data at address in r2 + immediate
            break;
    }
}

void storeA(byte r1, byte r2, byte subop, halfword immediate) //store data in register at immediate address
{
    switch(subop) {
        case 0:
            memory[segment.MS][immediate] = registers[r1]; //set memory address at immediate equal to r1's data
            break;
        case 1: 
            memory[segment.MS][r2] = registers[r1]; //set memory address at r2 equal to r1's data
            break;
        case 2:
            memory[segment.MS][r2 + immediate] = registers[r1]; //set memory address at r2 + immediate equal to r1's data
            break;
    }
}

void gotoA(byte r2, byte subop, halfword immediate) 
{
    switch(subop) {
        case 0:
            jump(immediate);
            break;
        case 1:
            jump(r2);
            break;
        case 2:
            jump(r2 + immediate);
            break;
    }
}

void jumpif(halfword immediate, char condition) //mode = subop, address = IR[1]
{
    //mode designates what branch if to execute 
    //address designates address to jump to if branch is not rejected 
    //flags are read to find condition
    switch (condition) {
        case 0: //Jump if carry
            if (flags.C != 0) {
                jump(immediate);
            }
            break;
        case 1: // Jump if not carry
            if (flags.C == 0) {
                jump(immediate);
            }
            break;
        case 2: //Jump if negative
            if (flags.N != 0) {
                jump(immediate);
            }
            break;
        case 3: //Jump if not negative
            if (flags.N == 0) {
                jump(immediate);
            }
            break;
        case 4: //Jump if zero
            if (flags.Z != 0) {
                jump(immediate);
            }
            break;
        case 5: //Jump if not zero
            if (flags.Z == 0) {
                jump(immediate);
            }
            break;
        case 6: //Jump if parity 
            if (flags.P != 0) {
                jump(immediate);
            }
            break;
        case 7: //Jump if not parity
            if (flags.P == 0) {
                jump(immediate);
            }
            break;
    }
}

void gotoSubroutine(halfword immediate)
{
    RETURN = PC; //store current PC state
    jump(immediate); //goto subroutine
}

void returnFromSubroutine(void)
{
    PC = RETURN; //restore return address to PC
}

void move(byte src, byte dest) //MOV (move r1 to r2)
{
    registers[dest] = registers[src];
}

void interrupt(byte line)
{
    if (flags.I == 0) {
        flags.I = 1; //prevent other interrupts from being called while servicing current one (must be set to 0 in code)
        word vector[] = {8, 16, 24, 32, 40, 48, 56, 64}; 
        RETURN = PC; //save PC state
        if (line < 9){ //if line is valid: go to designated vector
            jump(vector[line]);
        }
        else {
            error(1);
        }
    }
}

void push(byte r1) 
{
    SP--; //increase stack size to make room for new entry
    memory[segment.SS][SP] = registers[r1]; //set memory at SP location to value in given register
}

void pop(byte r1)
{
    registers[r1] = memory[segment.SS][SP]; //pop top stack entry into given register
    SP++; //decrease stack size to remove now-vacant entry
}

word ALU(byte r1, byte r2, byte r3, char operation) //r3 = subop
{
    int result;
    switch (operation) {
        case ADD: 
            result = registers[r1] + registers[r2];
            break;
        case SUB: 
            result = registers[r1] - registers[r2];
            break;
        case AND:
            result = registers[r1] & registers[r2];
            break;
        case OR:
            result = registers[r1] | registers[r2];
            break;
        case XOR: 
            result = registers[r1] ^ registers[r2];
            break;
        case LSHIFT:
            result = registers[r1] << 1;
            break;
        case RSHIFT:
            result = registers[r1] >> 1;
            break;
        case ADC: //add with carry 
            result = registers[r1] + registers[r2] + flags.C;
            break;
        case SBB: //subtract with borrow
            result = registers[r1] - (registers[r2] + flags.C);
            break;
    }
    
    if (result > 65535 || (operation == SUB && registers[r1] < registers[r2])) {
        flags.C = 1; //set carry flag if number is too big for 16 bits or if operation is SUB and A<B
    }
    if (result < 0) {
        flags.N = 1; //set negative flag if number is too small for 16 bits
    }
    if (result == 0) {
        flags.Z = 1; //set zero flag if number is zero
    }
    if (result%2 == 1) {
        flags.P = 1; //set parity flag if number is odd
    }

    if (r3 < 8) { //if register exists
        registers[r3] = (word)result; //cast to unsigned short and put in dest register
    }
    else {
        error(2);
    }
    
    return (halfword)result; //cast to unsigned short and return 
}

void ldSegment(byte subop, halfword immediate)
{
    if (immediate > 15) {
        error(6);
    }
    
    switch(subop) {
        case 0:
            segment.RS = immediate;
            break;
        case 1:
            segment.MS = immediate;
            break;
        case 2:
            segment.SS = immediate;
            break;
    }
}

void loadSp(halfword immediate)
{
    SP = immediate;
}

void setFlag(byte subop) 
{
    switch(subop) {
        case 0:
            flags.C = 0;
            flags.N = 0;
            flags.Z = 0;
            flags.P = 0;
            flags.I = 0;
            break;
        case 1:
            flags.C = 1;
            break;
        case 2: 
            flags.N = 1;
            break;
        case 3: 
            flags.Z = 1;
            break;
        case 4:
            flags.P = 1;
            break;
        case 5:
            flags.I = 1;
            break;
        case 6:
            flags.C = 0;
            break;
        case 7: 
            flags.N = 0;
            break;
        case 8: 
            flags.Z = 0;
            break;
        case 9:
            flags.P = 0;
            break;
        case 10:
            flags.I = 0;
            break;
        case 11:
            flags.C = 1;
            flags.N = 1;
            flags.Z = 1;
            flags.P = 1;
            flags.I = 1;
            break;
    }   
}