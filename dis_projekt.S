
projekt.o:     file format elf32-bfin


Disassembly of section .text:

00000000 <init>:
   0:	67 01       	[--SP] = RETS;
   2:	ff e3 ff ff 	CALL 0x0 <init>;
   6:	08 e1 00 00 	P0.L = 0x0;		/* (  0)	P0=0x0 <init> */
   a:	48 e1 00 00 	P0.H = 0x0;		/* (  0)	P0=0x0 <init> */
   e:	88 61       	R0 = 0x31 (X);		/*		R0=0x31( 49) */
  10:	ff e3 f8 ff 	CALL 0x0 <init>;
  14:	08 e1 0f 00 	P0.L = 0xf;		/* ( 15)	P0=0xf */
  18:	48 e1 00 00 	P0.H = 0x0;		/* (  0)	P0=0xf */
  1c:	40 30       	R0 = P0;
  1e:	ff e3 f1 ff 	CALL 0x0 <init>;
  22:	09 e1 13 00 	P1.L = 0x13;		/* ( 19)	P1=0x13 */
  26:	49 e1 00 00 	P1.H = 0x0;		/* (  0)	P1=0x13 */
  2a:	8a e1 02 00 	P2 = 0x2 (Z);		/*		P2=0x2(  2) */
  2e:	8b e1 06 00 	P3 = 0x6 (Z);		/*		P3=0x6(  6) */
  32:	0c e1 00 00 	P4.L = 0x0;		/* (  0)	P4=0x0 <init> */
  36:	4c e1 00 00 	P4.H = 0x0;		/* (  0)	P4=0x0 <init> */
  3a:	90 61       	R0 = 0x32 (X);		/*		R0=0x32( 50) */
  3c:	ff e3 e2 ff 	CALL 0x0 <init>;
  40:	00 e3 12 00 	CALL 0x64 <autokorrelation>;
  44:	0c e1 00 00 	P4.L = 0x0;		/* (  0)	P4=0x0 <init> */
  48:	4c e1 00 00 	P4.H = 0x0;		/* (  0)	P4=0x0 <init> */
  4c:	83 e1 00 00 	R3 = 0x0 (Z);		/*		R3=0x0 <init>(  0) */
  50:	34 60       	R4 = 0x6 (X);		/*		R4=0x6(  6) */
  52:	85 e1 01 00 	R5 = 0x1 (Z);		/*		R5=0x1(  1) */

00000056 <print_loop>:
  56:	20 94       	R0 = W[P4++] (Z);
  58:	ff e3 d4 ff 	CALL 0x0 <init>;
  5c:	2c 53       	R4 = R4 - R5;
  5e:	a3 08       	CC = R3 < R4;
  60:	fb 1b       	IF CC JUMP 0x56 <print_loop>;

00000062 <mloop>:
  62:	00 20       	JUMP.S 0x62 <mloop>;

00000064 <autokorrelation>:
  64:	67 01       	[--SP] = RETS;
  66:	20 e1 53 00 	R0 = 0x53 (X);		/*		R0=0x53( 83) */
  6a:	ff e3 cb ff 	CALL 0x0 <init>;
  6e:	a2 e0 0d 30 	LSETUP(0x72 <autokorrelation+0xe>, 0x88 <autokorrelation+0x24>) LC0 = P3;
  72:	00 00       	NOP;
  74:	20 e1 4c 00 	R0 = 0x4c (X);		/*		R0=0x4c( 76) */
  78:	ff e3 c4 ff 	CALL 0x0 <init>;
  7c:	59 32       	P3 = P1;
  7e:	68 32       	P5 = P0;
  80:	b2 e0 04 20 	LSETUP(0x84 <autokorrelation+0x20>, 0x88 <autokorrelation+0x24>) LC1 = P2;
  84:	20 e1 50 00 	R0 = 0x50 (X);		/*		R0=0x50( 80) */
  88:	ff e3 bc ff 	CALL 0x0 <init>;
  8c:	20 e1 45 00 	R0 = 0x45 (X);		/*		R0=0x45( 69) */
  90:	ff e3 b8 ff 	CALL 0x0 <init>;
  94:	27 01       	RETS = [SP++];
  96:	10 00       	RTS;

Disassembly of section .rodata:

00000000 <hello_msg>:
   0:	48 61       	R0 = 0x29 (X);		/*		R0=0x29( 41) */
   2:	6c 6c       	P4 += 0xd;		/* ( 13) */
   4:	6f 2c       	JUMP.S 0xfffff8e2 <autokorrelation+0xfffff87e>;
   6:	20 65       	R0 += 0x24;		/* ( 36) */
   8:	73 20       	JUMP.S 0xee <autokorrelation+0x8a>;
   a:	74 75       	ILLEGAL;
   c:	74 21       	JUMP.S 0x2f4 <autokorrelation+0x290>;
	...

0000000f <signal>:
   f:	00 00       	NOP;
  11:	01 00       	ILLEGAL;

00000013 <data>:
  13:	00 00       	NOP;
  15:	05 00       	(R7:0) = [SP++];
  17:	03 00       	CC = AZ;
  19:	00 00       	NOP;
  1b:	00 00       	NOP;
  1d:	02 00       	R0 = CC;

Disassembly of section extram:

00000000 <result>:
	...
