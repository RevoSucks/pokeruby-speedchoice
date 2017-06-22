#include "global.h"
#include "pokemon.h"

extern void dp01_tbl1_exec_completed(void);
extern void nullsub_91(void);

extern void (*gUnknown_081FAD98[])(void);

extern u32 gBattleExecBuffer;
extern const u32 gBitTable[];
extern u8 gActiveBank;
extern u8 BattleBufferA[][0x200];

void sub_802C014(void) // PlayerBufferRunCommand
{
	if(gBattleExecBuffer & gBitTable[gActiveBank])
	{
		if(BattleBufferA[gActiveBank][0] <= 0x38)
			gUnknown_081FAD98[BattleBufferA[gActiveBank][0]]();
		else
			dp01_tbl1_exec_completed();
	}
}

/*
	thumb_func_start sub_802C014
sub_802C014: @ 802C014
	push {lr}
	ldr r2, _0802C048 @ =gBattleExecBuffer
	ldr r1, _0802C04C @ =gBitTable
	ldr r0, _0802C050 @ =gActiveBank
	ldrb r3, [r0]
	lsls r0, r3, 2
	adds r0, r1
	ldr r1, [r2]
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	beq _0802C060
	ldr r0, _0802C054 @ =BattleBufferA
	lsls r1, r3, 9
	adds r1, r0
	ldrb r0, [r1]
	cmp r0, 0x38
	bhi _0802C05C
	ldr r0, _0802C058 @ =gUnknown_081FAD98
	ldrb r1, [r1]
	lsls r1, 2
	adds r1, r0
	ldr r0, [r1]
	bl _call_via_r0
	b _0802C060
	.align 2, 0
_0802C048: .4byte gBattleExecBuffer
_0802C04C: .4byte gBitTable
_0802C050: .4byte gActiveBank
_0802C054: .4byte BattleBufferA
_0802C058: .4byte gUnknown_081FAD98
_0802C05C:
	bl dp01_tbl1_exec_completed
_0802C060:
	pop {r0}
	bx r0
	thumb_func_end sub_802C014
*/
