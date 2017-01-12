	.file	"vm.c"
	.comm	A, 1, 0
	.comm	AB, 1, 0
	.comm	AP, 8, 3
	.comm	BP, 8, 3
	.comm	X, 1, 0
	.comm	Y, 1, 0
	.comm	Z, 1, 0
	.comm	F, 1, 0
	.comm	PC, 2, 1
	.comm	MDR, 1, 0
	.comm	MAR, 2, 1
	.comm	SP, 2, 1
	.comm	IX, 2, 1
	.comm	IR, 2, 0
	.comm	AH, 2, 1
	.comm	FETCH, 1, 0
	.comm	WM, 1, 0
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii " A: %d\12AB: %d\12 X: %d\12 Y: %d\12 Z: %d\12 F: %d\12PC: %d\12SP: %d\12IX: %d\12\12\0"
	.text
	.globl	registerDump
	.def	registerDump;	.scl	2;	.type	32;	.endef
	.seh_proc	registerDump
registerDump:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$88, %rsp
	.seh_stackalloc	88
	.seh_setframe	%rbp, 112
	.seh_endprologue
	movzwl	IX(%rip), %eax
	movzwl	%ax, %ebx
	movzwl	SP(%rip), %eax
	movzwl	%ax, %r11d
	movzwl	PC(%rip), %eax
	movzwl	%ax, %r10d
	movzbl	F(%rip), %eax
	movzbl	%al, %r9d
	movzbl	Z(%rip), %eax
	movzbl	%al, %r8d
	movzbl	Y(%rip), %eax
	movzbl	%al, %ecx
	movzbl	X(%rip), %eax
	movzbl	%al, %edi
	movzbl	AB(%rip), %eax
	movzbl	%al, %esi
	movzbl	A(%rip), %eax
	movzbl	%al, %edx
	leaq	.LC0(%rip), %rax
	movl	%ebx, 72(%rsp)
	movl	%r11d, 64(%rsp)
	movl	%r10d, 56(%rsp)
	movl	%r9d, 48(%rsp)
	movl	%r8d, 40(%rsp)
	movl	%ecx, 32(%rsp)
	movl	%edi, %r9d
	movl	%esi, %r8d
	movq	%rax, %rcx
	call	printf
	nop
	addq	$88, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	ret
	.seh_endproc
	.comm	memory, 65535, 5
	.globl	vector
	.data
	.align 16
vector:
	.word	8
	.word	16
	.word	24
	.word	32
	.word	40
	.word	48
	.word	56
	.word	64
	.text
	.globl	ALU
	.def	ALU;	.scl	2;	.type	32;	.endef
	.seh_proc	ALU
ALU:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_setframe	%rbp, 16
	.seh_endprologue
	movl	%edx, %eax
	movl	%r8d, %edx
	movb	%cl, 16(%rbp)
	movb	%al, 24(%rbp)
	movb	%dl, 32(%rbp)
	movl	$0, -4(%rbp)
	movsbl	32(%rbp), %eax
	cmpl	$6, %eax
	ja	.L3
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L10(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rdx
	leaq	.L10(%rip), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L10:
	.long	.L3-.L10
	.long	.L4-.L10
	.long	.L5-.L10
	.long	.L6-.L10
	.long	.L7-.L10
	.long	.L8-.L10
	.long	.L9-.L10
	.text
.L4:
	movzbl	16(%rbp), %edx
	movzbl	24(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, -4(%rbp)
	jmp	.L3
.L5:
	movzbl	16(%rbp), %edx
	movzbl	24(%rbp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -4(%rbp)
	jmp	.L3
.L6:
	movzbl	24(%rbp), %eax
	movzbl	16(%rbp), %edx
	andl	%edx, %eax
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
	jmp	.L3
.L7:
	movzbl	24(%rbp), %eax
	movzbl	16(%rbp), %edx
	orl	%edx, %eax
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
	jmp	.L3
.L8:
	movzbl	24(%rbp), %eax
	movzbl	16(%rbp), %edx
	xorl	%edx, %eax
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
.L9:
	movzbl	16(%rbp), %eax
	notl	%eax
	movl	%eax, -4(%rbp)
.L3:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	sall	$4, %eax
	testl	%eax, %eax
	jne	.L11
	movb	$0, F(%rip)
.L11:
	movl	-4(%rbp), %eax
	movl	%eax, %edx
	sarl	$31, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	.L12
	movzbl	F(%rip), %eax
	orl	$1, %eax
	movb	%al, F(%rip)
.L12:
	cmpl	$255, -4(%rbp)
	jle	.L13
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	addl	%eax, %eax
	orl	$1, %eax
	movb	%al, F(%rip)
.L13:
	cmpl	$0, -4(%rbp)
	jns	.L14
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	sall	$2, %eax
	orl	$1, %eax
	movb	%al, F(%rip)
.L14:
	cmpl	$0, -4(%rbp)
	jne	.L15
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	sall	$3, %eax
	orl	$1, %eax
	movb	%al, F(%rip)
.L15:
	cmpl	$255, -4(%rbp)
	jle	.L16
	movl	$255, -4(%rbp)
	jmp	.L17
.L16:
	cmpl	$0, -4(%rbp)
	jns	.L17
	movl	$0, -4(%rbp)
.L17:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	testBit
	.def	testBit;	.scl	2;	.type	32;	.endef
	.seh_proc	testBit
testBit:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$24, %rsp
	.seh_stackalloc	24
	.seh_setframe	%rbp, 32
	.seh_endprologue
	movl	%edx, %eax
	movb	%cl, 16(%rbp)
	movb	%al, 24(%rbp)
	movsbl	24(%rbp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movl	%eax, %ecx
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movzbl	16(%rbp), %eax
	andl	%edx, %eax
	movb	%al, -17(%rbp)
	movzbl	-17(%rbp), %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	assignAccumulator
	.def	assignAccumulator;	.scl	2;	.type	32;	.endef
	.seh_proc	assignAccumulator
assignAccumulator:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movb	%al, 16(%rbp)
	cmpb	$1, 16(%rbp)
	jne	.L20
	leaq	A(%rip), %rax
	movq	%rax, AP(%rip)
	leaq	AB(%rip), %rax
	movq	%rax, BP(%rip)
	jmp	.L19
.L20:
	cmpb	$2, 16(%rbp)
	jne	.L22
	leaq	AB(%rip), %rax
	movq	%rax, AP(%rip)
	leaq	A(%rip), %rax
	movq	%rax, BP(%rip)
	jmp	.L19
.L22:
	leaq	A(%rip), %rax
	movq	%rax, AP(%rip)
	leaq	AB(%rip), %rax
	movq	%rax, BP(%rip)
.L19:
	popq	%rbp
	ret
	.seh_endproc
	.globl	readData
	.def	readData;	.scl	2;	.type	32;	.endef
	.seh_proc	readData
readData:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movq	%rdx, 24(%rbp)
	movw	%ax, 16(%rbp)
	movzwl	16(%rbp), %eax
	movw	%ax, MAR(%rip)
	movzwl	MAR(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, MDR(%rip)
	movzbl	MDR(%rip), %edx
	movq	24(%rbp), %rax
	movb	%dl, (%rax)
	popq	%rbp
	ret
	.seh_endproc
	.globl	writeData
	.def	writeData;	.scl	2;	.type	32;	.endef
	.seh_proc	writeData
writeData:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%edx, %eax
	movw	%cx, 16(%rbp)
	movb	%al, 24(%rbp)
	movzwl	16(%rbp), %eax
	movw	%ax, MAR(%rip)
	movzbl	24(%rbp), %eax
	movb	%al, MDR(%rip)
	movzwl	MAR(%rip), %eax
	movzwl	%ax, %eax
	movzbl	MDR(%rip), %ecx
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movb	%cl, (%rdx,%rax)
	popq	%rbp
	ret
	.seh_endproc
	.globl	incPC
	.def	incPC;	.scl	2;	.type	32;	.endef
	.seh_proc	incPC
incPC:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movzwl	PC(%rip), %eax
	addl	$1, %eax
	movw	%ax, PC(%rip)
	movzwl	PC(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, MDR(%rip)
	popq	%rbp
	ret
	.seh_endproc
	.globl	jump
	.def	jump;	.scl	2;	.type	32;	.endef
	.seh_proc	jump
jump:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movl	%ecx, %eax
	movw	%ax, 16(%rbp)
	movzwl	16(%rbp), %eax
	movw	%ax, PC(%rip)
	movzwl	PC(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, MDR(%rip)
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "\12Register dump:\0"
	.text
	.globl	halt
	.def	halt;	.scl	2;	.type	32;	.endef
	.seh_proc	halt
halt:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_setframe	%rbp, 32
	.seh_endprologue
	leaq	.LC1(%rip), %rcx
	call	puts
	call	registerDump
	movl	$0, %ecx
	call	exit
	nop
	.seh_endproc
	.globl	fetch
	.def	fetch;	.scl	2;	.type	32;	.endef
	.seh_proc	fetch
fetch:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_setframe	%rbp, 32
	.seh_endprologue
	movzwl	PC(%rip), %eax
	testw	%ax, %ax
	jne	.L29
	movzwl	PC(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, MDR(%rip)
.L29:
	movzbl	MDR(%rip), %eax
	movb	%al, IR(%rip)
	movzbl	IR(%rip), %eax
	cmpb	$31, %al
	setbe	%dl
	movzbl	IR(%rip), %eax
	shrb	$7, %al
	orl	%edx, %eax
	testb	%al, %al
	je	.L30
	movb	$1, WM(%rip)
	jmp	.L28
.L30:
	movzbl	IR(%rip), %eax
	cmpb	$63, %al
	ja	.L32
	movb	$2, WM(%rip)
	call	incPC
	movzbl	MDR(%rip), %eax
	movb	%al, 1+IR(%rip)
	jmp	.L28
.L32:
	movzbl	IR(%rip), %eax
	cmpb	$63, %al
	jbe	.L28
	movb	$3, WM(%rip)
	call	incPC
	movzbl	MDR(%rip), %eax
	movb	%al, 1+IR(%rip)
	call	incPC
	movzbl	MDR(%rip), %eax
	movb	%al, 2+IR(%rip)
	nop
.L28:
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	decode
	.def	decode;	.scl	2;	.type	32;	.endef
	.seh_proc	decode
decode:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movzbl	WM(%rip), %eax
	movsbl	%al, %eax
	cmpl	$2, %eax
	je	.L36
	cmpl	$3, %eax
	je	.L37
	cmpl	$1, %eax
	jmp	.L33
.L36:
	movzbl	1+IR(%rip), %eax
	movb	%al, FETCH(%rip)
	jmp	.L33
.L37:
	movzbl	1+IR(%rip), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	movl	%eax, %edx
	movzbl	2+IR(%rip), %eax
	movzbl	%al, %eax
	orl	%edx, %eax
	movw	%ax, AH(%rip)
	nop
.L33:
	popq	%rbp
	ret
	.seh_endproc
	.globl	execute
	.def	execute;	.scl	2;	.type	32;	.endef
	.seh_proc	execute
execute:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$40, %rsp
	.seh_stackalloc	40
	.seh_setframe	%rbp, 48
	.seh_endprologue
	movzbl	IR(%rip), %eax
	movzbl	%al, %eax
	cmpl	$130, %eax
	ja	.L38
	movl	%eax, %eax
	leaq	0(,%rax,4), %rdx
	leaq	.L115(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rdx
	leaq	.L115(%rip), %rax
	addq	%rdx, %rax
	jmp	*%rax
	.section .rdata,"dr"
	.align 4
.L115:
	.long	.L38-.L115
	.long	.L41-.L115
	.long	.L42-.L115
	.long	.L43-.L115
	.long	.L44-.L115
	.long	.L45-.L115
	.long	.L46-.L115
	.long	.L47-.L115
	.long	.L48-.L115
	.long	.L49-.L115
	.long	.L50-.L115
	.long	.L51-.L115
	.long	.L52-.L115
	.long	.L53-.L115
	.long	.L54-.L115
	.long	.L38-.L115
	.long	.L56-.L115
	.long	.L57-.L115
	.long	.L58-.L115
	.long	.L59-.L115
	.long	.L60-.L115
	.long	.L61-.L115
	.long	.L62-.L115
	.long	.L63-.L115
	.long	.L64-.L115
	.long	.L65-.L115
	.long	.L66-.L115
	.long	.L67-.L115
	.long	.L68-.L115
	.long	.L69-.L115
	.long	.L70-.L115
	.long	.L71-.L115
	.long	.L72-.L115
	.long	.L73-.L115
	.long	.L74-.L115
	.long	.L75-.L115
	.long	.L76-.L115
	.long	.L77-.L115
	.long	.L78-.L115
	.long	.L79-.L115
	.long	.L80-.L115
	.long	.L81-.L115
	.long	.L82-.L115
	.long	.L83-.L115
	.long	.L84-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L85-.L115
	.long	.L86-.L115
	.long	.L87-.L115
	.long	.L88-.L115
	.long	.L89-.L115
	.long	.L90-.L115
	.long	.L91-.L115
	.long	.L92-.L115
	.long	.L93-.L115
	.long	.L94-.L115
	.long	.L95-.L115
	.long	.L96-.L115
	.long	.L97-.L115
	.long	.L98-.L115
	.long	.L99-.L115
	.long	.L100-.L115
	.long	.L101-.L115
	.long	.L102-.L115
	.long	.L103-.L115
	.long	.L104-.L115
	.long	.L105-.L115
	.long	.L106-.L115
	.long	.L107-.L115
	.long	.L108-.L115
	.long	.L109-.L115
	.long	.L110-.L115
	.long	.L111-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L38-.L115
	.long	.L112-.L115
	.long	.L113-.L115
	.long	.L114-.L115
	.text
.L41:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, X(%rip)
	jmp	.L38
.L42:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, Y(%rip)
	jmp	.L38
.L43:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, Z(%rip)
	jmp	.L38
.L44:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, F(%rip)
	jmp	.L38
.L45:
	movq	AP(%rip), %rax
	movzbl	X(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L46:
	movzbl	X(%rip), %eax
	movb	%al, Y(%rip)
	jmp	.L38
.L47:
	movzbl	X(%rip), %eax
	movb	%al, Z(%rip)
	jmp	.L38
.L48:
	movq	AP(%rip), %rax
	movzbl	Y(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L49:
	movzbl	Y(%rip), %eax
	movb	%al, X(%rip)
	jmp	.L38
.L50:
	movzbl	Y(%rip), %eax
	movb	%al, Z(%rip)
	jmp	.L38
.L51:
	movq	AP(%rip), %rax
	movzbl	Z(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L52:
	movzbl	Z(%rip), %eax
	movb	%al, X(%rip)
	jmp	.L38
.L53:
	movzbl	Z(%rip), %eax
	movb	%al, Y(%rip)
	jmp	.L38
.L54:
	movq	AP(%rip), %rax
	movzbl	F(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L56:
	movq	BP(%rip), %rax
	movzbl	X(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L57:
	movq	BP(%rip), %rax
	movzbl	Y(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L58:
	movq	BP(%rip), %rax
	movzbl	Z(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L59:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$1, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L60:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$2, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L61:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$3, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L62:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$4, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L63:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$5, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L64:
	movq	AP(%rip), %rbx
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	$6, %r8d
	movl	%eax, %ecx
	call	ALU
	movb	%al, (%rbx)
	jmp	.L38
.L65:
	movl	$1, %ecx
	call	assignAccumulator
	jmp	.L38
.L66:
	movl	$2, %ecx
	call	assignAccumulator
	jmp	.L38
.L67:
	movq	AP(%rip), %rax
	movq	BP(%rip), %rdx
	movzbl	(%rdx), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L68:
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, X(%rip)
	jmp	.L38
.L69:
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, Y(%rip)
	jmp	.L38
.L70:
	movq	BP(%rip), %rax
	movzbl	(%rax), %eax
	movb	%al, Z(%rip)
	jmp	.L38
.L71:
	call	halt
	jmp	.L38
.L72:
	movq	AP(%rip), %rax
	movzbl	FETCH(%rip), %edx
	movb	%dl, (%rax)
	jmp	.L38
.L73:
	movzbl	FETCH(%rip), %eax
	movb	%al, X(%rip)
	jmp	.L38
.L74:
	movzbl	FETCH(%rip), %eax
	movb	%al, Y(%rip)
	jmp	.L38
.L75:
	movzbl	FETCH(%rip), %eax
	movb	%al, Z(%rip)
	jmp	.L38
.L76:
	movzbl	FETCH(%rip), %eax
	movb	%al, F(%rip)
	jmp	.L38
.L77:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L116
	movzwl	vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L146
.L116:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L146
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L147
.L118:
	movzwl	vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L146
.L78:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L119
	movzwl	2+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L148
.L119:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L148
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L149
.L121:
	movzwl	2+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L148
.L79:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L122
	movzwl	4+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L150
.L122:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L150
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L151
.L124:
	movzwl	4+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L150
.L80:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L125
	movzwl	6+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L152
.L125:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L152
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L153
.L127:
	movzwl	6+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L152
.L81:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L128
	movzwl	8+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L154
.L128:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L154
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L155
.L130:
	movzwl	8+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L154
.L82:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L131
	movzwl	10+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L156
.L131:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L156
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L157
.L133:
	movzwl	10+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L156
.L83:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L134
	movzwl	12+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L158
.L134:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L158
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L159
.L136:
	movzwl	12+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L158
.L84:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	jne	.L137
	movzwl	14+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L160
.L137:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$7, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L160
	movzbl	FETCH(%rip), %eax
	testb	%al, %al
	jne	.L161
.L139:
	movzwl	14+vector(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L160
.L85:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	writeData
	jmp	.L38
.L86:
	movq	AP(%rip), %rdx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	readData
	jmp	.L38
.L87:
	movzbl	X(%rip), %eax
	movzbl	%al, %edx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	writeData
	jmp	.L38
.L88:
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	leaq	X(%rip), %rdx
	movl	%eax, %ecx
	call	readData
	jmp	.L38
.L89:
	movzbl	Y(%rip), %eax
	movzbl	%al, %edx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	writeData
	jmp	.L38
.L90:
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	leaq	Y(%rip), %rdx
	movl	%eax, %ecx
	call	readData
	jmp	.L38
.L91:
	movzbl	Z(%rip), %eax
	movzbl	%al, %edx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	writeData
	jmp	.L38
.L92:
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	leaq	Z(%rip), %rdx
	movl	%eax, %ecx
	call	readData
	jmp	.L38
.L93:
	movzbl	Z(%rip), %eax
	movzbl	%al, %edx
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	writeData
	jmp	.L38
.L94:
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	leaq	F(%rip), %rdx
	movl	%eax, %ecx
	call	readData
	jmp	.L38
.L95:
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L96:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$0, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L162
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L97:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$1, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L163
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L98:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$2, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L164
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L99:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$3, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L165
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L100:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$5, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L166
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L101:
	movzbl	F(%rip), %eax
	movzbl	%al, %eax
	movl	$6, %edx
	movl	%eax, %ecx
	call	testBit
	testb	%al, %al
	je	.L167
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L102:
	movzwl	AH(%rip), %eax
	movw	%ax, SP(%rip)
	jmp	.L38
.L103:
	movzwl	SP(%rip), %eax
	subl	$1, %eax
	movw	%ax, SP(%rip)
	movzwl	SP(%rip), %eax
	movzwl	%ax, %edx
	movq	AP(%rip), %rax
	movzbl	(%rax), %ecx
	movslq	%edx, %rdx
	leaq	memory(%rip), %rax
	movb	%cl, (%rdx,%rax)
	jmp	.L38
.L104:
	movq	AP(%rip), %rax
	movzwl	SP(%rip), %edx
	movzwl	%dx, %edx
	movslq	%edx, %rcx
	leaq	memory(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	movb	%dl, (%rax)
	movzwl	SP(%rip), %eax
	addl	$1, %eax
	movw	%ax, SP(%rip)
	jmp	.L38
.L105:
	movzwl	SP(%rip), %eax
	subl	$1, %eax
	movw	%ax, SP(%rip)
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movzbl	X(%rip), %ecx
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movb	%cl, (%rdx,%rax)
	jmp	.L38
.L106:
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, X(%rip)
	movzwl	SP(%rip), %eax
	addl	$1, %eax
	movw	%ax, SP(%rip)
	jmp	.L38
.L107:
	movzwl	SP(%rip), %eax
	subl	$1, %eax
	movw	%ax, SP(%rip)
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movzbl	Y(%rip), %ecx
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movb	%cl, (%rdx,%rax)
	jmp	.L38
.L108:
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, Y(%rip)
	movzwl	SP(%rip), %eax
	addl	$1, %eax
	movw	%ax, SP(%rip)
	jmp	.L38
.L109:
	movzwl	SP(%rip), %eax
	subl	$1, %eax
	movw	%ax, SP(%rip)
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movzbl	Z(%rip), %ecx
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movb	%cl, (%rdx,%rax)
	jmp	.L38
.L110:
	movzwl	SP(%rip), %eax
	movzwl	%ax, %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %eax
	movb	%al, Z(%rip)
	movzwl	SP(%rip), %eax
	addl	$1, %eax
	movw	%ax, SP(%rip)
	jmp	.L38
.L111:
	movzwl	IX(%rip), %edx
	movzwl	AH(%rip), %eax
	addl	%edx, %eax
	movw	%ax, AH(%rip)
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L112:
	movzwl	AH(%rip), %eax
	movw	%ax, IX(%rip)
	jmp	.L38
.L113:
	movzwl	IX(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	jmp	.L38
.L114:
	movq	AP(%rip), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movzwl	IX(%rip), %eax
	addl	%edx, %eax
	movw	%ax, AH(%rip)
	movzwl	AH(%rip), %eax
	movzwl	%ax, %eax
	movl	%eax, %ecx
	call	jump
	nop
	jmp	.L38
.L146:
	nop
	jmp	.L38
.L147:
	nop
	jmp	.L38
.L148:
	nop
	jmp	.L38
.L149:
	nop
	jmp	.L38
.L150:
	nop
	jmp	.L38
.L151:
	nop
	jmp	.L38
.L152:
	nop
	jmp	.L38
.L153:
	nop
	jmp	.L38
.L154:
	nop
	jmp	.L38
.L155:
	nop
	jmp	.L38
.L156:
	nop
	jmp	.L38
.L157:
	nop
	jmp	.L38
.L158:
	nop
	jmp	.L38
.L159:
	nop
	jmp	.L38
.L160:
	nop
	jmp	.L38
.L161:
	nop
	jmp	.L38
.L162:
	nop
	jmp	.L38
.L163:
	nop
	jmp	.L38
.L164:
	nop
	jmp	.L38
.L165:
	nop
	jmp	.L38
.L166:
	nop
	jmp	.L38
.L167:
	nop
.L38:
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.globl	run
	.def	run;	.scl	2;	.type	32;	.endef
	.seh_proc	run
run:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_setframe	%rbp, 32
	.seh_endprologue
	call	fetch
	call	decode
	call	execute
	call	incPC
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC2:
	.ascii "cls\0"
.LC3:
	.ascii "%c \0"
	.text
	.globl	display
	.def	display;	.scl	2;	.type	32;	.endef
	.seh_proc	display
display:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$304, %rsp
	.seh_stackalloc	304
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	movl	$0, 168(%rbp)
	movl	$32768, 172(%rbp)
	jmp	.L170
.L173:
	movl	172(%rbp), %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	movzbl	(%rdx,%rax), %edx
	movl	168(%rbp), %eax
	cltq
	movb	%dl, -96(%rbp,%rax)
	movl	168(%rbp), %eax
	cltq
	movzbl	-96(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L171
	movl	168(%rbp), %eax
	cltq
	movb	$42, -96(%rbp,%rax)
	jmp	.L172
.L171:
	movl	168(%rbp), %eax
	cltq
	movb	$35, -96(%rbp,%rax)
.L172:
	addl	$1, 168(%rbp)
	addl	$1, 172(%rbp)
.L170:
	cmpl	$33024, 172(%rbp)
	jle	.L173
	leaq	.LC2(%rip), %rcx
	call	system
	movl	$1, 172(%rbp)
	jmp	.L174
.L176:
	movl	172(%rbp), %eax
	subl	$1, %eax
	cltq
	movzbl	-96(%rbp,%rax), %eax
	movzbl	%al, %edx
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	172(%rbp), %eax
	andl	$15, %eax
	testl	%eax, %eax
	jne	.L175
	movl	$10, %ecx
	call	putchar
.L175:
	addl	$1, 172(%rbp)
.L174:
	cmpl	$256, 172(%rbp)
	jle	.L176
	addq	$304, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC4:
	.ascii "\12Enter name of .mcpu file to load as ROM: \0"
.LC5:
	.ascii "%s\0"
.LC6:
	.ascii "r\0"
	.align 8
.LC7:
	.ascii "\12ERROR: ROM file not found in current directory\0"
.LC8:
	.ascii "%d\0"
	.align 8
.LC9:
	.ascii "\12Machine code fetching complete, press ENTER to run\12\0"
	.text
	.globl	readMem
	.def	readMem;	.scl	2;	.type	32;	.endef
	.seh_proc	readMem
readMem:
	pushq	%rbp
	.seh_pushreg	%rbp
	subq	$560, %rsp
	.seh_stackalloc	560
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
.L178:
	leaq	.LC4(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	.LC5(%rip), %rax
	leaq	-96(%rbp), %rdx
	movq	%rax, %rcx
	call	scanf
	leaq	.LC6(%rip), %rdx
	leaq	-96(%rbp), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, 416(%rbp)
	cmpq	$0, 416(%rbp)
	jne	.L179
	leaq	.LC7(%rip), %rcx
	call	puts
	jmp	.L178
.L179:
	movl	$0, 428(%rbp)
	jmp	.L180
.L181:
	movl	428(%rbp), %eax
	movslq	%eax, %rdx
	leaq	memory(%rip), %rax
	leaq	(%rdx,%rax), %rcx
	leaq	.LC8(%rip), %rdx
	movq	416(%rbp), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	fscanf
	addl	$1, 428(%rbp)
.L180:
	cmpl	$16382, 428(%rbp)
	jle	.L181
	leaq	.LC9(%rip), %rcx
	call	puts
	call	getch
	movq	416(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	nop
	addq	$560, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_setframe	%rbp, 32
	.seh_endprologue
	call	__main
	call	readMem
.L183:
	call	run
	call	display
	jmp	.L183
	.seh_endproc
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	exit;	.scl	2;	.type	32;	.endef
	.def	putchar;	.scl	2;	.type	32;	.endef
	.def	system;	.scl	2;	.type	32;	.endef
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fscanf;	.scl	2;	.type	32;	.endef
	.def	getch;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
