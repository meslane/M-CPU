#include "Registers.h"

word loadReg(byte rval) //load register selected by r1 or r2 with immediate 
{
	registers[rval] = IR[1]; //set designated register equal to value
}

word loadA(byte rval) //load register with data stored at immediate address
{
	word address;
	word data;
	
	address = IR[1]; //get address from IR
	
	data = memory[address]; //get data at specified address
	
	registers[rval] = data; //set register equal to data at given address
}


word storeA(byte rval) //store data in register at immediate address
{
	word address;
	address = IR[1];
	
	memory[address] = registers[rval]; //write data in designated register to address
}

word jump(word address) 
{
	PC = address; //jump to address
}

word jumpif(word address, byte mode, struct flag flags) //mode = subop, address = IR[1]
{
	//mode designates what branch if to execute 
	//address designates address to jump to if branch is not rejected 
	//flags are read to find condition
	switch (mode) {
		case 0: 
			break;
	}
}