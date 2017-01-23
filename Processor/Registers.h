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
word A; //accumulators
word B;

word X; //general-purpose
word Y;
word Z;

//flags 
struct flag {
	char O; //overflow
	char U; //underflow
	char Z; //zero
	char P; //parity
	char I; //interrupt
};

word IX; //Index registers
word IY; 
word SP; //Stack pointer

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