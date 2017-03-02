#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <conio.h>
#include <windows.h>

typedef uint32_t word;
typedef uint16_t halfword;
typedef uint8_t byte;

enum states {F, T};
enum operations {NONE, ADD, SUB, AND, OR, XOR, LSHIFT, RSHIFT, ADC, SBB};
enum registers {A, B, C, D, E, X, Y, Z};

//CPU memory
word memory[16][65536]; //16 segements of 64kB (1mB)

//data registers
halfword registers[8]; //all programmer-accessible registers except PC
/*
* [0] = A General-purpose
* [1] = B
* [2] = C
* [3] = D
* [4] = E
* [5] = X General-purpose, but ideally used for indexing
* [6] = Y
* [7] = Z 
*/

halfword PC; //Program Counter 
halfword SP; //Stack Pointer

typedef struct {
    byte RS; //ROM Segment Pointer (PC should use this) 
    byte MS; //RAM Segment Pointer (LDA/STA should use this)
    byte SS; //Stack Segment Pointer (SP should use this)
} segPointer; 

//flags 
typedef struct {
    uint8_t C; //carry
    uint8_t N; //negative
    uint8_t Z; //zero
    uint8_t P; //parity
    uint8_t I; //interrupt
} flag;

//inaccessible registers
//instruction fetch registers
typedef struct {
    byte opcode; //5 bits
    byte r1; //first register/value (3 bits)
    byte r2; //second register/value (3 bits)
    byte subop; //5 bits 
    halfword immediate; //second byte (if present) 
} wordSegment; 

//initalize wordSegments, segmentPointers and flags 
wordSegment wordSeg;
segPointer segment;
flag flags;

halfword RETURN[16]; //Return address call stack for subroutine calls
int8_t RP = 15; //call stack pointer 

word IR; //instruction register

uint64_t cycles;

byte halt;