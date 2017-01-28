#include "VMFuncts.h"

#define MAX 65535
#define MIN 0

char fetch(void)
{
	char WM; //one or two byte wordmode
	IR[0] = memory[PC++]; //get word at PC location
	char op = ((IR[0] >> 11)&0x1f);
	if (op >= 0 && op <= 13) { //if opcode designates a two-word instruction
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
		//double-word opcodes
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
		case 7: //JMPIF N
			jumpif(wordSeg.immediate, flags, 2);
			break;
		case 8: //JMPIF NN
			jumpif(wordSeg.immediate, flags, 3);
			break;
		case 9: //JMPIF Z
			jumpif(wordSeg.immediate, flags, 4);
			break;
		case 10: //JMPIF NZ
			jumpif(wordSeg.immediate, flags, 5);
			break;
		case 11: //JMPIF P
			jumpif(wordSeg.immediate, flags, 6);
			break;
		case 12: //JMPIF NP
			jumpif(wordSeg.immediate, flags, 7);
			break;
		case 13: //GSR (goto to immediate value and store PC state in RETURN register)
			gotoSubroutine(wordSeg.immediate);
			break;
		//single-word opcodes
		case 14: //RSR (return from subroutine, restore PC from RETURN)
			returnFromSubroutine();
			break;
		case 15: //MOV (move r1 to r2)
			move(wordSeg.r1, wordSeg.r2);
			break;
		case 16: //PUSH (push value in register to stack)
			push(wordSeg.r1);
			break;
		case 17: //POP (pop topmost stack value into register)
			pop(wordSeg.r1);
			break;
		//TODO: add ALU operations 
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