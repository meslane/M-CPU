Welcome to M-CPU!

INSTRUCTION LIST:
NOP: no operation
LDI: load immediate into register
LDA: load data from address into register
STA: store data in register at address
GOTO: jump to given address
JUMPIFC: jump to address if carry flag is set
JUMPIFNC: jump to address if carry flag is not set 
JUMPIFN: jump to address if negative flag is set 
JUMPIFNN: jump to address if negative flag is not set 
JUMPIFZ: jump to address if zero flag is set
JUMPIFNZ: jump to address if zero flag is not set
JUMPIFP: jump to address if parity flag is set
JUMPIFNP: jump to address if parity flag is not set 
GSR: goto subroutine
RSR: return from subroutine
INT: call interrupt
MOV: copy data in first register to second register 
PUSH: push data in register to stack
POP: pop top stack entry into register 
ADD: add two registers
ADC: add with carry 
SUB: subtract second register from first
SBB: subtract with borrow
AND: bitwise and 
OR: bitwise or
XOR: bitwise xor
LSHIFT: shift register left by one
RSHIFT: shift register right by one 
LSG: set segment register
LSP: set stack pointer
SETF: set flag(s)
HALT: halt vm 


REGISTERS:
The M-CPU has 8 general-puropse data registers:
(A, B, C, D, E, X, Y, Z)
A program counter:
(PC)
A stack pointer:
(SP)
A call stack pointer:
(RP) 
Three segment pointers:
(RS, MS, SS) 
An instruction register:
(IR)
And Five flags:
(C, N, Z, P, I)


MEMORY:
The M-CPU has 16 segments of 65536 words of memory, or 4 megabytes total.
Each segment pointer addresses a different segment to be used for different puropses.
However, multiple pointers CAN point to the same segment. 
Since each word is stored in a single memory location, the M-CPU has no defined endianness, but arrays are ideally big-endian while the stacks grow from the highest to lowest address.


THE STACKS:
The M-CPU has a stack in memory and a seperate isolated call stack for return addresses.
The call stack is only accessible via the GSR and RSR instructions, and can go 16 subroutine levels deep before overflowing.
If the call stack overflows, the M-CPU will raise an error and halt immediately.  
The general-purpose stack is accessed via the PUSH and POP instructions, can be used to hold any data and can occupy an entire segment (65536 addresses) before overflowing.
A stack overflow will raise an error, just as the call stack does.  


FLAGS:
The M-CPU has five flags, four of which are raised by the ALU and one of which is triggered by interrupt calls.
C: Carry flag, triggered if ALU output is > 65535
N: Negative flag, triggered if ALU output is > 0 
Z: Zero flag, triggered if ALU output == 0
P: Parity flag, triggered if ALU output is odd
I: Interrupt service flag, triggered on interrupt


ASSEMBLER:
The MASM (M-CPU assembler) assembles .masm files into .mcpu files that can be read by the M-CPU 
Syntax errors may cause the MASM to halt but often also result in undefined behavior that will not produce a helpful error message.


SETF CODES:
The SETF instruction uses a 0-11 subop code to set flags, the codes are as follows:
0: all flags = 0
1: C = 1
2: N = 1
3: Z = 1
4: P = 1
5: I = 1
6: C = 0
7: N = 0
8: Z = 0
9: P = 0
10: I = 0
11: all flags = 1


ADDRESSING MODES:
0 = immedate 
1 = register 2 
2 = register 2 + immediate 