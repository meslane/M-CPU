#include "VMFuncts.h"


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
	wordSeg.opcode = (IR[0] >> 11)&0x1f; //highest 5 bits
	wordSeg.r1 = (IR[0] >> 8)&0x07; //next 3 bits
	wordSeg.r2 = (IR[0] >> 5)&0x07; //next 3 bits
	wordSeg.subop = IR[0]&0x1f; //last 5 bits
	
	if (wordmode == 2) { //if two-word instruction
		wordSeg.immediate = IR[1];
		wordmode = 1; //reset for next instruction 
	}
}

void execute(void)
{
	switch (wordSeg.opcode) {
		case 0: //NOP
			return;
			break;
		case 1: //LDO (load operand)
			loadReg(wordSeg.r1);
			break;
		case 2: //LDA (load data at address to register)
			loadA(wordSeg.r1);
			break;
		case 3: //STA (store data in register at address)
			storeA(wordSeg.r1);
			break;
		case 4: //GOTO (jump to given immediate value)
			jump(wordSeg.immediate);
			break;
		case 5: //JUMPIF 
			break;
	}
}

void run(void)
{
	fetch();
	decode();
	execute();	
}

int main(int argc, char *argv[])
{
	run();
	printf("%i,%i,%i,%i,%i\n", wordSeg.opcode, wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
}