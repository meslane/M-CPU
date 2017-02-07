	.file	"vm.c"
	.comm	_memory, 4194304, 5
	.comm	_registers, 16, 2
	.comm	_PC, 2, 1
	.comm	_SP, 2, 1
	.comm	_wordSeg, 6, 2
	.comm	_segment, 3, 0
	.comm	_flags, 5, 2
	.comm	_RETURN, 2, 1
	.comm	_IR, 4, 2
	.comm	_halt, 1, 0
	.section .rdata,"dr"
LC0:
	.ascii "r\0"
	.align 4
LC1:
	.ascii "ERROR: ROM file not found in current directory\0"
LC2:
	.ascii "%x%*[^\12]\12\0"
	.text
	.globl	_reader
	.def	_reader;	.scl	2;	.type	32;	.endef
_reader:
LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$LC0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L2
	movl	$LC1, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L2:
	movl	$0, -16(%ebp)
	jmp	L3
L7:
	leal	-24(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC2, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fscanf
	cmpl	$0, -16(%ebp)
	jne	L4
	movl	-24(%ebp), %eax
	cmpl	$1028015, %eax
	jne	L5
	movl	$1, -16(%ebp)
	jmp	L4
L5:
	movsbl	-9(%ebp), %ecx
	movzwl	-12(%ebp), %edx
	movl	-24(%ebp), %eax
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	%eax, _memory(,%edx,4)
	movzwl	-12(%ebp), %eax
	addl	$1, %eax
	movw	%ax, -12(%ebp)
L4:
	cmpl	$1, -16(%ebp)
	jne	L3
	movl	-24(%ebp), %eax
	cmpl	$1028015, %eax
	je	L6
	movl	-24(%ebp), %eax
	cmpl	$719610, %eax
	je	L6
	movl	-24(%ebp), %eax
	shrl	$16, %eax
	movb	%al, -9(%ebp)
	movl	-24(%ebp), %eax
	movw	%ax, -12(%ebp)
	jmp	L3
L6:
	movl	-24(%ebp), %eax
	cmpl	$719610, %eax
	jne	L3
	movl	$0, -16(%ebp)
L3:
	movl	-20(%ebp), %eax
	movl	12(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L7
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE17:
	.section .rdata,"dr"
	.align 4
LC3:
	.ascii "ERROR FATAL: subop is not in defined range\0"
	.align 4
LC4:
	.ascii "ERROR FATAL: designated register does not exist\0"
	.align 4
LC5:
	.ascii "ERROR FATAL: attempt to write into ROM segment\0"
	.align 4
LC6:
	.ascii "ERROR FATAL: cannot push SP onto stack\0"
	.align 4
LC7:
	.ascii "ERROR FATAL: cannot pop stack value into SP\0"
	.align 4
LC8:
	.ascii "ERROR FATAL: nonexistent segment\0"
	.text
	.globl	_error
	.def	_error;	.scl	2;	.type	32;	.endef
_error:
LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %eax
	movb	%al, -12(%ebp)
	movzbl	-12(%ebp), %eax
	cmpl	$6, %eax
	ja	L9
	movl	L11(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L11:
	.long	L19
	.long	L12
	.long	L13
	.long	L14
	.long	L15
	.long	L16
	.long	L17
	.text
L12:
	movl	$LC3, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L13:
	movl	$LC4, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L14:
	movl	$LC5, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L15:
	movl	$LC6, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L16:
	movl	$LC7, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L17:
	movl	$LC8, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
L19:
	nop
L9:
	movzbl	-12(%ebp), %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE18:
	.globl	_jump
	.def	_jump;	.scl	2;	.type	32;	.endef
_jump:
LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movw	%ax, -4(%ebp)
	movzwl	-4(%ebp), %eax
	movw	%ax, _PC
	movzwl	_PC, %eax
	movzwl	%ax, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE19:
	.globl	_loadReg
	.def	_loadReg;	.scl	2;	.type	32;	.endef
_loadReg:
LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movb	%dl, -4(%ebp)
	movw	%ax, -8(%ebp)
	movzbl	-4(%ebp), %eax
	movzwl	-8(%ebp), %edx
	movw	%dx, _registers(%eax,%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE20:
	.globl	_loadA
	.def	_loadA;	.scl	2;	.type	32;	.endef
_loadA:
LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %ebx
	movl	12(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%bl, -8(%ebp)
	movb	%cl, -12(%ebp)
	movb	%dl, -16(%ebp)
	movw	%ax, -20(%ebp)
	movzbl	-16(%ebp), %eax
	cmpl	$1, %eax
	je	L25
	cmpl	$2, %eax
	je	L26
	testl	%eax, %eax
	je	L27
	jmp	L28
L27:
	movzbl	-8(%ebp), %eax
	movzbl	_segment+1, %edx
	movzbl	%dl, %ecx
	movzwl	-20(%ebp), %edx
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	_memory(,%edx,4), %edx
	movw	%dx, _registers(%eax,%eax)
	jmp	L24
L25:
	movzbl	-8(%ebp), %eax
	movzbl	_segment+1, %edx
	movzbl	%dl, %ecx
	movzbl	-12(%ebp), %edx
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	_memory(,%edx,4), %edx
	movw	%dx, _registers(%eax,%eax)
	jmp	L24
L26:
	movzbl	-8(%ebp), %eax
	movzbl	_segment+1, %edx
	movzbl	%dl, %edx
	movzbl	-12(%ebp), %ebx
	movzwl	-20(%ebp), %ecx
	addl	%ebx, %ecx
	sall	$16, %edx
	addl	%ecx, %edx
	movl	_memory(,%edx,4), %edx
	movw	%dx, _registers(%eax,%eax)
	nop
L24:
L28:
	nop
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE21:
	.globl	_storeA
	.def	_storeA;	.scl	2;	.type	32;	.endef
_storeA:
LFB22:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$16, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %ebx
	movl	12(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%bl, -8(%ebp)
	movb	%cl, -12(%ebp)
	movb	%dl, -16(%ebp)
	movw	%ax, -20(%ebp)
	movzbl	-16(%ebp), %eax
	cmpl	$1, %eax
	je	L31
	cmpl	$2, %eax
	je	L32
	testl	%eax, %eax
	je	L33
	jmp	L34
L33:
	movzbl	_segment+1, %eax
	movzbl	%al, %ecx
	movzwl	-20(%ebp), %edx
	movzbl	-8(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	%eax, _memory(,%edx,4)
	jmp	L30
L31:
	movzbl	_segment+1, %eax
	movzbl	%al, %ecx
	movzbl	-12(%ebp), %edx
	movzbl	-8(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	%eax, _memory(,%edx,4)
	jmp	L30
L32:
	movzbl	_segment+1, %eax
	movzbl	%al, %edx
	movzbl	-12(%ebp), %ecx
	movzwl	-20(%ebp), %eax
	addl	%eax, %ecx
	movzbl	-8(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	sall	$16, %edx
	addl	%ecx, %edx
	movl	%eax, _memory(,%edx,4)
	nop
L30:
L34:
	nop
	addl	$16, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE22:
	.globl	_gotoA
	.def	_gotoA;	.scl	2;	.type	32;	.endef
_gotoA:
LFB23:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	8(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movb	%cl, -4(%ebp)
	movb	%dl, -8(%ebp)
	movw	%ax, -12(%ebp)
	movzbl	-8(%ebp), %eax
	cmpl	$1, %eax
	je	L37
	cmpl	$2, %eax
	je	L38
	testl	%eax, %eax
	je	L39
	jmp	L40
L39:
	movzwl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L36
L37:
	movzbl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L36
L38:
	movzbl	-4(%ebp), %edx
	movzwl	-12(%ebp), %eax
	addl	%edx, %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	_jump
	nop
L36:
L40:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE23:
	.globl	_jumpif
	.def	_jumpif;	.scl	2;	.type	32;	.endef
_jumpif:
LFB24:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$12, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movw	%dx, -4(%ebp)
	movb	%al, -8(%ebp)
	movsbl	-8(%ebp), %eax
	cmpl	$7, %eax
	ja	L60
	movl	L44(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L44:
	.long	L43
	.long	L45
	.long	L46
	.long	L47
	.long	L48
	.long	L49
	.long	L50
	.long	L51
	.text
L43:
	movzbl	_flags, %eax
	testb	%al, %al
	je	L61
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L61
L45:
	movzbl	_flags, %eax
	testb	%al, %al
	jne	L62
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L62
L46:
	movzbl	_flags+1, %eax
	testb	%al, %al
	je	L63
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L63
L47:
	movzbl	_flags+1, %eax
	testb	%al, %al
	jne	L64
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L64
L48:
	movzbl	_flags+2, %eax
	testb	%al, %al
	je	L65
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L65
L49:
	movzbl	_flags+2, %eax
	testb	%al, %al
	jne	L66
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L66
L50:
	movzbl	_flags+3, %eax
	testb	%al, %al
	je	L67
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L67
L51:
	movzbl	_flags+3, %eax
	testb	%al, %al
	jne	L68
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L68
L61:
	nop
	jmp	L60
L62:
	nop
	jmp	L60
L63:
	nop
	jmp	L60
L64:
	nop
	jmp	L60
L65:
	nop
	jmp	L60
L66:
	nop
	jmp	L60
L67:
	nop
	jmp	L60
L68:
	nop
L60:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE24:
	.globl	_gotoSubroutine
	.def	_gotoSubroutine;	.scl	2;	.type	32;	.endef
_gotoSubroutine:
LFB25:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %eax
	movw	%ax, -4(%ebp)
	movzwl	_PC, %eax
	movw	%ax, _RETURN
	movzwl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_jump
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE25:
	.globl	_returnFromSubroutine
	.def	_returnFromSubroutine;	.scl	2;	.type	32;	.endef
_returnFromSubroutine:
LFB26:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movzwl	_RETURN, %eax
	movw	%ax, _PC
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE26:
	.globl	_move
	.def	_move;	.scl	2;	.type	32;	.endef
_move:
LFB27:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movb	%dl, -4(%ebp)
	movb	%al, -8(%ebp)
	movzbl	-8(%ebp), %eax
	movzbl	-4(%ebp), %edx
	movzwl	_registers(%edx,%edx), %edx
	movw	%dx, _registers(%eax,%eax)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE27:
	.globl	_interrupt
	.def	_interrupt;	.scl	2;	.type	32;	.endef
_interrupt:
LFB28:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$72, %esp
	movl	8(%ebp), %eax
	movb	%al, -44(%ebp)
	movzbl	_flags+4, %eax
	testb	%al, %al
	jne	L76
	movb	$1, _flags+4
	movl	$8, -40(%ebp)
	movl	$16, -36(%ebp)
	movl	$24, -32(%ebp)
	movl	$32, -28(%ebp)
	movl	$40, -24(%ebp)
	movl	$48, -20(%ebp)
	movl	$56, -16(%ebp)
	movl	$64, -12(%ebp)
	movzwl	_PC, %eax
	movw	%ax, _RETURN
	cmpb	$8, -44(%ebp)
	ja	L74
	movzbl	-44(%ebp), %eax
	movl	-40(%ebp,%eax,4), %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	_jump
	jmp	L76
L74:
	movl	$1, (%esp)
	call	_error
L76:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE28:
	.globl	_push
	.def	_push;	.scl	2;	.type	32;	.endef
_push:
LFB29:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movzwl	_SP, %eax
	subl	$1, %eax
	movw	%ax, _SP
	movzbl	_segment+2, %eax
	movzbl	%al, %ecx
	movzwl	_SP, %eax
	movzwl	%ax, %edx
	movzbl	-4(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	%eax, _memory(,%edx,4)
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE29:
	.globl	_pop
	.def	_pop;	.scl	2;	.type	32;	.endef
_pop:
LFB30:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movzbl	-4(%ebp), %eax
	movzbl	_segment+2, %edx
	movzbl	%dl, %ecx
	movzwl	_SP, %edx
	movzwl	%dx, %edx
	sall	$16, %ecx
	addl	%ecx, %edx
	movl	_memory(,%edx,4), %edx
	movw	%dx, _registers(%eax,%eax)
	movzwl	_SP, %eax
	addl	$1, %eax
	movw	%ax, _SP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE30:
	.globl	_ALU
	.def	_ALU;	.scl	2;	.type	32;	.endef
_ALU:
LFB31:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$52, %esp
	.cfi_offset 3, -12
	movl	8(%ebp), %ebx
	movl	12(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%bl, -28(%ebp)
	movb	%cl, -32(%ebp)
	movb	%dl, -36(%ebp)
	movb	%al, -40(%ebp)
	movsbl	-40(%ebp), %eax
	cmpl	$9, %eax
	ja	L80
	movl	L82(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L82:
	.long	L80
	.long	L81
	.long	L83
	.long	L84
	.long	L85
	.long	L86
	.long	L87
	.long	L88
	.long	L89
	.long	L90
	.text
L81:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L83:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L84:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	andl	%edx, %eax
	movzwl	%ax, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L85:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	orl	%edx, %eax
	movzwl	%ax, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L86:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	xorl	%edx, %eax
	movzwl	%ax, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L87:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	addl	%eax, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L88:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	shrw	%ax
	movzwl	%ax, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L89:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %eax
	addl	%eax, %edx
	movzbl	_flags, %eax
	movsbl	%al, %eax
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	jmp	L80
L90:
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	movzwl	%ax, %ecx
	movzbl	_flags, %eax
	movsbl	%al, %eax
	addl	%ecx, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -12(%ebp)
	nop
L80:
	cmpl	$65535, -12(%ebp)
	jg	L91
	cmpb	$2, -40(%ebp)
	jne	L92
	movzbl	-28(%ebp), %eax
	movzwl	_registers(%eax,%eax), %edx
	movzbl	-32(%ebp), %eax
	movzwl	_registers(%eax,%eax), %eax
	cmpw	%ax, %dx
	jnb	L92
L91:
	movb	$1, _flags
L92:
	cmpl	$0, -12(%ebp)
	jns	L93
	movb	$1, _flags+1
L93:
	cmpl	$0, -12(%ebp)
	jne	L94
	movb	$1, _flags+2
L94:
	movl	-12(%ebp), %eax
	cltd
	shrl	$31, %edx
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	L95
	movb	$1, _flags+3
L95:
	cmpb	$7, -36(%ebp)
	ja	L96
	movzbl	-36(%ebp), %eax
	movl	-12(%ebp), %edx
	movw	%dx, _registers(%eax,%eax)
	jmp	L97
L96:
	movl	$2, (%esp)
	call	_error
L97:
	movl	-12(%ebp), %eax
	movzwl	%ax, %eax
	addl	$52, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE31:
	.globl	_ldSegment
	.def	_ldSegment;	.scl	2;	.type	32;	.endef
_ldSegment:
LFB32:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movb	%dl, -12(%ebp)
	movw	%ax, -16(%ebp)
	cmpw	$15, -16(%ebp)
	jbe	L100
	movl	$6, (%esp)
	call	_error
L100:
	movzbl	-12(%ebp), %eax
	cmpl	$1, %eax
	je	L102
	cmpl	$2, %eax
	je	L103
	testl	%eax, %eax
	je	L104
	jmp	L105
L104:
	movzwl	-16(%ebp), %eax
	movb	%al, _segment
	jmp	L101
L102:
	movzwl	-16(%ebp), %eax
	movb	%al, _segment+1
	jmp	L101
L103:
	movzwl	-16(%ebp), %eax
	movb	%al, _segment+2
	nop
L101:
L105:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE32:
	.globl	_loadSp
	.def	_loadSp;	.scl	2;	.type	32;	.endef
_loadSp:
LFB33:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movw	%ax, -4(%ebp)
	movzwl	-4(%ebp), %eax
	movw	%ax, _SP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE33:
	.globl	_setFlag
	.def	_setFlag;	.scl	2;	.type	32;	.endef
_setFlag:
LFB34:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$4, %esp
	movl	8(%ebp), %eax
	movb	%al, -4(%ebp)
	movzbl	-4(%ebp), %eax
	cmpl	$11, %eax
	ja	L122
	movl	L110(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L110:
	.long	L109
	.long	L111
	.long	L112
	.long	L113
	.long	L114
	.long	L115
	.long	L116
	.long	L117
	.long	L118
	.long	L119
	.long	L120
	.long	L121
	.text
L109:
	movb	$0, _flags
	movb	$0, _flags+1
	movb	$0, _flags+2
	movb	$0, _flags+3
	movb	$0, _flags+4
	jmp	L108
L111:
	movb	$1, _flags
	jmp	L108
L112:
	movb	$1, _flags+1
	jmp	L108
L113:
	movb	$1, _flags+2
	jmp	L108
L114:
	movb	$1, _flags+3
	jmp	L108
L115:
	movb	$1, _flags+4
	jmp	L108
L116:
	movb	$0, _flags
	jmp	L108
L117:
	movb	$0, _flags+1
	jmp	L108
L118:
	movb	$0, _flags+2
	jmp	L108
L119:
	movb	$0, _flags+3
	jmp	L108
L120:
	movb	$0, _flags+4
	jmp	L108
L121:
	movb	$1, _flags
	movb	$1, _flags+1
	movb	$1, _flags+2
	movb	$1, _flags+3
	movb	$1, _flags+4
	nop
L108:
L122:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE34:
	.globl	_fetch
	.def	_fetch;	.scl	2;	.type	32;	.endef
_fetch:
LFB35:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movzbl	_segment, %eax
	movzbl	%al, %ecx
	movzwl	_PC, %eax
	leal	1(%eax), %edx
	movw	%dx, _PC
	movzwl	%ax, %eax
	sall	$16, %ecx
	movl	%ecx, %edx
	addl	%edx, %eax
	movl	_memory(,%eax,4), %eax
	movl	%eax, _IR
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE35:
	.globl	_decode
	.def	_decode;	.scl	2;	.type	32;	.endef
_decode:
LFB36:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movl	_IR, %eax
	shrl	$27, %eax
	movb	%al, _wordSeg
	movl	_IR, %eax
	shrl	$24, %eax
	andl	$7, %eax
	movb	%al, _wordSeg+1
	movl	_IR, %eax
	shrl	$21, %eax
	andl	$7, %eax
	movb	%al, _wordSeg+2
	movl	_IR, %eax
	shrl	$16, %eax
	andl	$31, %eax
	movb	%al, _wordSeg+3
	movl	_IR, %eax
	movw	%ax, _wordSeg+4
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE36:
	.globl	_execute
	.def	_execute;	.scl	2;	.type	32;	.endef
_execute:
LFB37:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$20, %esp
	.cfi_offset 3, -12
	movzbl	_wordSeg, %eax
	movzbl	%al, %eax
	cmpl	$31, %eax
	ja	L125
	movl	L128(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L128:
	.long	L160
	.long	L129
	.long	L130
	.long	L131
	.long	L132
	.long	L133
	.long	L134
	.long	L135
	.long	L136
	.long	L137
	.long	L138
	.long	L139
	.long	L140
	.long	L141
	.long	L142
	.long	L143
	.long	L144
	.long	L145
	.long	L146
	.long	L147
	.long	L148
	.long	L149
	.long	L150
	.long	L151
	.long	L152
	.long	L153
	.long	L154
	.long	L155
	.long	L156
	.long	L157
	.long	L158
	.long	L159
	.text
L129:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_loadReg
	jmp	L125
L130:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %ebx
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%ebx, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_loadA
	jmp	L125
L131:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %ebx
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%ebx, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_storeA
	jmp	L125
L132:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %ecx
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_gotoA
	jmp	L125
L133:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L134:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L135:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$2, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L136:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$3, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L137:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L138:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$5, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L139:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$6, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L140:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	$7, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L125
L141:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	_gotoSubroutine
	jmp	L125
L142:
	call	_returnFromSubroutine
	jmp	L125
L143:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %eax
	movl	%eax, (%esp)
	call	_interrupt
	jmp	L125
L144:
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_move
	jmp	L125
L145:
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%eax, (%esp)
	call	_push
	jmp	L125
L146:
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	%eax, (%esp)
	call	_pop
	jmp	L125
L147:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$1, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L148:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$8, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L149:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$2, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L150:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$9, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L151:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$3, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L152:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$4, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L153:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$5, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L154:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$6, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L155:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %ecx
	movzbl	_wordSeg+2, %eax
	movzbl	%al, %edx
	movzbl	_wordSeg+1, %eax
	movzbl	%al, %eax
	movl	$7, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ALU
	jmp	L125
L156:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %edx
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_ldSegment
	jmp	L125
L157:
	movzwl	_wordSeg+4, %eax
	movzwl	%ax, %eax
	movl	%eax, (%esp)
	call	_loadSp
	jmp	L125
L158:
	movzbl	_wordSeg+3, %eax
	movzbl	%al, %eax
	movl	%eax, (%esp)
	call	_setFlag
	jmp	L125
L159:
	movb	$1, _halt
	nop
	jmp	L125
L160:
	nop
L125:
	addl	$20, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE37:
	.globl	_run
	.def	_run;	.scl	2;	.type	32;	.endef
_run:
LFB38:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	8(%ebp), %eax
	movb	%al, -12(%ebp)
	cmpb	$0, -12(%ebp)
	jne	L162
	call	_fetch
	call	_decode
	call	_execute
	jmp	L164
L162:
	movzbl	-12(%ebp), %eax
	subl	$1, %eax
	movzbl	%al, %eax
	movl	%eax, (%esp)
	call	_interrupt
L164:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE38:
	.globl	_prexec
	.def	_prexec;	.scl	2;	.type	32;	.endef
_prexec:
LFB39:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	movb	$0, _segment
	movb	$9, _segment+1
	movb	$8, _segment+2
	nop
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE39:
	.section .rdata,"dr"
LC9:
	.ascii "VM safely halted at PC %i\12\0"
	.align 4
LC10:
	.ascii "A:%i B:%i C:%i D:%i E:%i X:%i Y:%i Z:%i SP:%i RS:%i MS:%i SS:%i C:%i N:%i Z:%i P:%i I:%i\12\0"
	.text
	.globl	_postexec
	.def	_postexec;	.scl	2;	.type	32;	.endef
_postexec:
LFB40:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	.cfi_offset 7, -12
	.cfi_offset 6, -16
	.cfi_offset 3, -20
	movzwl	_PC, %eax
	movzwl	%ax, %eax
	subl	$1, %eax
	movl	%eax, 4(%esp)
	movl	$LC9, (%esp)
	call	_printf
	movzbl	_flags+4, %eax
	movsbl	%al, %eax
	movl	%eax, %edx
	movzbl	_flags+3, %eax
	movsbl	%al, %eax
	movl	%eax, -28(%ebp)
	movzbl	_flags+2, %eax
	movsbl	%al, %ecx
	movl	%ecx, -32(%ebp)
	movzbl	_flags+1, %eax
	movsbl	%al, %ebx
	movl	%ebx, -36(%ebp)
	movzbl	_flags, %eax
	movsbl	%al, %esi
	movl	%esi, -40(%ebp)
	movzbl	_segment+2, %eax
	movzbl	%al, %edi
	movl	%edi, -44(%ebp)
	movzbl	_segment+1, %eax
	movzbl	%al, %eax
	movl	%eax, -48(%ebp)
	movzbl	_segment, %eax
	movzbl	%al, %ecx
	movl	%ecx, -52(%ebp)
	movzwl	_SP, %eax
	movzwl	%ax, %ebx
	movl	%ebx, -56(%ebp)
	movzwl	_registers+14, %eax
	movzwl	%ax, %esi
	movl	%esi, -60(%ebp)
	movzwl	_registers+12, %eax
	movzwl	%ax, %edi
	movl	%edi, -64(%ebp)
	movzwl	_registers+10, %eax
	movzwl	%ax, %edi
	movzwl	_registers+8, %eax
	movzwl	%ax, %esi
	movzwl	_registers+6, %eax
	movzwl	%ax, %ebx
	movzwl	_registers+4, %eax
	movzwl	%ax, %ecx
	movzwl	_registers+2, %eax
	movzwl	%ax, %eax
	movl	%eax, -68(%ebp)
	movzwl	_registers, %eax
	movzwl	%ax, %eax
	movl	%edx, 68(%esp)
	movl	-28(%ebp), %edx
	movl	%edx, 64(%esp)
	movl	-32(%ebp), %edx
	movl	%edx, 60(%esp)
	movl	-36(%ebp), %edx
	movl	%edx, 56(%esp)
	movl	-40(%ebp), %edx
	movl	%edx, 52(%esp)
	movl	-44(%ebp), %edx
	movl	%edx, 48(%esp)
	movl	-48(%ebp), %edx
	movl	%edx, 44(%esp)
	movl	-52(%ebp), %edx
	movl	%edx, 40(%esp)
	movl	-56(%ebp), %edx
	movl	%edx, 36(%esp)
	movl	-60(%ebp), %edx
	movl	%edx, 32(%esp)
	movl	-64(%ebp), %edx
	movl	%edx, 28(%esp)
	movl	%edi, 24(%esp)
	movl	%esi, 20(%esp)
	movl	%ebx, 16(%esp)
	movl	%ecx, 12(%esp)
	movl	-68(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$LC10, (%esp)
	call	_printf
	movl	$0, (%esp)
	call	_exit
	.cfi_endproc
LFE40:
	.globl	_testKeyboard
	.def	_testKeyboard;	.scl	2;	.type	32;	.endef
_testKeyboard:
LFB41:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movb	$0, -11(%ebp)
	call	_kbhit
	testl	%eax, %eax
	je	L168
	movzbl	_flags+4, %eax
	testb	%al, %al
	jne	L168
	call	__getch
	movw	%ax, -10(%ebp)
	cmpw	$0, -10(%ebp)
	je	L169
	cmpw	$224, -10(%ebp)
	jne	L170
L169:
	movb	$1, -11(%ebp)
	call	__getch
	movw	%ax, -10(%ebp)
L170:
	cmpw	$10, -10(%ebp)
	jne	L171
	movl	$10, _memory+3933180
	jmp	L172
L171:
	movzwl	-10(%ebp), %eax
	movl	%eax, _memory+3933180
L172:
	movl	$1, %eax
	jmp	L173
L168:
	movl	$0, %eax
L173:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE41:
	.section .rdata,"dr"
LC11:
	.ascii "CLS\0"
LC12:
	.ascii "============================\0"
	.text
	.globl	_display
	.def	_display;	.scl	2;	.type	32;	.endef
_display:
LFB42:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	_memory+3932416, %eax
	testl	%eax, %eax
	je	L175
	movl	_memory+3932412, %eax
	testl	%eax, %eax
	je	L175
	movl	_memory+3932416, %eax
	movl	%eax, (%esp)
	call	__putch
	movl	$0, _memory+3932416
L175:
	movl	_memory+3932420, %eax
	testl	%eax, %eax
	je	L177
	movl	$LC11, (%esp)
	call	_system
	movl	$LC12, (%esp)
	call	_puts
L177:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE42:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC13:
	.ascii "\12============================\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB43:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	call	___main
	call	_prexec
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_reader
	movl	$LC12, (%esp)
	call	_puts
L179:
	call	_testKeyboard
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	_run
	call	_display
	movzbl	_halt, %eax
	testb	%al, %al
	je	L179
	movl	$LC13, (%esp)
	call	_puts
	call	_postexec
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE43:
	.ident	"GCC: (GNU) 5.3.0"
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_fscanf;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_kbhit;	.scl	2;	.type	32;	.endef
	.def	__getch;	.scl	2;	.type	32;	.endef
	.def	__putch;	.scl	2;	.type	32;	.endef
	.def	_system;	.scl	2;	.type	32;	.endef
