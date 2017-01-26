#include "Registers.h"

void loadReg(byte rval, word address) //load register selected by r1 or r2 with immediate 
{
	registers[rval] = address; //set designated register equal to value
}

void loadA(byte rval, word address) //load register with data stored at immediate address
{
	word data;
	
	data = memory[address]; //get data at specified address
	
	registers[rval] = data; //set register equal to data at given address
}

void storeA(byte rval, word address) //store data in register at immediate address
{
	memory[address] = registers[rval]; //write data in designated register to address
}

word jump(word address) 
{
	PC = address; //jump to address
	return PC;
}

void jumpif(word address, byte mode, flag flags) //mode = subop, address = IR[1]
{
	//mode designates what branch if to execute 
	//address designates address to jump to if branch is not rejected 
	//flags are read to find condition
	switch (mode) {
		case 0: //Jump if overflow
			if (flags.O != 0) {
				jump(address);
			}
			break;
		case 1: // Jump if not overflow
			if (flags.O == 0) {
				jump(address);
			}
			break;
		case 2: //Jump if underflow
			if (flags.U != 0) {
				jump(address);
			}
			break;
		case 3: //Jump if not underflow
			if (flags.U == 0) {
				jump(address);
			}
			break;
		case 4: //Jump if zero
			if (flags.Z != 0) {
				jump(address);
			}
			break;
		case 5: //Jump if not zero
			if (flags.Z == 0) {
				jump(address);
			}
			break;
		case 6: //Jump if parity 
			if (flags.P != 0) {
				jump(address);
			}
			break;
		case 7: //Jump if not parity
			if (flags.P == 0) {
				jump(address);
			}
			break;
	}
}

void move(byte src, byte dest) //MOV (move r1 to r2)
{
	registers[dest] = registers[src];
}

