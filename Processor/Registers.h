#include <stdio.h>
#include <stdlib.h>

//Register File:
unsigned char A; //Accumulator 1
unsigned char AB; //Accumulator 2
unsigned char *AP; //accumulator pointer (software only)
unsigned char *BP; //non-accucumulating pointer (software only)
//general-purpose registers
unsigned char X; 
unsigned char Y;
unsigned char Z;
unsigned char F; //FLAGs
unsigned short PC; //Program Counter
//memory registers
unsigned char MDR; 
unsigned short MAR;
unsigned short SP; //Stack Pointer
//Index Register
unsigned short IX;
unsigned short IY;
//Control Registers
unsigned char IR[2]; //Instruction register
unsigned short AH; //Address Hold
unsigned char FETCH; //operand hold
char WM; //1, 2, or 3 byte word mode 

char jmpHld = 0; //jump hold buffer

long ticks;

void registerDump() //prints the data in programmer accessable registers 
{
    printf("A:%d|AB:%d|X:%d|Y:%d|Z:%d|F:%d|SP:%d|IX:%d|PC:%d|Ticks:%d|\r", A, AB, X, Y, Z, F, SP, IX, PC, ticks);
}