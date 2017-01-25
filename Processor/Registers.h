#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>

//header file for all EVIL global variables needed to store VM values 

typedef unsigned short word;
typedef unsigned char byte;

enum states {F, T};
enum operations {NONE, ADD, SUB, AND, OR, XOR, LSHIFT, RSHIFT};

//CPU memory
unsigned short memory[65536];

//data registers
word registers[8]; //all programmer-accessible registers except PC
/*
* [0] = A Accumulators
* [1] = B
* [2] = X General-purpose
* [3] = Y
* [4] = Z
* [5] = IX Index registers
* [6] = IY
* [7] = SP Stack pointer
*/

word PC; //Program Counter 

//flags 
typedef struct {
	char O; //overflow
	char U; //underflow
	char Z; //zero
	char P; //parity
	char I; //interrupt
} flag;

//initalize flags
flag flags;

//inaccessible registers
//instruction fetch registers
typedef struct {
	byte opcode; //5 bits
	byte r1; //first register/value (3 bits)
	byte r2; //second register/value (3 bits)
	byte subop; //5 bits 

	word immediate; //second byte (if present) 
} wordSegment; 

//initalize wordSegments
wordSegment wordSeg;

word IR[1]; //two-word instruction register

char wordmode = 1;