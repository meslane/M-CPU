#include "Registers.h"


void fetch(void)
{
	IR[0] = memory[PC++]; //get word at PC location
	if (((IR[0] >> 11)&0x1f) >= 0 && ((IR[0] >> 11)&0x1f) <= 5) { //if opcode designates a two-word instruction
		wordmode = 2; //tell decoder to store IR[1] in immediate
		IR[1] = memory[PC++];
	}
}

void decode(void)
{
	opcode = (IR[0] >> 11)&0x1f;
	r1 = (IR[0] >> 8)&0x07;
	r2 = (IR[0] >> 5)&0x07;
	subop = IR[0]&0x1f;
	
	if (wordmode == 2) { //if two-word instruction
		immediate = IR[1];
		wordmode = 1; //reset for next instruction 
	}
}

void execute(void)
{

}

void run(void)
{
	fetch();
	decode();
	execute();	
}

int main(void)
{
	run();
	printf("%i,%i,%i,%i,%i\n", opcode, r1, r2, subop, immediate);
}