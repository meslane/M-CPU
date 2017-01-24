#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>

typedef unsigned short word;
typedef unsigned char byte;
enum states {F, T};

//CPU memory
unsigned short memory[65536];

//data registers
word registers[8];
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

//flags 
struct flag {
	char O; //overflow
	char U; //underflow
	char Z; //zero
	char P; //parity
	char I; //interrupt
};

word PC; //Program Counter

//inaccessible registers
//instruction fetch registers
word IR[1]; //two-word instruction register

char wordmode = 1;

byte opcode; //5 bits
byte r1; //first register/value (3 bits)
byte r2; //second register/value (3 bits)
byte subop; //5 bits 

word immediate; //second byte (if present) 