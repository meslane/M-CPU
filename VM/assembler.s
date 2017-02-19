	.file	"assembler.c"
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "SYNTAX ERROR: Invalid Subop, instruction %lu\12\0"
	.section	.text.unlikely,"x"
LCOLDB1:
LHOTB1:
	.def	_testSubop.part.1;	.scl	3;	.type	32;	.endef
_testSubop.part.1:
LFB31:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
	.cfi_endproc
LFE31:
LCOLDE1:
LHOTE1:
	.section .rdata,"dr"
	.align 4
LC2:
	.ascii "SYNTAX ERROR: Invalid Register, instruction %lu Given Value: %c\12\0"
	.section	.text.unlikely,"x"
LCOLDB3:
	.text
LHOTB3:
	.p2align 4,,15
	.globl	_getReg
	.def	_getReg;	.scl	2;	.type	32;	.endef
_getReg:
LFB25:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %edx
	leal	-65(%edx), %eax
	cmpb	$4, %al
	jbe	L5
	leal	-88(%edx), %eax
	cmpb	$2, %al
	jbe	L12
	leal	-97(%edx), %eax
	cmpb	$4, %al
	jbe	L5
	leal	-120(%edx), %eax
	cmpb	$2, %al
	jbe	L13
	movl	%edx, %eax
	andl	$-33, %eax
	cmpb	$78, %al
	je	L9
	cmpb	$48, %dl
	jne	L14
L9:
	xorl	%eax, %eax
L5:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L12:
	.cfi_restore_state
	leal	-83(%edx), %eax
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L13:
	.cfi_restore_state
	leal	-115(%edx), %eax
	jmp	L5
L14:
	movsbl	%dl, %eax
	movl	$LC2, (%esp)
	movl	%eax, 8(%esp)
	movl	36(%esp), %eax
	movl	%eax, 4(%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
	.cfi_endproc
LFE25:
	.section	.text.unlikely,"x"
LCOLDE3:
	.text
LHOTE3:
	.section .rdata,"dr"
LC4:
	.ascii "RS\0"
LC5:
	.ascii "rs\0"
LC6:
	.ascii "MS\0"
LC7:
	.ascii "ms\0"
LC8:
	.ascii "SS\0"
LC9:
	.ascii "ss\0"
	.section	.text.unlikely,"x"
LCOLDB10:
	.text
LHOTB10:
	.p2align 4,,15
	.globl	_getSr
	.def	_getSr;	.scl	2;	.type	32;	.endef
_getSr:
LFB26:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	movl	$LC4, %edi
	movl	12(%esp), %eax
	movl	$3, %ecx
	movl	%eax, %esi
	repz cmpsb
	je	L18
	movl	$LC5, %edi
	movl	$3, %ecx
	movl	%eax, %esi
	repz cmpsb
	je	L18
	movl	$LC6, %edi
	movl	$3, %ecx
	movl	%eax, %esi
	repz cmpsb
	je	L20
	movl	$LC7, %edi
	movl	$3, %ecx
	movl	%eax, %esi
	repz cmpsb
	je	L20
	movl	$LC8, %edi
	movl	$3, %ecx
	movl	%eax, %esi
	repz cmpsb
	je	L22
	movl	%eax, %esi
	movl	$LC9, %edi
	movl	$3, %ecx
	repz cmpsb
	seta	%dl
	setb	%al
	cmpb	%al, %dl
	jne	L15
L22:
	movl	$2, %eax
	jmp	L15
	.p2align 4,,10
L18:
	xorl	%eax, %eax
L15:
	popl	%esi
	.cfi_remember_state
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L20:
	.cfi_restore_state
	movl	$1, %eax
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE26:
	.section	.text.unlikely,"x"
LCOLDE10:
	.text
LHOTE10:
	.section	.text.unlikely,"x"
LCOLDB11:
	.text
LHOTB11:
	.p2align 4,,15
	.globl	_testSubop
	.def	_testSubop;	.scl	2;	.type	32;	.endef
_testSubop:
LFB27:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	cmpl	$2, 16(%esp)
	ja	L27
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
L27:
	.cfi_restore_state
	movl	20(%esp), %eax
	call	_testSubop.part.1
	.cfi_endproc
LFE27:
	.section	.text.unlikely,"x"
LCOLDE11:
	.text
LHOTE11:
	.section .rdata,"dr"
LC12:
	.ascii "r\0"
LC13:
	.ascii "w\0"
LC14:
	.ascii "%5120s\0"
LC15:
	.ascii "SEG\0"
LC16:
	.ascii "seg\0"
LC17:
	.ascii " %x %5120s %x%*[^\12]\12\0"
LC18:
	.ascii "ADDRESS\0"
LC19:
	.ascii "address\0"
	.align 4
LC20:
	.ascii "SYNTAX ERROR: instruction %lu\12\0"
LC21:
	.ascii "fafaf\12\0"
LC22:
	.ascii "%x\12\0"
LC23:
	.ascii "afafa\12\0"
LC24:
	.ascii "NOP\0"
LC25:
	.ascii "nop\0"
LC26:
	.ascii "LDI\0"
LC27:
	.ascii "ldi\0"
LC28:
	.ascii " %c %x%*[^\12]\12\0"
LC29:
	.ascii "LDA\0"
LC30:
	.ascii "lda\0"
LC31:
	.ascii " %c %c %x %x%*[^\12]\12\0"
LC32:
	.ascii "STA\0"
LC33:
	.ascii "sta\0"
LC34:
	.ascii "GOTO\0"
LC35:
	.ascii "goto\0"
LC36:
	.ascii " %x%*[^\12]\12\0"
LC37:
	.ascii "JUMPIFC\0"
LC38:
	.ascii "jumpifc\0"
LC39:
	.ascii "JUMPIFNC\0"
LC40:
	.ascii "jumpifnc\0"
LC41:
	.ascii "JUMPIFN\0"
LC42:
	.ascii "jumpifn\0"
LC43:
	.ascii "JUMPIFNN\0"
LC44:
	.ascii "jumpifnn\0"
LC45:
	.ascii "JUMPIFZ\0"
LC46:
	.ascii "jumpifz\0"
LC47:
	.ascii "JUMPIFNZ\0"
LC48:
	.ascii "jumpifnz\0"
LC49:
	.ascii "JUMPIFP\0"
LC50:
	.ascii "jumpifp\0"
LC51:
	.ascii "JUMPIFNP\0"
LC52:
	.ascii "jumpifnp\0"
LC53:
	.ascii "GSR\0"
LC54:
	.ascii "gsr\0"
LC55:
	.ascii "RSR\0"
LC56:
	.ascii "rsr\0"
LC57:
	.ascii "INT\0"
LC58:
	.ascii "int\0"
LC59:
	.ascii "MOV\0"
LC60:
	.ascii "mov\0"
LC61:
	.ascii " %c %c%*[^\12]\12\0"
LC62:
	.ascii "PUSH\0"
LC63:
	.ascii "push\0"
LC64:
	.ascii " %c%*[^\12]\12\0"
LC65:
	.ascii "POP\0"
LC66:
	.ascii "pop\0"
LC67:
	.ascii "ADD\0"
LC68:
	.ascii "add\0"
LC69:
	.ascii " %c %c %c%*[^\12]\12\0"
LC70:
	.ascii "ADC\0"
LC71:
	.ascii "adc\0"
LC72:
	.ascii "SUB\0"
LC73:
	.ascii "sub\0"
LC74:
	.ascii "SBB\0"
LC75:
	.ascii "sbb\0"
LC76:
	.ascii "AND\0"
LC77:
	.ascii "and\0"
LC78:
	.ascii "OR\0"
LC79:
	.ascii "or\0"
LC80:
	.ascii "XOR\0"
LC81:
	.ascii "xor\0"
LC82:
	.ascii "LSHIFT\0"
LC83:
	.ascii "lshift\0"
LC84:
	.ascii "RSHIFT\0"
LC85:
	.ascii "rshift\0"
LC86:
	.ascii "LSG\0"
LC87:
	.ascii "lsg\0"
LC88:
	.ascii " %5120s %x%*[^\12]\12\0"
LC89:
	.ascii "LSP\0"
LC90:
	.ascii "lsp\0"
LC91:
	.ascii "SETF\0"
LC92:
	.ascii "setf\0"
	.align 4
LC93:
	.ascii "SYNTAX ERROR: Invalid Flag Set, instruction %lu\12\0"
LC94:
	.ascii "HALT\0"
LC95:
	.ascii "halt\0"
	.section	.text.unlikely,"x"
LCOLDB96:
	.text
LHOTB96:
	.p2align 4,,15
	.globl	_reader
	.def	_reader;	.scl	2;	.type	32;	.endef
_reader:
LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	pushl	%edi
	.cfi_def_cfa_offset 12
	.cfi_offset 7, -12
	pushl	%esi
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushl	%ebx
	.cfi_def_cfa_offset 20
	.cfi_offset 3, -20
	subl	$1132, %esp
	.cfi_def_cfa_offset 1152
	movl	1152(%esp), %eax
	movl	$LC12, 4(%esp)
	leal	608(%esp), %ebx
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 40(%esp)
	movl	1156(%esp), %eax
	movl	$LC13, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	$1, 44(%esp)
	movl	%eax, %ebp
	.p2align 4,,10
L102:
	movl	40(%esp), %eax
	movl	%ebx, 8(%esp)
	movl	$LC14, 4(%esp)
	movb	$0, 96(%esp)
	movb	$0, 608(%esp)
	movl	%eax, (%esp)
	call	_fscanf
	cmpl	$-1, %eax
	je	L29
	movb	$0, 57(%esp)
	movb	$0, 58(%esp)
	movl	$LC15, %edi
	movb	$0, 59(%esp)
	movl	$0, 60(%esp)
	movl	$4, %ecx
	movl	$0, 64(%esp)
	movl	%ebx, %esi
	repz cmpsb
	je	L30
	movl	$LC16, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L30
	movl	$LC24, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L34
	movl	$LC25, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L34
	movl	$LC26, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L36
	movl	$LC27, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L36
	movl	$LC29, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L38
	movl	$LC30, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L38
	movl	$LC32, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L41
	movl	$LC33, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L42
L41:
	leal	64(%esp), %eax
	movl	$LC31, 4(%esp)
	movl	%eax, 20(%esp)
	leal	60(%esp), %eax
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	60(%esp), %esi
	movl	44(%esp), %eax
	cmpl	$2, %esi
	ja	L214
	movl	%eax, 4(%esp)
	movsbl	57(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movl	44(%esp), %eax
	sall	$24, %edi
	movl	%eax, 4(%esp)
	movsbl	58(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 58(%esp)
	movsbl	%al, %eax
	sall	$21, %eax
	orl	%edi, %eax
	orl	$402653184, %eax
	jmp	L210
	.p2align 4,,10
L30:
	leal	72(%esp), %eax
	movl	$LC17, 4(%esp)
	leal	76(%esp), %esi
	movl	$LC18, %edi
	movl	%eax, 16(%esp)
	leal	76(%esp), %eax
	movl	%eax, 12(%esp)
	leal	68(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	$8, %ecx
	repz cmpsb
	je	L32
	leal	76(%esp), %esi
	movl	$LC19, %edi
	movl	$8, %ecx
	repz cmpsb
	jne	L216
L32:
	movl	68(%esp), %esi
	movl	%ebp, 12(%esp)
	movl	$6, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC21, (%esp)
	sall	$16, %esi
	orl	72(%esp), %esi
	call	_fwrite
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	movl	%esi, 8(%esp)
	call	_fprintf
	movl	%ebp, 12(%esp)
	movl	$6, 8(%esp)
	movl	$1, 4(%esp)
	movl	$LC23, (%esp)
	call	_fwrite
L33:
	addl	$1, 44(%esp)
	jmp	L102
	.p2align 4,,10
L34:
	movl	$0, 8(%esp)
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	call	_fprintf
	jmp	L33
	.p2align 4,,10
L36:
	leal	64(%esp), %eax
	movl	$LC28, 4(%esp)
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	57(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 57(%esp)
	sall	$24, %eax
	movb	$0, 58(%esp)
	movl	$0, 60(%esp)
	orl	$134217728, %eax
L209:
	orl	64(%esp), %eax
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	movl	%eax, 8(%esp)
	call	_fprintf
	jmp	L33
	.p2align 4,,10
L38:
	leal	64(%esp), %eax
	movl	$LC31, 4(%esp)
	movl	%eax, 20(%esp)
	leal	60(%esp), %eax
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	60(%esp), %esi
	movl	44(%esp), %eax
	cmpl	$2, %esi
	ja	L214
	movl	%eax, 4(%esp)
	movsbl	57(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movl	44(%esp), %eax
	sall	$24, %edi
	movl	%eax, 4(%esp)
	movsbl	58(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 58(%esp)
	movsbl	%al, %eax
	sall	$21, %eax
	orl	%edi, %eax
	orl	$268435456, %eax
L210:
	sall	$16, %esi
	orl	64(%esp), %esi
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	orl	%esi, %eax
	movl	%eax, 8(%esp)
	call	_fprintf
	jmp	L33
	.p2align 4,,10
L29:
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	%ebp, (%esp)
	call	_fclose
	addl	$1132, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 20
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 16
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 12
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 8
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa_offset 4
	ret
L42:
	.cfi_restore_state
	movl	$LC34, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L44
	movl	$LC35, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L44
	movl	$LC37, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L46
	movl	$LC38, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L46
	movl	$LC39, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L48
	movl	$LC40, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L48
	movl	$LC41, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L50
	movl	$LC42, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L50
	movl	$LC43, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L52
	movl	$LC44, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L52
	movl	$LC45, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L54
	movl	$LC46, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L55
L54:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1207959552, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
	.p2align 4,,10
L44:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %edx
	movsbl	58(%esp), %eax
	sall	$24, %edx
	sall	$21, %eax
	orl	%edx, %eax
	orl	$536870912, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
L211:
	sall	$16, %eax
	orl	64(%esp), %eax
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	orl	%edx, %eax
	movl	%eax, 8(%esp)
	call	_fprintf
	jmp	L33
L46:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$671088640, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L48:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$805306368, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L50:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$939524096, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L216:
	movl	44(%esp), %eax
	movl	$LC20, (%esp)
	movl	%eax, 4(%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
L52:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1073741824, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L215:
	movl	44(%esp), %eax
L214:
	call	_testSubop.part.1
L55:
	movl	$LC47, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L56
	movl	$LC48, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L57
L56:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1342177280, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L57:
	movl	$LC49, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L58
	movl	$LC50, %edi
	movl	$8, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L59
L58:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1476395008, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L59:
	movl	$LC51, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L60
	movl	$LC52, %edi
	movl	$9, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L61
L60:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1610612736, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L61:
	movl	$LC53, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L62
	movl	$LC54, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L63
L62:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$1744830464, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L63:
	movl	$LC55, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L64
	movl	$LC56, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L65
L64:
	movl	$1879048192, 8(%esp)
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	call	_fprintf
	jmp	L33
L65:
	movl	$LC57, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L66
	movl	$LC58, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L67
L66:
	leal	60(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	60(%esp), %eax
	cmpl	$2, %eax
	ja	L215
	movsbl	57(%esp), %edx
	movl	%edx, %ecx
	movsbl	58(%esp), %edx
	sall	$24, %ecx
	sall	$21, %edx
	orl	%ecx, %edx
	orl	$2013265920, %edx
	jmp	L211
L67:
	movl	$LC59, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L69
	movl	$LC60, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L70
L69:
	leal	58(%esp), %eax
	movl	$LC61, 4(%esp)
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %edi
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 57(%esp)
	movl	%eax, %esi
	movsbl	58(%esp), %eax
	movl	%edi, 4(%esp)
	sall	$24, %esi
	movl	%eax, (%esp)
	call	_getReg
	movl	60(%esp), %ecx
	movsbl	%al, %edx
	movb	%al, 58(%esp)
	sall	$21, %edx
	movl	%esi, %eax
	movl	$LC22, 4(%esp)
	orl	%edx, %eax
	movl	%ebp, (%esp)
	sall	$16, %ecx
	orl	64(%esp), %ecx
	orl	$-2147483648, %eax
	orl	%ecx, %eax
	movl	%eax, 8(%esp)
	call	_fprintf
	jmp	L33
L70:
	movl	$LC62, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L71
	movl	$LC63, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L72
L71:
	leal	57(%esp), %eax
	movl	$LC64, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	57(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movsbl	58(%esp), %edx
	movb	%al, 57(%esp)
	sall	$24, %eax
	sall	$21, %edx
	orl	$-2013265920, %edx
	orl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L72:
	movl	$LC65, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L73
	movl	$LC66, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L74
L73:
	leal	57(%esp), %eax
	movl	$LC64, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	57(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movsbl	58(%esp), %edx
	movb	%al, 57(%esp)
	sall	$24, %eax
	sall	$21, %edx
	orl	$-1879048192, %edx
	orl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L74:
	movl	$LC67, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L75
	movl	$LC68, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L76
L75:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1744830464, %edx
L212:
	movsbl	%al, %eax
	sall	$16, %eax
	orl	%edx, %eax
	jmp	L209
L76:
	movl	$LC70, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L77
	movl	$LC71, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L78
L77:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1610612736, %edx
	jmp	L212
L78:
	movl	$LC72, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L79
	movl	$LC73, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L80
L79:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1476395008, %edx
	jmp	L212
L80:
	movl	$LC74, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L81
	movl	$LC75, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L82
L81:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1342177280, %edx
	jmp	L212
L82:
	movl	$LC76, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L83
	movl	$LC77, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L84
L83:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1207959552, %edx
	jmp	L212
L84:
	movl	$LC78, %edi
	movl	$3, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L85
	movl	$LC79, %edi
	movl	$3, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L86
L85:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-1073741824, %edx
	jmp	L212
L86:
	movl	$LC80, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L87
	movl	$LC81, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L88
L87:
	leal	59(%esp), %eax
	movl	$LC69, 4(%esp)
	movl	%eax, 16(%esp)
	leal	58(%esp), %eax
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %esi
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %edi
	movb	%al, 57(%esp)
	movsbl	58(%esp), %eax
	movl	%esi, 4(%esp)
	movl	%esi, 44(%esp)
	sall	$24, %edi
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 58(%esp)
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movsbl	59(%esp), %eax
	movl	%eax, (%esp)
	call	_getReg
	movl	%esi, %ecx
	movb	%al, 59(%esp)
	movsbl	%cl, %esi
	movl	%esi, %edx
	sall	$21, %edx
	orl	%edi, %edx
	orl	$-939524096, %edx
	jmp	L212
L88:
	movl	$LC82, %edi
	movl	$7, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L89
	movl	$LC83, %edi
	movl	$7, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L90
L89:
	leal	59(%esp), %eax
	movl	$LC61, 4(%esp)
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %edi
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 57(%esp)
	movsbl	59(%esp), %eax
	movl	%edi, 4(%esp)
	movb	$0, 58(%esp)
	sall	$24, %esi
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 59(%esp)
	movsbl	%al, %eax
	sall	$16, %eax
	orl	%esi, %eax
	orl	$-805306368, %eax
	jmp	L209
L90:
	movl	$LC84, %edi
	movl	$7, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L91
	movl	$LC85, %edi
	movl	$7, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L92
L91:
	leal	59(%esp), %eax
	movl	$LC61, 4(%esp)
	movl	%eax, 12(%esp)
	leal	57(%esp), %eax
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	movl	44(%esp), %edi
	movl	%edi, 4(%esp)
	movl	%eax, (%esp)
	call	_getReg
	movl	%eax, %esi
	movb	%al, 57(%esp)
	movsbl	59(%esp), %eax
	movl	%edi, 4(%esp)
	movb	$0, 58(%esp)
	sall	$24, %esi
	movl	%eax, (%esp)
	call	_getReg
	movb	%al, 59(%esp)
	movsbl	%al, %eax
	sall	$16, %eax
	orl	%esi, %eax
	orl	$-671088640, %eax
	jmp	L209
L92:
	movl	$LC86, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L93
	movl	$LC87, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L94
L93:
	leal	64(%esp), %eax
	leal	96(%esp), %esi
	movl	$LC88, 4(%esp)
	movl	%eax, 12(%esp)
	movl	40(%esp), %eax
	movl	%esi, 8(%esp)
	movl	%eax, (%esp)
	call	_fscanf
	movl	44(%esp), %eax
	movl	%esi, (%esp)
	movl	%eax, 4(%esp)
	call	_getSr
	movsbl	%al, %eax
	cmpl	$2, %eax
	movl	%eax, 60(%esp)
	ja	L215
	movsbl	57(%esp), %edx
	sall	$16, %eax
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	movl	%edx, %ecx
	movsbl	58(%esp), %edx
	sall	$24, %ecx
	sall	$21, %edx
	orl	%ecx, %edx
	orl	$-536870912, %edx
	orl	64(%esp), %edx
	orl	%eax, %edx
	movl	%edx, 8(%esp)
	call	_fprintf
	jmp	L33
L94:
	movl	$LC89, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L96
	movl	$LC90, %edi
	movl	$4, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L97
L96:
	leal	64(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movsbl	57(%esp), %eax
	sall	$24, %eax
	movl	%eax, %edx
	movsbl	58(%esp), %eax
	sall	$21, %eax
	orl	%edx, %eax
	orl	$-402653184, %eax
	movl	%eax, %edx
	movl	60(%esp), %eax
	jmp	L211
L97:
	movl	$LC91, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L98
	movl	$LC92, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L99
L98:
	leal	60(%esp), %eax
	movl	$LC36, 4(%esp)
	movl	%eax, 8(%esp)
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	movl	60(%esp), %eax
	cmpl	$11, %eax
	ja	L217
	movsbl	57(%esp), %edx
	movl	%edx, %ecx
	movsbl	58(%esp), %edx
	sall	$24, %ecx
	sall	$21, %edx
	orl	%ecx, %edx
	orl	$-268435456, %edx
	jmp	L211
L99:
	movl	$LC94, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	je	L101
	movl	$LC95, %edi
	movl	$5, %ecx
	movl	%ebx, %esi
	repz cmpsb
	jne	L33
L101:
	movl	$-134217728, 8(%esp)
	movl	$LC22, 4(%esp)
	movl	%ebp, (%esp)
	call	_fprintf
	jmp	L33
L217:
	movl	44(%esp), %eax
	movl	$LC93, (%esp)
	movl	%eax, 4(%esp)
	call	_printf
	movl	$1, (%esp)
	call	_exit
	.cfi_endproc
LFE28:
	.section	.text.unlikely,"x"
LCOLDE96:
	.text
LHOTE96:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section	.text.unlikely,"x"
LCOLDB97:
	.section	.text.startup,"x"
LHOTB97:
	.p2align 4,,15
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	andl	$-16, %esp
	subl	$16, %esp
	.cfi_offset 3, -12
	movl	12(%ebp), %ebx
	call	___main
	movl	8(%ebx), %eax
	movl	%eax, 4(%esp)
	movl	4(%ebx), %eax
	movl	%eax, (%esp)
	call	_reader
	xorl	%eax, %eax
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE29:
	.section	.text.unlikely,"x"
LCOLDE97:
	.section	.text.startup,"x"
LHOTE97:
	.ident	"GCC: (GNU) 5.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_fscanf;	.scl	2;	.type	32;	.endef
	.def	_fwrite;	.scl	2;	.type	32;	.endef
	.def	_fprintf;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
