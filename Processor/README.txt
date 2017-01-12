Welcome to M-CPU!

Dependencies: 
Registers.h --> VM.h --> Display.h --> Reader.h --> VM.c
	

Programming the M-CPU:

The .mcpu file must have a number on every line that is to be read into memory:
Example:

WRONG:
--------------       
1 |25    
2 |81
3 |15
4 |160
5 |//not read by cpu
6 |//not read by cpu
7 |//not read bu cpu
8 |32 //real address of 5
9 |8 //real address of 6

RIGHT:
--------------
1 |25    
2 |81
3 |15
4 |160
5 |0 //0, read by cpu
6 |0
7 |0
8 |32
9 |8









