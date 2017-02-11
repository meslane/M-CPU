Welcome to M-CPU!

Instruction List:

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