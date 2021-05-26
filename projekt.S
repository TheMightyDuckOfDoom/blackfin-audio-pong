#include    <defBF532.h>

.data
.section    .rodata
#define um_pro_sample 3573 * 2
#define SIG_LEN 10

level_str: .string "Level: "
final_str: .string "You've won the game!"

.align 2;
freqn_array: .short 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85

.align 2;

#define death_notes 13
death_freq:	.short 49, 34, 28800, 34, 34, 36, 41, 46, 73, 28800, 73, 92, 28800
death_length:	.short 28800/4, 28800/4, 28800/4, 28800/4, 38400/4, 38400/4, 38400/4, 28800/4, 28800/4, 28800/4, 28800/4, 28800/4, 28800

#define win_notes 16
win_freq:	.short 92, 49, 41, 31, 24, 58, 46, 39, 29, 23, 51, 41, 34, 26, 20, 28800
win_length:	.short 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 3600/2, 28800

#define coin_notes 2
coin_freq: .short 24, 18
coin_length: .short 28800/4, 20000

#define level_notes 33
level_freq: 	.short 73,92,73,92,73,61,46,61,28800,77,92,77,92,77,58,46,58,28000,69,82,69,82,69,51,41,28000,41,28000, 41,28000,41,36, 28800
level_length:	.short 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520, 11520/2, 11520/2, 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520, 11520/2, 11520/2, 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520/3, 11520, 500, 11520/3, 500, 11520/3, 500, 11520/3, 11520 * 4, 28800

.align 2;
signal_new_100: .short 0x0148, 0x0050, 0xfedf, 0xff25, 0x00b8, 0x0133, 0xffd6, 0xfeba, 0xff95, 0x0116, 0x00e7, 0xff4f, 0xfecc, 0x002c, 0x0147, 0x005d, 0xfedf, 0xff2d, 0x00cc, 0x0124, 0xffa7, 0xfeb9, 0xffdc, 0x0139, 0x0099, 0xfeff, 0xff0a, 0x00aa, 0x0131, 0xffc0, 0xfeb8, 0xffd3, 0x0139, 0x0093, 0xfef6, 0xff19, 0x00c3, 0x0122, 0xff94, 0xfebe, 0x0010, 0x0146, 0x004b, 0xfece, 0xff64, 0x0109, 0x00e0, 0xff2f, 0xfeec, 0x008f, 0x0135, 0xffb8, 0xfeba, 0x0001, 0x0146, 0x0043, 0xfec8, 0xff7f, 0x0120, 0x00b7, 0xff02, 0xff1c, 0x00d8, 0x0108, 0xff53, 0xfedd, 0x0082, 0x0135, 0xffa9, 0xfebf, 0x002e, 0x0147, 0xfff9, 0xfeb9, 0xffe4, 0x0145, 0x003b, 0xfec1, 0xffa9, 0x0138, 0x006e, 0xfecf, 0xff7e, 0x0129, 0x0092, 0xfede, 0xff62, 0x011c, 0x00a7, 0xfee8, 0xff52, 0x0115, 0x00b1, 0xfeec, 0xff4f, 0x0115, 0x00ae, 0xfee9, 0xff58, 0x011c

.align 2;
signal: .short 0x0ccd, 0x0148, 0xf361, 0xfd69, 0x0c87, 0x0243, 0xf349, 0xffb6, 0x0cbb, 0xfcb0

.align 2;
signal_old: .short 0x05d2, 0x083a, 0x0a53, 0x0bdf, 0x0cb2, 0x0cb2, 0x0bdf, 0x0a53, 0x083a, 0x05d2

.align 2;
#define numRecSamples 5000
data: 	.short 0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x02e9,0x041d,0x0529,0x05f0,0x0659,0x0659,0x05f0,0x0529,0x041d,0x02e9,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x05d2,0x083a,0x0a53,0x0bdf,0x0cb2,0x0cb2,0x0bdf,0x0a53,0x083a,0x05d2


.section extram
.align 4;
result:		.space numRecSamples * 2

.align 4;
received:	.space numRecSamples * 2
old_random: 	.word 0
try:	.short 0
level_max_tries: .short 0
random_tone:	.short 0
round:		.short 0
roundForNextLevel: .short 0

#define initialMaxTries 15
#define tryDecrementPerLevel 2
#define Level1Rounds 1
#define RoundIncrementPerLevel 1
#define FinalWinRounds 9 //7

.text
init:	
	[--SP] = RETS;
	//  Init uart
	call 	initx;
	R0 = 1; // USE MIC IN
	call inicodec;
start:
	//Read mic input to get a random seed
	call rxsport;
	P0.L = old_random;
	P0.H = old_random;
	[P0] = R0;

	P0.L = level_str;
	P0.H = level_str;

	call txstr;

	P0.L = roundForNextLevel;
	P0.H = roundForNextLevel;

	R0 = Level1Rounds (Z);
	W[P0] = R0;

	call txdec;
	call txbr;

	P0.L = level_max_tries;
	P0.H = level_max_tries;

	R0 = initialMaxTries (Z);
	W[P0] = R0;

	P4.L = round;
	P4.H = round;

	R0 = 0(Z);
	W[P4] = R0;

	jump mloop;

test_loop:
	R1 = level_notes(Z);

	P2.L = level_freq;
	P2.H = level_freq;

	P3.L = level_length;
	P3.H = level_length;

	call play_track;

	jump test_loop;

mloop:
	//Make random tone
	call random;
	R1 = 0xF(Z);
	R0 = R0 & R1; //Extract lower two bits

	R0 <<= 1;	

	//call txbr;
	//call txhex;

	R1.L = freqn_array;
	R1.H = freqn_array;
	R0 = R0 + R1;
	
	//call txbr;
	//call txhex;

	P0 = R0;
	
	//Load freq
	R0 = W[P0] (Z);

	//Store random tone
	P0.L = random_tone;
	P0.H = random_tone;
	W[P0] = R0;

	P1 = R0;
	R2.L = LO(48000);
	R2.H = HI(48000);
	call make_tone;

	call delay;
	
	P0.L = try;
	P0.H = try;
	R0 = 0(Z);
	W[P0] = R0;
//Counter tries
try_loop:
	call sendSignal;

	call receiveSignal;

	P0.L = signal;
	P0.H = signal;
	P1.L = received;
	P1.H = received;
	P2 = SIG_LEN (Z);
	P3 = numRecSamples (Z);
	P4.L = result;
	P4.H = result;

	call autokorrelation;

	P0.L = result;
	P0.H = result;
	P1 = numRecSamples (Z);
	call calcDistance;

	R2 = 12000 (Z);
	R1 = 0 (Z);

	CC = R0 < R1;
	if !CC jump skip_zero;
	R0 = 0 (Z);
skip_zero:
	R1 = 100 (Z);
	CC = R0 < R1;
	if CC jump skip_hundred;
	R0 = 100 (Z);
skip_hundred:
	P1 = R0;
	call make_tone;

	call delay;


	P0.L = try;
	P0.H = try;
	R2 = W[P0] (Z);
	R1 = 1 (Z);
	R2 = R2 + R1;
	
	W[P0] = R2;

	P0.L = level_max_tries;
	P0.H = level_max_tries;

	R1 = W[P0] (Z);
	CC = R2 < R1;
	if cc jump try_loop;

	//Check for win
	//R0 contains distance
	//load random tone
	P0.L = random_tone;
	P0.H = random_tone;
	R1 = W[P0] (Z);

	//Calculate distance
	R0 = R0 - R1;

	R0 = abs R0;
	
	R1 = 10 (Z); //win threshold

	CC = R0 < R1;
	if !cc jump lost;


	P4.L = round;
	P4.H = round;

	R0 = W[P4];
	R1 = 1(Z);
	R0 = R0 + R1;
	W[P4] = R0;

	//Current round in R0

	//call txbr;
	//call txdec;

	P0.L = roundForNextLevel;
	P0.H = roundForNextLevel;

	R1 = W[P0] (Z);

	CC = R1 == R0;	
	if !CC jump coin_sound;


	//Level is won/cleared
	
	//Increment to next level
	R0 = RoundIncrementPerLevel (Z);
	R1 = R0 + R1;

	W[P0] = R1;

	//Check if we won the game
	R0 = FinalWinRounds (Z);
	CC = R1 == R0;
	if !CC jump skip_final_win;

	P0.L = final_str;
	P0.H = final_str;

	call txstr;
	call txbr;

	R1 = level_notes(Z);

	P2.L = level_freq;
	P2.H = level_freq;

	P3.L = level_length;
	P3.H = level_length;

	call play_track;
	jump start;

skip_final_win:
	P0.L = level_str;
	P0.H = level_str;

	call txstr;
	
	R0 = R1;
	call txdec;
	call txbr;

	//Decrement tries for level
	P0.L = level_max_tries;
	P0.H = level_max_tries;

	R1 = W[P0] (Z);

	R0 = tryDecrementPerLevel (Z);

	R1 = R1 - R0;

	W[P0] = R1;


	//Reset round
	P4.L = round;
	P4.H = round;

	R0 = 0(Z);
	W[P4] = R0;

	R1 = win_notes(Z);

	P2.L = win_freq;
	P2.H = win_freq;

	P3.L = win_length;
	P3.H = win_length;

	jump play_win_sound;
coin_sound:
	R1 = coin_notes(Z);

	P2.L = coin_freq;
	P2.H = coin_freq;

	P3.L = coin_length;
	P3.H = coin_length;
play_win_sound:
	call play_track;
	jump skip_lost;
lost:
	P4.L = round;
	P4.H = round;

	R0 = 0(Z);
	W[P4] = R0;

	R1 = death_notes(Z);

	P2.L = death_freq;
	P2.H = death_freq;

	P3.L = death_length;
	P3.H = death_length;

	call play_track;

skip_lost:

	jump mloop;

delay:
	[--SP] = RETS;
	[--SP] = (R7:0);
	R0.L = 0;
	R0.H = 2;
	R1 = 1 (Z);
	R2 = 0 (Z);
delay_loop:
	R0 = R0 - R1;
	CC = R0 == R2;
	if !CC jump delay_loop;
	(R7:0) = [SP++];
	RETS = [SP++];
        RTS;

//Returns pseudo random number in R0
random:
	[--SP] = RETS;
	[--SP] = R1;

	P0.L = old_random;
	P0.H = old_random;

	R0 = [P0];
	R1 = R0 << 13;
	R0 = R0 ^ R1;

	R1 = R0 >> 17;
	R0 = R0 ^ R1;

	R1 = R0 << 5;
	R0 = R0 ^ R1;

	[P0] = R0;
	
	R1 = [SP++];
	RETS = [SP++];
        RTS;
//P0 autokorr, P1 data length => distance in cm in R0
calcDistance:
	[--SP] = RETS;
	[--SP] = (R7:1);

	R0 = 0(Z);
	R2 = R0;
	R3 = R0;	
	R4 = 1(Z);	

	LOOP maxl LC0 = P1;
	LOOP_BEGIN maxl;
		R1 = W[P0++];
		CC = R0 < R1;
		if !CC jump cont_maxl;
			R0 = R1;
			R3 = R2;
	cont_maxl:
		R2 = R2 + R4;
	LOOP_END maxl;
	
	//R3 index des samples

	//call txbr;
	R0 = R3;
	//call txdec;
	R1 = um_pro_sample(Z);

	R0 = 0(Z);

	R2 = (SIG_LEN / 2) (Z);

	CC = R3 < R2;
	if CC jump skip_adjustment;

	//call txbr;
	R3 = R3 - R2; //Zeit zum Senden abziehen
skip_adjustment:
	P1 = R3;

	LOOP calcD LC0 = P1;
	LOOP_BEGIN calcD;
		R0 = R0 + R1;
	LOOP_END calcD;
	
	//call txdec;
	//R0 length in um
	R1 = 0(Z);	
	R3 = 10100(Z);
	R4 = 1(Z);
mm_loop:
	CC = R0 < R3;
	if CC jump end_mm_loop;
	
	R1 = R1 + R4;
	R0 = R0 - R3;
	jump mm_loop;
end_mm_loop:
	R2 = 23(Z); //calibrierung
	R0 = R1 - R2;	
	
	
	//call txbr;
	//call txdec;
	
	(R7:1) = [SP++];
	RETS = [SP++];
        RTS;

//WICHTIG!!! Signal muss normiert sein! Durch anzahl elemente geteilt
//P0 16bit, P1 16bit, P4 16 bit
//P0 Signal, P1 Data, P2 Anzahl Elemente Signal, P3 Anzahl Elemente Data, 
//P4 Resultat
autokorrelation:
	[--SP] = RETS;
	[--SP] = (R7:0);
	// register wie auf papier

	R4 = 0(Z);
	
	//Calc end of data
	R5 = P1;
	R6 = P3;
	R6 <<= 1;
	R5 = R5 + R6;

	R3 = P2;

	//P1 = Data[i]
	LOOP koloop1 LC0 = P3;
	LOOP_BEGIN koloop1;
		P3 = P1;	//P3 = P1[0] = Data[i + 0]
		P5 = P0;	//P5 = Signal[0]	

		A0 = R4;
		LOOP kosum LC1 = P2;
		LOOP_BEGIN kosum;
			R0 = P3;
			CC = R0 < R5;
			if !CC jump skip_inner;

			R1 = W[P3++]; // R0 = Data[i + j]
			R2 = W[P5++]; // R1 = Signal[j]
			A0 += R1.L * R2.L;
		LOOP_END kosum;
	skip_inner:	
		P1 += 2;
		//Betrag nehmen
		A0 = ABS A0;
		R2.L = A0;
		W[P4++] = R2;
	LOOP_END koloop1;
	(R7:0) = [SP++];
	RETS = [SP++];
        RTS;

sendSignal:
	[--SP] = RETS;
	[--SP] = R0;
	[--SP] = R1;

	P0.L = signal;
	P0.H = signal;

	P1 = SIG_LEN (Z);
	LOOP sendloop LC0 = P1;
	LOOP_BEGIN sendloop;
		//De normalisieren -> lauter machen
		R1 = W[P0++];
		R0 = R1;

		P2 = (SIG_LEN - 1) (Z);
		LOOP multl LC1 = P2;
		LOOP_BEGIN multl;
			R0 = R0 + R1;
		LOOP_END multl;
		call txsport;
		call txsport;
	LOOP_END sendloop;
	
	R1 = [SP++];
	R0 = [SP++];
	RETS = [SP++];
	RTS;

receiveSignal:
	[--SP] = RETS;
	[--SP] = R0;

	P0.L = received;
	P0.H = received; 
	P1 = numRecSamples (Z);

	LOOP receiveloop LC0 = P1;
	LOOP_BEGIN receiveloop;
		call rxsport;
		call rxsport;

		W[P0++] = R0;
	LOOP_END receiveloop;

	R0 = [SP++];
	RETS = [SP++];
	RTS;

//R1 number of notes, P2 frequnecies, P3 lengths
play_track:
	[--SP] = RETS;
	[--SP] = (R7:0);

	R4 = 1 (Z); //Incrementer
	R3 = 0 (Z); //counter

	//call txbr;
	//R0 = 'T';
	//call txchr;

play_loop:
	//Load frequency
	R0 = W[P2++] (Z);
	P1 = R0;

	//call txbr;
	//call txdec;

	//Load length
	R2 = W[P3++] (Z);

	call make_tone;

	R3 = R3 + R4;
	CC = R3 < R1;
	if CC jump play_loop;

	(R7:0) = [SP++];
	RETS = [SP++];
	RTS;

// R2 maxSamples, P1 numCount \ freq_n
make_tone:
	[--SP] = RETS;
	[--SP] = (R7:0);
	R0.L = 0x0400;
	R1.L = 0x8000; // -1
	R3 = 0 (Z);
	R4 = 1 (Z);
repeat_loop:
	R0.L = R0.L * R1.L;
	LOOP count LC1 = P1;
	LOOP_BEGIN count;
		call txsport;
		call txsport;

		R3 = R3 + R4;
		CC = R2 < R3;
		if CC jump end_repeat;
	LOOP_END count;

	jump repeat_loop;
end_repeat:
	
	(R7:0) = [SP++];
	RETS = [SP++];
	RTS;
	
	
