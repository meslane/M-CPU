#include "VMFuncts.h"

#define MAX 65535
#define MIN 0

char fetch(void)
{
	char WM; //one or two byte wordmode
	IR[0] = memory[PC++]; //get word at PC location
	if (((IR[0] >> 11)&0x1f) >= 0 && ((IR[0] >> 11)&0x1f) <= 5) { //if opcode designates a two-word instruction
		WM = 2; //tell decoder to store IR[1] in immediate
		IR[1] = memory[PC++];
	}
	return WM;
}

void decode(char WM)
{
	wordSeg.opcode = (IR[0] >> 11)&0x1f; //highest 5 bits
	wordSeg.r1 = (IR[0] >> 8)&0x07; //next 3 bits (src register usually)
	wordSeg.r2 = (IR[0] >> 5)&0x07; //next 3 bits (dest register usually)
	wordSeg.subop = IR[0]&0x1f; //last 5 bits
	
	if (WM == 2) { //if two-word instruction
		wordSeg.immediate = IR[1];
	}
}

void execute(void)
{
	switch (wordSeg.opcode) {
		case 0: //NOP
			return;
			break;
		case 1: //LDO (load operand)
			loadReg(wordSeg.r1, wordSeg.immediate);
			break;
		case 2: //LDA (load data at address to register)
			loadA(wordSeg.r1, wordSeg.immediate);
			break;
		case 3: //STA (store data in register at address)
			storeA(wordSeg.r1, wordSeg.immediate);
			break;
		case 4: //LDA R (load data at address pointed to by second register to first register)
			loadA(wordSeg.r1, wordSeg.r2);
			break;
		case 5: //STA R (store data in first register at address pointed to by second register)
			storeA(wordSeg.r1, wordSeg.r2);
			break;
		case 8: //GOTO (jump to given immediate value)
			jump(wordSeg.immediate);
			break;
		case 9: //GOTO R (jump to address in r2)
			jump(wordSeg.r2);
			break;
		case 11: //JMP (jump to immediate value if condition designated by subop is met)
			jumpif(wordSeg.immediate, wordSeg.subop, flags);
			break;
		case 12: //JMP R (jump to address specified by r2 if condition designated by subop is met)
			jumpif(wordSeg.r2, wordSeg.subop, flags);
			break;
		case 13: //MOV (move r1 to r2)
			move(wordSeg.r1, wordSeg.r2);
			break;
	}
}

void run(void)
{
	char wordmode = 1; //single or double word mode
	wordmode = fetch(); //get instruction word(s) and set wordmode for decode();
	decode(wordmode); //decode words(s) given perameter from fetch();
	execute();	 
}

int main(int argc, char *argv[])
{
	run();
	printf("%i,%i,%i,%i,%i\n", wordSeg.opcode, wordSeg.r1, wordSeg.r2, wordSeg.subop, wordSeg.immediate);
}