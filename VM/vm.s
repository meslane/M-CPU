	.file	"vm.c"
	.section	.text.unlikely,"x"
LCOLDB0:
	.text
LHOTB0:
	.p2align 4,,15
	.def	_testKeyboard.part.3;	.scl	3;	.type	32;	.endef
_testKeyboard.part.3:
LFB59:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	__getch
	testw	%ax, %ax
	je	L6
	cmpw	$224, %ax
	movzwl	%ax, %edx
	je	L6
	cmpw	$10, %dx
	je	L12
L4:
	movl	%edx, _memory+3933180
	movl	$1, %eax
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L6:
	.cfi_restore_state
	call	__getch
	movzwl	%ax, %edx
	cmpw	$10, %dx
	jne	L4
L12:
	movl	$10, _memory+3933180
	movl	$1, %eax
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE59:
	.section	.text.unlikely,"x"
LCOLDE0:
	.text
LHOTE0:
	.section .rdata,"dr"
LC1:
	.ascii "r\0"
	.align 4
LC2:
	.ascii "ERROR FATAL: ROM file not found in current directory\0"
LC3:
	.ascii "%x%*[^\12]\12\0"
	.section	.text.unlikely,"x"
LCOLDB4:
	.text
LHOTB4:
	.p2align 4,,15
	.globl	_reader
	.def	_reader;	.scl	2;	.type	32;	.endef
_reader:
LFB29:
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
	subl	$60, %esp
	.cfi_def_cfa_offset 80
	movl	80(%esp), %eax
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	testl	%eax, %eax
	je	L14
	leal	44(%esp), %ebp
	movl	%eax, %esi
	xorl	%ebx, %ebx
	.p2align 4,,10
L15:
	movl	%ebp, 8(%esp)
	movl	$LC3, 4(%esp)
	movl	%esi, (%esp)
	call	_fscanf
	cmpl	$-1, %eax
	je	L13
	testl	%ebx, %ebx
	jne	L17
	movl	44(%esp), %ecx
	cmpl	$1028015, %ecx
	je	L22
	movsbl	16(%esp), %eax
	movzwl	%di, %edx
	addl	$1, %edi
	sall	$16, %eax
	addl	%edx, %eax
	movl	%ecx, _memory(,%eax,4)
	jmp	L15
	.p2align 4,,10
L17:
	movl	44(%esp), %eax
	cmpl	$719610, %eax
	setne	%dl
	cmpl	$1028015, %eax
	movzbl	%dl, %ebx
	je	L15
	testb	%dl, %dl
	je	L15
	movl	%eax, %edi
	movl	$1, %ebx
	shrl	$16, %edi
	movl	%edi, 16(%esp)
	movl	%eax, %edi
	jmp	L15
	.p2align 4,,10
L22:
	movl	$1, %ebx
	jmp	L15
	.p2align 4,,10
L13:
	addl	$60, %esp
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
L14:
	.cfi_restore_state
	movl	$LC2, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.cfi_endproc
LFE29:
	.section	.text.unlikely,"x"
LCOLDE4:
	.text
LHOTE4:
	.section .rdata,"dr"
	.align 4
LC5:
	.ascii "\12ERROR FATAL: interrupt vector is out of range\0"
	.align 4
LC6:
	.ascii "\12ERROR FATAL: designated register does not exist\0"
	.align 4
LC7:
	.ascii "\12ERROR FATAL: attempt to write into ROM segment\0"
	.align 4
LC8:
	.ascii "\12ERROR FATAL: cannot push SP onto stack\0"
	.align 4
LC9:
	.ascii "\12ERROR FATAL: cannot pop stack value into SP\0"
	.align 4
LC10:
	.ascii "\12ERROR FATAL: nonexistent segment\0"
	.align 4
LC11:
	.ascii "\12ERROR FATAL: too many subroutine calls\0"
	.align 4
LC12:
	.ascii "\12ERROR FATAL: return without matching subroutine call\0"
LC13:
	.ascii "\12ERROR FATAL: stack underflow\0"
LC14:
	.ascii "\12ERROR FATAL: stack overflow\0"
	.section	.text.unlikely,"x"
LCOLDB15:
	.text
LHOTB15:
	.p2align 4,,15
	.globl	_error
	.def	_error;	.scl	2;	.type	32;	.endef
_error:
LFB30:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	32(%esp), %eax
	cmpb	$10, %al
	ja	L28
	movzbl	%al, %edx
	jmp	*L30(,%edx,4)
	.section .rdata,"dr"
	.align 4
L30:
	.long	L28
	.long	L29
	.long	L31
	.long	L32
	.long	L33
	.long	L34
	.long	L35
	.long	L36
	.long	L37
	.long	L38
	.long	L39
	.text
	.p2align 4,,10
L38:
	movl	$LC13, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L39:
	movl	$LC14, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L29:
	movl	$LC5, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L31:
	movl	$LC6, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L32:
	movl	$LC7, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L33:
	movl	$LC8, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L34:
	movl	$LC9, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L35:
	movl	$LC10, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L36:
	movl	$LC11, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L37:
	movl	$LC12, (%esp)
	call	_puts
	movl	$1, (%esp)
	call	_exit
	.p2align 4,,10
L28:
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE30:
	.section	.text.unlikely,"x"
LCOLDE15:
	.text
LHOTE15:
	.section	.text.unlikely,"x"
LCOLDB16:
	.text
LHOTB16:
	.p2align 4,,15
	.globl	_jump
	.def	_jump;	.scl	2;	.type	32;	.endef
_jump:
LFB31:
	.cfi_startproc
	movl	4(%esp), %eax
	movw	%ax, _PC
	movzwl	%ax, %eax
	ret
	.cfi_endproc
LFE31:
	.section	.text.unlikely,"x"
LCOLDE16:
	.text
LHOTE16:
	.section	.text.unlikely,"x"
LCOLDB17:
	.text
LHOTB17:
	.p2align 4,,15
	.globl	_loadReg
	.def	_loadReg;	.scl	2;	.type	32;	.endef
_loadReg:
LFB32:
	.cfi_startproc
	movzbl	4(%esp), %eax
	movl	8(%esp), %edx
	movw	%dx, _registers(%eax,%eax)
	ret
	.cfi_endproc
LFE32:
	.section	.text.unlikely,"x"
LCOLDE17:
	.text
LHOTE17:
	.section	.text.unlikely,"x"
LCOLDB18:
	.text
LHOTB18:
	.p2align 4,,15
	.globl	_loadA
	.def	_loadA;	.scl	2;	.type	32;	.endef
_loadA:
LFB33:
	.cfi_startproc
	pushl	%edi
	.cfi_def_cfa_offset 8
	.cfi_offset 7, -8
	pushl	%esi
	.cfi_def_cfa_offset 12
	.cfi_offset 6, -12
	pushl	%ebx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	24(%esp), %ecx
	movl	16(%esp), %edx
	movl	20(%esp), %ebx
	movl	28(%esp), %eax
	cmpb	$1, %cl
	je	L45
	jb	L46
	cmpb	$2, %cl
	jne	L43
	movzbl	%bl, %ebx
	movzbl	_segment+1, %esi
	movzbl	%dl, %ecx
	movzwl	_registers(%ebx,%ebx), %edi
	movzwl	%ax, %edx
	sall	$16, %esi
	leal	(%edi,%edx), %eax
	addl	%esi, %eax
	movl	_memory(,%eax,4), %eax
	movw	%ax, _registers(%ecx,%ecx)
L43:
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L46:
	.cfi_restore_state
	movzbl	_segment+1, %ebx
	movzwl	%ax, %ecx
	movzbl	%dl, %edx
	movl	%ebx, %eax
	sall	$16, %eax
	addl	%ecx, %eax
	movl	_memory(,%eax,4), %eax
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	movw	%ax, _registers(%edx,%edx)
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L45:
	.cfi_restore_state
	movzbl	%bl, %ebx
	movzbl	_segment+1, %eax
	movzbl	%dl, %edx
	movzwl	_registers(%ebx,%ebx), %ecx
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 12
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 8
	sall	$16, %eax
	addl	%ecx, %eax
	movl	_memory(,%eax,4), %eax
	popl	%edi
	.cfi_restore 7
	.cfi_def_cfa_offset 4
	movw	%ax, _registers(%edx,%edx)
	ret
	.cfi_endproc
LFE33:
	.section	.text.unlikely,"x"
LCOLDE18:
	.text
LHOTE18:
	.section	.text.unlikely,"x"
LCOLDB19:
	.text
LHOTB19:
	.p2align 4,,15
	.globl	_storeA
	.def	_storeA;	.scl	2;	.type	32;	.endef
_storeA:
LFB34:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	movl	20(%esp), %ebx
	movl	12(%esp), %ecx
	movl	16(%esp), %edx
	movl	24(%esp), %eax
	cmpb	$1, %bl
	je	L51
	jb	L52
	cmpb	$2, %bl
	jne	L49
	movzbl	%dl, %edx
	movzbl	_segment+1, %ebx
	movzbl	%cl, %ecx
	movzwl	_registers(%edx,%edx), %esi
	movzwl	%ax, %edx
	sall	$16, %ebx
	leal	(%esi,%edx), %eax
	movzwl	_registers(%ecx,%ecx), %edx
	addl	%ebx, %eax
	movl	%edx, _memory(,%eax,4)
L49:
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L52:
	.cfi_restore_state
	movzbl	_segment+1, %ebx
	movzwl	%ax, %edx
	movl	%ebx, %eax
L55:
	sall	$16, %eax
	movzbl	%cl, %ecx
	addl	%edx, %eax
	movzwl	_registers(%ecx,%ecx), %edx
	popl	%ebx
	.cfi_remember_state
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	movl	%edx, _memory(,%eax,4)
	ret
	.p2align 4,,10
L51:
	.cfi_restore_state
	movzbl	%dl, %edx
	movzbl	_segment+1, %eax
	movzwl	_registers(%edx,%edx), %edx
	jmp	L55
	.cfi_endproc
LFE34:
	.section	.text.unlikely,"x"
LCOLDE19:
	.text
LHOTE19:
	.section	.text.unlikely,"x"
LCOLDB20:
	.text
LHOTB20:
	.p2align 4,,15
	.globl	_gotoA
	.def	_gotoA;	.scl	2;	.type	32;	.endef
_gotoA:
LFB35:
	.cfi_startproc
	movl	4(%esp), %eax
	movw	%ax, _PC
	ret
	.cfi_endproc
LFE35:
	.section	.text.unlikely,"x"
LCOLDE20:
	.text
LHOTE20:
	.section	.text.unlikely,"x"
LCOLDB21:
	.text
LHOTB21:
	.p2align 4,,15
	.globl	_jumpif
	.def	_jumpif;	.scl	2;	.type	32;	.endef
_jumpif:
LFB36:
	.cfi_startproc
	movl	8(%esp), %eax
	movl	4(%esp), %edx
	cmpb	$7, %al
	ja	L57
	movzbl	%al, %eax
	jmp	*L60(,%eax,4)
	.section .rdata,"dr"
	.align 4
L60:
	.long	L59
	.long	L61
	.long	L62
	.long	L63
	.long	L64
	.long	L65
	.long	L66
	.long	L67
	.text
	.p2align 4,,10
L59:
	cmpb	$0, _flags
	jne	L68
L57:
	rep ret
	.p2align 4,,10
L66:
	cmpb	$0, _flags+3
	jne	L68
	rep ret
	.p2align 4,,10
L67:
	cmpb	$0, _flags+3
	jne	L57
L68:
	movw	%dx, _PC
	ret
	.p2align 4,,10
L61:
	cmpb	$0, _flags
	je	L68
	rep ret
	.p2align 4,,10
L62:
	cmpb	$0, _flags+1
	jne	L68
	rep ret
	.p2align 4,,10
L63:
	cmpb	$0, _flags+1
	je	L68
	rep ret
	.p2align 4,,10
L64:
	cmpb	$0, _flags+2
	jne	L68
	rep ret
	.p2align 4,,10
L65:
	cmpb	$0, _flags+2
	je	L68
	rep ret
	.cfi_endproc
LFE36:
	.section	.text.unlikely,"x"
LCOLDE21:
	.text
LHOTE21:
	.section	.text.unlikely,"x"
LCOLDB22:
	.text
LHOTB22:
	.p2align 4,,15
	.globl	_gotoSubroutine
	.def	_gotoSubroutine;	.scl	2;	.type	32;	.endef
_gotoSubroutine:
LFB37:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$24, %esp
	.cfi_def_cfa_offset 32
	movzbl	_RP, %eax
	movzwl	_PC, %ecx
	movl	32(%esp), %ebx
	subl	$1, %eax
	movsbl	%al, %edx
	testb	%al, %al
	movb	%al, _RP
	movw	%cx, _RETURN(%edx,%edx)
	js	L72
	movw	%bx, _PC
	addl	$24, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L72:
	.cfi_restore_state
	movl	$7, (%esp)
	call	_error
	movw	%bx, _PC
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE37:
	.section	.text.unlikely,"x"
LCOLDE22:
	.text
LHOTE22:
	.section	.text.unlikely,"x"
LCOLDB23:
	.text
LHOTB23:
	.p2align 4,,15
	.globl	_returnFromSubroutine
	.def	_returnFromSubroutine;	.scl	2;	.type	32;	.endef
_returnFromSubroutine:
LFB38:
	.cfi_startproc
	movsbl	_RP, %edx
	movl	%edx, %eax
	movzwl	_RETURN(%edx,%edx), %edx
	addl	$1, %eax
	cmpb	$15, %al
	movb	%al, _RP
	movw	%dx, _PC
	jg	L78
	ret
	.p2align 4,,10
L78:
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	$8, (%esp)
	call	_error
	addl	$28, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE38:
	.section	.text.unlikely,"x"
LCOLDE23:
	.text
LHOTE23:
	.section	.text.unlikely,"x"
LCOLDB24:
	.text
LHOTB24:
	.p2align 4,,15
	.globl	_move
	.def	_move;	.scl	2;	.type	32;	.endef
_move:
LFB39:
	.cfi_startproc
	movzbl	4(%esp), %edx
	movl	$_registers, %eax
	movzwl	(%eax,%edx,2), %ecx
	movzbl	8(%esp), %edx
	movw	%cx, (%eax,%edx,2)
	ret
	.cfi_endproc
LFE39:
	.section	.text.unlikely,"x"
LCOLDE24:
	.text
LHOTE24:
	.section	.text.unlikely,"x"
LCOLDB25:
	.text
LHOTB25:
	.p2align 4,,15
	.globl	_interrupt
	.def	_interrupt;	.scl	2;	.type	32;	.endef
_interrupt:
LFB40:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$56, %esp
	.cfi_def_cfa_offset 64
	cmpb	$0, _flags+4
	movl	64(%esp), %ebx
	jne	L80
	movzbl	_RP, %eax
	movzwl	_PC, %ecx
	movb	$1, _flags+4
	subl	$1, %eax
	movsbl	%al, %edx
	testb	%al, %al
	movb	%al, _RP
	movw	%cx, _RETURN(%edx,%edx)
	js	L85
L82:
	cmpb	$8, %bl
	ja	L83
	movzbl	%bl, %ebx
	movl	$8, 16(%esp)
	movl	$16, 20(%esp)
	movl	$24, 24(%esp)
	movl	$32, 28(%esp)
	movl	$40, 32(%esp)
	movl	$48, 36(%esp)
	movl	$56, 40(%esp)
	movl	$64, 44(%esp)
	movl	16(%esp,%ebx,4), %eax
	movw	%ax, _PC
L80:
	addl	$56, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L83:
	.cfi_restore_state
	movl	$1, 64(%esp)
	addl	$56, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	jmp	_error
	.p2align 4,,10
L85:
	.cfi_restore_state
	movl	$7, (%esp)
	call	_error
	jmp	L82
	.cfi_endproc
LFE40:
	.section	.text.unlikely,"x"
LCOLDE25:
	.text
LHOTE25:
	.section	.text.unlikely,"x"
LCOLDB26:
	.text
LHOTB26:
	.p2align 4,,15
	.globl	_push
	.def	_push;	.scl	2;	.type	32;	.endef
_push:
LFB41:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$24, %esp
	.cfi_def_cfa_offset 32
	movzwl	_SP, %eax
	movl	32(%esp), %ebx
	testw	%ax, %ax
	jne	L87
	movl	$10, (%esp)
	call	_error
	movzwl	_SP, %eax
L87:
	movzbl	_segment+2, %ecx
	subl	$1, %eax
	movzbl	%bl, %ebx
	movzwl	%ax, %edx
	movw	%ax, _SP
	movl	%ecx, %eax
	sall	$16, %eax
	addl	%edx, %eax
	movzwl	_registers(%ebx,%ebx), %edx
	movl	%edx, _memory(,%eax,4)
	addl	$24, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE41:
	.section	.text.unlikely,"x"
LCOLDE26:
	.text
LHOTE26:
	.section	.text.unlikely,"x"
LCOLDB27:
	.text
LHOTB27:
	.p2align 4,,15
	.globl	_pop
	.def	_pop;	.scl	2;	.type	32;	.endef
_pop:
LFB42:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$24, %esp
	.cfi_def_cfa_offset 32
	movzwl	_SP, %eax
	movl	32(%esp), %ebx
	cmpw	$-1, %ax
	je	L92
L90:
	movzbl	_segment+2, %edx
	movzwl	%ax, %ecx
	movzbl	%bl, %ebx
	addl	$1, %eax
	movw	%ax, _SP
	sall	$16, %edx
	addl	%ecx, %edx
	movl	_memory(,%edx,4), %edx
	movw	%dx, _registers(%ebx,%ebx)
	addl	$24, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L92:
	.cfi_restore_state
	movl	$9, (%esp)
	call	_error
	movzwl	_SP, %eax
	jmp	L90
	.cfi_endproc
LFE42:
	.section	.text.unlikely,"x"
LCOLDE27:
	.text
LHOTE27:
	.section	.text.unlikely,"x"
LCOLDB28:
	.text
LHOTB28:
	.p2align 4,,15
	.globl	_ALU
	.def	_ALU;	.scl	2;	.type	32;	.endef
_ALU:
LFB43:
	.cfi_startproc
	pushl	%esi
	.cfi_def_cfa_offset 8
	.cfi_offset 6, -8
	pushl	%ebx
	.cfi_def_cfa_offset 12
	.cfi_offset 3, -12
	subl	$20, %esp
	.cfi_def_cfa_offset 32
	movl	44(%esp), %edx
	movl	32(%esp), %ebx
	movl	36(%esp), %esi
	movl	40(%esp), %ecx
	cmpb	$9, %dl
	ja	L94
	movzbl	%dl, %edx
	jmp	*L96(,%edx,4)
	.section .rdata,"dr"
	.align 4
L96:
	.long	L94
	.long	L95
	.long	L97
	.long	L98
	.long	L99
	.long	L100
	.long	L101
	.long	L102
	.long	L103
	.long	L104
	.text
	.p2align 4,,10
L95:
	movl	%esi, %eax
	movzbl	%bl, %ebx
	movzbl	%al, %esi
	movzwl	_registers(%ebx,%ebx), %edx
	movzwl	_registers(%esi,%esi), %eax
	addl	%edx, %eax
L94:
	cmpl	$65535, %eax
	jle	L105
	movb	$1, _flags
L107:
	movl	%eax, %ebx
	shrl	$31, %ebx
	leal	(%eax,%ebx), %edx
	andl	$1, %edx
	subl	%ebx, %edx
	cmpl	$1, %edx
	jne	L114
	movb	$1, _flags+3
L114:
	movzwl	%ax, %ebx
L109:
	cmpb	$7, %cl
	ja	L111
	movzbl	%cl, %ecx
	movw	%ax, _registers(%ecx,%ecx)
	addl	$20, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	movl	%ebx, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L111:
	.cfi_restore_state
	movl	$2, (%esp)
	call	_error
	addl	$20, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 12
	movl	%ebx, %eax
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	popl	%esi
	.cfi_restore 6
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L97:
	.cfi_restore_state
	movzbl	%bl, %ebx
	movzwl	_registers(%ebx,%ebx), %eax
	movl	%esi, %ebx
	movzbl	%bl, %esi
	movzwl	_registers(%esi,%esi), %edx
	subl	%edx, %eax
L105:
	testl	%eax, %eax
	jns	L108
	movb	$1, _flags+1
	jmp	L107
	.p2align 4,,10
L99:
	movl	%esi, %eax
	movzbl	%bl, %ebx
	movzbl	%al, %esi
	movzwl	_registers(%ebx,%ebx), %eax
	orw	_registers(%esi,%esi), %ax
	movzwl	%ax, %eax
L108:
	testl	%eax, %eax
	jne	L107
	movb	$1, _flags+2
	xorl	%ebx, %ebx
	jmp	L109
	.p2align 4,,10
L104:
	movzbl	%bl, %ebx
	movsbl	_flags+1, %edx
	movzwl	_registers(%ebx,%ebx), %eax
	movl	%esi, %ebx
	movzbl	%bl, %esi
	movzwl	_registers(%esi,%esi), %ebx
	addl	%ebx, %edx
	subl	%edx, %eax
	jmp	L94
	.p2align 4,,10
L98:
	movl	%esi, %eax
	movzbl	%bl, %ebx
	movzbl	%al, %esi
	movzwl	_registers(%ebx,%ebx), %eax
	andw	_registers(%esi,%esi), %ax
	movzwl	%ax, %eax
	jmp	L108
	.p2align 4,,10
L100:
	movl	%esi, %eax
	movzbl	%bl, %ebx
	movzbl	%al, %esi
	movzwl	_registers(%ebx,%ebx), %eax
	xorw	_registers(%esi,%esi), %ax
	movzwl	%ax, %eax
	jmp	L108
	.p2align 4,,10
L101:
	movzbl	%bl, %ebx
	movzwl	_registers(%ebx,%ebx), %eax
	addl	%eax, %eax
	jmp	L94
	.p2align 4,,10
L102:
	movzbl	%bl, %ebx
	movzwl	_registers(%ebx,%ebx), %eax
	shrw	%ax
	movzwl	%ax, %eax
	jmp	L108
	.p2align 4,,10
L103:
	movl	%esi, %eax
	movzbl	%bl, %ebx
	movzbl	%al, %esi
	movzwl	_registers(%ebx,%ebx), %edx
	movzwl	_registers(%esi,%esi), %eax
	addl	%edx, %eax
	movsbl	_flags, %edx
	addl	%edx, %eax
	jmp	L94
	.cfi_endproc
LFE43:
	.section	.text.unlikely,"x"
LCOLDE28:
	.text
LHOTE28:
	.section	.text.unlikely,"x"
LCOLDB29:
	.text
LHOTB29:
	.p2align 4,,15
	.globl	_ldSegment
	.def	_ldSegment;	.scl	2;	.type	32;	.endef
_ldSegment:
LFB44:
	.cfi_startproc
	pushl	%ebx
	.cfi_def_cfa_offset 8
	.cfi_offset 3, -8
	subl	$40, %esp
	.cfi_def_cfa_offset 48
	movl	52(%esp), %ebx
	movl	48(%esp), %edx
	cmpw	$15, %bx
	ja	L122
	cmpb	$1, %dl
	je	L118
L123:
	jb	L119
	cmpb	$2, %dl
	jne	L115
	movb	%bl, _segment+2
L115:
	addl	$40, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L122:
	.cfi_restore_state
	movl	$6, (%esp)
	movl	%edx, 28(%esp)
	call	_error
	movl	28(%esp), %edx
	cmpb	$1, %dl
	jne	L123
L118:
	movb	%bl, _segment+1
	addl	$40, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L119:
	.cfi_restore_state
	movb	%bl, _segment
	addl	$40, %esp
	.cfi_def_cfa_offset 8
	popl	%ebx
	.cfi_restore 3
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE44:
	.section	.text.unlikely,"x"
LCOLDE29:
	.text
LHOTE29:
	.section	.text.unlikely,"x"
LCOLDB30:
	.text
LHOTB30:
	.p2align 4,,15
	.globl	_loadSp
	.def	_loadSp;	.scl	2;	.type	32;	.endef
_loadSp:
LFB45:
	.cfi_startproc
	movl	4(%esp), %eax
	movw	%ax, _SP
	ret
	.cfi_endproc
LFE45:
	.section	.text.unlikely,"x"
LCOLDE30:
	.text
LHOTE30:
	.section	.text.unlikely,"x"
LCOLDB31:
	.text
LHOTB31:
	.p2align 4,,15
	.globl	_setFlag
	.def	_setFlag;	.scl	2;	.type	32;	.endef
_setFlag:
LFB46:
	.cfi_startproc
	movl	4(%esp), %eax
	cmpb	$11, %al
	ja	L125
	movzbl	%al, %eax
	jmp	*L128(,%eax,4)
	.section .rdata,"dr"
	.align 4
L128:
	.long	L127
	.long	L129
	.long	L130
	.long	L131
	.long	L132
	.long	L140
	.long	L134
	.long	L135
	.long	L136
	.long	L137
	.long	L138
	.long	L139
	.text
	.p2align 4,,10
L139:
	movb	$1, _flags
	movb	$1, _flags+1
	movb	$1, _flags+2
	movb	$1, _flags+3
L140:
	movb	$1, _flags+4
L125:
	rep ret
	.p2align 4,,10
L134:
	movb	$0, _flags
	ret
	.p2align 4,,10
L135:
	movb	$0, _flags+1
	ret
	.p2align 4,,10
L136:
	movb	$0, _flags+2
	ret
	.p2align 4,,10
L137:
	movb	$0, _flags+3
	ret
	.p2align 4,,10
L138:
	movb	$0, _flags+4
	ret
	.p2align 4,,10
L127:
	movb	$0, _flags
	movb	$0, _flags+1
	movb	$0, _flags+2
	movb	$0, _flags+3
	movb	$0, _flags+4
	ret
	.p2align 4,,10
L129:
	movb	$1, _flags
	ret
	.p2align 4,,10
L130:
	movb	$1, _flags+1
	ret
	.p2align 4,,10
L131:
	movb	$1, _flags+2
	ret
	.p2align 4,,10
L132:
	movb	$1, _flags+3
	ret
	.cfi_endproc
LFE46:
	.section	.text.unlikely,"x"
LCOLDE31:
	.text
LHOTE31:
	.section	.text.unlikely,"x"
LCOLDB32:
	.text
LHOTB32:
	.p2align 4,,15
	.globl	_fetch
	.def	_fetch;	.scl	2;	.type	32;	.endef
_fetch:
LFB47:
	.cfi_startproc
	movzwl	_PC, %eax
	movzbl	_segment, %ecx
	leal	1(%eax), %edx
	movw	%dx, _PC
	movzwl	%ax, %edx
	movl	%ecx, %eax
	sall	$16, %eax
	addl	%edx, %eax
	movl	_memory(,%eax,4), %eax
	movl	%eax, _IR
	ret
	.cfi_endproc
LFE47:
	.section	.text.unlikely,"x"
LCOLDE32:
	.text
LHOTE32:
	.section	.text.unlikely,"x"
LCOLDB33:
	.text
LHOTB33:
	.p2align 4,,15
	.globl	_decode
	.def	_decode;	.scl	2;	.type	32;	.endef
_decode:
LFB48:
	.cfi_startproc
	movl	_IR, %eax
	movl	%eax, %edx
	movw	%ax, _wordSeg+4
	shrl	$27, %edx
	movb	%dl, _wordSeg
	movl	%eax, %edx
	shrl	$24, %edx
	andl	$7, %edx
	movb	%dl, _wordSeg+1
	movl	%eax, %edx
	shrl	$21, %edx
	andl	$7, %edx
	movb	%dl, _wordSeg+2
	movl	%eax, %edx
	shrl	$16, %edx
	andl	$31, %edx
	movb	%dl, _wordSeg+3
	ret
	.cfi_endproc
LFE48:
	.section	.text.unlikely,"x"
LCOLDE33:
	.text
LHOTE33:
	.section	.text.unlikely,"x"
LCOLDB34:
	.text
LHOTB34:
	.p2align 4,,15
	.globl	_execute
	.def	_execute;	.scl	2;	.type	32;	.endef
_execute:
LFB49:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	cmpb	$31, _wordSeg
	ja	L143
	movzbl	_wordSeg, %eax
	jmp	*L146(,%eax,4)
	.section .rdata,"dr"
	.align 4
L146:
	.long	L143
	.long	L145
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
	.long	L160
	.long	L161
	.long	L162
	.long	L163
	.long	L164
	.long	L165
	.long	L166
	.long	L167
	.long	L168
	.long	L169
	.long	L170
	.long	L171
	.long	L172
	.long	L173
	.long	L174
	.long	L175
	.long	L176
	.text
	.p2align 4,,10
L172:
	movl	$7, 12(%esp)
	.p2align 4,,10
L178:
	movzbl	_wordSeg+3, %eax
	movl	%eax, 8(%esp)
	movzbl	_wordSeg+2, %eax
	movl	%eax, 4(%esp)
	movzbl	_wordSeg+1, %eax
	movl	%eax, (%esp)
	call	_ALU
L143:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L175:
	.cfi_restore_state
	movzbl	_wordSeg+3, %eax
	movl	%eax, (%esp)
	call	_setFlag
	jmp	L143
	.p2align 4,,10
L174:
	movzwl	_wordSeg+4, %eax
	movw	%ax, _SP
	jmp	L143
	.p2align 4,,10
L173:
	movzwl	_wordSeg+4, %eax
	movl	%eax, 4(%esp)
	movzbl	_wordSeg+3, %eax
	movl	%eax, (%esp)
	call	_ldSegment
	jmp	L143
	.p2align 4,,10
L171:
	movl	$6, 12(%esp)
	jmp	L178
	.p2align 4,,10
L170:
	movl	$5, 12(%esp)
	jmp	L178
	.p2align 4,,10
L169:
	movl	$4, 12(%esp)
	jmp	L178
	.p2align 4,,10
L168:
	movl	$3, 12(%esp)
	jmp	L178
	.p2align 4,,10
L167:
	movl	$9, 12(%esp)
	jmp	L178
	.p2align 4,,10
L166:
	movl	$2, 12(%esp)
	jmp	L178
	.p2align 4,,10
L165:
	movl	$8, 12(%esp)
	jmp	L178
	.p2align 4,,10
L164:
	movl	$1, 12(%esp)
	jmp	L178
	.p2align 4,,10
L163:
	movzbl	_wordSeg+1, %eax
	movl	%eax, (%esp)
	call	_pop
	jmp	L143
	.p2align 4,,10
L162:
	movzbl	_wordSeg+1, %eax
	movl	%eax, (%esp)
	call	_push
	jmp	L143
	.p2align 4,,10
L161:
	movzbl	_wordSeg+1, %eax
	movzwl	_registers(%eax,%eax), %edx
	movzbl	_wordSeg+2, %eax
	movw	%dx, _registers(%eax,%eax)
	jmp	L143
	.p2align 4,,10
L160:
	movzbl	_wordSeg+3, %eax
	movl	%eax, (%esp)
	call	_interrupt
	jmp	L143
	.p2align 4,,10
L159:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	jmp	_returnFromSubroutine
	.p2align 4,,10
L158:
	.cfi_restore_state
	movzwl	_wordSeg+4, %eax
	movl	%eax, (%esp)
	call	_gotoSubroutine
	jmp	L143
	.p2align 4,,10
L157:
	movzwl	_wordSeg+4, %eax
	movl	$7, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L156:
	movzwl	_wordSeg+4, %eax
	movl	$6, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L155:
	movzwl	_wordSeg+4, %eax
	movl	$5, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L154:
	movzwl	_wordSeg+4, %eax
	movl	$4, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L153:
	movzwl	_wordSeg+4, %eax
	movl	$3, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L152:
	movzwl	_wordSeg+4, %eax
	movl	$2, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L151:
	movzwl	_wordSeg+4, %eax
	movl	$1, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L150:
	movzwl	_wordSeg+4, %eax
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_jumpif
	jmp	L143
	.p2align 4,,10
L149:
	movzwl	_wordSeg+4, %eax
	movw	%ax, _PC
	jmp	L143
	.p2align 4,,10
L148:
	movzwl	_wordSeg+4, %eax
	movl	%eax, 12(%esp)
	movzbl	_wordSeg+3, %eax
	movl	%eax, 8(%esp)
	movzbl	_wordSeg+2, %eax
	movl	%eax, 4(%esp)
	movzbl	_wordSeg+1, %eax
	movl	%eax, (%esp)
	call	_storeA
	jmp	L143
	.p2align 4,,10
L147:
	movzwl	_wordSeg+4, %eax
	movl	%eax, 12(%esp)
	movzbl	_wordSeg+3, %eax
	movl	%eax, 8(%esp)
	movzbl	_wordSeg+2, %eax
	movl	%eax, 4(%esp)
	movzbl	_wordSeg+1, %eax
	movl	%eax, (%esp)
	call	_loadA
	jmp	L143
	.p2align 4,,10
L145:
	movzbl	_wordSeg+1, %eax
	movzwl	_wordSeg+4, %edx
	movw	%dx, _registers(%eax,%eax)
	jmp	L143
	.p2align 4,,10
L176:
	movb	$1, _halt
	jmp	L143
	.cfi_endproc
LFE49:
	.section	.text.unlikely,"x"
LCOLDE34:
	.text
LHOTE34:
	.section	.text.unlikely,"x"
LCOLDB35:
	.text
LHOTB35:
	.p2align 4,,15
	.globl	_run
	.def	_run;	.scl	2;	.type	32;	.endef
_run:
LFB50:
	.cfi_startproc
	movl	4(%esp), %eax
	testb	%al, %al
	je	L180
	cmpb	$1, _flags+4
	je	L180
	subl	$1, %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	jmp	_interrupt
	.p2align 4,,10
L180:
	movzwl	_PC, %eax
	movzbl	_segment, %ecx
	leal	1(%eax), %edx
	movw	%dx, _PC
	movzwl	%ax, %edx
	movl	%ecx, %eax
	sall	$16, %eax
	addl	%edx, %eax
	movl	_memory(,%eax,4), %eax
	movl	%eax, %edx
	movl	%eax, _IR
	movw	%ax, _wordSeg+4
	shrl	$27, %edx
	movb	%dl, _wordSeg
	movl	%eax, %edx
	shrl	$24, %edx
	andl	$7, %edx
	movb	%dl, _wordSeg+1
	movl	%eax, %edx
	shrl	$21, %edx
	andl	$7, %edx
	movb	%dl, _wordSeg+2
	movl	%eax, %edx
	shrl	$16, %edx
	andl	$31, %edx
	movb	%dl, _wordSeg+3
	jmp	_execute
	.cfi_endproc
LFE50:
	.section	.text.unlikely,"x"
LCOLDE35:
	.text
LHOTE35:
	.section	.text.unlikely,"x"
LCOLDB36:
	.text
LHOTB36:
	.p2align 4,,15
	.globl	_prexec
	.def	_prexec;	.scl	2;	.type	32;	.endef
_prexec:
LFB51:
	.cfi_startproc
	movb	$0, _segment
	movb	$9, _segment+1
	movb	$8, _segment+2
	ret
	.cfi_endproc
LFE51:
	.section	.text.unlikely,"x"
LCOLDE36:
	.text
LHOTE36:
	.section .rdata,"dr"
	.align 4
LC37:
	.ascii "VM safely halted at PC HEX:%x DEC:%i\12\0"
	.align 4
LC38:
	.ascii "A:%x B:%x C:%x D:%x E:%x X:%x Y:%x Z:%x SP:%x RP:%x RS:%x MS:%x SS:%x C:%x N:%x Z:%x P:%x I:%x Cycles:%lx\12\0"
	.align 4
LC39:
	.ascii "A:%i B:%i C:%i D:%i E:%i X:%i Y:%i Z:%i SP:%i RP:%i RS:%i MS:%i SS:%i C:%i N:%i Z:%i P:%i I:%i Cycles:%lu\12\0"
	.section	.text.unlikely,"x"
LCOLDB40:
	.text
LHOTB40:
	.p2align 4,,15
	.globl	_postexec
	.def	_postexec;	.scl	2;	.type	32;	.endef
_postexec:
LFB52:
	.cfi_startproc
	subl	$92, %esp
	.cfi_def_cfa_offset 96
	movzwl	_PC, %eax
	movl	$LC37, (%esp)
	subl	$1, %eax
	movl	%eax, 8(%esp)
	movl	%eax, 4(%esp)
	call	_printf
	movl	_cycles, %eax
	movl	%eax, 76(%esp)
	movsbl	_flags+4, %eax
	movl	%eax, 72(%esp)
	movsbl	_flags+3, %eax
	movl	%eax, 68(%esp)
	movsbl	_flags+2, %eax
	movl	%eax, 64(%esp)
	movsbl	_flags+1, %eax
	movl	%eax, 60(%esp)
	movsbl	_flags, %eax
	movl	%eax, 56(%esp)
	movzbl	_segment+2, %eax
	movl	%eax, 52(%esp)
	movzbl	_segment+1, %eax
	movl	%eax, 48(%esp)
	movzbl	_segment, %eax
	movl	%eax, 44(%esp)
	movsbl	_RP, %eax
	movl	%eax, 40(%esp)
	movzwl	_SP, %eax
	movl	%eax, 36(%esp)
	movzwl	_registers+14, %eax
	movl	%eax, 32(%esp)
	movzwl	_registers+12, %eax
	movl	%eax, 28(%esp)
	movzwl	_registers+10, %eax
	movl	%eax, 24(%esp)
	movzwl	_registers+8, %eax
	movl	%eax, 20(%esp)
	movzwl	_registers+6, %eax
	movl	%eax, 16(%esp)
	movzwl	_registers+4, %eax
	movl	$LC38, (%esp)
	movl	%eax, 12(%esp)
	movzwl	_registers+2, %eax
	movl	%eax, 8(%esp)
	movzwl	_registers, %eax
	movl	%eax, 4(%esp)
	call	_printf
	movl	_cycles, %eax
	movl	%eax, 76(%esp)
	movsbl	_flags+4, %eax
	movl	%eax, 72(%esp)
	movsbl	_flags+3, %eax
	movl	%eax, 68(%esp)
	movsbl	_flags+2, %eax
	movl	%eax, 64(%esp)
	movsbl	_flags+1, %eax
	movl	%eax, 60(%esp)
	movsbl	_flags, %eax
	movl	%eax, 56(%esp)
	movzbl	_segment+2, %eax
	movl	%eax, 52(%esp)
	movzbl	_segment+1, %eax
	movl	%eax, 48(%esp)
	movzbl	_segment, %eax
	movl	%eax, 44(%esp)
	movsbl	_RP, %eax
	movl	%eax, 40(%esp)
	movzwl	_SP, %eax
	movl	%eax, 36(%esp)
	movzwl	_registers+14, %eax
	movl	%eax, 32(%esp)
	movzwl	_registers+12, %eax
	movl	%eax, 28(%esp)
	movzwl	_registers+10, %eax
	movl	%eax, 24(%esp)
	movzwl	_registers+8, %eax
	movl	%eax, 20(%esp)
	movzwl	_registers+6, %eax
	movl	%eax, 16(%esp)
	movzwl	_registers+4, %eax
	movl	$LC39, (%esp)
	movl	%eax, 12(%esp)
	movzwl	_registers+2, %eax
	movl	%eax, 8(%esp)
	movzwl	_registers, %eax
	movl	%eax, 4(%esp)
	call	_printf
	addl	$92, %esp
	.cfi_def_cfa_offset 4
	ret
	.cfi_endproc
LFE52:
	.section	.text.unlikely,"x"
LCOLDE40:
	.text
LHOTE40:
	.section	.text.unlikely,"x"
LCOLDB41:
	.text
LHOTB41:
	.p2align 4,,15
	.globl	_testKeyboard
	.def	_testKeyboard;	.scl	2;	.type	32;	.endef
_testKeyboard:
LFB53:
	.cfi_startproc
	subl	$12, %esp
	.cfi_def_cfa_offset 16
	call	_kbhit
	testl	%eax, %eax
	jne	L188
	xorl	%eax, %eax
	addl	$12, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L188:
	.cfi_restore_state
	addl	$12, %esp
	.cfi_def_cfa_offset 4
	jmp	_testKeyboard.part.3
	.cfi_endproc
LFE53:
	.section	.text.unlikely,"x"
LCOLDE41:
	.text
LHOTE41:
	.section .rdata,"dr"
LC42:
	.ascii "CLS\0"
LC43:
	.ascii "============================\0"
	.section	.text.unlikely,"x"
LCOLDB44:
	.text
LHOTB44:
	.p2align 4,,15
	.globl	_display
	.def	_display;	.scl	2;	.type	32;	.endef
_display:
LFB54:
	.cfi_startproc
	subl	$28, %esp
	.cfi_def_cfa_offset 32
	movl	_memory+3932416, %eax
	testl	%eax, %eax
	je	L190
	movl	_memory+3932412, %edx
	testl	%edx, %edx
	jne	L196
L190:
	movl	_memory+3932420, %eax
	testl	%eax, %eax
	je	L189
	movl	$LC42, (%esp)
	movl	$0, _memory+3932420
	call	_system
	movl	$LC43, (%esp)
	call	_puts
L189:
	addl	$28, %esp
	.cfi_remember_state
	.cfi_def_cfa_offset 4
	ret
	.p2align 4,,10
L196:
	.cfi_restore_state
	movl	%eax, (%esp)
	call	__putch
	movl	$0, _memory+3932416
	jmp	L190
	.cfi_endproc
LFE54:
	.section	.text.unlikely,"x"
LCOLDE44:
	.text
LHOTE44:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC45:
	.ascii "\12============================\0"
	.section	.text.unlikely,"x"
LCOLDB46:
	.section	.text.startup,"x"
LHOTB46:
	.p2align 4,,15
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB55:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$16, %esp
	call	___main
	movl	12(%ebp), %eax
	movb	$0, _segment
	movb	$9, _segment+1
	movb	$8, _segment+2
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	_reader
	movl	$LC43, (%esp)
	call	_puts
	jmp	L199
	.p2align 4,,10
L198:
	movl	%eax, (%esp)
	call	_run
	call	_display
	addl	$1, _cycles
	cmpb	$0, _halt
	jne	L205
L199:
	call	_kbhit
	testl	%eax, %eax
	je	L198
	call	_testKeyboard.part.3
	movsbl	%al, %eax
	jmp	L198
	.p2align 4,,10
L205:
	movl	$LC45, (%esp)
	call	_puts
	call	_postexec
	xorl	%eax, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE55:
	.section	.text.unlikely,"x"
LCOLDE46:
	.section	.text.startup,"x"
LHOTE46:
	.comm	_halt, 1, 0
	.comm	_cycles, 4, 2
	.comm	_IR, 4, 2
	.globl	_RP
	.data
_RP:
	.byte	15
	.comm	_RETURN, 32, 5
	.comm	_flags, 5, 2
	.comm	_segment, 3, 0
	.comm	_wordSeg, 6, 2
	.comm	_SP, 2, 1
	.comm	_PC, 2, 1
	.comm	_registers, 16, 2
	.comm	_memory, 4194304, 5
	.ident	"GCC: (GNU) 5.3.0"
	.def	__getch;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_fscanf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_exit;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_kbhit;	.scl	2;	.type	32;	.endef
	.def	_system;	.scl	2;	.type	32;	.endef
	.def	__putch;	.scl	2;	.type	32;	.endef
