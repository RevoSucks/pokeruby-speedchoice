	.include "constants/gba_constants.inc"
	.include "constants/species_constants.inc"
	.include "asm/macros.inc"

	.syntax unified

	.text


	thumb_func_start atk48_playstatchangeanimation
atk48_playstatchangeanimation: @ 80215FC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	movs r7, 0
	movs r0, 0
	mov r8, r0
	movs r3, 0
	ldr r5, _08021670 @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	str r3, [sp]
	bl GetBattleBank
	ldr r2, _08021674 @ =gActiveBank
	strb r0, [r2]
	ldr r0, [r5]
	ldrb r4, [r0, 0x2]
	ldrb r1, [r0, 0x3]
	movs r0, 0x1
	ands r0, r1
	ldr r3, [sp]
	cmp r0, 0
	beq _08021710
	movs r0, 0x2
	ands r0, r1
	movs r1, 0x15
	cmp r0, 0
	beq _0802163C
	movs r1, 0x2D
_0802163C:
	cmp r4, 0
	beq _080216E4
	movs r0, 0x1
	mov r10, r0
	ldr r0, _08021678 @ =gUnknown_02024A98
	mov r9, r0
	lsls r5, r1, 16
_0802164A:
	adds r0, r4, 0
	mov r1, r10
	ands r0, r1
	cmp r0, 0
	beq _080216D6
	ldr r0, _08021670 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r1, [r0, 0x3]
	movs r0, 0x8
	ands r0, r1
	cmp r0, 0
	beq _0802167C
	ldr r0, _08021674 @ =gActiveBank
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r7, r0
	b _080216C4
	.align 2, 0
_08021670: .4byte gBattlescriptCurrInstr
_08021674: .4byte gActiveBank
_08021678: .4byte gUnknown_02024A98
_0802167C:
	ldr r6, _08021700 @ =gActiveBank
	ldrb r0, [r6]
	str r3, [sp]
	bl GetBankIdentity
	mov r1, r10
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	ldr r1, _08021704 @ =gSideTimer
	adds r0, r1
	ldrb r0, [r0, 0x2]
	ldr r3, [sp]
	cmp r0, 0
	bne _080216D6
	ldr r0, _08021708 @ =gBattleMons
	ldrb r2, [r6]
	movs r1, 0x58
	muls r2, r1
	adds r0, r2, r0
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x1D
	beq _080216D6
	cmp r0, 0x49
	beq _080216D6
	cmp r0, 0x33
	bne _080216BA
	cmp r7, 0x6
	beq _080216D6
_080216BA:
	cmp r0, 0x34
	bne _080216C2
	cmp r7, 0x1
	beq _080216D6
_080216C2:
	adds r0, r7, r2
_080216C4:
	add r0, r9
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	cmp r0, 0
	ble _080216D6
	lsrs r0, r5, 16
	mov r8, r0
	adds r3, 0x1
_080216D6:
	lsrs r4, 1
	movs r1, 0x80
	lsls r1, 9
	adds r5, r1
	adds r7, 0x1
	cmp r4, 0
	bne _0802164A
_080216E4:
	ldr r0, _0802170C @ =gBattlescriptCurrInstr
	mov r9, r0
	cmp r3, 0x1
	ble _08021772
	ldr r0, [r0]
	ldrb r1, [r0, 0x3]
	movs r0, 0x2
	ands r0, r1
	movs r1, 0x39
	mov r8, r1
	cmp r0, 0
	beq _08021772
	movs r0, 0x3A
	b _08021770
	.align 2, 0
_08021700: .4byte gActiveBank
_08021704: .4byte gSideTimer
_08021708: .4byte gBattleMons
_0802170C: .4byte gBattlescriptCurrInstr
_08021710:
	movs r0, 0x2
	ands r0, r1
	movs r1, 0xE
	cmp r0, 0
	beq _0802171C
	movs r1, 0x26
_0802171C:
	mov r9, r5
	cmp r4, 0
	beq _08021758
	ldr r6, _0802178C @ =gUnknown_02024A98
	adds r5, r2, 0
	lsls r2, r1, 16
_08021728:
	movs r0, 0x1
	ands r0, r4
	cmp r0, 0
	beq _0802174A
	ldrb r1, [r5]
	movs r0, 0x58
	muls r0, r1
	adds r0, r7, r0
	adds r0, r6
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	cmp r0, 0xB
	bgt _0802174A
	lsrs r1, r2, 16
	mov r8, r1
	adds r3, 0x1
_0802174A:
	lsrs r4, 1
	movs r0, 0x80
	lsls r0, 9
	adds r2, r0
	adds r7, 0x1
	cmp r4, 0
	bne _08021728
_08021758:
	cmp r3, 0x1
	ble _08021772
	mov r1, r9
	ldr r0, [r1]
	ldrb r1, [r0, 0x3]
	movs r0, 0x2
	ands r0, r1
	movs r1, 0x37
	mov r8, r1
	cmp r0, 0
	beq _08021772
	movs r0, 0x38
_08021770:
	mov r8, r0
_08021772:
	mov r1, r9
	ldr r2, [r1]
	ldrb r1, [r2, 0x3]
	movs r0, 0x4
	ands r0, r1
	cmp r0, 0
	beq _08021790
	cmp r3, 0x1
	bgt _08021790
	adds r0, r2, 0x4
	mov r1, r9
	b _080217E6
	.align 2, 0
_0802178C: .4byte gUnknown_02024A98
_08021790:
	cmp r3, 0
	beq _080217E0
	ldr r0, _080217D0 @ =0x02000000
	ldr r1, _080217D4 @ =0x000160dc
	adds r4, r0, r1
	ldrb r0, [r4]
	cmp r0, 0
	bne _080217E0
	movs r0, 0
	movs r1, 0x1
	mov r2, r8
	str r3, [sp]
	bl EmitBattleAnimation
	ldr r0, _080217D8 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r0, _080217DC @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r1, [r0, 0x3]
	movs r0, 0x4
	ands r0, r1
	ldr r3, [sp]
	cmp r0, 0
	beq _080217CC
	cmp r3, 0x1
	ble _080217CC
	movs r0, 0x1
	strb r0, [r4]
_080217CC:
	ldr r1, _080217DC @ =gBattlescriptCurrInstr
	b _080217E2
	.align 2, 0
_080217D0: .4byte 0x02000000
_080217D4: .4byte 0x000160dc
_080217D8: .4byte gActiveBank
_080217DC: .4byte gBattlescriptCurrInstr
_080217E0:
	mov r1, r9
_080217E2:
	ldr r0, [r1]
	adds r0, 0x4
_080217E6:
	str r0, [r1]
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end atk48_playstatchangeanimation

	thumb_func_start sub_80217F8
sub_80217F8: @ 80217F8
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x18
	movs r0, 0
	mov r10, r0
	ldr r0, _08021834 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r1, [r0, 0x1]
	str r1, [sp, 0x10]
	ldrb r0, [r0, 0x2]
	str r0, [sp, 0x14]
	ldr r1, _08021838 @ =gBattleMons
	ldr r0, _0802183C @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r1, r0, r1
	ldrh r0, [r1, 0x2E]
	cmp r0, 0xAF
	bne _08021844
	ldr r1, _08021840 @ =gEnigmaBerries
	lsls r0, r2, 3
	subs r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x7]
	b _0802184E
	.align 2, 0
_08021834: .4byte gBattlescriptCurrInstr
_08021838: .4byte gBattleMons
_0802183C: .4byte gBankAttacker
_08021840: .4byte gEnigmaBerries
_08021844:
	ldrh r0, [r1, 0x2E]
	bl ItemId_GetHoldEffect
	lsls r0, 24
	lsrs r0, 24
_0802184E:
	str r0, [sp, 0x8]
	ldr r0, _0802186C @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 1
	ldr r0, _08021870 @ =0x020160e8
	adds r1, r0
	str r1, [sp, 0xC]
	subs r0, 0xCC
	ldrb r0, [r0]
	cmp r0, 0
	beq _080218C0
	movs r2, 0x3F
	ands r2, r0
	str r2, [sp, 0x4]
	b _080218D2
	.align 2, 0
_0802186C: .4byte gBankAttacker
_08021870: .4byte 0x020160e8
_08021874:
	strb r2, [r7]
	ldr r0, [r5]
	orrs r0, r6
	str r0, [r5]
	ldr r0, _080218AC @ =0x02000000
	ldr r3, _080218B0 @ =0x0001600c
	adds r0, r3
	strb r4, [r0]
	bl MoveValuesCleanUp
	ldr r2, _080218B4 @ =gUnknown_081D6BBC
	mov r4, r8
	ldrh r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	add r0, r9
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r2
	ldr r0, [r0]
	bl b_movescr_stack_push
	ldr r1, _080218B8 @ =gBattlescriptCurrInstr
	ldr r0, _080218BC @ =gUnknown_081D9B2D
	bl _0802229C
	.align 2, 0
_080218AC: .4byte 0x02000000
_080218B0: .4byte 0x0001600c
_080218B4: .4byte gUnknown_081D6BBC
_080218B8: .4byte gBattlescriptCurrInstr
_080218BC: .4byte gUnknown_081D9B2D
_080218C0:
	ldr r2, _080218D8 @ =gBattleMoves
	ldr r0, _080218DC @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x2]
	str r0, [sp, 0x4]
_080218D2:
	ldr r5, _080218E0 @ =0x02000000
	mov r12, r5
	b _080218EE
	.align 2, 0
_080218D8: .4byte gBattleMoves
_080218DC: .4byte gCurrentMove
_080218E0: .4byte 0x02000000
_080218E4:
	mov r0, r10
	cmp r0, 0
	beq _080218EE
	bl _08022286
_080218EE:
	ldr r0, _08021908 @ =0x0001600c
	add r0, r12
	ldrb r0, [r0]
	cmp r0, 0x11
	bls _080218FC
	bl _0802224E
_080218FC:
	lsls r0, 2
	ldr r1, _0802190C @ =_08021910
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08021908: .4byte 0x0001600c
_0802190C: .4byte _08021910
	.align 2, 0
_08021910:
	.4byte _08021958
	.4byte _08021A34
	.4byte _08021AF0
	.4byte _08021B20
	.4byte _08021B44
	.4byte _08021B78
	.4byte _08021B9C
	.4byte _08021C40
	.4byte _08021C78
	.4byte _08021CA8
	.4byte _08021CCC
	.4byte _08021D18
	.4byte _08021DAC
	.4byte _08021E30
	.4byte _08021E70
	.4byte _08022068
	.4byte _080221C0
	.4byte _0802224E
_08021958:
	ldr r5, _08021A08 @ =gBattleMons
	ldr r2, _08021A0C @ =gBankTarget
	ldrb r4, [r2]
	movs r6, 0x58
	adds r3, r4, 0
	muls r3, r6
	adds r0, r5, 0
	adds r0, 0x50
	adds r0, r3, r0
	ldr r1, [r0]
	movs r0, 0x80
	lsls r0, 16
	ands r1, r0
	cmp r1, 0
	beq _080219FE
	adds r0, r3, r5
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _080219FE
	ldr r0, _08021A10 @ =gBankAttacker
	ldrb r1, [r0]
	cmp r1, r4
	beq _080219FE
	adds r0, r1, 0
	bl GetBankSide
	adds r4, r0, 0
	ldr r1, _08021A0C @ =gBankTarget
	ldrb r0, [r1]
	bl GetBankSide
	lsls r4, 24
	lsls r0, 24
	cmp r4, r0
	beq _080219FE
	ldr r0, _08021A14 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	bne _080219FE
	ldr r2, _08021A18 @ =gProtectStructs
	ldr r4, _08021A0C @ =gBankTarget
	ldrb r3, [r4]
	lsls r1, r3, 4
	adds r0, r2, 0x4
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	bne _080219C8
	adds r0, r2, 0
	adds r0, 0x8
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	beq _080219FE
_080219C8:
	ldr r2, _08021A1C @ =gBattleMoves
	ldr r0, _08021A20 @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x1]
	cmp r0, 0
	beq _080219FE
	adds r0, r3, 0
	muls r0, r6
	adds r1, r0, r5
	ldrb r2, [r1, 0x19]
	movs r0, 0x19
	ldrsb r0, [r1, r0]
	cmp r0, 0xB
	bgt _080219FE
	adds r0, r2, 0x1
	strb r0, [r1, 0x19]
	bl b_movescr_stack_push_cursor
	ldr r1, _08021A24 @ =gBattlescriptCurrInstr
	ldr r0, _08021A28 @ =gUnknown_081D9132
	str r0, [r1]
	movs r5, 0x1
	mov r10, r5
_080219FE:
	ldr r2, _08021A2C @ =0x02000000
	ldr r0, _08021A30 @ =0x0001600c
	adds r1, r2, r0
	b _08021E00
	.align 2, 0
_08021A08: .4byte gBattleMons
_08021A0C: .4byte gBankTarget
_08021A10: .4byte gBankAttacker
_08021A14: .4byte gBattleMoveFlags
_08021A18: .4byte gProtectStructs
_08021A1C: .4byte gBattleMoves
_08021A20: .4byte gCurrentMove
_08021A24: .4byte gBattlescriptCurrInstr
_08021A28: .4byte gUnknown_081D9132
_08021A2C: .4byte 0x02000000
_08021A30: .4byte 0x0001600c
_08021A34:
	ldr r2, _08021AD0 @ =gBattleMons
	ldr r1, _08021AD4 @ =gBankTarget
	ldrb r4, [r1]
	movs r3, 0x58
	mov r12, r3
	mov r3, r12
	muls r3, r4
	adds r7, r2, 0
	adds r7, 0x4C
	adds r6, r3, r7
	ldr r5, [r6]
	movs r0, 0x20
	ands r0, r5
	cmp r0, 0
	bne _08021A54
	b _08021DFA
_08021A54:
	adds r0, r3, r2
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	bne _08021A5E
	b _08021DFA
_08021A5E:
	ldr r0, _08021AD8 @ =gBankAttacker
	ldrb r0, [r0]
	cmp r0, r4
	bne _08021A68
	b _08021DFA
_08021A68:
	ldr r0, _08021ADC @ =gSpecialStatuses
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 2
	adds r0, 0xC
	adds r1, r0
	ldr r0, [r1]
	cmp r0, 0
	bne _08021A7C
	b _08021DFA
_08021A7C:
	ldr r0, _08021AE0 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	beq _08021A8A
	b _08021DFA
_08021A8A:
	ldr r4, [sp, 0x4]
	cmp r4, 0xA
	beq _08021A92
	b _08021DFA
_08021A92:
	movs r0, 0x21
	negs r0, r0
	ands r5, r0
	str r5, [r6]
	ldr r4, _08021AE4 @ =gActiveBank
	ldr r5, _08021AD4 @ =gBankTarget
	ldrb r0, [r5]
	strb r0, [r4]
	ldrb r0, [r5]
	mov r1, r12
	muls r1, r0
	adds r0, r1, 0
	adds r0, r7
	str r0, [sp]
	movs r0, 0
	movs r1, 0x28
	movs r2, 0
	movs r3, 0x4
	bl EmitSetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	bl b_movescr_stack_push_cursor
	ldr r1, _08021AE8 @ =gBattlescriptCurrInstr
	ldr r0, _08021AEC @ =gUnknown_081D955D
	str r0, [r1]
	movs r2, 0x1
	mov r10, r2
	b _08021DFA
	.align 2, 0
_08021AD0: .4byte gBattleMons
_08021AD4: .4byte gBankTarget
_08021AD8: .4byte gBankAttacker
_08021ADC: .4byte gSpecialStatuses
_08021AE0: .4byte gBattleMoveFlags
_08021AE4: .4byte gActiveBank
_08021AE8: .4byte gBattlescriptCurrInstr
_08021AEC: .4byte gUnknown_081D955D
_08021AF0:
	ldr r0, _08021B14 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0
	str r0, [sp]
	movs r0, 0x7
	movs r2, 0
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	beq _08021B0C
	movs r4, 0x1
	mov r10, r4
_08021B0C:
	ldr r2, _08021B18 @ =0x02000000
	ldr r5, _08021B1C @ =0x0001600c
	adds r1, r2, r5
	b _08021E00
	.align 2, 0
_08021B14: .4byte gBankTarget
_08021B18: .4byte 0x02000000
_08021B1C: .4byte 0x0001600c
_08021B20:
	ldr r0, _08021B40 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0
	str r0, [sp]
	movs r0, 0x4
	movs r2, 0
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	bne _08021B3A
	b _08021DFA
_08021B3A:
	movs r0, 0x1
	mov r10, r0
	b _08021DFA
	.align 2, 0
_08021B40: .4byte gBankTarget
_08021B44:
	movs r0, 0
	str r0, [sp]
	movs r0, 0x5
	movs r1, 0
	movs r2, 0
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	beq _08021B68
	movs r4, 0x1
	mov r10, r4
	ldr r5, _08021B64 @ =0x02000000
	mov r12, r5
	b _0802224E
	.align 2, 0
_08021B64: .4byte 0x02000000
_08021B68:
	ldr r2, _08021B70 @ =0x02000000
	ldr r0, _08021B74 @ =0x0001600c
	adds r1, r2, r0
	b _08021E00
	.align 2, 0
_08021B70: .4byte 0x02000000
_08021B74: .4byte 0x0001600c
_08021B78:
	ldr r0, _08021B98 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0
	str r0, [sp]
	movs r0, 0x8
	movs r2, 0
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	bne _08021B92
	b _08021DFA
_08021B92:
	movs r1, 0x1
	mov r10, r1
	b _08021DFA
	.align 2, 0
_08021B98: .4byte gBankAttacker
_08021B9C:
	ldr r0, _08021C28 @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 18
	ands r0, r1
	cmp r0, 0
	beq _08021BE0
	ldr r4, [sp, 0x8]
	cmp r4, 0x1D
	bne _08021BE0
	ldr r0, _08021C2C @ =gUnknown_02024BE8
	ldrh r2, [r0]
	adds r7, r0, 0
	cmp r2, 0xA5
	beq _08021BE0
	ldr r5, [sp, 0xC]
	ldrh r1, [r5]
	cmp r1, 0
	beq _08021BC8
	ldr r0, _08021C30 @ =0x0000ffff
	cmp r1, r0
	bne _08021BE0
_08021BC8:
	cmp r2, 0xE2
	bne _08021BDA
	ldr r0, _08021C34 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x20
	ands r0, r1
	cmp r0, 0
	bne _08021BDA
	b _08022244
_08021BDA:
	ldrh r0, [r7]
	ldr r1, [sp, 0xC]
	strh r0, [r1]
_08021BE0:
	movs r4, 0
	ldr r2, _08021C38 @ =gBattleMons
	ldr r3, _08021C3C @ =gBankAttacker
	ldrb r1, [r3]
	movs r0, 0x58
	muls r0, r1
	adds r2, 0xC
	adds r0, r2
	ldrh r0, [r0]
	ldr r5, [sp, 0xC]
	ldrh r1, [r5]
	mov r9, r3
	cmp r0, r1
	beq _08021C18
	mov r6, r9
	movs r3, 0x58
	adds r5, r1, 0
_08021C02:
	adds r4, 0x1
	cmp r4, 0x3
	bgt _08021C18
	lsls r0, r4, 1
	ldrb r1, [r6]
	muls r1, r3
	adds r0, r1
	adds r0, r2
	ldrh r0, [r0]
	cmp r0, r5
	bne _08021C02
_08021C18:
	cmp r4, 0x4
	beq _08021C1E
	b _08022244
_08021C1E:
	movs r0, 0
	ldr r1, [sp, 0xC]
_08021C22:
	strh r0, [r1]
	b _08022244
	.align 2, 0
_08021C28: .4byte gHitMarker
_08021C2C: .4byte gUnknown_02024BE8
_08021C30: .4byte 0x0000ffff
_08021C34: .4byte gBattleMoveFlags
_08021C38: .4byte gBattleMons
_08021C3C: .4byte gBankAttacker
_08021C40:
	movs r4, 0
	ldr r0, _08021C6C @ =gNoOfAllBanks
	ldrb r2, [r0]
	cmp r4, r2
	blt _08021C4C
	b _08022244
_08021C4C:
	movs r5, 0
	ldr r2, _08021C70 @ =0x020160f0
	ldr r3, _08021C74 @ =gBattleMons
_08021C52:
	ldrh r1, [r2]
	cmp r1, 0
	beq _08021C5C
	strh r1, [r3, 0x2E]
	strh r5, [r2]
_08021C5C:
	adds r2, 0x2
	adds r3, 0x58
	adds r4, 0x1
	ldrb r1, [r0]
	cmp r4, r1
	blt _08021C52
	b _08022244
	.align 2, 0
_08021C6C: .4byte gNoOfAllBanks
_08021C70: .4byte 0x020160f0
_08021C74: .4byte gBattleMons
_08021C78:
	movs r0, 0x3
	movs r1, 0
	movs r2, 0
	bl sub_801A02C
	lsls r0, 24
	cmp r0, 0
	beq _08021C98
	movs r2, 0x1
	mov r10, r2
	ldr r3, _08021C94 @ =0x02000000
	mov r12, r3
	b _0802224E
	.align 2, 0
_08021C94: .4byte 0x02000000
_08021C98:
	ldr r2, _08021CA0 @ =0x02000000
	ldr r4, _08021CA4 @ =0x0001600c
	adds r1, r2, r4
	b _08021E00
	.align 2, 0
_08021CA0: .4byte 0x02000000
_08021CA4: .4byte 0x0001600c
_08021CA8:
	movs r0, 0x4
	movs r1, 0
	movs r2, 0
	bl sub_801A02C
	lsls r0, 24
	cmp r0, 0
	beq _08021CBC
	movs r5, 0x1
	mov r10, r5
_08021CBC:
	ldr r2, _08021CC4 @ =0x02000000
	ldr r0, _08021CC8 @ =0x0001600c
	adds r1, r2, r0
	b _08021E00
	.align 2, 0
_08021CC4: .4byte 0x02000000
_08021CC8: .4byte 0x0001600c
_08021CCC:
	ldr r1, _08021D04 @ =gStatuses3
	ldr r0, _08021D08 @ =gBankAttacker
	ldrb r2, [r0]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _08021D0C @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _08021CE2
	b _08021DFA
_08021CE2:
	ldr r0, _08021D10 @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08021CF0
	b _08021DFA
_08021CF0:
	ldr r4, _08021D14 @ =gActiveBank
	strb r2, [r4]
	movs r0, 0
	movs r1, 0x1
	bl EmitSpriteInvisibility
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08021DFA
	.align 2, 0
_08021D04: .4byte gStatuses3
_08021D08: .4byte gBankAttacker
_08021D0C: .4byte 0x000400c0
_08021D10: .4byte gHitMarker
_08021D14: .4byte gActiveBank
_08021D18:
	ldr r0, _08021D88 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	bne _08021D44
	ldr r1, _08021D8C @ =gStatuses3
	ldr r0, _08021D90 @ =gBankAttacker
	ldrb r2, [r0]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _08021D94 @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	beq _08021D44
	adds r0, r2, 0
	bl sub_8015660
	lsls r0, 24
	cmp r0, 0
	beq _08021D7E
_08021D44:
	ldr r4, _08021D98 @ =gActiveBank
	ldr r5, _08021D90 @ =gBankAttacker
	ldrb r0, [r5]
	strb r0, [r4]
	movs r0, 0
	movs r1, 0
	bl EmitSpriteInvisibility
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, _08021D8C @ =gStatuses3
	ldrb r2, [r5]
	lsls r2, 2
	adds r2, r0
	ldr r0, [r2]
	ldr r1, _08021D9C @ =0xfffbff3f
	ands r0, r1
	str r0, [r2]
	ldr r2, _08021DA0 @ =gSpecialStatuses
	ldrb r1, [r5]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x4
	orrs r1, r2
	strb r1, [r0]
_08021D7E:
	ldr r2, _08021DA4 @ =0x02000000
	ldr r4, _08021DA8 @ =0x0001600c
	adds r1, r2, r4
	b _08021E00
	.align 2, 0
_08021D88: .4byte gBattleMoveFlags
_08021D8C: .4byte gStatuses3
_08021D90: .4byte gBankAttacker
_08021D94: .4byte 0x000400c0
_08021D98: .4byte gActiveBank
_08021D9C: .4byte 0xfffbff3f
_08021DA0: .4byte gSpecialStatuses
_08021DA4: .4byte 0x02000000
_08021DA8: .4byte 0x0001600c
_08021DAC:
	ldr r2, _08021E0C @ =gSpecialStatuses
	ldr r1, _08021E10 @ =gBankTarget
	ldrb r3, [r1]
	lsls r4, r3, 2
	adds r0, r4, r3
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 29
	cmp r0, 0
	blt _08021DFA
	ldr r0, _08021E14 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r3, r0
	bcs _08021DFA
	ldr r5, _08021E18 @ =gStatuses3
	adds r0, r4, r5
	ldr r0, [r0]
	ldr r1, _08021E1C @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _08021DFA
	ldr r4, _08021E20 @ =gActiveBank
	strb r3, [r4]
	movs r0, 0
	movs r1, 0
	bl EmitSpriteInvisibility
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, _08021E10 @ =gBankTarget
	ldrb r2, [r0]
	lsls r2, 2
	adds r2, r5
	ldr r0, [r2]
	ldr r1, _08021E24 @ =0xfffbff3f
	ands r0, r1
	str r0, [r2]
_08021DFA:
	ldr r2, _08021E28 @ =0x02000000
	ldr r3, _08021E2C @ =0x0001600c
	adds r1, r2, r3
_08021E00:
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	mov r12, r2
	b _0802224E
	.align 2, 0
_08021E0C: .4byte gSpecialStatuses
_08021E10: .4byte gBankTarget
_08021E14: .4byte gNoOfAllBanks
_08021E18: .4byte gStatuses3
_08021E1C: .4byte 0x000400c0
_08021E20: .4byte gActiveBank
_08021E24: .4byte 0xfffbff3f
_08021E28: .4byte 0x02000000
_08021E2C: .4byte 0x0001600c
_08021E30:
	movs r4, 0
	ldr r0, _08021E60 @ =gNoOfAllBanks
	ldrb r5, [r0]
	cmp r4, r5
	blt _08021E3C
	b _08022244
_08021E3C:
	ldr r2, _08021E64 @ =gDisableStructs
	ldr r5, _08021E68 @ =0xfeffffff
	adds r3, r0, 0
	ldr r1, _08021E6C @ =gUnknown_02024AD0
_08021E44:
	ldrb r0, [r2, 0xA]
	cmp r0, 0
	bne _08021E50
	ldr r0, [r1]
	ands r0, r5
	str r0, [r1]
_08021E50:
	adds r2, 0x1C
	adds r1, 0x58
	adds r4, 0x1
	ldrb r0, [r3]
	cmp r4, r0
	blt _08021E44
	b _08022244
	.align 2, 0
_08021E60: .4byte gNoOfAllBanks
_08021E64: .4byte gDisableStructs
_08021E68: .4byte 0xfeffffff
_08021E6C: .4byte gUnknown_02024AD0
_08021E70:
	ldr r1, _08021F2C @ =gHitMarker
	ldr r3, [r1]
	movs r0, 0x80
	lsls r0, 5
	ands r0, r3
	ldr r2, _08021F30 @ =gBankAttacker
	mov r9, r2
	adds r5, r1, 0
	cmp r0, 0
	beq _08021E9A
	ldr r0, _08021F34 @ =gActiveBank
	ldrb r2, [r2]
	strb r2, [r0]
	ldr r1, _08021F38 @ =gBankTarget
	ldrb r0, [r1]
	mov r4, r9
	strb r0, [r4]
	strb r2, [r1]
	ldr r0, _08021F3C @ =0xffffefff
	ands r3, r0
	str r3, [r5]
_08021E9A:
	ldr r1, _08021F40 @ =gBattleMoves
	ldr r2, _08021F44 @ =gUnknown_02024BE8
	ldrh r3, [r2]
	lsls r0, r3, 1
	adds r0, r3
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0]
	mov r8, r1
	adds r7, r2, 0
	cmp r0, 0x7F
	bne _08021EBE
	ldr r0, _08021F48 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	beq _08021ECA
_08021EBE:
	ldr r1, _08021F4C @ =gUnknown_02024C2C
	mov r2, r9
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r1
	strh r3, [r0]
_08021ECA:
	ldr r0, _08021F50 @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _08021F54 @ =gBitTable
	mov r3, r9
	ldrb r4, [r3]
	lsls r0, r4, 2
	adds r0, r2
	ldr r3, [r0]
	ands r1, r3
	adds r6, r2, 0
	cmp r1, 0
	beq _08021EE4
	b _08022244
_08021EE4:
	ldr r0, _08021F58 @ =0x000160a6
	add r0, r12
	ldrb r0, [r0]
	ands r0, r3
	cmp r0, 0
	beq _08021EF2
	b _08022244
_08021EF2:
	ldrh r2, [r7]
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	add r0, r8
	ldrb r0, [r0]
	cmp r0, 0x7F
	bne _08021F04
	b _08022244
_08021F04:
	ldr r0, [r5]
	movs r1, 0x80
	lsls r1, 18
	ands r0, r1
	cmp r0, 0
	beq _08021F68
	ldr r1, _08021F5C @ =gLastUsedMove
	lsls r0, r4, 1
	adds r0, r1
	strh r2, [r0]
	ldr r0, _08021F60 @ =gUnknown_02024C4C
	mov r4, r9
	ldrb r1, [r4]
	lsls r1, 1
	adds r1, r0
	ldr r0, _08021F64 @ =gCurrentMove
	ldrh r0, [r0]
	strh r0, [r1]
	b _08021F82
	.align 2, 0
_08021F2C: .4byte gHitMarker
_08021F30: .4byte gBankAttacker
_08021F34: .4byte gActiveBank
_08021F38: .4byte gBankTarget
_08021F3C: .4byte 0xffffefff
_08021F40: .4byte gBattleMoves
_08021F44: .4byte gUnknown_02024BE8
_08021F48: .4byte gBattleMoveFlags
_08021F4C: .4byte gUnknown_02024C2C
_08021F50: .4byte gAbsentBankFlags
_08021F54: .4byte gBitTable
_08021F58: .4byte 0x000160a6
_08021F5C: .4byte gLastUsedMove
_08021F60: .4byte gUnknown_02024C4C
_08021F64: .4byte gCurrentMove
_08021F68:
	ldr r1, _08021FD0 @ =gLastUsedMove
	lsls r0, r4, 1
	adds r0, r1
	ldr r1, _08021FD4 @ =0x0000ffff
	strh r1, [r0]
	ldr r1, _08021FD8 @ =gUnknown_02024C4C
	mov r2, r9
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r1
	movs r1, 0x1
	negs r1, r1
	strh r1, [r0]
_08021F82:
	ldr r2, _08021FDC @ =gBankTarget
	ldrb r3, [r2]
	lsls r0, r3, 2
	adds r0, r6
	ldr r0, [r0]
	lsls r0, 28
	ldr r1, [r5]
	ands r1, r0
	cmp r1, 0
	bne _08021FA0
	ldr r0, _08021FE0 @ =gUnknown_02024C5C
	adds r0, r3, r0
	mov r3, r9
	ldrb r1, [r3]
	strb r1, [r0]
_08021FA0:
	ldr r0, [r5]
	movs r1, 0x80
	lsls r1, 18
	ands r0, r1
	cmp r0, 0
	beq _0802204C
	ldr r0, _08021FE4 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	bne _0802204C
	ldrh r2, [r7]
	ldr r0, _08021FD4 @ =0x0000ffff
	cmp r2, r0
	bne _08021FEC
	ldr r1, _08021FE8 @ =gMoveHitWith
	ldr r4, _08021FDC @ =gBankTarget
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r1
	strh r2, [r0]
	b _08022244
	.align 2, 0
_08021FD0: .4byte gLastUsedMove
_08021FD4: .4byte 0x0000ffff
_08021FD8: .4byte gUnknown_02024C4C
_08021FDC: .4byte gBankTarget
_08021FE0: .4byte gUnknown_02024C5C
_08021FE4: .4byte gBattleMoveFlags
_08021FE8: .4byte gMoveHitWith
_08021FEC:
	ldr r0, _08022014 @ =gMoveHitWith
	ldr r5, _08022018 @ =gBankTarget
	ldrb r1, [r5]
	lsls r1, 1
	adds r1, r0
	ldr r4, _0802201C @ =gCurrentMove
	ldrh r0, [r4]
	strh r0, [r1]
	ldr r0, _08022020 @ =0x0001601c
	add r0, r12
	ldrb r3, [r0]
	cmp r3, 0
	beq _08022028
	ldr r0, _08022024 @ =gUnknown_02024C44
	ldrb r1, [r5]
	lsls r1, 1
	adds r1, r0
	movs r0, 0x3F
	ands r0, r3
	b _08021C22
	.align 2, 0
_08022014: .4byte gMoveHitWith
_08022018: .4byte gBankTarget
_0802201C: .4byte gCurrentMove
_08022020: .4byte 0x0001601c
_08022024: .4byte gUnknown_02024C44
_08022028:
	ldr r0, _08022044 @ =gUnknown_02024C44
	ldr r1, _08022048 @ =gBankTarget
	ldrb r2, [r1]
	lsls r2, 1
	adds r2, r0
	ldrh r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	add r0, r8
	ldrb r0, [r0, 0x2]
	strh r0, [r2]
	b _08022244
	.align 2, 0
_08022044: .4byte gUnknown_02024C44
_08022048: .4byte gBankTarget
_0802204C:
	ldr r0, _0802205C @ =gMoveHitWith
	ldr r2, _08022060 @ =gBankTarget
	ldrb r1, [r2]
	lsls r1, 1
	adds r1, r0
	ldr r0, _08022064 @ =0x0000ffff
	b _08021C22
	.align 2, 0
_0802205C: .4byte gMoveHitWith
_08022060: .4byte gBankTarget
_08022064: .4byte 0x0000ffff
_08022068:
	ldr r0, _0802212C @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r6, _08022130 @ =gBitTable
	ldr r2, _08022134 @ =gBankAttacker
	ldrb r5, [r2]
	lsls r0, r5, 2
	adds r0, r6
	ldr r4, [r0]
	ands r1, r4
	mov r9, r2
	cmp r1, 0
	beq _08022082
	b _08022244
_08022082:
	ldr r0, _08022138 @ =0x000160a6
	add r0, r12
	ldrb r0, [r0]
	ands r0, r4
	cmp r0, 0
	beq _08022090
	b _08022244
_08022090:
	ldr r1, _0802213C @ =gBattleMoves
	ldr r4, _08022140 @ =gUnknown_02024BE8
	ldrh r3, [r4]
	lsls r0, r3, 1
	adds r0, r3
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r0, 0x8]
	movs r0, 0x10
	ands r0, r1
	cmp r0, 0
	beq _0802215C
	ldr r0, _08022144 @ =gHitMarker
	ldr r1, [r0]
	movs r0, 0x80
	lsls r0, 18
	ands r0, r1
	cmp r0, 0
	beq _0802215C
	ldr r2, _08022148 @ =gBankTarget
	ldrb r0, [r2]
	cmp r5, r0
	bne _080220C0
	b _08022244
_080220C0:
	adds r2, r0, 0
	lsls r0, r2, 2
	adds r0, r6
	ldr r0, [r0]
	lsls r0, 28
	ands r1, r0
	cmp r1, 0
	bne _0802215C
	ldr r0, _0802214C @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	bne _0802215C
	lsls r0, r2, 1
	ldr r5, _08022150 @ =0x000160ac
	adds r0, r5
	add r0, r12
	strb r3, [r0]
	ldr r0, _08022148 @ =gBankTarget
	ldrb r1, [r0]
	lsls r1, 1
	ldr r2, _08022154 @ =0x000160ad
	adds r1, r2
	add r1, r12
	ldrh r0, [r4]
	lsrs r0, 8
	strb r0, [r1]
	ldr r3, _08022148 @ =gBankTarget
	ldrb r2, [r3]
	lsls r2, 2
	mov r5, r9
	ldrb r0, [r5]
	lsrs r0, 1
	lsls r0, 1
	ldr r1, _08022158 @ =0x00016100
	adds r0, r1
	adds r2, r0
	add r2, r12
	ldrh r0, [r4]
	strb r0, [r2]
	ldrb r2, [r3]
	lsls r2, 2
	ldrb r0, [r5]
	lsrs r0, 1
	lsls r0, 1
	adds r1, 0x1
	adds r0, r1
	adds r2, r0
	add r2, r12
	ldrh r0, [r4]
	lsrs r0, 8
	strb r0, [r2]
	b _08022244
	.align 2, 0
_0802212C: .4byte gAbsentBankFlags
_08022130: .4byte gBitTable
_08022134: .4byte gBankAttacker
_08022138: .4byte 0x000160a6
_0802213C: .4byte gBattleMoves
_08022140: .4byte gUnknown_02024BE8
_08022144: .4byte gHitMarker
_08022148: .4byte gBankTarget
_0802214C: .4byte gBattleMoveFlags
_08022150: .4byte 0x000160ac
_08022154: .4byte 0x000160ad
_08022158: .4byte 0x00016100
_0802215C:
	mov r1, r9
	ldrb r0, [r1]
	ldr r2, _080221B4 @ =gBankTarget
	ldrb r2, [r2]
	cmp r0, r2
	beq _08022244
	ldr r3, _080221B4 @ =gBankTarget
	ldrb r0, [r3]
	lsls r0, 1
	ldr r4, _080221B8 @ =0x000160ac
	adds r0, r4
	add r0, r12
	movs r3, 0
	strb r3, [r0]
	ldr r5, _080221B4 @ =gBankTarget
	ldrb r0, [r5]
	lsls r0, 1
	ldr r1, _080221BC @ =0x000160ad
	adds r0, r1
	add r0, r12
	strb r3, [r0]
	ldrb r2, [r5]
	lsls r2, 2
	mov r4, r9
	ldrb r0, [r4]
	lsrs r0, 1
	lsls r0, 1
	adds r1, 0x53
	adds r0, r1
	adds r2, r0
	add r2, r12
	strb r3, [r2]
	ldrb r2, [r5]
	lsls r2, 2
	ldrb r0, [r4]
	lsrs r0, 1
	lsls r0, 1
	adds r1, 0x1
	adds r0, r1
	adds r2, r0
	add r2, r12
	strb r3, [r2]
	b _08022244
	.align 2, 0
_080221B4: .4byte gBankTarget
_080221B8: .4byte 0x000160ac
_080221BC: .4byte 0x000160ad
_080221C0:
	ldr r5, _080222B0 @ =gHitMarker
	ldr r2, [r5]
	movs r0, 0x80
	lsls r0, 12
	ands r0, r2
	cmp r0, 0
	bne _08022244
	ldr r0, _080222B4 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08022244
	ldr r1, _080222B8 @ =gProtectStructs
	ldr r0, _080222BC @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0, 0x1]
	lsls r0, 29
	cmp r0, 0
	blt _08022244
	ldr r0, _080222C0 @ =gBattleMoves
	mov r9, r0
	ldr r1, _080222C4 @ =gCurrentMove
	mov r8, r1
	ldrh r0, [r1]
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	add r1, r9
	ldrb r0, [r1, 0x6]
	cmp r0, 0x8
	bne _08022244
	movs r6, 0x80
	lsls r6, 2
	adds r4, r6, 0
	ands r4, r2
	cmp r4, 0
	bne _08022244
	ldr r7, _080222C8 @ =gBankTarget
	ldrb r0, [r7]
	bl GetBankIdentity
	movs r1, 0x2
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r1, _080222CC @ =gBattleMons
	movs r0, 0x58
	muls r0, r2
	adds r0, r1
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _0802223A
	bl _08021874
_0802223A:
	ldr r0, [r5]
	orrs r0, r6
	str r0, [r5]
	ldr r2, _080222D0 @ =0x02000000
	mov r12, r2
_08022244:
	ldr r1, _080222D4 @ =0x0001600c
	add r1, r12
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
_0802224E:
	ldr r3, [sp, 0x10]
	cmp r3, 0x1
	bne _08022262
	mov r4, r10
	cmp r4, 0
	bne _08022262
	ldr r1, _080222D4 @ =0x0001600c
	add r1, r12
	movs r0, 0x11
	strb r0, [r1]
_08022262:
	ldr r5, [sp, 0x10]
	cmp r5, 0x2
	bne _08022278
	ldr r1, _080222D4 @ =0x0001600c
	add r1, r12
	ldr r0, [sp, 0x14]
	ldrb r2, [r1]
	cmp r0, r2
	bne _08022278
	movs r0, 0x11
	strb r0, [r1]
_08022278:
	ldr r0, _080222D4 @ =0x0001600c
	add r0, r12
	ldrb r0, [r0]
	cmp r0, 0x11
	beq _08022286
	bl _080218E4
_08022286:
	ldr r0, _080222D4 @ =0x0001600c
	add r0, r12
	ldrb r0, [r0]
	cmp r0, 0x11
	bne _0802229E
	mov r3, r10
	cmp r3, 0
	bne _0802229E
	ldr r1, _080222D8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x3
_0802229C:
	str r0, [r1]
_0802229E:
	add sp, 0x18
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080222B0: .4byte gHitMarker
_080222B4: .4byte gBattleTypeFlags
_080222B8: .4byte gProtectStructs
_080222BC: .4byte gBankAttacker
_080222C0: .4byte gBattleMoves
_080222C4: .4byte gCurrentMove
_080222C8: .4byte gBankTarget
_080222CC: .4byte gBattleMons
_080222D0: .4byte 0x02000000
_080222D4: .4byte 0x0001600c
_080222D8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80217F8

	thumb_func_start atk4A_damageflags
atk4A_damageflags: @ 80222DC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	movs r4, 0
	movs r5, 0
	ldr r2, _08022340 @ =gBattleMoves
	ldr r0, _08022344 @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x2]
	mov r8, r0
	ldr r2, _08022348 @ =gBattleMons
	ldr r3, _0802234C @ =gBankTarget
	ldrb r1, [r3]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x20
	ldrb r0, [r0]
	mov r12, r2
	adds r7, r3, 0
	cmp r0, 0x1A
	bne _08022370
	mov r1, r8
	cmp r1, 0x4
	bne _08022370
	ldr r3, _08022350 @ =gLastUsedAbility
	strb r0, [r3]
	ldr r2, _08022354 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x9
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08022358 @ =gMoveHitWith
	ldrb r0, [r7]
	lsls r0, 1
	adds r0, r1
	strh r4, [r0]
	ldr r0, _0802235C @ =gBattleCommunication
	mov r2, r8
	strb r2, [r0, 0x6]
	ldrb r0, [r7]
	ldrb r1, [r3]
	bl RecordAbilityBattle
	b _08022452
	.align 2, 0
_08022340: .4byte gBattleMoves
_08022344: .4byte gCurrentMove
_08022348: .4byte gBattleMons
_0802234C: .4byte gBankTarget
_08022350: .4byte gLastUsedAbility
_08022354: .4byte gBattleMoveFlags
_08022358: .4byte gMoveHitWith
_0802235C: .4byte gBattleCommunication
_08022360:
	ldr r0, _0802236C @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r2, 0x8
	orrs r1, r2
	strb r1, [r0]
	b _08022452
	.align 2, 0
_0802236C: .4byte gBattleMoveFlags
_08022370:
	ldr r1, _0802237C @ =gTypeEffectiveness
	adds r0, r5, r1
	ldrb r0, [r0]
	adds r6, r1, 0
	b _08022432
	.align 2, 0
_0802237C: .4byte gTypeEffectiveness
_08022380:
	adds r0, r5, r6
	ldrb r0, [r0]
	cmp r0, r8
	bne _0802242C
	adds r2, r5, 0x1
	adds r3, r2, r6
	ldrb r1, [r7]
	movs r0, 0x58
	muls r0, r1
	add r0, r12
	adds r0, 0x21
	ldrb r1, [r3]
	adds r3, r2, 0
	ldrb r0, [r0]
	cmp r1, r0
	bne _080223BE
	adds r0, r5, 0x2
	adds r0, r6
	ldrb r1, [r0]
	cmp r1, 0
	beq _08022360
	cmp r1, 0x5
	bne _080223B2
	movs r0, 0x4
	orrs r4, r0
_080223B2:
	cmp r1, 0x14
	bne _080223BE
	movs r0, 0x2
	orrs r4, r0
	lsls r0, r4, 24
	lsrs r4, r0, 24
_080223BE:
	adds r2, r3, r6
	ldrb r1, [r7]
	movs r0, 0x58
	muls r0, r1
	add r0, r12
	adds r1, r0, 0
	adds r1, 0x22
	ldrb r2, [r2]
	ldrb r1, [r1]
	cmp r2, r1
	bne _0802242C
	adds r0, 0x21
	ldrb r1, [r0]
	cmp r1, r2
	beq _080223E6
	adds r0, r5, 0x2
	adds r0, r6
	ldrb r0, [r0]
	cmp r0, 0
	beq _08022360
_080223E6:
	cmp r1, r2
	beq _080223FC
	adds r0, r5, 0x2
	adds r0, r6
	ldrb r0, [r0]
	cmp r0, 0x5
	bne _080223FC
	movs r0, 0x4
	orrs r4, r0
	lsls r0, r4, 24
	lsrs r4, r0, 24
_080223FC:
	adds r2, r3, r6
	ldrb r1, [r7]
	movs r0, 0x58
	muls r0, r1
	add r0, r12
	adds r1, r0, 0
	adds r1, 0x22
	ldrb r2, [r2]
	ldrb r1, [r1]
	cmp r2, r1
	bne _0802242C
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, r2
	beq _0802242C
	adds r0, r5, 0x2
	adds r0, r6
	ldrb r0, [r0]
	cmp r0, 0x14
	bne _0802242C
	movs r0, 0x2
	orrs r4, r0
	lsls r0, r4, 24
	lsrs r4, r0, 24
_0802242C:
	adds r5, 0x3
	adds r0, r5, r6
	ldrb r0, [r0]
_08022432:
	cmp r0, 0xFF
	beq _08022452
	cmp r0, 0xFE
	bne _08022380
	ldrb r1, [r7]
	movs r0, 0x58
	muls r0, r1
	mov r1, r12
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 22
	ands r0, r1
	cmp r0, 0
	beq _0802242C
_08022452:
	ldr r2, _08022500 @ =gBattleMons
	ldr r0, _08022504 @ =gBankTarget
	mov r8, r0
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x20
	ldrb r6, [r0]
	cmp r6, 0x19
	bne _080224CE
	movs r5, 0x29
	ands r5, r4
	cmp r5, 0
	bne _080224CE
	ldr r0, _08022508 @ =gBankAttacker
	ldrb r0, [r0]
	ldr r7, _0802250C @ =gCurrentMove
	ldrh r1, [r7]
	bl AttacksThisTurn
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0x2
	bne _080224CE
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	beq _08022494
	movs r0, 0x6
	ands r4, r0
	cmp r4, 0x6
	bne _080224CE
_08022494:
	ldr r2, _08022510 @ =gBattleMoves
	ldrh r1, [r7]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x1]
	cmp r0, 0
	beq _080224CE
	ldr r3, _08022514 @ =gLastUsedAbility
	strb r6, [r3]
	ldr r2, _08022518 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _0802251C @ =gMoveHitWith
	mov r2, r8
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r1
	strh r5, [r0]
	ldr r1, _08022520 @ =gBattleCommunication
	movs r0, 0x3
	strb r0, [r1, 0x6]
	ldrb r0, [r2]
	ldrb r1, [r3]
	bl RecordAbilityBattle
_080224CE:
	ldr r0, _08022518 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x8
	ands r0, r1
	cmp r0, 0
	beq _080224EC
	ldr r2, _08022524 @ =gProtectStructs
	ldr r0, _08022508 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 4
	adds r1, r2
	ldrb r0, [r1, 0x1]
	movs r2, 0x2
	orrs r0, r2
	strb r0, [r1, 0x1]
_080224EC:
	ldr r1, _08022528 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08022500: .4byte gBattleMons
_08022504: .4byte gBankTarget
_08022508: .4byte gBankAttacker
_0802250C: .4byte gCurrentMove
_08022510: .4byte gBattleMoves
_08022514: .4byte gLastUsedAbility
_08022518: .4byte gBattleMoveFlags
_0802251C: .4byte gMoveHitWith
_08022520: .4byte gBattleCommunication
_08022524: .4byte gProtectStructs
_08022528: .4byte gBattlescriptCurrInstr
	thumb_func_end atk4A_damageflags

	thumb_func_start atk4B_cmd4b
atk4B_cmd4b: @ 802252C
	push {r4,lr}
	ldr r4, _08022568 @ =gActiveBank
	ldr r0, _0802256C @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r4]
	ldr r2, _08022570 @ =gHitMarker
	ldr r1, _08022574 @ =gBitTable
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r1
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	ands r0, r1
	cmp r0, 0
	bne _0802255A
	movs r0, 0
	movs r1, 0
	bl dp01_build_cmdbuf_x06_a
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_0802255A:
	ldr r1, _08022578 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08022568: .4byte gActiveBank
_0802256C: .4byte gBankAttacker
_08022570: .4byte gHitMarker
_08022574: .4byte gBitTable
_08022578: .4byte gBattlescriptCurrInstr
	thumb_func_end atk4B_cmd4b

	thumb_func_start atk4C_switch1
atk4C_switch1: @ 802257C
	push {r4-r6,lr}
	ldr r0, _080225D4 @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _080225CC
	ldr r5, _080225D8 @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _080225DC @ =gActiveBank
	strb r0, [r4]
	ldr r3, _080225E0 @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r1, r0, 1
	adds r1, r3
	ldr r2, _080225E4 @ =0x02000000
	ldr r6, _080225E8 @ =0x00016068
	adds r0, r6
	adds r0, r2
	ldrb r0, [r0]
	strh r0, [r1]
	ldr r1, _080225EC @ =gBitTable
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	lsls r0, 2
	adds r0, r1
	ldrb r2, [r0]
	movs r0, 0
	movs r1, 0
	bl EmitGetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
_080225CC:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_080225D4: .4byte gBattleExecBuffer
_080225D8: .4byte gBattlescriptCurrInstr
_080225DC: .4byte gActiveBank
_080225E0: .4byte gBattlePartyID
_080225E4: .4byte 0x02000000
_080225E8: .4byte 0x00016068
_080225EC: .4byte gBitTable
	thumb_func_end atk4C_switch1

	thumb_func_start sub_80225F0
sub_80225F0: @ 80225F0
	push {r4-r7,lr}
	sub sp, 0x58
	ldr r0, _0802274C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	beq _080225FE
	b _08022744
_080225FE:
	ldr r0, _08022750 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _08022754 @ =gActiveBank
	strb r0, [r4]
	ldr r6, _08022758 @ =gBattleMons
	ldrb r0, [r4]
	movs r5, 0x58
	adds r1, r0, 0
	muls r1, r5
	adds r1, r6
	mov r0, sp
	movs r2, 0x58
	bl memcpy
	ldrb r0, [r4]
	muls r0, r5
	adds r3, r0, r6
	movs r2, 0
	ldr r5, _0802275C @ =BattleBufferB
	adds r7, r4, 0
_0802262C:
	adds r0, r3, r2
	ldrb r1, [r4]
	lsls r1, 9
	adds r1, 0x4
	adds r1, r2, r1
	adds r1, r5
	ldrb r1, [r1]
	strb r1, [r0]
	adds r2, 0x1
	cmp r2, 0x57
	bls _0802262C
	ldr r4, _08022758 @ =gBattleMons
	ldrb r0, [r7]
	movs r6, 0x58
	adds r2, r0, 0
	muls r2, r6
	adds r2, r4
	ldr r3, _08022760 @ =gBaseStats
	ldrh r1, [r2]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r3
	ldrb r0, [r0, 0x6]
	adds r2, 0x21
	strb r0, [r2]
	ldrb r0, [r7]
	adds r1, r0, 0
	muls r1, r6
	adds r1, r4
	ldrh r2, [r1]
	lsls r0, r2, 3
	subs r0, r2
	lsls r0, 2
	adds r0, r3
	ldrb r0, [r0, 0x7]
	adds r1, 0x22
	strb r0, [r1]
	ldrb r0, [r7]
	adds r1, r0, 0
	muls r1, r6
	adds r1, r4
	ldrh r0, [r1]
	ldrb r1, [r1, 0x17]
	lsrs r1, 7
	bl GetAbilityBySpecies
	ldrb r1, [r7]
	muls r1, r6
	adds r1, r4
	adds r1, 0x20
	strb r0, [r1]
	ldrb r0, [r7]
	bl GetBankSide
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r0, _08022764 @ =gWishFutureKnock
	adds r0, 0x29
	adds r0, r2, r0
	ldrb r1, [r0]
	ldr r3, _08022768 @ =gBitTable
	ldr r2, _0802276C @ =gBattlePartyID
	ldrb r5, [r7]
	lsls r0, r5, 1
	adds r0, r2
	ldrh r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	ands r1, r0
	mov r12, r4
	cmp r1, 0
	beq _080226CA
	adds r0, r5, 0
	muls r0, r6
	add r0, r12
	movs r1, 0
	strh r1, [r0, 0x2E]
_080226CA:
	ldr r2, _08022770 @ =gBattleMoves
	ldr r0, _08022774 @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	cmp r0, 0x7F
	bne _08022710
	movs r2, 0
	adds r4, r7, 0
	movs r6, 0x58
	mov r5, r12
	adds r5, 0x18
	add r3, sp, 0x18
_080226EA:
	ldrb r0, [r4]
	adds r1, r0, 0
	muls r1, r6
	adds r1, r2, r1
	adds r1, r5
	adds r0, r3, r2
	ldrb r0, [r0]
	strb r0, [r1]
	adds r2, 0x1
	cmp r2, 0x7
	ble _080226EA
	ldrb r1, [r7]
	movs r0, 0x58
	muls r0, r1
	mov r1, r12
	adds r1, 0x50
	adds r0, r1
	ldr r1, [sp, 0x50]
	str r1, [r0]
_08022710:
	bl sub_8010B88
	ldr r0, _08022778 @ =0x02000000
	ldr r3, _08022754 @ =gActiveBank
	ldrb r2, [r3]
	ldr r1, _0802277C @ =0x00016003
	adds r0, r1
	strb r2, [r0]
	ldr r1, _08022780 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x7
	strb r0, [r1, 0x1]
	strb r2, [r1, 0x2]
	ldr r2, _0802276C @ =gBattlePartyID
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _08022750 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
_08022744:
	add sp, 0x58
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802274C: .4byte gBattleExecBuffer
_08022750: .4byte gBattlescriptCurrInstr
_08022754: .4byte gActiveBank
_08022758: .4byte gBattleMons
_0802275C: .4byte BattleBufferB
_08022760: .4byte gBaseStats
_08022764: .4byte gWishFutureKnock
_08022768: .4byte gBitTable
_0802276C: .4byte gBattlePartyID
_08022770: .4byte gBattleMoves
_08022774: .4byte gCurrentMove
_08022778: .4byte 0x02000000
_0802277C: .4byte 0x00016003
_08022780: .4byte gBattleTextBuff1
	thumb_func_end sub_80225F0

	thumb_func_start sub_8022784
sub_8022784: @ 8022784
	push {r4,r5,lr}
	ldr r0, _0802280C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _08022806
	ldr r0, _08022810 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _08022814 @ =gActiveBank
	strb r0, [r4]
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _080227D0
	ldr r0, _08022818 @ =gBattleTypeFlags
	ldrh r1, [r0]
	ldr r0, _0802281C @ =0x00000902
	ands r0, r1
	cmp r0, 0
	bne _080227D0
	ldr r2, _08022820 @ =gBattleMons
	ldrb r1, [r4]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x2
	bl GetNationalPokedexFlag
_080227D0:
	ldr r2, _08022824 @ =gAbsentBankFlags
	ldr r1, _08022828 @ =gBitTable
	ldr r5, _08022814 @ =gActiveBank
	ldrb r0, [r5]
	lsls r0, 2
	adds r0, r1
	ldr r1, [r0]
	ldrb r0, [r2]
	bics r0, r1
	strb r0, [r2]
	ldr r1, _0802282C @ =gBattlePartyID
	ldrb r0, [r5]
	lsls r0, 1
	adds r0, r1
	ldrb r1, [r0]
	ldr r4, _08022810 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r2, [r0, 0x2]
	movs r0, 0
	bl sub_800C704
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r0, [r4]
	adds r0, 0x3
	str r0, [r4]
_08022806:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802280C: .4byte gBattleExecBuffer
_08022810: .4byte gBattlescriptCurrInstr
_08022814: .4byte gActiveBank
_08022818: .4byte gBattleTypeFlags
_0802281C: .4byte 0x00000902
_08022820: .4byte gBattleMons
_08022824: .4byte gAbsentBankFlags
_08022828: .4byte gBitTable
_0802282C: .4byte gBattlePartyID
	thumb_func_end sub_8022784

	thumb_func_start sub_8022830
sub_8022830: @ 8022830
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r4, _08022894 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r1, [r0, 0x1]
	movs r0, 0x7F
	ands r0, r1
	bl GetBattleBank
	ldr r3, _08022898 @ =gActiveBank
	strb r0, [r3]
	ldr r2, [r4]
	ldrb r1, [r2, 0x1]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _080228A8
	ldr r1, _0802289C @ =gBattleMons
	ldrb r3, [r3]
	movs r0, 0x58
	muls r0, r3
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _080228A0 @ =0x0400e000
	ands r0, r1
	cmp r0, 0
	bne _0802287C
	ldr r1, _080228A4 @ =gStatuses3
	lsls r0, r3, 2
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 3
	ands r0, r1
	cmp r0, 0
	beq _080228A8
_0802287C:
	ldrb r1, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r1, r0
	str r1, [r4]
	b _08022A2C
	.align 2, 0
_08022894: .4byte gBattlescriptCurrInstr
_08022898: .4byte gActiveBank
_0802289C: .4byte gBattleMons
_080228A0: .4byte 0x0400e000
_080228A4: .4byte gStatuses3
_080228A8:
	ldr r5, _08022934 @ =gBattleTypeFlags
	ldrh r1, [r5]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08022948
	ldr r4, _08022938 @ =gActiveBank
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	ldr r1, _0802293C @ =gPlayerParty
	mov r8, r1
	cmp r0, 0x1
	bne _080228CC
	ldr r0, _08022940 @ =gEnemyParty
	mov r8, r0
_080228CC:
	movs r5, 0
	ldrb r0, [r4]
	bl sub_803FC34
	lsls r0, 24
	lsrs r0, 24
	bl sub_803FBFC
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0x1
	bne _080228E6
	movs r5, 0x3
_080228E6:
	adds r6, r5, 0x3
	cmp r5, r6
	bge _0802292E
	ldr r7, _08022944 @ =gBattlePartyID
_080228EE:
	movs r0, 0x64
	muls r0, r5
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _08022928
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _08022928
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _08022928
	ldr r0, _08022938 @ =gActiveBank
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r7
	ldrh r0, [r0]
	cmp r0, r5
	bne _0802292E
_08022928:
	adds r5, 0x1
	cmp r5, r6
	blt _080228EE
_0802292E:
	cmp r5, r6
	beq _080229FC
	b _08022A24
	.align 2, 0
_08022934: .4byte gBattleTypeFlags
_08022938: .4byte gActiveBank
_0802293C: .4byte gPlayerParty
_08022940: .4byte gEnemyParty
_08022944: .4byte gBattlePartyID
_08022948:
	ldr r0, _08022978 @ =gActiveBank
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x1
	bne _08022988
	movs r0, 0x1
	bl GetBankByPlayerAI
	lsls r0, 24
	lsrs r7, r0, 24
	ldrh r1, [r5]
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	beq _0802297C
	movs r0, 0x3
	bl GetBankByPlayerAI
	lsls r0, 24
	lsrs r6, r0, 24
	b _0802297E
	.align 2, 0
_08022978: .4byte gActiveBank
_0802297C:
	adds r6, r7, 0
_0802297E:
	ldr r0, _08022984 @ =gEnemyParty
	mov r8, r0
	b _080229AE
	.align 2, 0
_08022984: .4byte gEnemyParty
_08022988:
	movs r0, 0
	bl GetBankByPlayerAI
	lsls r0, 24
	lsrs r7, r0, 24
	ldrh r1, [r5]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080229A8
	movs r0, 0x2
	bl GetBankByPlayerAI
	lsls r0, 24
	lsrs r6, r0, 24
	b _080229AA
_080229A8:
	adds r6, r7, 0
_080229AA:
	ldr r1, _08022A18 @ =gPlayerParty
	mov r8, r1
_080229AE:
	movs r5, 0
_080229B0:
	movs r0, 0x64
	muls r0, r5
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _080229F2
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _080229F2
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _080229F2
	ldr r1, _08022A1C @ =gBattlePartyID
	lsls r0, r7, 1
	adds r0, r1
	ldrh r0, [r0]
	cmp r5, r0
	beq _080229F2
	lsls r0, r6, 1
	adds r0, r1
	ldrh r0, [r0]
	cmp r5, r0
	bne _080229F8
_080229F2:
	adds r5, 0x1
	cmp r5, 0x5
	ble _080229B0
_080229F8:
	cmp r5, 0x6
	bne _08022A24
_080229FC:
	ldr r3, _08022A20 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08022A2C
	.align 2, 0
_08022A18: .4byte gPlayerParty
_08022A1C: .4byte gBattlePartyID
_08022A20: .4byte gBattlescriptCurrInstr
_08022A24:
	ldr r1, _08022A38 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x6
	str r0, [r1]
_08022A2C:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08022A38: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8022830

	thumb_func_start sub_8022A3C
sub_8022A3C: @ 8022A3C
	push {r4,r5,lr}
	sub sp, 0x4
	adds r2, r0, 0
	lsls r2, 24
	lsrs r2, 24
	ldr r4, _08022A84 @ =0x02000000
	ldr r5, _08022A88 @ =gActiveBank
	ldrb r0, [r5]
	ldr r3, _08022A8C @ =0x00016064
	adds r1, r0, r3
	adds r1, r4
	ldr r3, _08022A90 @ =gBattlePartyID
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	strb r0, [r1]
	ldrb r1, [r5]
	lsls r0, r1, 1
	adds r0, r1
	ldr r1, _08022A94 @ =0x0001606c
	adds r4, r1
	adds r0, r4
	str r0, [sp]
	movs r0, 0
	movs r1, 0x1
	movs r3, 0
	bl dp01_build_cmdbuf_x16_a_b_c_ptr_d_e_f
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08022A84: .4byte 0x02000000
_08022A88: .4byte gActiveBank
_08022A8C: .4byte 0x00016064
_08022A90: .4byte gBattlePartyID
_08022A94: .4byte 0x0001606c
	thumb_func_end sub_8022A3C

	thumb_func_start atk50_openpartyscreen
atk50_openpartyscreen: @ 8022A98
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	sub sp, 0x4
	movs r7, 0
	movs r0, 0
	mov r9, r0
	ldr r6, _08022B44 @ =gBattlescriptCurrInstr
	ldr r1, [r6]
	ldrb r2, [r1, 0x2]
	ldrb r0, [r1, 0x3]
	lsls r0, 8
	orrs r2, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 16
	orrs r2, r0
	ldrb r0, [r1, 0x5]
	lsls r0, 24
	orrs r2, r0
	mov r8, r2
	ldrb r2, [r1, 0x1]
	adds r0, r2, 0
	mov r12, r6
	cmp r0, 0x5
	beq _08022ACE
	b _08022F74
_08022ACE:
	ldr r0, _08022B48 @ =gBattleTypeFlags
	ldrh r0, [r0]
	movs r1, 0x41
	ands r1, r0
	cmp r1, 0x1
	beq _08022BBC
	ldr r1, _08022B4C @ =gActiveBank
	strb r7, [r1]
	ldr r0, _08022B50 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r7, r0
	bcc _08022AE8
	b _08022F62
_08022AE8:
	ldr r7, _08022B54 @ =gHitMarker
	ldr r6, _08022B58 @ =gBitTable
	adds r4, r1, 0
	ldr r0, _08022B5C @ =gAbsentBankFlags
	mov r8, r0
_08022AF2:
	ldrb r2, [r4]
	lsls r0, r2, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r7]
	ands r0, r1
	cmp r0, 0
	beq _08022B94
	adds r0, r2, 0
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08022B60
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	mov r2, r8
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r7]
	bics r0, r1
	str r0, [r7]
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08022BA2
	.align 2, 0
_08022B44: .4byte gBattlescriptCurrInstr
_08022B48: .4byte gBattleTypeFlags
_08022B4C: .4byte gActiveBank
_08022B50: .4byte gNoOfAllBanks
_08022B54: .4byte gHitMarker
_08022B58: .4byte gBitTable
_08022B5C: .4byte gAbsentBankFlags
_08022B60:
	ldr r5, _08022B90 @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r5
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022BA2
	movs r0, 0x6
	bl sub_8022A3C
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r5
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08022BA2
	.align 2, 0
_08022B90: .4byte gSpecialStatuses
_08022B94:
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_08022BA2:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	ldr r1, _08022BB8 @ =gNoOfAllBanks
	lsls r0, 24
	lsrs r0, 24
	ldrb r1, [r1]
	cmp r0, r1
	bcc _08022AF2
	b _08022F62
	.align 2, 0
_08022BB8: .4byte gNoOfAllBanks
_08022BBC:
	ands r1, r0
	cmp r1, 0
	bne _08022BC4
	b _08022F62
_08022BC4:
	ldr r0, _08022C1C @ =gHitMarker
	mov r8, r0
	ldr r0, [r0]
	lsrs r5, r0, 28
	ldr r6, _08022C20 @ =gBitTable
	ldr r0, [r6]
	ands r0, r5
	cmp r0, 0
	beq _08022C7E
	ldr r4, _08022C24 @ =gActiveBank
	strb r7, [r4]
	movs r0, 0
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08022C2C
	ldr r2, _08022C28 @ =gAbsentBankFlags
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	mov r2, r8
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08022C7E
	.align 2, 0
_08022C1C: .4byte gHitMarker
_08022C20: .4byte gBitTable
_08022C24: .4byte gActiveBank
_08022C28: .4byte gAbsentBankFlags
_08022C2C:
	ldr r6, _08022C60 @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022C6C
	ldr r0, _08022C64 @ =0x02000000
	ldr r1, _08022C68 @ =0x0001606a
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08022C7E
	.align 2, 0
_08022C60: .4byte gSpecialStatuses
_08022C64: .4byte 0x02000000
_08022C68: .4byte 0x0001606a
_08022C6C:
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	movs r2, 0x1
	mov r9, r2
_08022C7E:
	ldr r6, _08022CD8 @ =gBitTable
	ldr r0, [r6, 0x8]
	ands r0, r5
	cmp r0, 0
	beq _08022D40
	ldr r0, [r6]
	ands r0, r5
	cmp r0, 0
	bne _08022D40
	ldr r4, _08022CDC @ =gActiveBank
	movs r0, 0x2
	strb r0, [r4]
	movs r0, 0x2
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08022CE8
	ldr r2, _08022CE0 @ =gAbsentBankFlags
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldr r2, _08022CE4 @ =gHitMarker
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08022D40
	.align 2, 0
_08022CD8: .4byte gBitTable
_08022CDC: .4byte gActiveBank
_08022CE0: .4byte gAbsentBankFlags
_08022CE4: .4byte gHitMarker
_08022CE8:
	ldr r6, _08022D1C @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022D28
	ldr r0, _08022D20 @ =0x02000000
	ldr r1, _08022D24 @ =0x00016068
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08022D40
	.align 2, 0
_08022D1C: .4byte gSpecialStatuses
_08022D20: .4byte 0x02000000
_08022D24: .4byte 0x00016068
_08022D28:
	movs r0, 0x1
	mov r2, r9
	ands r0, r2
	cmp r0, 0
	bne _08022D40
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_08022D40:
	ldr r6, _08022D90 @ =gBitTable
	ldr r0, [r6, 0x4]
	ands r0, r5
	cmp r0, 0
	beq _08022DF6
	ldr r4, _08022D94 @ =gActiveBank
	movs r0, 0x1
	strb r0, [r4]
	movs r0, 0x1
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08022DA0
	ldr r2, _08022D98 @ =gAbsentBankFlags
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldr r2, _08022D9C @ =gHitMarker
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08022DF6
	.align 2, 0
_08022D90: .4byte gBitTable
_08022D94: .4byte gActiveBank
_08022D98: .4byte gAbsentBankFlags
_08022D9C: .4byte gHitMarker
_08022DA0:
	ldr r6, _08022DD4 @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022DE0
	ldr r0, _08022DD8 @ =0x02000000
	ldr r1, _08022DDC @ =0x0001606b
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08022DF6
	.align 2, 0
_08022DD4: .4byte gSpecialStatuses
_08022DD8: .4byte 0x02000000
_08022DDC: .4byte 0x0001606b
_08022DE0:
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	movs r0, 0x2
	mov r2, r9
	orrs r2, r0
	mov r9, r2
_08022DF6:
	ldr r6, _08022E50 @ =gBitTable
	ldr r0, [r6, 0xC]
	ands r0, r5
	cmp r0, 0
	beq _08022EB8
	ldr r0, [r6, 0x4]
	ands r0, r5
	cmp r0, 0
	bne _08022EB8
	ldr r4, _08022E54 @ =gActiveBank
	movs r0, 0x3
	strb r0, [r4]
	movs r0, 0x3
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08022E60
	ldr r2, _08022E58 @ =gAbsentBankFlags
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldr r2, _08022E5C @ =gHitMarker
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _08022EB8
	.align 2, 0
_08022E50: .4byte gBitTable
_08022E54: .4byte gActiveBank
_08022E58: .4byte gAbsentBankFlags
_08022E5C: .4byte gHitMarker
_08022E60:
	ldr r6, _08022E94 @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r6
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022EA0
	ldr r0, _08022E98 @ =0x02000000
	ldr r1, _08022E9C @ =0x00016069
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08022EB8
	.align 2, 0
_08022E94: .4byte gSpecialStatuses
_08022E98: .4byte 0x02000000
_08022E9C: .4byte 0x00016069
_08022EA0:
	movs r0, 0x2
	mov r2, r9
	ands r2, r0
	cmp r2, 0
	bne _08022EB8
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_08022EB8:
	ldr r1, _08022EE8 @ =gSpecialStatuses
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _08022F0C
	adds r0, r1, 0
	adds r0, 0x28
	ldrb r0, [r0]
	lsls r0, 25
	cmp r0, 0
	blt _08022F0C
	cmp r5, 0
	beq _08022F0C
	ldr r0, _08022EEC @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r0, _08022EF0 @ =gBitTable
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	beq _08022EF8
	ldr r1, _08022EF4 @ =gActiveBank
	movs r0, 0x2
	strb r0, [r1]
	b _08022EFC
	.align 2, 0
_08022EE8: .4byte gSpecialStatuses
_08022EEC: .4byte gAbsentBankFlags
_08022EF0: .4byte gBitTable
_08022EF4: .4byte gActiveBank
_08022EF8:
	ldr r0, _08022F3C @ =gActiveBank
	strb r1, [r0]
_08022EFC:
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldr r0, _08022F3C @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
_08022F0C:
	ldr r1, _08022F40 @ =gSpecialStatuses
	ldrb r0, [r1, 0x14]
	lsls r0, 25
	cmp r0, 0
	blt _08022F62
	adds r0, r1, 0
	adds r0, 0x3C
	ldrb r0, [r0]
	lsls r0, 25
	cmp r0, 0
	blt _08022F62
	cmp r5, 0
	beq _08022F62
	ldr r0, _08022F44 @ =gAbsentBankFlags
	ldrb r0, [r0]
	ldr r1, _08022F48 @ =gBitTable
	ldr r1, [r1, 0x4]
	ands r0, r1
	cmp r0, 0
	beq _08022F4C
	ldr r1, _08022F3C @ =gActiveBank
	movs r0, 0x3
	b _08022F50
	.align 2, 0
_08022F3C: .4byte gActiveBank
_08022F40: .4byte gSpecialStatuses
_08022F44: .4byte gAbsentBankFlags
_08022F48: .4byte gBitTable
_08022F4C:
	ldr r1, _08022F6C @ =gActiveBank
	movs r0, 0x1
_08022F50:
	strb r0, [r1]
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldr r0, _08022F6C @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
_08022F62:
	ldr r1, _08022F70 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x6
	str r0, [r1]
	b _08023302
	.align 2, 0
_08022F6C: .4byte gActiveBank
_08022F70: .4byte gBattlescriptCurrInstr
_08022F74:
	cmp r0, 0x6
	beq _08022F7A
	b _08023170
_08022F7A:
	ldr r0, _08022FF0 @ =gBattleTypeFlags
	ldrh r2, [r0]
	movs r0, 0x40
	ands r0, r2
	cmp r0, 0
	beq _08022F88
	b _0802310C
_08022F88:
	movs r0, 0x1
	ands r0, r2
	cmp r0, 0
	bne _08022F92
	b _0802310C
_08022F92:
	ldr r7, _08022FF4 @ =gHitMarker
	ldr r0, [r7]
	lsrs r5, r0, 28
	ldr r4, _08022FF8 @ =gBitTable
	ldr r0, [r4, 0x8]
	ands r0, r5
	cmp r0, 0
	beq _0802303A
	ldr r0, [r4]
	ands r0, r5
	cmp r0, 0
	beq _0802303A
	ldr r6, _08022FFC @ =gActiveBank
	movs r0, 0x2
	strb r0, [r6]
	ldr r0, _08023000 @ =BattleBufferB
	ldrb r1, [r0, 0x1]
	movs r0, 0x2
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _08023008
	ldr r2, _08023004 @ =gAbsentBankFlags
	ldrb r0, [r6]
	lsls r0, 2
	adds r0, r4
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldrb r0, [r6]
	lsls r0, 2
	adds r0, r4
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r7]
	bics r0, r1
	str r0, [r7]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r6]
	bl MarkBufferBankForExecution
	b _0802303A
	.align 2, 0
_08022FF0: .4byte gBattleTypeFlags
_08022FF4: .4byte gHitMarker
_08022FF8: .4byte gBitTable
_08022FFC: .4byte gActiveBank
_08023000: .4byte BattleBufferB
_08023004: .4byte gAbsentBankFlags
_08023008:
	ldr r4, _08023098 @ =gSpecialStatuses
	ldrb r0, [r6]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _0802303A
	ldr r0, _0802309C @ =0x02000000
	ldr r1, _080230A0 @ =0x00016068
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r6]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
_0802303A:
	ldr r4, _080230A4 @ =gBitTable
	ldr r0, [r4, 0xC]
	ands r0, r5
	cmp r0, 0
	beq _080230EE
	ldr r0, [r4, 0x4]
	ands r5, r0
	cmp r5, 0
	beq _080230EE
	ldr r5, _080230A8 @ =gActiveBank
	movs r0, 0x3
	strb r0, [r5]
	ldr r0, _080230AC @ =BattleBufferB
	ldr r2, _080230B0 @ =0x00000201
	adds r0, r2
	ldrb r1, [r0]
	movs r0, 0x3
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _080230BC
	ldr r2, _080230B4 @ =gAbsentBankFlags
	ldrb r0, [r5]
	lsls r0, 2
	adds r0, r4
	ldr r0, [r0]
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	ldr r2, _080230B8 @ =gHitMarker
	ldrb r0, [r5]
	lsls r0, 2
	adds r0, r4
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	movs r0, 0
	bl dp01_build_cmdbuf_x2A_2A_2A_2A
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	b _080230EE
	.align 2, 0
_08023098: .4byte gSpecialStatuses
_0802309C: .4byte 0x02000000
_080230A0: .4byte 0x00016068
_080230A4: .4byte gBitTable
_080230A8: .4byte gActiveBank
_080230AC: .4byte BattleBufferB
_080230B0: .4byte 0x00000201
_080230B4: .4byte gAbsentBankFlags
_080230B8: .4byte gHitMarker
_080230BC:
	ldr r4, _080230FC @ =gSpecialStatuses
	ldrb r0, [r5]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r0, [r1]
	lsls r0, 25
	cmp r0, 0
	blt _080230EE
	ldr r0, _08023100 @ =0x02000000
	ldr r1, _08023104 @ =0x00016069
	adds r0, r1
	ldrb r0, [r0]
	bl sub_8022A3C
	ldrb r1, [r5]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
_080230EE:
	ldr r1, _08023108 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x6
	str r0, [r1]
	mov r12, r1
	b _08023110
	.align 2, 0
_080230FC: .4byte gSpecialStatuses
_08023100: .4byte 0x02000000
_08023104: .4byte 0x00016069
_08023108: .4byte gBattlescriptCurrInstr
_0802310C:
	adds r0, r1, 0x6
	str r0, [r6]
_08023110:
	ldr r0, _08023160 @ =gHitMarker
	ldr r0, [r0]
	lsrs r5, r0, 28
	ldr r1, _08023164 @ =gBank1
	movs r0, 0
	strb r0, [r1]
	ldr r4, _08023168 @ =gBitTable
	ldr r2, [r4]
	ands r2, r5
	ldr r6, _0802316C @ =gNoOfAllBanks
	cmp r2, 0
	bne _0802314C
	adds r7, r6, 0
	ldrb r0, [r6]
	cmp r2, r0
	bcs _0802314C
	adds r3, r1, 0
_08023132:
	ldrb r0, [r3]
	adds r0, 0x1
	strb r0, [r3]
	ldrb r2, [r3]
	lsls r0, r2, 2
	adds r0, r4
	ldr r0, [r0]
	ands r0, r5
	cmp r0, 0
	bne _0802314C
	ldrb r0, [r7]
	cmp r2, r0
	bcc _08023132
_0802314C:
	ldrb r0, [r1]
	ldrb r6, [r6]
	cmp r0, r6
	beq _08023156
	b _08023302
_08023156:
	mov r1, r8
	mov r2, r12
	str r1, [r2]
	b _08023302
	.align 2, 0
_08023160: .4byte gHitMarker
_08023164: .4byte gBank1
_08023168: .4byte gBitTable
_0802316C: .4byte gNoOfAllBanks
_08023170:
	movs r0, 0x80
	ands r0, r2
	movs r5, 0x1
	cmp r0, 0
	beq _0802317C
	movs r5, 0
_0802317C:
	movs r0, 0x7F
	ands r0, r2
	bl GetBattleBank
	lsls r0, 24
	lsrs r7, r0, 24
	ldr r1, _080231A4 @ =gSpecialStatuses
	lsls r0, r7, 2
	adds r0, r7
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 25
	cmp r0, 0
	bge _080231A8
	ldr r0, [r6]
	adds r0, 0x6
	str r0, [r6]
	b _08023302
	.align 2, 0
_080231A4: .4byte gSpecialStatuses
_080231A8:
	adds r0, r7, 0
	movs r1, 0x6
	movs r2, 0x6
	bl sub_8018018
	lsls r0, 24
	cmp r0, 0
	beq _080231F8
	ldr r2, _080231E8 @ =gActiveBank
	strb r7, [r2]
	ldr r3, _080231EC @ =gAbsentBankFlags
	ldr r4, _080231F0 @ =gBitTable
	ldrb r0, [r2]
	lsls r0, 2
	adds r0, r4
	ldr r0, [r0]
	ldrb r1, [r3]
	orrs r0, r1
	strb r0, [r3]
	ldr r3, _080231F4 @ =gHitMarker
	ldrb r0, [r2]
	lsls r0, 2
	adds r0, r4
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r3]
	bics r0, r1
	str r0, [r3]
	mov r0, r8
	str r0, [r6]
	b _08023302
	.align 2, 0
_080231E8: .4byte gActiveBank
_080231EC: .4byte gAbsentBankFlags
_080231F0: .4byte gBitTable
_080231F4: .4byte gHitMarker
_080231F8:
	ldr r4, _080232A0 @ =gActiveBank
	strb r7, [r4]
	ldr r3, _080232A4 @ =0x02000000
	ldrb r0, [r4]
	ldr r2, _080232A8 @ =0x00016064
	adds r1, r0, r2
	adds r1, r3
	ldr r2, _080232AC @ =gBattlePartyID
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1]
	ldrb r1, [r4]
	movs r0, 0x2
	eors r0, r1
	ldr r1, _080232B0 @ =0x00016068
	adds r0, r1
	adds r0, r3
	ldrb r2, [r0]
	ldrb r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	ldr r1, _080232B4 @ =0x0001606c
	adds r3, r1
	adds r0, r3
	str r0, [sp]
	movs r0, 0
	adds r1, r5, 0
	movs r3, 0
	bl dp01_build_cmdbuf_x16_a_b_c_ptr_d_e_f
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r6]
	adds r0, 0x6
	str r0, [r6]
	ldrb r0, [r4]
	bl GetBankIdentity
	lsls r0, 24
	cmp r0, 0
	bne _0802325A
	ldr r1, _080232B8 @ =gBattleResults
	ldrb r0, [r1, 0x2]
	cmp r0, 0xFE
	bhi _0802325A
	adds r0, 0x1
	strb r0, [r1, 0x2]
_0802325A:
	ldr r0, _080232BC @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080232C4
	ldr r1, _080232A0 @ =gActiveBank
	movs r0, 0
	strb r0, [r1]
	ldr r0, _080232C0 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r0, 0
	beq _08023302
	adds r4, r1, 0
_08023276:
	ldrb r0, [r4]
	cmp r0, r7
	beq _0802328A
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_0802328A:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	ldr r1, _080232C0 @ =gNoOfAllBanks
	lsls r0, 24
	lsrs r0, 24
	ldrb r1, [r1]
	cmp r0, r1
	bcc _08023276
	b _08023302
	.align 2, 0
_080232A0: .4byte gActiveBank
_080232A4: .4byte 0x02000000
_080232A8: .4byte 0x00016064
_080232AC: .4byte gBattlePartyID
_080232B0: .4byte 0x00016068
_080232B4: .4byte 0x0001606c
_080232B8: .4byte gBattleResults
_080232BC: .4byte gBattleTypeFlags
_080232C0: .4byte gNoOfAllBanks
_080232C4:
	adds r0, r7, 0
	bl GetBankIdentity
	movs r1, 0x1
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	ldr r4, _08023310 @ =gActiveBank
	strb r0, [r4]
	ldr r0, _08023314 @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _08023318 @ =gBitTable
	ldrb r3, [r4]
	lsls r0, r3, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	beq _080232F4
	movs r0, 0x2
	eors r3, r0
	strb r3, [r4]
_080232F4:
	movs r0, 0
	movs r1, 0x2
	bl EmitLinkStandbyMsg
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_08023302:
	add sp, 0x4
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08023310: .4byte gActiveBank
_08023314: .4byte gAbsentBankFlags
_08023318: .4byte gBitTable
	thumb_func_end atk50_openpartyscreen

	thumb_func_start sub_802331C
sub_802331C: @ 802331C
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r0, _0802334C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	beq _0802332C
	b _080234FE
_0802332C:
	ldr r4, _08023350 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r7, _08023354 @ =gActiveBank
	strb r0, [r7]
	ldr r0, [r4]
	ldrb r0, [r0, 0x2]
	cmp r0, 0x1
	beq _080233A0
	cmp r0, 0x1
	bgt _08023358
	cmp r0, 0
	beq _0802335E
	b _080234F6
	.align 2, 0
_0802334C: .4byte gBattleExecBuffer
_08023350: .4byte gBattlescriptCurrInstr
_08023354: .4byte gActiveBank
_08023358:
	cmp r0, 0x2
	beq _080233BC
	b _080234F6
_0802335E:
	movs r3, 0
	ldr r2, _08023390 @ =gNoOfAllBanks
	ldrb r0, [r2]
	cmp r3, r0
	blt _0802336A
	b _080234F6
_0802336A:
	ldr r0, _08023394 @ =0x02000000
	ldr r1, _08023398 @ =BattleBufferB
	movs r5, 0x80
	lsls r5, 2
	adds r4, r2, 0
	ldr r6, _0802339C @ =0x00016068
	adds r2, r0, r6
_08023378:
	ldrb r0, [r1]
	cmp r0, 0x22
	bne _08023382
	ldrb r0, [r1, 0x1]
	strb r0, [r2]
_08023382:
	adds r1, r5
	adds r2, 0x1
	adds r3, 0x1
	ldrb r0, [r4]
	cmp r3, r0
	blt _08023378
	b _080234F6
	.align 2, 0
_08023390: .4byte gNoOfAllBanks
_08023394: .4byte 0x02000000
_08023398: .4byte BattleBufferB
_0802339C: .4byte 0x00016068
_080233A0:
	ldr r0, _080233B8 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080233AE
	b _080234F6
_080233AE:
	ldrb r0, [r7]
	bl sub_8012258
	b _080234F6
	.align 2, 0
_080233B8: .4byte gBattleTypeFlags
_080233BC:
	ldr r1, _08023484 @ =gBattleCommunication
	ldr r4, _08023488 @ =BattleBufferB
	ldrb r0, [r7]
	lsls r0, 9
	adds r2, r4, 0x1
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1]
	ldr r6, _0802348C @ =0x02000000
	ldrb r0, [r7]
	ldr r3, _08023490 @ =0x00016068
	adds r1, r0, r3
	adds r1, r6
	lsls r0, 9
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1]
	ldr r0, _08023494 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080234A4
	ldrb r0, [r7]
	lsls r1, r0, 1
	adds r1, r0
	ldr r5, _08023498 @ =0x0001606c
	adds r1, r5
	adds r1, r6
	ldrb r2, [r1]
	movs r0, 0xF
	ands r0, r2
	strb r0, [r1]
	ldrb r0, [r7]
	lsls r1, r0, 1
	adds r1, r0
	adds r1, r5
	adds r1, r6
	lsls r0, 9
	adds r2, r4, 0x2
	mov r12, r2
	add r0, r12
	ldrb r2, [r0]
	movs r3, 0xF0
	adds r0, r3, 0
	ands r0, r2
	ldrb r2, [r1]
	orrs r0, r2
	strb r0, [r1]
	ldrb r0, [r7]
	lsls r1, r0, 1
	adds r1, r0
	ldr r2, _0802349C @ =0x0001606d
	adds r1, r2
	adds r1, r6
	lsls r0, 9
	adds r4, 0x3
	mov r8, r4
	add r0, r8
	ldrb r0, [r0]
	strb r0, [r1]
	ldrb r0, [r7]
	movs r4, 0x2
	eors r0, r4
	lsls r1, r0, 1
	adds r1, r0
	adds r1, r5
	adds r1, r6
	ldrb r2, [r1]
	adds r0, r3, 0
	ands r0, r2
	strb r0, [r1]
	ldrb r0, [r7]
	eors r0, r4
	lsls r1, r0, 1
	adds r1, r0
	adds r1, r5
	adds r1, r6
	ldrb r0, [r7]
	lsls r0, 9
	add r0, r12
	ldrb r0, [r0]
	ands r3, r0
	lsrs r3, 4
	ldrb r0, [r1]
	orrs r3, r0
	strb r3, [r1]
	ldrb r0, [r7]
	eors r4, r0
	lsls r1, r4, 1
	adds r1, r4
	ldr r3, _080234A0 @ =0x0001606e
	adds r1, r3
	adds r1, r6
	ldrb r0, [r7]
	lsls r0, 9
	add r0, r8
	ldrb r0, [r0]
	strb r0, [r1]
	b _080234AA
	.align 2, 0
_08023484: .4byte gBattleCommunication
_08023488: .4byte BattleBufferB
_0802348C: .4byte 0x02000000
_08023490: .4byte 0x00016068
_08023494: .4byte gBattleTypeFlags
_08023498: .4byte 0x0001606c
_0802349C: .4byte 0x0001606d
_080234A0: .4byte 0x0001606e
_080234A4:
	ldrb r0, [r7]
	bl sub_8012258
_080234AA:
	ldr r1, _08023508 @ =gBattleTextBuff1
	movs r5, 0xFD
	strb r5, [r1]
	movs r0, 0x6
	strb r0, [r1, 0x1]
	ldr r4, _0802350C @ =gBattleMons
	ldr r3, _08023510 @ =gBankAttacker
	ldrb r0, [r3]
	movs r2, 0x58
	muls r0, r2
	adds r0, r4
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r3]
	muls r0, r2
	adds r0, r4
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r2, _08023514 @ =gBattleTextBuff2
	strb r5, [r2]
	movs r0, 0x7
	strb r0, [r2, 0x1]
	ldr r3, _08023518 @ =gActiveBank
	ldrb r0, [r3]
	strb r0, [r2, 0x2]
	ldr r1, _0802351C @ =BattleBufferB
	ldrb r0, [r3]
	lsls r0, 9
	adds r1, 0x1
	adds r0, r1
	ldrb r0, [r0]
	strb r0, [r2, 0x3]
	movs r0, 0x1
	negs r0, r0
	strb r0, [r2, 0x4]
_080234F6:
	ldr r1, _08023520 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x3
	str r0, [r1]
_080234FE:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08023508: .4byte gBattleTextBuff1
_0802350C: .4byte gBattleMons
_08023510: .4byte gBankAttacker
_08023514: .4byte gBattleTextBuff2
_08023518: .4byte gActiveBank
_0802351C: .4byte BattleBufferB
_08023520: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802331C

	thumb_func_start sub_8023524
sub_8023524: @ 8023524
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	sub sp, 0x4
	ldr r6, _08023630 @ =gBattlescriptCurrInstr
	ldr r0, [r6]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _08023634 @ =gActiveBank
	strb r0, [r4]
	ldrb r0, [r4]
	bl sub_80157C4
	ldr r2, _08023638 @ =gHitMarker
	ldr r1, _0802363C @ =gBitTable
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r1
	ldr r1, [r0]
	lsls r1, 28
	ldr r0, [r2]
	bics r0, r1
	str r0, [r2]
	ldr r2, _08023640 @ =gSpecialStatuses
	ldrb r0, [r4]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r2, [r1]
	movs r0, 0x41
	negs r0, r0
	ands r0, r2
	strb r0, [r1]
	ldrb r0, [r4]
	bl GetBankSide
	ldr r5, _08023644 @ =gSideAffecting
	lsls r0, 24
	lsrs r0, 23
	adds r0, r5
	ldrh r1, [r0]
	movs r0, 0x80
	lsls r0, 2
	mov r8, r0
	ands r0, r1
	cmp r0, 0
	bne _0802367C
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 23
	adds r0, r5
	ldrh r1, [r0]
	movs r0, 0x10
	ands r0, r1
	cmp r0, 0
	beq _0802367C
	ldr r1, _08023648 @ =gBattleMons
	mov r9, r1
	ldrb r2, [r4]
	movs r7, 0x58
	adds r0, r2, 0
	muls r0, r7
	adds r1, r0, r1
	adds r0, r1, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0x2
	beq _0802367C
	adds r0, r1, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0x2
	beq _0802367C
	adds r0, r1, 0
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x1A
	beq _0802367C
	adds r0, r2, 0
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 23
	adds r0, r5
	ldrh r2, [r0]
	mov r1, r8
	orrs r1, r2
	strh r1, [r0]
	ldrb r0, [r4]
	bl GetBankSide
	ldr r2, _0802364C @ =gSideTimer
	lsls r0, 24
	lsrs r0, 24
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r0, [r1, 0x6]
	movs r1, 0x5
	subs r1, r0
	lsls r1, 25
	lsrs r1, 24
	ldr r5, _08023650 @ =gBattleMoveDamage
	ldrb r0, [r4]
	muls r0, r7
	add r0, r9
	ldrh r0, [r0, 0x2C]
	bl __divsi3
	str r0, [r5]
	cmp r0, 0
	bne _08023614
	movs r0, 0x1
	str r0, [r5]
_08023614:
	ldr r0, _08023654 @ =0x02000000
	ldrb r1, [r4]
	ldr r2, _08023658 @ =0x00016003
	adds r0, r2
	strb r1, [r0]
	bl b_movescr_stack_push_cursor
	ldr r0, [r6]
	ldrb r0, [r0, 0x1]
	cmp r0, 0
	bne _08023660
	ldr r0, _0802365C @ =gUnknown_081D919F
	str r0, [r6]
	b _080237B6
	.align 2, 0
_08023630: .4byte gBattlescriptCurrInstr
_08023634: .4byte gActiveBank
_08023638: .4byte gHitMarker
_0802363C: .4byte gBitTable
_08023640: .4byte gSpecialStatuses
_08023644: .4byte gSideAffecting
_08023648: .4byte gBattleMons
_0802364C: .4byte gSideTimer
_08023650: .4byte gBattleMoveDamage
_08023654: .4byte 0x02000000
_08023658: .4byte 0x00016003
_0802365C: .4byte gUnknown_081D919F
_08023660:
	cmp r0, 0x1
	bne _08023670
	ldr r0, _0802366C @ =gUnknown_081D9171
	str r0, [r6]
	b _080237B6
	.align 2, 0
_0802366C: .4byte gUnknown_081D9171
_08023670:
	ldr r0, _08023678 @ =gUnknown_081D91CD
	str r0, [r6]
	b _080237B6
	.align 2, 0
_08023678: .4byte gUnknown_081D91CD
_0802367C:
	ldr r1, _08023754 @ =gBattleMons
	ldr r5, _08023758 @ =gActiveBank
	ldrb r2, [r5]
	movs r0, 0x58
	muls r0, r2
	adds r0, r1
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x36
	bne _080236A2
	ldr r1, _0802375C @ =gDisableStructs
	lsls r0, r2, 3
	subs r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r0, 0x18]
	movs r2, 0x1
	orrs r1, r2
	strb r1, [r0, 0x18]
_080236A2:
	ldrb r1, [r5]
	movs r0, 0
	str r0, [sp]
	movs r2, 0
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	beq _080236B8
	b _080237B6
_080236B8:
	ldrb r1, [r5]
	movs r0, 0
	movs r2, 0
	bl sub_801A02C
	lsls r0, 24
	cmp r0, 0
	bne _080237B6
	ldrb r0, [r5]
	bl GetBankSide
	ldr r1, _08023760 @ =gSideAffecting
	lsls r0, 24
	lsrs r0, 23
	adds r0, r1
	ldrh r2, [r0]
	ldr r1, _08023764 @ =0x0000fdff
	ands r1, r2
	strh r1, [r0]
	movs r4, 0
	ldr r0, _08023768 @ =gNoOfAllBanks
	ldrb r3, [r0]
	cmp r4, r3
	bge _08023706
	ldr r6, _0802376C @ =gTurnOrder
	ldr r3, _08023770 @ =gUnknown_02024A76
	movs r2, 0xC
	adds r1, r0, 0
_080236F0:
	adds r0, r4, r6
	ldrb r0, [r0]
	ldrb r7, [r5]
	cmp r0, r7
	bne _080236FE
	adds r0, r4, r3
	strb r2, [r0]
_080236FE:
	adds r4, 0x1
	ldrb r0, [r1]
	cmp r4, r0
	blt _080236F0
_08023706:
	movs r4, 0
	ldr r0, _08023768 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r4, r0
	bge _08023736
	ldr r5, _08023754 @ =gBattleMons
_08023712:
	lsls r0, r4, 24
	lsrs r0, 24
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 23
	ldr r1, _08023774 @ =0x020160bc
	adds r0, r1
	movs r1, 0x58
	muls r1, r4
	adds r1, r5
	ldrh r1, [r1, 0x28]
	strh r1, [r0]
	adds r4, 0x1
	ldr r0, _08023768 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r4, r0
	blt _08023712
_08023736:
	ldr r0, _08023778 @ =gBattlescriptCurrInstr
	ldr r1, [r0]
	ldrb r1, [r1, 0x1]
	adds r5, r0, 0
	cmp r1, 0x5
	bne _080237B0
	ldr r0, _0802377C @ =gHitMarker
	ldr r0, [r0]
	lsrs r4, r0, 28
	ldr r1, _08023780 @ =gBank1
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	ldr r2, _08023784 @ =gBitTable
	b _08023796
	.align 2, 0
_08023754: .4byte gBattleMons
_08023758: .4byte gActiveBank
_0802375C: .4byte gDisableStructs
_08023760: .4byte gSideAffecting
_08023764: .4byte 0x0000fdff
_08023768: .4byte gNoOfAllBanks
_0802376C: .4byte gTurnOrder
_08023770: .4byte gUnknown_02024A76
_08023774: .4byte 0x020160bc
_08023778: .4byte gBattlescriptCurrInstr
_0802377C: .4byte gHitMarker
_08023780: .4byte gBank1
_08023784: .4byte gBitTable
_08023788:
	ldr r0, _080237C4 @ =gNoOfAllBanks
	ldrb r3, [r1]
	ldrb r0, [r0]
	cmp r3, r0
	bcs _080237B0
	adds r0, r3, 0x1
	strb r0, [r1]
_08023796:
	ldrb r0, [r1]
	lsls r0, 2
	adds r0, r2
	ldr r3, [r0]
	adds r0, r4, 0
	ands r0, r3
	cmp r0, 0
	beq _08023788
	ldr r0, _080237C8 @ =gAbsentBankFlags
	ldrb r0, [r0]
	ands r0, r3
	cmp r0, 0
	bne _08023788
_080237B0:
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
_080237B6:
	add sp, 0x4
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080237C4: .4byte gNoOfAllBanks
_080237C8: .4byte gAbsentBankFlags
	thumb_func_end sub_8023524

	thumb_func_start sub_80237CC
sub_80237CC: @ 80237CC
	push {lr}
	ldr r0, _080237DC @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	cmp r0, 0
	bne _080237E0
	movs r0, 0
	b _080237E2
	.align 2, 0
_080237DC: .4byte gBattlescriptCurrInstr
_080237E0:
	movs r0, 0x1
_080237E2:
	bl GetBankByPlayerAI
	ldr r1, _08023804 @ =gActiveBank
	strb r0, [r1]
	movs r0, 0
	bl dp01_build_cmdbuf_x08_8_8_8
	ldr r0, _08023804 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r1, _08023808 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08023804: .4byte gActiveBank
_08023808: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80237CC

	thumb_func_start atk54_802511C
atk54_802511C: @ 802380C
	push {r4,r5,lr}
	ldr r5, _0802383C @ =gActiveBank
	ldr r0, _08023840 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r5]
	ldr r4, _08023844 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r1, [r0, 0x1]
	ldrb r0, [r0, 0x2]
	lsls r0, 8
	orrs r1, r0
	movs r0, 0
	bl EmitEffectivenessSound
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r0, [r4]
	adds r0, 0x3
	str r0, [r4]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802383C: .4byte gActiveBank
_08023840: .4byte gBankAttacker
_08023844: .4byte gBattlescriptCurrInstr
	thumb_func_end atk54_802511C

	thumb_func_start sub_8023848
sub_8023848: @ 8023848
	push {r4,r5,lr}
	ldr r5, _08023878 @ =gActiveBank
	ldr r0, _0802387C @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r5]
	ldr r4, _08023880 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r1, [r0, 0x1]
	ldrb r0, [r0, 0x2]
	lsls r0, 8
	orrs r1, r0
	movs r0, 0
	bl EmitPlaySound
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r0, [r4]
	adds r0, 0x3
	str r0, [r4]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08023878: .4byte gActiveBank
_0802387C: .4byte gBankAttacker
_08023880: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8023848

	thumb_func_start atk56_8025194
atk56_8025194: @ 8023884
	push {r4,r5,lr}
	ldr r5, _080238AC @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _080238B0 @ =gActiveBank
	strb r0, [r4]
	movs r0, 0
	bl EmitFaintingCry
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080238AC: .4byte gBattlescriptCurrInstr
_080238B0: .4byte gActiveBank
	thumb_func_end atk56_8025194

	thumb_func_start atk57_80251C4_flee
atk57_80251C4_flee: @ 80238B4
	push {r4,lr}
	movs r0, 0
	bl GetBankByPlayerAI
	ldr r4, _080238E0 @ =gActiveBank
	strb r0, [r4]
	ldr r0, _080238E4 @ =gBattleOutcome
	ldrb r1, [r0]
	movs r0, 0
	bl dp01_build_cmdbuf_x37_a
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _080238E8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080238E0: .4byte gActiveBank
_080238E4: .4byte gBattleOutcome
_080238E8: .4byte gBattlescriptCurrInstr
	thumb_func_end atk57_80251C4_flee

	thumb_func_start atk58_cmd58
atk58_cmd58: @ 80238EC
	push {r4,r5,lr}
	ldr r5, _08023918 @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _0802391C @ =gActiveBank
	strb r0, [r4]
	movs r0, 0
	movs r1, 0x1
	bl dp01_build_cmdbuf_x06_a
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08023918: .4byte gBattlescriptCurrInstr
_0802391C: .4byte gActiveBank
	thumb_func_end atk58_cmd58

	thumb_func_start atk59_8025230
atk59_8025230: @ 8023920
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r0, _0802399C @ =gBattlescriptCurrInstr
	ldr r2, [r0]
	ldrb r6, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r6, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r6, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r6, r0
	ldrb r4, [r2, 0x5]
	ldrb r0, [r2, 0x6]
	lsls r0, 8
	orrs r4, r0
	ldrb r0, [r2, 0x7]
	lsls r0, 16
	orrs r4, r0
	ldrb r0, [r2, 0x8]
	lsls r0, 24
	orrs r4, r0
	ldr r0, _080239A0 @ =0x02000000
	ldr r1, _080239A4 @ =0x00016018
	adds r7, r0, r1
	ldrb r1, [r7]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _080239A8 @ =gPlayerParty
	adds r0, r1
	ldrb r1, [r2, 0x9]
	bl sub_803B7C8
	lsls r0, 16
	lsrs r5, r0, 16
	ldr r0, _080239AC @ =0x0000fffe
	cmp r5, r0
	bne _08023992
	mov r9, r7
	mov r8, r5
	movs r7, 0x64
_0802397A:
	mov r3, r9
	ldrb r0, [r3]
	muls r0, r7
	ldr r1, _080239A8 @ =gPlayerParty
	adds r0, r1
	movs r1, 0
	bl sub_803B7C8
	lsls r0, 16
	lsrs r5, r0, 16
	cmp r5, r8
	beq _0802397A
_08023992:
	cmp r5, 0
	bne _080239B0
	ldr r0, _0802399C @ =gBattlescriptCurrInstr
	str r4, [r0]
	b _08023A58
	.align 2, 0
_0802399C: .4byte gBattlescriptCurrInstr
_080239A0: .4byte 0x02000000
_080239A4: .4byte 0x00016018
_080239A8: .4byte gPlayerParty
_080239AC: .4byte 0x0000fffe
_080239B0:
	ldr r0, _080239C0 @ =0x0000ffff
	cmp r5, r0
	bne _080239C8
	ldr r1, _080239C4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0xA
	str r0, [r1]
	b _08023A58
	.align 2, 0
_080239C0: .4byte 0x0000ffff
_080239C4: .4byte gBattlescriptCurrInstr
_080239C8:
	movs r0, 0
	bl GetBankByPlayerAI
	ldr r1, _08023A64 @ =gActiveBank
	strb r0, [r1]
	ldr r0, _08023A68 @ =gBattlePartyID
	ldrb r2, [r1]
	lsls r1, r2, 1
	adds r1, r0
	ldr r0, _08023A6C @ =0x02000000
	ldr r3, _08023A70 @ =0x00016018
	adds r0, r3
	ldrh r1, [r1]
	ldrb r0, [r0]
	cmp r1, r0
	bne _08023A08
	ldr r3, _08023A74 @ =gBattleMons
	movs r0, 0x58
	muls r2, r0
	adds r0, r3, 0
	adds r0, 0x50
	adds r0, r2, r0
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 14
	ands r0, r1
	cmp r0, 0
	bne _08023A08
	adds r0, r2, r3
	adds r1, r5, 0
	bl GiveMoveToBattleMon
_08023A08:
	ldr r0, _08023A78 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08023A54
	movs r0, 0x2
	bl GetBankByPlayerAI
	ldr r1, _08023A64 @ =gActiveBank
	strb r0, [r1]
	ldr r0, _08023A68 @ =gBattlePartyID
	ldrb r2, [r1]
	lsls r1, r2, 1
	adds r1, r0
	ldr r0, _08023A6C @ =0x02000000
	ldr r3, _08023A70 @ =0x00016018
	adds r0, r3
	ldrh r1, [r1]
	ldrb r0, [r0]
	cmp r1, r0
	bne _08023A54
	ldr r3, _08023A74 @ =gBattleMons
	movs r0, 0x58
	muls r2, r0
	adds r0, r3, 0
	adds r0, 0x50
	adds r0, r2, r0
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 14
	ands r0, r1
	cmp r0, 0
	bne _08023A54
	adds r0, r2, r3
	adds r1, r5, 0
	bl GiveMoveToBattleMon
_08023A54:
	ldr r0, _08023A7C @ =gBattlescriptCurrInstr
	str r6, [r0]
_08023A58:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08023A64: .4byte gActiveBank
_08023A68: .4byte gBattlePartyID
_08023A6C: .4byte 0x02000000
_08023A70: .4byte 0x00016018
_08023A74: .4byte gBattleMons
_08023A78: .4byte gBattleTypeFlags
_08023A7C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk59_8025230

	thumb_func_start sub_8023A80
sub_8023A80: @ 8023A80
	push {r4,lr}
	sub sp, 0x4
	movs r0, 0
	str r0, [sp]
	movs r0, 0x18
	movs r1, 0x8
	movs r2, 0x1D
	movs r3, 0xD
	bl sub_802BBD4
	ldr r4, _08023AC8 @ =gUnknown_03004210
	ldr r1, _08023ACC @ =gUnknown_08400D7A
	movs r2, 0x80
	lsls r2, 1
	movs r0, 0x9
	str r0, [sp]
	adds r0, r4, 0
	movs r3, 0x19
	bl InitWindow
	adds r0, r4, 0
	bl sub_8002F44
	ldr r1, _08023AD0 @ =0x0000ffff
	ldr r3, _08023AD4 @ =0x00002d9f
	movs r0, 0x20
	str r0, [sp]
	movs r0, 0
	movs r2, 0xC
	bl sub_814A5C0
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08023AC8: .4byte gUnknown_03004210
_08023ACC: .4byte gUnknown_08400D7A
_08023AD0: .4byte 0x0000ffff
_08023AD4: .4byte 0x00002d9f
	thumb_func_end sub_8023A80

	thumb_func_start sub_8023AD8
sub_8023AD8: @ 8023AD8
	push {lr}
	sub sp, 0x4
	movs r0, 0x1
	str r0, [sp]
	movs r0, 0x18
	movs r1, 0x8
	movs r2, 0x1D
	movs r3, 0xD
	bl sub_802BBD4
	bl DestroyMenuCursor
	add sp, 0x4
	pop {r0}
	bx r0
	thumb_func_end sub_8023AD8

	thumb_func_start sub_8023AF8
sub_8023AF8: @ 8023AF8
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	sub sp, 0x4
	ldr r1, _08023B24 @ =gActiveBank
	movs r0, 0
	strb r0, [r1]
	ldr r1, _08023B28 @ =0x02000000
	ldr r2, _08023B2C @ =0x0001601a
	adds r0, r1, r2
	ldrb r0, [r0]
	adds r5, r1, 0
	cmp r0, 0x5
	bls _08023B18
	b _08023E5C
_08023B18:
	lsls r0, 2
	ldr r1, _08023B30 @ =_08023B34
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08023B24: .4byte gActiveBank
_08023B28: .4byte 0x02000000
_08023B2C: .4byte 0x0001601a
_08023B30: .4byte _08023B34
	.align 2, 0
_08023B34:
	.4byte _08023B4C
	.4byte _08023B74
	.4byte _08023C30
	.4byte _08023C84
	.4byte _08023E38
	.4byte _08023E4C
_08023B4C:
	bl sub_8023A80
	ldr r1, _08023B68 @ =0x02000000
	ldr r0, _08023B6C @ =0x0001601a
	adds r1, r0
	ldrb r0, [r1]
	adds r0, 0x1
	movs r2, 0
	strb r0, [r1]
	ldr r0, _08023B70 @ =gBattleCommunication
	strb r2, [r0, 0x1]
	bl sub_802BC6C
	b _08023E5C
	.align 2, 0
_08023B68: .4byte 0x02000000
_08023B6C: .4byte 0x0001601a
_08023B70: .4byte gBattleCommunication
_08023B74:
	ldr r0, _08023BFC @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08023B9A
	ldr r4, _08023C00 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	beq _08023B9A
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_08023B9A:
	ldr r0, _08023BFC @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08023BC0
	ldr r4, _08023C00 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	bne _08023BC0
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0x1
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_08023BC0:
	ldr r0, _08023BFC @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08023C0C
	movs r0, 0x5
	bl PlaySE
	ldr r0, _08023C00 @ =gBattleCommunication
	ldrb r4, [r0, 0x1]
	cmp r4, 0
	bne _08023C1C
	bl sub_8023AD8
	movs r0, 0x1
	negs r0, r0
	str r4, [sp]
	movs r1, 0
	movs r2, 0
	movs r3, 0x10
	bl BeginNormalPaletteFade
	ldr r1, _08023C04 @ =0x02000000
	ldr r2, _08023C08 @ =0x0001601a
	adds r1, r2
	ldrb r0, [r1]
	adds r0, 0x1
	b _08023E5A
	.align 2, 0
_08023BFC: .4byte gMain
_08023C00: .4byte gBattleCommunication
_08023C04: .4byte 0x02000000
_08023C08: .4byte 0x0001601a
_08023C0C:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	bne _08023C16
	b _08023E5C
_08023C16:
	movs r0, 0x5
	bl PlaySE
_08023C1C:
	ldr r0, _08023C28 @ =0x02000000
	ldr r1, _08023C2C @ =0x0001601a
	adds r0, r1
	movs r1, 0x4
	strb r1, [r0]
	b _08023E5C
	.align 2, 0
_08023C28: .4byte 0x02000000
_08023C2C: .4byte 0x0001601a
_08023C30:
	ldr r0, _08023C68 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08023C3E
	b _08023E5C
_08023C3E:
	ldr r0, _08023C6C @ =gPlayerParty
	ldr r2, _08023C70 @ =0x00016018
	adds r1, r5, r2
	ldrb r1, [r1]
	ldr r2, _08023C74 @ =gPlayerPartyCount
	ldrb r2, [r2]
	subs r2, 0x1
	lsls r2, 24
	lsrs r2, 24
	ldr r3, _08023C78 @ =ReshowBattleScreenAfterMenu
	ldr r4, _08023C7C @ =word_2024E82
	ldrh r4, [r4]
	str r4, [sp]
	bl sub_809D9F0
	ldr r0, _08023C80 @ =0x0001601a
	adds r1, r5, r0
	ldrb r0, [r1]
	adds r0, 0x1
	b _08023E5A
	.align 2, 0
_08023C68: .4byte gPaletteFade
_08023C6C: .4byte gPlayerParty
_08023C70: .4byte 0x00016018
_08023C74: .4byte gPlayerPartyCount
_08023C78: .4byte ReshowBattleScreenAfterMenu
_08023C7C: .4byte word_2024E82
_08023C80: .4byte 0x0001601a
_08023C84:
	ldr r0, _08023CB4 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08023C92
	b _08023E5C
_08023C92:
	ldr r0, _08023CB8 @ =gMain
	ldr r1, [r0, 0x4]
	ldr r0, _08023CBC @ =sub_800F808
	cmp r1, r0
	beq _08023C9E
	b _08023E5C
_08023C9E:
	bl sub_809FA30
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x4
	bne _08023CC8
	ldr r0, _08023CC0 @ =0x02000000
	ldr r1, _08023CC4 @ =0x0001601a
	adds r0, r1
	strb r5, [r0]
	b _08023E5C
	.align 2, 0
_08023CB4: .4byte gPaletteFade
_08023CB8: .4byte gMain
_08023CBC: .4byte sub_800F808
_08023CC0: .4byte 0x02000000
_08023CC4: .4byte 0x0001601a
_08023CC8:
	ldr r2, _08023D08 @ =0x02000000
	mov r9, r2
	ldr r6, _08023D0C @ =0x00016018
	add r6, r9
	ldrb r0, [r6]
	movs r1, 0x64
	mov r8, r1
	mov r2, r8
	muls r2, r0
	adds r0, r2, 0
	ldr r7, _08023D10 @ =gPlayerParty
	adds r0, r7
	adds r1, r5, 0
	adds r1, 0xD
	bl GetMonData
	lsls r0, 16
	lsrs r4, r0, 16
	adds r0, r4, 0
	bl IsHMMove2
	cmp r0, 0
	beq _08023D20
	ldr r0, _08023D14 @ =0x0000013f
	ldr r1, _08023D18 @ =gActiveBank
	ldrb r1, [r1]
	bl PrepareStringBattle
	ldr r1, _08023D1C @ =0x0001601a
	add r1, r9
	movs r0, 0x5
	b _08023E5A
	.align 2, 0
_08023D08: .4byte 0x02000000
_08023D0C: .4byte 0x00016018
_08023D10: .4byte gPlayerParty
_08023D14: .4byte 0x0000013f
_08023D18: .4byte gActiveBank
_08023D1C: .4byte 0x0001601a
_08023D20:
	ldr r3, _08023E10 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	ldr r1, _08023E14 @ =gBattleTextBuff2
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	strb r4, [r1, 0x2]
	lsrs r0, r4, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldrb r0, [r6]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	adds r0, r7
	adds r1, r5, 0
	bl RemoveMonPPBonus
	ldrb r0, [r6]
	mov r2, r8
	muls r2, r0
	adds r0, r2, 0
	adds r0, r7
	ldr r7, _08023E18 @ =word_2024E82
	ldrh r1, [r7]
	adds r2, r5, 0
	bl SetMonMoveSlot
	ldr r0, _08023E1C @ =gBattlePartyID
	ldrh r0, [r0]
	ldrb r6, [r6]
	cmp r0, r6
	bne _08023DB0
	ldr r4, _08023E20 @ =gBattleMons
	ldr r0, [r4, 0x50]
	movs r1, 0x80
	lsls r1, 14
	ands r0, r1
	cmp r0, 0
	bne _08023DB0
	ldr r0, _08023E24 @ =gDisableStructs
	ldrb r1, [r0, 0x18]
	lsrs r1, 4
	ldr r2, _08023E28 @ =gBitTable
	lsls r0, r5, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _08023DB0
	adds r0, r4, 0
	adds r1, r5, 0
	bl RemoveBattleMonPPBonus
	ldrh r1, [r7]
	adds r0, r4, 0
	adds r2, r5, 0
	bl SetBattleMonMoveSlot
_08023DB0:
	ldr r0, _08023E2C @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08023E5C
	ldr r0, _08023E1C @ =gBattlePartyID
	ldr r1, _08023E30 @ =0x02000000
	ldr r2, _08023E34 @ =0x00016018
	adds r1, r2
	ldrh r0, [r0, 0x4]
	ldrb r1, [r1]
	cmp r0, r1
	bne _08023E5C
	ldr r4, _08023E20 @ =gBattleMons
	movs r1, 0x80
	lsls r1, 1
	adds r0, r4, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 14
	ands r0, r1
	cmp r0, 0
	bne _08023E5C
	ldr r0, _08023E24 @ =gDisableStructs
	adds r0, 0x50
	ldrb r1, [r0]
	lsrs r1, 4
	ldr r2, _08023E28 @ =gBitTable
	lsls r0, r5, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _08023E5C
	adds r4, 0xB0
	adds r0, r4, 0
	adds r1, r5, 0
	bl RemoveBattleMonPPBonus
	ldr r0, _08023E18 @ =word_2024E82
	ldrh r1, [r0]
	adds r0, r4, 0
	adds r2, r5, 0
	bl SetBattleMonMoveSlot
	b _08023E5C
	.align 2, 0
_08023E10: .4byte gBattlescriptCurrInstr
_08023E14: .4byte gBattleTextBuff2
_08023E18: .4byte word_2024E82
_08023E1C: .4byte gBattlePartyID
_08023E20: .4byte gBattleMons
_08023E24: .4byte gDisableStructs
_08023E28: .4byte gBitTable
_08023E2C: .4byte gBattleTypeFlags
_08023E30: .4byte 0x02000000
_08023E34: .4byte 0x00016018
_08023E38:
	bl sub_8023AD8
	ldr r1, _08023E48 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08023E5C
	.align 2, 0
_08023E48: .4byte gBattlescriptCurrInstr
_08023E4C:
	ldr r0, _08023E6C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _08023E5C
	ldr r2, _08023E70 @ =0x0001601a
	adds r1, r5, r2
	movs r0, 0x2
_08023E5A:
	strb r0, [r1]
_08023E5C:
	add sp, 0x4
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08023E6C: .4byte gBattleExecBuffer
_08023E70: .4byte 0x0001601a
	thumb_func_end sub_8023AF8

	thumb_func_start atk5B_80256E0
atk5B_80256E0: @ 8023E74
	push {r4,r5,lr}
	ldr r0, _08023E88 @ =0x02000000
	ldr r1, _08023E8C @ =0x0001601a
	adds r5, r0, r1
	ldrb r4, [r5]
	cmp r4, 0
	beq _08023E90
	cmp r4, 0x1
	beq _08023EA8
	b _08023F78
	.align 2, 0
_08023E88: .4byte 0x02000000
_08023E8C: .4byte 0x0001601a
_08023E90:
	bl sub_8023A80
	ldrb r0, [r5]
	adds r0, 0x1
	strb r0, [r5]
	ldr r0, _08023EA4 @ =gBattleCommunication
	strb r4, [r0, 0x1]
	bl sub_802BC6C
	b _08023F78
	.align 2, 0
_08023EA4: .4byte gBattleCommunication
_08023EA8:
	ldr r0, _08023F2C @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08023ECE
	ldr r4, _08023F30 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	beq _08023ECE
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_08023ECE:
	ldr r0, _08023F2C @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08023EF4
	ldr r4, _08023F30 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	bne _08023EF4
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0x1
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_08023EF4:
	ldr r0, _08023F2C @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08023F4C
	movs r0, 0x5
	bl PlaySE
	ldr r0, _08023F30 @ =gBattleCommunication
	ldrb r0, [r0, 0x1]
	cmp r0, 0
	beq _08023F38
	ldr r3, _08023F34 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08023F40
	.align 2, 0
_08023F2C: .4byte gMain
_08023F30: .4byte gBattleCommunication
_08023F34: .4byte gBattlescriptCurrInstr
_08023F38:
	ldr r1, _08023F48 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08023F40:
	bl sub_8023AD8
	b _08023F78
	.align 2, 0
_08023F48: .4byte gBattlescriptCurrInstr
_08023F4C:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _08023F78
	movs r0, 0x5
	bl PlaySE
	ldr r3, _08023F80 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	bl sub_8023AD8
_08023F78:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08023F80: .4byte gBattlescriptCurrInstr
	thumb_func_end atk5B_80256E0

	thumb_func_start atk5C_cmd5c
atk5C_cmd5c: @ 8023F84
	push {r4,lr}
	ldr r4, _08023FF0 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r2, _08023FF4 @ =gActiveBank
	strb r0, [r2]
	ldr r0, _08023FF8 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	bne _08024008
	ldr r0, _08023FFC @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 1
	ands r0, r1
	cmp r0, 0
	beq _08023FD6
	ldr r1, _08024000 @ =gBattleMons
	ldrb r2, [r2]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 17
	ands r0, r1
	cmp r0, 0
	beq _08023FD6
	ldr r0, _08024004 @ =gDisableStructs
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0xA]
	cmp r0, 0
	bne _08024008
_08023FD6:
	movs r0, 0
	bl EmitHitAnimation
	ldr r0, _08023FF4 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r1, _08023FF0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	b _0802400E
	.align 2, 0
_08023FF0: .4byte gBattlescriptCurrInstr
_08023FF4: .4byte gActiveBank
_08023FF8: .4byte gBattleMoveFlags
_08023FFC: .4byte gHitMarker
_08024000: .4byte gBattleMons
_08024004: .4byte gDisableStructs
_08024008:
	ldr r0, [r4]
	adds r0, 0x2
	str r0, [r4]
_0802400E:
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end atk5C_cmd5c

	thumb_func_start sub_8024014
sub_8024014: @ 8024014
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	movs r6, 0
	movs r5, 0
	ldr r0, _08024048 @ =gTrainerBattleOpponent
	ldrh r2, [r0]
	movs r1, 0x80
	lsls r1, 3
	cmp r2, r1
	bne _08024058
	ldr r0, _0802404C @ =0x02017000
	adds r1, r0, 0
	adds r1, 0x94
	ldrb r2, [r1]
	ldr r1, _08024050 @ =0xfffff056
	adds r0, r1
	ldrb r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r4, r2, 0
	muls r4, r0
	ldr r0, _08024054 @ =gSaveBlock1 + 0x490
	mov r8, r0
	b _08024140
	.align 2, 0
_08024048: .4byte gTrainerBattleOpponent
_0802404C: .4byte 0x02017000
_08024050: .4byte 0xfffff056
_08024054: .4byte gSaveBlock1 + 0x490
_08024058:
	ldr r2, _08024074 @ =gTrainers
	ldrh r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r3, r0, 3
	adds r4, r3, r2
	ldrb r1, [r4]
	cmp r1, 0x1
	beq _080240AE
	cmp r1, 0x1
	bgt _08024078
	cmp r1, 0
	beq _08024082
	b _080240C4
	.align 2, 0
_08024074: .4byte gTrainers
_08024078:
	cmp r1, 0x2
	beq _08024098
	cmp r1, 0x3
	beq _080240AE
	b _080240C4
_08024082:
	adds r0, r2, 0
	adds r0, 0x24
	adds r0, r3, r0
	ldr r1, [r0]
	adds r0, r4, 0
	adds r0, 0x20
	ldrb r0, [r0]
	lsls r0, 3
	adds r0, r1
	subs r0, 0x8
	b _080240C2
_08024098:
	adds r0, r2, 0
	adds r0, 0x24
	adds r0, r3, r0
	ldr r1, [r0]
	adds r0, r4, 0
	adds r0, 0x20
	ldrb r0, [r0]
	lsls r0, 3
	adds r0, r1
	subs r0, 0x8
	b _080240C2
_080240AE:
	adds r0, r2, 0
	adds r0, 0x24
	adds r0, r3, r0
	ldr r1, [r0]
	adds r0, r4, 0
	adds r0, 0x20
	ldrb r0, [r0]
	lsls r0, 4
	adds r0, r1
	subs r0, 0x10
_080240C2:
	ldrb r5, [r0, 0x2]
_080240C4:
	ldr r0, _08024120 @ =gTrainerMoney
	lsls r1, r6, 2
	adds r3, r1, r0
	ldrb r1, [r3]
	mov r12, r0
	lsls r4, r5, 2
	ldr r5, _08024124 @ =0x02000000
	ldr r7, _08024128 @ =gBattleTypeFlags
	ldr r0, _0802412C @ =gSaveBlock1 + 0x490
	mov r8, r0
	cmp r1, 0xFF
	beq _080240FE
	ldr r2, _08024130 @ =gTrainers
	ldr r0, _08024134 @ =gTrainerBattleOpponent
	ldrh r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 3
	adds r0, r2
	ldrb r2, [r0, 0x1]
	adds r1, r3, 0
_080240EE:
	ldrb r0, [r1]
	cmp r0, r2
	beq _080240FE
	adds r1, 0x4
	adds r6, 0x1
	ldrb r0, [r1]
	cmp r0, 0xFF
	bne _080240EE
_080240FE:
	ldr r1, _08024138 @ =0x00016056
	adds r0, r5, r1
	ldrb r0, [r0]
	adds r3, r4, 0
	muls r3, r0
	lsls r0, r6, 2
	add r0, r12
	ldrb r2, [r0, 0x1]
	ldrh r1, [r7]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0802413C
	lsls r0, r2, 1
	adds r4, r3, 0
	muls r4, r0
	b _08024140
	.align 2, 0
_08024120: .4byte gTrainerMoney
_08024124: .4byte 0x02000000
_08024128: .4byte gBattleTypeFlags
_0802412C: .4byte gSaveBlock1 + 0x490
_08024130: .4byte gTrainers
_08024134: .4byte gTrainerBattleOpponent
_08024138: .4byte 0x00016056
_0802413C:
	adds r4, r3, 0
	muls r4, r2
_08024140:
	mov r0, r8
	adds r1, r4, 0
	bl sub_80B79B8
	ldr r1, _0802418C @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x1
	strb r0, [r1, 0x1]
	movs r0, 0x4
	strb r0, [r1, 0x2]
	movs r0, 0x5
	strb r0, [r1, 0x3]
	strb r4, [r1, 0x4]
	movs r0, 0xFF
	lsls r0, 8
	ands r0, r4
	lsrs r0, 8
	strb r0, [r1, 0x5]
	movs r0, 0xFF
	lsls r0, 16
	ands r0, r4
	lsrs r0, 16
	strb r0, [r1, 0x6]
	lsrs r0, r4, 24
	strb r0, [r1, 0x7]
	movs r0, 0xFF
	strb r0, [r1, 0x8]
	ldr r1, _08024190 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802418C: .4byte gBattleTextBuff1
_08024190: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8024014

	thumb_func_start atk5E_8025A70
atk5E_8025A70: @ 8024194
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r4, _080241B8 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r6, _080241BC @ =gActiveBank
	strb r0, [r6]
	ldr r5, _080241C0 @ =gBattleCommunication
	ldrb r0, [r5]
	mov r8, r4
	cmp r0, 0
	beq _080241C4
	cmp r0, 0x1
	beq _080241DC
	b _08024230
	.align 2, 0
_080241B8: .4byte gBattlescriptCurrInstr
_080241BC: .4byte gActiveBank
_080241C0: .4byte gBattleCommunication
_080241C4:
	movs r0, 0
	movs r1, 0
	movs r2, 0
	bl EmitGetAttributes
	ldrb r0, [r6]
	bl MarkBufferBankForExecution
	ldrb r0, [r5]
	adds r0, 0x1
	strb r0, [r5]
	b _08024230
_080241DC:
	ldr r0, _0802423C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _08024230
	ldrb r0, [r6]
	lsls r0, 9
	ldr r1, _08024240 @ =gUnknown_02024264
	adds r0, r1
	mov r12, r0
	movs r2, 0
	adds r4, r6, 0
	movs r5, 0x58
	ldr r6, _08024244 @ =gUnknown_02024AA4
	adds r7, r6, 0
	subs r7, 0x18
	mov r3, r12
	adds r3, 0xC
_080241FE:
	lsls r1, r2, 1
	ldrb r0, [r4]
	muls r0, r5
	adds r1, r0
	adds r1, r7
	ldrh r0, [r3]
	strh r0, [r1]
	ldrb r0, [r4]
	adds r1, r0, 0
	muls r1, r5
	adds r1, r2, r1
	adds r1, r6
	mov r0, r12
	adds r0, 0x24
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1]
	adds r3, 0x2
	adds r2, 0x1
	cmp r2, 0x3
	ble _080241FE
	mov r1, r8
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
_08024230:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802423C: .4byte gBattleExecBuffer
_08024240: .4byte gUnknown_02024264
_08024244: .4byte gUnknown_02024AA4
	thumb_func_end atk5E_8025A70

	thumb_func_start atk5F_8025B24
atk5F_8025B24: @ 8024248
	push {lr}
	ldr r0, _08024270 @ =gActiveBank
	ldr r2, _08024274 @ =gBankAttacker
	ldrb r3, [r2]
	strb r3, [r0]
	ldr r1, _08024278 @ =gBankTarget
	ldrb r0, [r1]
	strb r0, [r2]
	strb r3, [r1]
	ldr r2, _0802427C @ =gHitMarker
	ldr r1, [r2]
	movs r3, 0x80
	lsls r3, 5
	adds r0, r1, 0
	ands r0, r3
	cmp r0, 0
	beq _08024284
	ldr r0, _08024280 @ =0xffffefff
	ands r1, r0
	b _08024286
	.align 2, 0
_08024270: .4byte gActiveBank
_08024274: .4byte gBankAttacker
_08024278: .4byte gBankTarget
_0802427C: .4byte gHitMarker
_08024280: .4byte 0xffffefff
_08024284:
	orrs r1, r3
_08024286:
	str r1, [r2]
	ldr r1, _08024294 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08024294: .4byte gBattlescriptCurrInstr
	thumb_func_end atk5F_8025B24

	thumb_func_start atk60_cmd60
atk60_cmd60: @ 8024298
	push {lr}
	ldr r0, _080242C0 @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	cmp r0, 0
	bne _080242B2
	ldr r0, _080242C4 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl IncrementGameStat
_080242B2:
	ldr r1, _080242C4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_080242C0: .4byte gBankAttacker
_080242C4: .4byte gBattlescriptCurrInstr
	thumb_func_end atk60_cmd60

	thumb_func_start atk61_8025BA4
atk61_8025BA4: @ 80242C8
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x30
	ldr r0, _0802432C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _0802437C
	ldr r0, _08024330 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r1, _08024334 @ =gActiveBank
	strb r0, [r1]
	ldrb r0, [r1]
	bl GetBankSide
	lsls r0, 24
	ldr r1, _08024338 @ =gEnemyParty
	mov r8, r1
	cmp r0, 0
	bne _080242FA
	ldr r0, _0802433C @ =gPlayerParty
	mov r8, r0
_080242FA:
	movs r7, 0
	add r6, sp, 0x4
	mov r5, sp
_08024300:
	movs r0, 0x64
	muls r0, r7
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	cmp r0, 0
	beq _08024324
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	movs r1, 0xCE
	lsls r1, 1
	cmp r0, r1
	bne _08024344
_08024324:
	ldr r0, _08024340 @ =0x0000ffff
	strh r0, [r5]
	movs r0, 0
	b _08024356
	.align 2, 0
_0802432C: .4byte gBattleExecBuffer
_08024330: .4byte gBattlescriptCurrInstr
_08024334: .4byte gActiveBank
_08024338: .4byte gEnemyParty
_0802433C: .4byte gPlayerParty
_08024340: .4byte 0x0000ffff
_08024344:
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	strh r0, [r5]
	adds r0, r4, 0
	movs r1, 0x37
	bl GetMonData
_08024356:
	str r0, [r6]
	adds r6, 0x8
	adds r5, 0x8
	adds r7, 0x1
	cmp r7, 0x5
	ble _08024300
	movs r0, 0
	mov r1, sp
	movs r2, 0x1
	bl dp01_build_cmdbuf_x30_TODO
	ldr r0, _08024388 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r1, _0802438C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
_0802437C:
	add sp, 0x30
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08024388: .4byte gActiveBank
_0802438C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk61_8025BA4

	thumb_func_start atk62_08025C6C
atk62_08025C6C: @ 8024390
	push {r4,r5,lr}
	ldr r5, _080243B8 @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _080243BC @ =gActiveBank
	strb r0, [r4]
	movs r0, 0
	bl dp01_build_cmdbuf_x31_31_31_31
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080243B8: .4byte gBattlescriptCurrInstr
_080243BC: .4byte gActiveBank
	thumb_func_end atk62_08025C6C

	thumb_func_start atk63_jumptoattack
atk63_jumptoattack: @ 80243C0
	push {r4,lr}
	ldr r0, _080243D8 @ =gBattlescriptCurrInstr
	ldr r1, [r0]
	ldrb r1, [r1, 0x1]
	adds r4, r0, 0
	cmp r1, 0
	beq _080243E4
	ldr r0, _080243DC @ =gCurrentMove
	ldr r1, _080243E0 @ =gUnknown_02024BEA
	ldrh r1, [r1]
	strh r1, [r0]
	b _080243F2
	.align 2, 0
_080243D8: .4byte gBattlescriptCurrInstr
_080243DC: .4byte gCurrentMove
_080243E0: .4byte gUnknown_02024BEA
_080243E4:
	ldr r2, _08024410 @ =gUnknown_02024BE8
	ldr r1, _08024414 @ =gCurrentMove
	ldr r0, _08024418 @ =gUnknown_02024BEA
	ldrh r0, [r0]
	strh r0, [r1]
	strh r0, [r2]
	adds r0, r1, 0
_080243F2:
	ldr r3, _0802441C @ =gUnknown_081D6BBC
	ldr r2, _08024420 @ =gBattleMoves
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	str r0, [r4]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08024410: .4byte gUnknown_02024BE8
_08024414: .4byte gCurrentMove
_08024418: .4byte gUnknown_02024BEA
_0802441C: .4byte gUnknown_081D6BBC
_08024420: .4byte gBattleMoves
	thumb_func_end atk63_jumptoattack

	thumb_func_start atk64_statusanimation
atk64_statusanimation: @ 8024424
	push {r4,lr}
	ldr r0, _08024494 @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _0802448C
	ldr r0, _08024498 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _0802449C @ =gActiveBank
	strb r0, [r4]
	ldr r1, _080244A0 @ =gStatuses3
	ldrb r2, [r4]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _080244A4 @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _08024484
	ldr r0, _080244A8 @ =gDisableStructs
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0xA]
	cmp r0, 0
	bne _08024484
	ldr r0, _080244AC @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08024484
	ldr r1, _080244B0 @ =gBattleMons
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x4C
	adds r0, r1
	ldr r2, [r0]
	movs r0, 0
	movs r1, 0
	bl EmitStatusAnimation
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_08024484:
	ldr r1, _08024498 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
_0802448C:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08024494: .4byte gBattleExecBuffer
_08024498: .4byte gBattlescriptCurrInstr
_0802449C: .4byte gActiveBank
_080244A0: .4byte gStatuses3
_080244A4: .4byte 0x000400c0
_080244A8: .4byte gDisableStructs
_080244AC: .4byte gHitMarker
_080244B0: .4byte gBattleMons
	thumb_func_end atk64_statusanimation

	thumb_func_start atk65_8025D90
atk65_8025D90: @ 80244B4
	push {r4,r5,lr}
	ldr r0, _0802453C @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _08024534
	ldr r4, _08024540 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r5, _08024544 @ =gActiveBank
	strb r0, [r5]
	ldr r1, [r4]
	ldrb r3, [r1, 0x2]
	ldrb r0, [r1, 0x3]
	lsls r0, 8
	orrs r3, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 16
	orrs r3, r0
	ldrb r0, [r1, 0x5]
	lsls r0, 24
	orrs r3, r0
	ldr r1, _08024548 @ =gStatuses3
	ldrb r2, [r5]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _0802454C @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _0802452C
	ldr r0, _08024550 @ =gDisableStructs
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0xA]
	cmp r0, 0
	bne _0802452C
	ldr r0, _08024554 @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0802452C
	ldr r1, _08024558 @ =gBattleMons
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r2, [r0]
	ands r2, r3
	movs r0, 0
	movs r1, 0x1
	bl EmitStatusAnimation
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
_0802452C:
	ldr r1, _08024540 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x6
	str r0, [r1]
_08024534:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802453C: .4byte gBattleExecBuffer
_08024540: .4byte gBattlescriptCurrInstr
_08024544: .4byte gActiveBank
_08024548: .4byte gStatuses3
_0802454C: .4byte 0x000400c0
_08024550: .4byte gDisableStructs
_08024554: .4byte gHitMarker
_08024558: .4byte gBattleMons
	thumb_func_end atk65_8025D90

	thumb_func_start atk66_8025E38
atk66_8025E38: @ 802455C
	push {r4,r5,lr}
	ldr r0, _080245D4 @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _080245CE
	ldr r4, _080245D8 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r5, _080245DC @ =gActiveBank
	strb r0, [r5]
	ldr r4, [r4]
	ldrb r2, [r4, 0x3]
	ldrb r0, [r4, 0x4]
	lsls r0, 8
	orrs r2, r0
	ldrb r0, [r4, 0x5]
	lsls r0, 16
	orrs r2, r0
	ldrb r0, [r4, 0x6]
	lsls r0, 24
	orrs r2, r0
	ldr r1, _080245E0 @ =gStatuses3
	ldrb r3, [r5]
	lsls r0, r3, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _080245E4 @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _080245C6
	ldr r0, _080245E8 @ =gDisableStructs
	lsls r1, r3, 3
	subs r1, r3
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0xA]
	cmp r0, 0
	bne _080245C6
	ldr r0, _080245EC @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	ands r0, r1
	cmp r0, 0
	bne _080245C6
	ldrb r1, [r4, 0x2]
	movs r0, 0
	bl EmitStatusAnimation
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
_080245C6:
	ldr r1, _080245D8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x7
	str r0, [r1]
_080245CE:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080245D4: .4byte gBattleExecBuffer
_080245D8: .4byte gBattlescriptCurrInstr
_080245DC: .4byte gActiveBank
_080245E0: .4byte gStatuses3
_080245E4: .4byte 0x000400c0
_080245E8: .4byte gDisableStructs
_080245EC: .4byte gHitMarker
	thumb_func_end atk66_8025E38

	thumb_func_start atk67_8025ECC
atk67_8025ECC: @ 80245F0
	push {r4,r5,lr}
	ldr r5, _08024600 @ =gBattleCommunication
	ldrb r4, [r5]
	cmp r4, 0
	beq _08024604
	cmp r4, 0x1
	beq _08024616
	b _08024696
	.align 2, 0
_08024600: .4byte gBattleCommunication
_08024604:
	bl sub_8023A80
	ldrb r0, [r5]
	adds r0, 0x1
	strb r0, [r5]
	strb r4, [r5, 0x1]
	bl sub_802BC6C
	b _08024696
_08024616:
	ldr r0, _08024674 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _0802463A
	ldrb r0, [r5, 0x1]
	cmp r0, 0
	beq _0802463A
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0
	strb r0, [r5, 0x1]
	bl sub_802BC6C
_0802463A:
	ldr r0, _08024674 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08024660
	ldr r4, _08024678 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	bne _08024660
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0x1
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_08024660:
	ldr r0, _08024674 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _0802467C
	ldr r1, _08024678 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x1]
	b _08024684
	.align 2, 0
_08024674: .4byte gMain
_08024678: .4byte gBattleCommunication
_0802467C:
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08024696
_08024684:
	movs r0, 0x5
	bl PlaySE
	bl sub_8023AD8
	ldr r1, _0802469C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_08024696:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802469C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk67_8025ECC

	thumb_func_start sub_80246A0
sub_80246A0: @ 80246A0
	push {r4,r5,lr}
	movs r1, 0
	ldr r2, _080246CC @ =gNoOfAllBanks
	ldr r5, _080246D0 @ =gBattlescriptCurrInstr
	ldrb r0, [r2]
	cmp r1, r0
	bge _080246BE
	ldr r4, _080246D4 @ =gUnknown_02024A76
	movs r3, 0xC
_080246B2:
	adds r0, r1, r4
	strb r3, [r0]
	adds r1, 0x1
	ldrb r0, [r2]
	cmp r1, r0
	blt _080246B2
_080246BE:
	ldr r0, [r5]
	adds r0, 0x1
	str r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080246CC: .4byte gNoOfAllBanks
_080246D0: .4byte gBattlescriptCurrInstr
_080246D4: .4byte gUnknown_02024A76
	thumb_func_end sub_80246A0

	thumb_func_start atk69_8025FE0
atk69_8025FE0: @ 80246D8
	push {r4-r7,lr}
	ldr r7, _08024700 @ =gBattleMons
	ldr r6, _08024704 @ =gBankTarget
	ldrb r2, [r6]
	movs r5, 0x58
	adds r0, r2, 0
	muls r0, r5
	adds r1, r0, r7
	ldrh r0, [r1, 0x2E]
	cmp r0, 0xAF
	bne _0802470C
	ldr r1, _08024708 @ =gEnigmaBerries
	lsls r0, r2, 3
	subs r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r4, [r0, 0x7]
	ldrb r6, [r0, 0x1A]
	b _08024726
	.align 2, 0
_08024700: .4byte gBattleMons
_08024704: .4byte gBankTarget
_08024708: .4byte gEnigmaBerries
_0802470C:
	ldrh r0, [r1, 0x2E]
	bl ItemId_GetHoldEffect
	lsls r0, 24
	lsrs r4, r0, 24
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r7
	ldrh r0, [r0, 0x2E]
	bl ItemId_GetHoldEffectParam
	lsls r0, 24
	lsrs r6, r0, 24
_08024726:
	ldr r1, _080247E8 @ =gStringBank
	ldr r5, _080247EC @ =gBankTarget
	ldrb r0, [r5]
	strb r0, [r1]
	cmp r4, 0x27
	bne _08024764
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x64
	bl __umodsi3
	lsls r0, 16
	lsrs r0, 16
	cmp r0, r6
	bcs _08024764
	ldrb r0, [r5]
	movs r1, 0x27
	bl RecordItemBattle
	ldr r2, _080247F0 @ =gSpecialStatuses
	ldrb r1, [r5]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x80
	orrs r1, r2
	strb r1, [r0]
_08024764:
	ldr r2, _080247F4 @ =gBattleMons
	ldr r3, _080247EC @ =gBankTarget
	ldrb r4, [r3]
	movs r0, 0x58
	muls r0, r4
	adds r1, r2, 0
	adds r1, 0x50
	adds r0, r1
	ldr r1, [r0]
	movs r0, 0x80
	lsls r0, 17
	ands r1, r0
	adds r5, r2, 0
	cmp r1, 0
	bne _08024834
	ldr r2, _080247F8 @ =gBattleMoves
	ldr r0, _080247FC @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	cmp r0, 0x65
	beq _080247B6
	ldr r0, _08024800 @ =gProtectStructs
	lsls r1, r4, 4
	adds r1, r0
	ldrb r0, [r1]
	lsls r0, 30
	cmp r0, 0
	blt _080247B6
	ldr r0, _080247F0 @ =gSpecialStatuses
	lsls r1, r4, 2
	adds r1, r4
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1]
	lsrs r0, 7
	cmp r0, 0
	beq _08024834
_080247B6:
	ldrb r0, [r3]
	movs r4, 0x58
	muls r0, r4
	adds r0, r5
	ldrh r1, [r0, 0x28]
	ldr r2, _08024804 @ =gBattleMoveDamage
	ldr r0, [r2]
	cmp r1, r0
	bgt _08024834
	subs r0, r1, 0x1
	str r0, [r2]
	ldr r1, _08024800 @ =gProtectStructs
	ldrb r3, [r3]
	lsls r0, r3, 4
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 30
	cmp r0, 0
	bge _0802480C
	ldr r0, _08024808 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r2, 0x40
	orrs r1, r2
	strb r1, [r0]
	b _08024834
	.align 2, 0
_080247E8: .4byte gStringBank
_080247EC: .4byte gBankTarget
_080247F0: .4byte gSpecialStatuses
_080247F4: .4byte gBattleMons
_080247F8: .4byte gBattleMoves
_080247FC: .4byte gCurrentMove
_08024800: .4byte gProtectStructs
_08024804: .4byte gBattleMoveDamage
_08024808: .4byte gBattleMoveFlags
_0802480C:
	ldr r0, _08024844 @ =gSpecialStatuses
	lsls r1, r3, 2
	adds r1, r3
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1]
	lsrs r0, 7
	cmp r0, 0
	beq _08024834
	ldr r2, _08024848 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _0802484C @ =gLastUsedItem
	adds r0, r3, 0
	muls r0, r4
	adds r0, r5
	ldrh r0, [r0, 0x2E]
	strh r0, [r1]
_08024834:
	ldr r1, _08024850 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08024844: .4byte gSpecialStatuses
_08024848: .4byte gBattleMoveFlags
_0802484C: .4byte gLastUsedItem
_08024850: .4byte gBattlescriptCurrInstr
	thumb_func_end atk69_8025FE0

	thumb_func_start atk6A_stash_item_for_side
atk6A_stash_item_for_side: @ 8024854
	push {r4-r6,lr}
	sub sp, 0x4
	ldr r6, _080248B0 @ =gBattlescriptCurrInstr
	ldr r0, [r6]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r5, _080248B4 @ =gActiveBank
	strb r0, [r5]
	ldrb r4, [r5]
	lsls r1, r4, 1
	ldr r0, _080248B8 @ =0x020160cc
	adds r1, r0
	ldr r2, _080248BC @ =gBattleMons
	movs r3, 0x58
	adds r0, r4, 0
	muls r0, r3
	adds r0, r2
	ldrh r0, [r0, 0x2E]
	strh r0, [r1]
	ldrb r0, [r5]
	muls r0, r3
	adds r0, r2
	movs r1, 0
	strh r1, [r0, 0x2E]
	ldrb r0, [r5]
	muls r0, r3
	adds r2, 0x2E
	adds r0, r2
	str r0, [sp]
	movs r0, 0
	movs r1, 0x2
	movs r2, 0
	movs r3, 0x2
	bl EmitSetAttributes
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r0, [r6]
	adds r0, 0x2
	str r0, [r6]
	add sp, 0x4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_080248B0: .4byte gBattlescriptCurrInstr
_080248B4: .4byte gActiveBank
_080248B8: .4byte 0x020160cc
_080248BC: .4byte gBattleMons
	thumb_func_end atk6A_stash_item_for_side

	thumb_func_start sub_80248C0
sub_80248C0: @ 80248C0
	ldr r1, _080248EC @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x7
	strb r0, [r1, 0x1]
	ldr r2, _080248F0 @ =gBankAttacker
	ldrb r0, [r2]
	strb r0, [r1, 0x2]
	ldr r3, _080248F4 @ =gBattlePartyID
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _080248F8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_080248EC: .4byte gBattleTextBuff1
_080248F0: .4byte gBankAttacker
_080248F4: .4byte gBattlePartyID
_080248F8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80248C0

	thumb_func_start sub_80248FC
sub_80248FC: @ 80248FC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	movs r1, 0
	movs r7, 0
	ldr r0, _08024928 @ =0x02000000
	mov r10, r0
	ldr r4, _0802492C @ =0x0001609c
	add r4, r10
	ldrb r0, [r4]
	cmp r0, 0x1
	bne _0802491C
	b _08024AF4
_0802491C:
	cmp r0, 0x1
	bgt _08024930
	cmp r0, 0
	beq _0802493E
	b _08024C38
	.align 2, 0
_08024928: .4byte 0x02000000
_0802492C: .4byte 0x0001609c
_08024930:
	cmp r0, 0x2
	bne _08024936
	b _08024C04
_08024936:
	cmp r0, 0x3
	bne _0802493C
	b _08024C30
_0802493C:
	b _08024C38
_0802493E:
	str r1, [sp]
	movs r0, 0xB
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x7
	bl sub_802BBD4
	ldr r0, _0802499C @ =gStringVar4
	ldr r1, _080249A0 @ =gUnknown_08400D9F
	bl StringCopy
	adds r5, r0, 0
	movs r1, 0
	mov r8, r1
_0802495A:
	movs r2, 0
	mov r9, r2
	ldr r0, _080249A4 @ =gUnknown_0840165C
	mov r1, r8
	lsls r4, r1, 2
	adds r0, r4, r0
	ldr r1, [r0]
	adds r0, r5, 0
	bl StringAppend
	adds r5, r0, 0
	ldr r0, _080249A8 @ =0x02000000
	ldr r2, _080249AC @ =0x00016018
	adds r0, r2
	ldrb r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _080249B0 @ =gPlayerParty
	adds r0, r1
	ldr r1, _080249B4 @ =gLevelUpStatBoxStats
	add r1, r8
	ldrb r1, [r1]
	bl GetMonData
	lsls r0, 16
	lsrs r1, r0, 16
	mov r0, r8
	cmp r0, 0x5
	bhi _08024A1A
	ldr r0, _080249B8 @ =_080249BC
	adds r0, r4, r0
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_0802499C: .4byte gStringVar4
_080249A0: .4byte gUnknown_08400D9F
_080249A4: .4byte gUnknown_0840165C
_080249A8: .4byte 0x02000000
_080249AC: .4byte 0x00016018
_080249B0: .4byte gPlayerParty
_080249B4: .4byte gLevelUpStatBoxStats
_080249B8: .4byte _080249BC
	.align 2, 0
_080249BC:
	.4byte _080249D4
	.4byte _080249E0
	.4byte _080249EC
	.4byte _080249F8
	.4byte _08024A04
	.4byte _08024A10
_080249D4:
	ldr r0, _080249DC @ =0x02017180
	ldrh r0, [r0]
	b _08024A14
	.align 2, 0
_080249DC: .4byte 0x02017180
_080249E0:
	ldr r0, _080249E8 @ =0x02017180
	ldrh r0, [r0, 0x8]
	b _08024A14
	.align 2, 0
_080249E8: .4byte 0x02017180
_080249EC:
	ldr r0, _080249F4 @ =0x02017180
	ldrh r0, [r0, 0x2]
	b _08024A14
	.align 2, 0
_080249F4: .4byte 0x02017180
_080249F8:
	ldr r0, _08024A00 @ =0x02017180
	ldrh r0, [r0, 0xA]
	b _08024A14
	.align 2, 0
_08024A00: .4byte 0x02017180
_08024A04:
	ldr r0, _08024A0C @ =0x02017180
	ldrh r0, [r0, 0x4]
	b _08024A14
	.align 2, 0
_08024A0C: .4byte 0x02017180
_08024A10:
	ldr r0, _08024A54 @ =0x02017180
	ldrh r0, [r0, 0x6]
_08024A14:
	subs r0, r1, r0
	lsls r0, 16
	lsrs r7, r0, 16
_08024A1A:
	lsls r0, r7, 16
	asrs r0, 16
	cmp r0, 0
	bge _08024A2C
	negs r0, r0
	lsls r0, 16
	lsrs r7, r0, 16
	movs r1, 0x1
	add r9, r1
_08024A2C:
	movs r0, 0xFC
	strb r0, [r5]
	movs r0, 0x13
	strb r0, [r5, 0x1]
	movs r1, 0x1
	mov r2, r8
	ands r1, r2
	lsls r0, r1, 3
	adds r0, r1
	adds r0, 0x5
	lsls r0, 3
	adds r0, 0x6
	strb r0, [r5, 0x2]
	adds r5, 0x3
	mov r0, r9
	cmp r0, 0
	beq _08024A5C
	ldr r1, _08024A58 @ =gUnknown_08400DAC
	b _08024A5E
	.align 2, 0
_08024A54: .4byte 0x02017180
_08024A58: .4byte gUnknown_08400DAC
_08024A5C:
	ldr r1, _08024AA4 @ =gUnknown_08400DAA
_08024A5E:
	adds r0, r5, 0
	bl StringCopy
	adds r5, r0, 0
	movs r6, 0xFC
	strb r6, [r5]
	movs r4, 0x14
	strb r4, [r5, 0x1]
	movs r0, 0x6
	strb r0, [r5, 0x2]
	adds r5, 0x3
	lsls r1, r7, 16
	asrs r1, 16
	adds r0, r5, 0
	movs r2, 0x1
	movs r3, 0x2
	bl ConvertIntToDecimalStringN
	adds r5, r0, 0
	strb r6, [r5]
	strb r4, [r5, 0x1]
	movs r0, 0
	strb r0, [r5, 0x2]
	adds r5, 0x3
	movs r0, 0x1
	mov r1, r8
	ands r0, r1
	cmp r0, 0
	beq _08024AA8
	movs r0, 0xFE
	strb r0, [r5]
	movs r0, 0xFF
	strb r0, [r5, 0x1]
	adds r5, 0x1
	b _08024AB8
	.align 2, 0
_08024AA4: .4byte gUnknown_08400DAA
_08024AA8:
	strb r6, [r5]
	movs r0, 0x11
	strb r0, [r5, 0x1]
	movs r0, 0x8
	strb r0, [r5, 0x2]
	adds r5, 0x3
	movs r0, 0xFF
	strb r0, [r5]
_08024AB8:
	movs r2, 0x1
	add r8, r2
	mov r0, r8
	cmp r0, 0x5
	bgt _08024AC4
	b _0802495A
_08024AC4:
	ldr r4, _08024AE4 @ =gUnknown_03004210
	ldr r1, _08024AE8 @ =gStringVar4
	adds r2, 0xFF
	movs r0, 0x1
	str r0, [sp]
	adds r0, r4, 0
	movs r3, 0xC
	bl InitWindow
	adds r0, r4, 0
	bl sub_8002F44
	ldr r1, _08024AEC @ =0x02000000
	ldr r2, _08024AF0 @ =0x0001609c
	adds r1, r2
	b _08024BEA
	.align 2, 0
_08024AE4: .4byte gUnknown_03004210
_08024AE8: .4byte gStringVar4
_08024AEC: .4byte 0x02000000
_08024AF0: .4byte 0x0001609c
_08024AF4:
	ldr r0, _08024B94 @ =gMain
	ldrh r0, [r0, 0x2E]
	cmp r0, 0
	bne _08024AFE
	b _08024C38
_08024AFE:
	movs r0, 0x5
	bl PlaySE
	ldr r0, _08024B98 @ =gStringVar4
	ldr r1, _08024B9C @ =gUnknown_08400D9F
	bl StringCopy
	adds r5, r0, 0
	movs r0, 0
	mov r8, r0
	mov r9, r0
	movs r6, 0xFC
	movs r7, 0x14
	ldr r1, _08024BA0 @ =0x00016018
	add r10, r1
_08024B1C:
	ldr r1, _08024BA4 @ =gUnknown_0840165C
	mov r2, r8
	lsls r0, r2, 2
	adds r0, r1
	ldr r1, [r0]
	adds r0, r5, 0
	bl StringAppend
	adds r5, r0, 0
	mov r0, r10
	ldrb r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _08024BA8 @ =gPlayerParty
	adds r0, r1
	ldr r1, _08024BAC @ =gLevelUpStatBoxStats
	add r1, r8
	ldrb r1, [r1]
	bl GetMonData
	adds r1, r0, 0
	strb r6, [r5]
	movs r0, 0x13
	strb r0, [r5, 0x1]
	movs r4, 0x1
	mov r2, r8
	ands r4, r2
	lsls r0, r4, 3
	adds r0, r4
	adds r0, 0x5
	lsls r0, 3
	adds r0, 0x6
	strb r0, [r5, 0x2]
	adds r5, 0x3
	strb r6, [r5]
	strb r7, [r5, 0x1]
	movs r0, 0x6
	strb r0, [r5, 0x2]
	adds r5, 0x3
	lsls r1, 16
	asrs r1, 16
	adds r0, r5, 0
	movs r2, 0x1
	movs r3, 0x3
	bl ConvertIntToDecimalStringN
	adds r5, r0, 0
	strb r6, [r5]
	strb r7, [r5, 0x1]
	mov r0, r9
	strb r0, [r5, 0x2]
	adds r5, 0x3
	cmp r4, 0
	beq _08024BB0
	movs r0, 0xFE
	strb r0, [r5]
	movs r0, 0xFF
	strb r0, [r5, 0x1]
	adds r5, 0x1
	b _08024BC0
	.align 2, 0
_08024B94: .4byte gMain
_08024B98: .4byte gStringVar4
_08024B9C: .4byte gUnknown_08400D9F
_08024BA0: .4byte 0x00016018
_08024BA4: .4byte gUnknown_0840165C
_08024BA8: .4byte gPlayerParty
_08024BAC: .4byte gLevelUpStatBoxStats
_08024BB0:
	strb r6, [r5]
	movs r0, 0x11
	strb r0, [r5, 0x1]
	movs r0, 0x8
	strb r0, [r5, 0x2]
	adds r5, 0x3
	movs r0, 0xFF
	strb r0, [r5]
_08024BC0:
	movs r1, 0x1
	add r8, r1
	mov r2, r8
	cmp r2, 0x5
	ble _08024B1C
	ldr r4, _08024BF4 @ =gUnknown_03004210
	ldr r1, _08024BF8 @ =gStringVar4
	movs r2, 0x80
	lsls r2, 1
	movs r0, 0x1
	str r0, [sp]
	adds r0, r4, 0
	movs r3, 0xC
	bl InitWindow
	adds r0, r4, 0
	bl sub_8002F44
	ldr r1, _08024BFC @ =0x02000000
	ldr r0, _08024C00 @ =0x0001609c
	adds r1, r0
_08024BEA:
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	b _08024C38
	.align 2, 0
_08024BF4: .4byte gUnknown_03004210
_08024BF8: .4byte gStringVar4
_08024BFC: .4byte 0x02000000
_08024C00: .4byte 0x0001609c
_08024C04:
	ldr r0, _08024C2C @ =gMain
	ldrh r0, [r0, 0x2E]
	cmp r0, 0
	beq _08024C38
	movs r0, 0x5
	bl PlaySE
	movs r0, 0x1
	str r0, [sp]
	movs r0, 0xB
	movs r1, 0
	movs r2, 0x1D
	movs r3, 0x7
	bl sub_802BBD4
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	b _08024C38
	.align 2, 0
_08024C2C: .4byte gMain
_08024C30:
	ldr r1, _08024C48 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_08024C38:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08024C48: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80248FC

	thumb_func_start sub_8024C4C
sub_8024C4C: @ 8024C4C
	push {lr}
	bl sub_80156DC
	ldr r1, _08024C60 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08024C60: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8024C4C

	thumb_func_start atk6E_state0_side_becomes_attacker
atk6E_state0_side_becomes_attacker: @ 8024C64
	push {lr}
	movs r0, 0
	bl GetBankByPlayerAI
	ldr r1, _08024C7C @ =gBankAttacker
	strb r0, [r1]
	ldr r1, _08024C80 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08024C7C: .4byte gBankAttacker
_08024C80: .4byte gBattlescriptCurrInstr
	thumb_func_end atk6E_state0_side_becomes_attacker

	thumb_func_start atk6F_8026810
atk6F_8026810: @ 8024C84
	push {r4,r5,lr}
	ldr r5, _08024CB0 @ =gBattlescriptCurrInstr
	ldr r0, [r5]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r4, _08024CB4 @ =gActiveBank
	strb r0, [r4]
	movs r0, 0
	movs r1, 0
	bl EmitSpriteInvisibility
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08024CB0: .4byte gBattlescriptCurrInstr
_08024CB4: .4byte gActiveBank
	thumb_func_end atk6F_8026810

	thumb_func_start atk70_record_ability_usage_of_side
atk70_record_ability_usage_of_side: @ 8024CB8
	push {r4,lr}
	ldr r4, _08024CE0 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r1, _08024CE4 @ =gActiveBank
	strb r0, [r1]
	ldrb r0, [r1]
	ldr r1, _08024CE8 @ =gLastUsedAbility
	ldrb r1, [r1]
	bl RecordAbilityBattle
	ldr r0, [r4]
	adds r0, 0x1
	str r0, [r4]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08024CE0: .4byte gBattlescriptCurrInstr
_08024CE4: .4byte gActiveBank
_08024CE8: .4byte gLastUsedAbility
	thumb_func_end atk70_record_ability_usage_of_side

	thumb_func_start sub_8024CEC
sub_8024CEC: @ 8024CEC
	ldr r2, _08024D0C @ =gBattleTextBuff2
	movs r0, 0xFD
	strb r0, [r2]
	movs r0, 0x2
	strb r0, [r2, 0x1]
	ldr r0, _08024D10 @ =word_2024E82
	ldrh r1, [r0]
	strb r1, [r2, 0x2]
	movs r0, 0xFF
	lsls r0, 8
	ands r0, r1
	lsrs r0, 8
	strb r0, [r2, 0x3]
	movs r0, 0xFF
	strb r0, [r2, 0x4]
	bx lr
	.align 2, 0
_08024D0C: .4byte gBattleTextBuff2
_08024D10: .4byte word_2024E82
	thumb_func_end sub_8024CEC

	thumb_func_start atk71_80268A0
atk71_80268A0: @ 8024D14
	push {lr}
	bl sub_8024CEC
	ldr r1, _08024D28 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08024D28: .4byte gBattlescriptCurrInstr
	thumb_func_end atk71_80268A0

	thumb_func_start atk72_flee
atk72_flee: @ 8024D2C
	push {lr}
	ldr r0, _08024D58 @ =gBank1
	ldrb r0, [r0]
	bl sub_8014AB8
	lsls r0, 24
	cmp r0, 0
	beq _08024D60
	ldr r3, _08024D5C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08024D68
	.align 2, 0
_08024D58: .4byte gBank1
_08024D5C: .4byte gBattlescriptCurrInstr
_08024D60:
	ldr r1, _08024D6C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08024D68:
	pop {r0}
	bx r0
	.align 2, 0
_08024D6C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk72_flee

	thumb_func_start atk73_cmd73
atk73_cmd73: @ 8024D70
	push {r4,r5,lr}
	ldr r0, _08024DC0 @ =gBattleTypeFlags
	ldrh r0, [r0]
	movs r5, 0x1
	ands r5, r0
	cmp r5, 0
	bne _08024E12
	ldr r0, _08024DC4 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r1, _08024DC8 @ =gActiveBank
	strb r0, [r1]
	movs r1, 0x1
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	ldr r2, _08024DCC @ =gBattleMons
	movs r1, 0x58
	muls r1, r0
	adds r1, r2
	ldrh r4, [r1, 0x28]
	movs r0, 0x64
	muls r0, r4
	ldrh r1, [r1, 0x2C]
	bl __divsi3
	cmp r0, 0
	bne _08024DAE
	movs r0, 0x1
_08024DAE:
	cmp r0, 0x45
	bgt _08024DB6
	cmp r4, 0
	bne _08024DD8
_08024DB6:
	ldr r0, _08024DD0 @ =0x02000000
	ldr r1, _08024DD4 @ =0x000160c1
	adds r0, r1
	strb r5, [r0]
	b _08024E12
	.align 2, 0
_08024DC0: .4byte gBattleTypeFlags
_08024DC4: .4byte gBattlescriptCurrInstr
_08024DC8: .4byte gActiveBank
_08024DCC: .4byte gBattleMons
_08024DD0: .4byte 0x02000000
_08024DD4: .4byte 0x000160c1
_08024DD8:
	cmp r0, 0x27
	ble _08024DF0
	ldr r0, _08024DE8 @ =0x02000000
	ldr r1, _08024DEC @ =0x000160c1
	adds r0, r1
	movs r1, 0x1
	b _08024E10
	.align 2, 0
_08024DE8: .4byte 0x02000000
_08024DEC: .4byte 0x000160c1
_08024DF0:
	cmp r0, 0x9
	ble _08024E08
	ldr r0, _08024E00 @ =0x02000000
	ldr r1, _08024E04 @ =0x000160c1
	adds r0, r1
	movs r1, 0x2
	b _08024E10
	.align 2, 0
_08024E00: .4byte 0x02000000
_08024E04: .4byte 0x000160c1
_08024E08:
	ldr r0, _08024E20 @ =0x02000000
	ldr r1, _08024E24 @ =0x000160c1
	adds r0, r1
	movs r1, 0x3
_08024E10:
	strb r1, [r0]
_08024E12:
	ldr r1, _08024E28 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08024E20: .4byte 0x02000000
_08024E24: .4byte 0x000160c1
_08024E28: .4byte gBattlescriptCurrInstr
	thumb_func_end atk73_cmd73

	thumb_func_start atk74_hp_tresholds_2
atk74_hp_tresholds_2: @ 8024E2C
	push {r4-r7,lr}
	ldr r0, _08024E8C @ =gBattleTypeFlags
	ldrh r0, [r0]
	movs r7, 0x1
	ands r7, r0
	cmp r7, 0
	bne _08024ED0
	ldr r0, _08024E90 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	adds r4, r0, 0
	ldr r0, _08024E94 @ =gActiveBank
	strb r4, [r0]
	movs r0, 0x1
	eors r4, r0
	lsls r4, 24
	lsrs r4, 24
	ldr r6, _08024E98 @ =0x02000000
	adds r0, r4, 0
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 23
	ldr r1, _08024E9C @ =0x000160bc
	adds r0, r1
	adds r0, r6
	ldrb r5, [r0]
	ldr r1, _08024EA0 @ =gBattleMons
	movs r0, 0x58
	muls r0, r4
	adds r0, r1
	ldrh r4, [r0, 0x28]
	subs r1, r5, r4
	movs r0, 0x64
	muls r0, r1
	adds r1, r5, 0
	bl __divsi3
	adds r1, r0, 0
	cmp r4, r5
	bcc _08024EA8
	ldr r1, _08024EA4 @ =0x000160c1
	adds r0, r6, r1
	strb r7, [r0]
	b _08024ED0
	.align 2, 0
_08024E8C: .4byte gBattleTypeFlags
_08024E90: .4byte gBattlescriptCurrInstr
_08024E94: .4byte gActiveBank
_08024E98: .4byte 0x02000000
_08024E9C: .4byte 0x000160bc
_08024EA0: .4byte gBattleMons
_08024EA4: .4byte 0x000160c1
_08024EA8:
	cmp r0, 0x1D
	bgt _08024EB8
	ldr r0, _08024EB4 @ =0x000160c1
	adds r1, r6, r0
	movs r0, 0x1
	b _08024ECE
	.align 2, 0
_08024EB4: .4byte 0x000160c1
_08024EB8:
	cmp r1, 0x45
	bgt _08024EC8
	ldr r0, _08024EC4 @ =0x000160c1
	adds r1, r6, r0
	movs r0, 0x2
	b _08024ECE
	.align 2, 0
_08024EC4: .4byte 0x000160c1
_08024EC8:
	ldr r0, _08024EE0 @ =0x000160c1
	adds r1, r6, r0
	movs r0, 0x3
_08024ECE:
	strb r0, [r1]
_08024ED0:
	ldr r1, _08024EE4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08024EE0: .4byte 0x000160c1
_08024EE4: .4byte gBattlescriptCurrInstr
	thumb_func_end atk74_hp_tresholds_2

	thumb_func_start atk75_8026A58
atk75_8026A58: @ 8024EE8
	push {lr}
	sub sp, 0x4
	ldr r2, _08024F28 @ =gBankInMenu
	ldr r1, _08024F2C @ =gBankAttacker
	ldrb r0, [r1]
	strb r0, [r2]
	ldr r2, _08024F30 @ =gBattlePartyID
	ldrb r0, [r1]
	lsls r0, 1
	adds r0, r2
	ldrh r2, [r0]
	movs r0, 0x64
	muls r0, r2
	ldr r1, _08024F34 @ =gEnemyParty
	adds r0, r1
	ldr r1, _08024F38 @ =gLastUsedItem
	ldrh r1, [r1]
	lsls r2, 24
	lsrs r2, 24
	movs r3, 0x1
	str r3, [sp]
	movs r3, 0
	bl sub_803E1B0
	ldr r1, _08024F3C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	add sp, 0x4
	pop {r0}
	bx r0
	.align 2, 0
_08024F28: .4byte gBankInMenu
_08024F2C: .4byte gBankAttacker
_08024F30: .4byte gBattlePartyID
_08024F34: .4byte gEnemyParty
_08024F38: .4byte gLastUsedItem
_08024F3C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk75_8026A58

	thumb_func_start sub_8024F40
sub_8024F40: @ 8024F40
	push {r4-r6,lr}
	ldr r4, _08024F64 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r1, _08024F68 @ =gActiveBank
	strb r0, [r1]
	ldr r0, [r4]
	ldrb r0, [r0, 0x2]
	cmp r0, 0x6
	bls _08024F5A
	b _08025112
_08024F5A:
	lsls r0, 2
	ldr r1, _08024F6C @ =_08024F70
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_08024F64: .4byte gBattlescriptCurrInstr
_08024F68: .4byte gActiveBank
_08024F6C: .4byte _08024F70
	.align 2, 0
_08024F70:
	.4byte _08024F8C
	.4byte _08024F9C
	.4byte _08024FFC
	.4byte _0802500C
	.4byte _08025024
	.4byte _08025060
	.4byte _08025098
_08024F8C:
	ldr r0, _08024F98 @ =gActiveBank
	ldrb r0, [r0]
	bl CancelMultiTurnMoves
	b _08025112
	.align 2, 0
_08024F98: .4byte gActiveBank
_08024F9C:
	ldr r1, _08024FD8 @ =gBankAttacker
	ldr r4, _08024FDC @ =gBankTarget
	ldrb r0, [r4]
	strb r0, [r1]
	ldrb r0, [r1]
	bl GetBankSide
	movs r1, 0x1
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	ldr r2, _08024FE0 @ =gSideTimer
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r2, r1, r2
	ldrb r0, [r2, 0x8]
	cmp r0, 0
	beq _08024FE8
	ldr r1, _08024FE4 @ =gBattleMons
	ldrb r2, [r2, 0x9]
	movs r0, 0x58
	muls r0, r2
	adds r0, r1
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _08024FE8
	strb r2, [r4]
	b _08025112
	.align 2, 0
_08024FD8: .4byte gBankAttacker
_08024FDC: .4byte gBankTarget
_08024FE0: .4byte gSideTimer
_08024FE4: .4byte gBattleMons
_08024FE8:
	ldr r0, _08024FF4 @ =gBankTarget
	ldr r1, _08024FF8 @ =gActiveBank
	ldrb r1, [r1]
	strb r1, [r0]
	b _08025112
	.align 2, 0
_08024FF4: .4byte gBankTarget
_08024FF8: .4byte gActiveBank
_08024FFC:
	bl CanRunFromBattle
	ldr r1, _08025008 @ =gBattleCommunication
	strb r0, [r1]
	b _08025112
	.align 2, 0
_08025008: .4byte gBattleCommunication
_0802500C:
	ldr r0, _0802501C @ =gCurrentMove
	ldrh r0, [r0]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _08025020 @ =gBankTarget
	strb r0, [r1]
	b _08025112
	.align 2, 0
_0802501C: .4byte gCurrentMove
_08025020: .4byte gBankTarget
_08025024:
	ldr r2, _08025044 @ =gHitMarker
	ldr r1, _08025048 @ =gBitTable
	ldr r0, _0802504C @ =gActiveBank
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	lsls r0, 28
	ldr r2, [r2]
	ands r2, r0
	cmp r2, 0
	beq _08025054
	ldr r1, _08025050 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1]
	b _08025112
	.align 2, 0
_08025044: .4byte gHitMarker
_08025048: .4byte gBitTable
_0802504C: .4byte gActiveBank
_08025050: .4byte gBattleCommunication
_08025054:
	ldr r0, _0802505C @ =gBattleCommunication
	strb r2, [r0]
	b _08025112
	.align 2, 0
_0802505C: .4byte gBattleCommunication
_08025060:
	ldr r4, _08025090 @ =gSpecialStatuses
	ldr r3, _08025094 @ =gActiveBank
	ldrb r0, [r3]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r2, [r1]
	movs r0, 0x9
	negs r0, r0
	ands r0, r2
	strb r0, [r1]
	ldrb r0, [r3]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r2, [r1]
	movs r0, 0x11
	negs r0, r0
	ands r0, r2
	strb r0, [r1]
	b _08025112
	.align 2, 0
_08025090: .4byte gSpecialStatuses
_08025094: .4byte gActiveBank
_08025098:
	ldr r3, _080250B8 @ =gBattlePartyID
	ldr r0, _080250BC @ =0x02000000
	ldr r1, _080250C0 @ =0x00016018
	adds r0, r1
	ldrh r2, [r3]
	ldrb r1, [r0]
	cmp r2, r1
	beq _080250B2
	ldrh r0, [r3, 0x4]
	cmp r0, r1
	bne _08025112
	cmp r2, r0
	bne _080250C8
_080250B2:
	ldr r1, _080250C4 @ =gActiveBank
	movs r0, 0
	b _080250CC
	.align 2, 0
_080250B8: .4byte gBattlePartyID
_080250BC: .4byte 0x02000000
_080250C0: .4byte 0x00016018
_080250C4: .4byte gActiveBank
_080250C8:
	ldr r1, _08025120 @ =gActiveBank
	movs r0, 0x2
_080250CC:
	strb r0, [r1]
	adds r5, r1, 0
	ldrb r2, [r5]
	lsls r1, r2, 1
	ldr r0, _08025124 @ =0x020160e8
	adds r4, r1, r0
	movs r3, 0
	ldr r1, _08025128 @ =gBattleMons
	movs r0, 0x58
	muls r0, r2
	adds r1, 0xC
	adds r0, r1
	ldrh r0, [r0]
	ldrh r2, [r4]
	cmp r0, r2
	beq _0802510A
	adds r6, r5, 0
	movs r5, 0x58
	adds r2, r1, 0
_080250F2:
	adds r3, 0x1
	cmp r3, 0x3
	bgt _0802510A
	lsls r1, r3, 1
	ldrb r0, [r6]
	muls r0, r5
	adds r1, r0
	adds r1, r2
	ldrh r0, [r1]
	ldrh r1, [r4]
	cmp r0, r1
	bne _080250F2
_0802510A:
	cmp r3, 0x4
	bne _08025112
	movs r0, 0
	strh r0, [r4]
_08025112:
	ldr r1, _0802512C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x3
	str r0, [r1]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08025120: .4byte gActiveBank
_08025124: .4byte 0x020160e8
_08025128: .4byte gBattleMons
_0802512C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8024F40

	thumb_func_start atk77_setprotect
atk77_setprotect: @ 8025130
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	movs r6, 0x1
	ldr r2, _080251FC @ =gUnknown_02024C4C
	ldr r1, _08025200 @ =gBankAttacker
	ldrb r3, [r1]
	lsls r0, r3, 1
	adds r0, r2
	ldrh r0, [r0]
	mov r8, r1
	ldr r7, _08025204 @ =gDisableStructs
	cmp r0, 0xB6
	beq _08025160
	cmp r0, 0xC5
	beq _08025160
	cmp r0, 0xCB
	beq _08025160
	lsls r0, r3, 3
	subs r0, r3
	lsls r0, 2
	adds r0, r7
	movs r1, 0
	strb r1, [r0, 0x8]
_08025160:
	ldr r0, _08025208 @ =gCurrentMoveTurn
	ldrb r1, [r0]
	ldr r0, _0802520C @ =gNoOfAllBanks
	ldrb r0, [r0]
	subs r0, 0x1
	cmp r1, r0
	bne _08025170
	movs r6, 0
_08025170:
	ldr r2, _08025210 @ =gProtectSuccessRates
	mov r5, r8
	ldrb r1, [r5]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r7
	ldrb r4, [r0, 0x8]
	lsls r4, 1
	adds r4, r2
	bl Random
	ldrh r1, [r4]
	lsls r0, 16
	lsrs r0, 16
	cmp r1, r0
	bls _08025224
	cmp r6, 0
	beq _08025224
	ldr r4, _08025214 @ =gBattleMoves
	ldr r3, _08025218 @ =gCurrentMove
	ldrh r0, [r3]
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r0, [r1]
	cmp r0, 0x6F
	bne _080251C0
	ldr r0, _0802521C @ =gProtectStructs
	ldrb r1, [r5]
	lsls r1, 4
	adds r1, r0
	ldrb r0, [r1]
	movs r2, 0x1
	orrs r0, r2
	strb r0, [r1]
	ldr r1, _08025220 @ =gBattleCommunication
	movs r0, 0
	strb r0, [r1, 0x5]
_080251C0:
	ldrh r0, [r3]
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r0, [r1]
	cmp r0, 0x74
	bne _080251E6
	ldr r0, _0802521C @ =gProtectStructs
	ldrb r1, [r5]
	lsls r1, 4
	adds r1, r0
	ldrb r0, [r1]
	movs r2, 0x2
	orrs r0, r2
	strb r0, [r1]
	ldr r1, _08025220 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
_080251E6:
	mov r1, r8
	ldrb r0, [r1]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	adds r1, r7
	ldrb r0, [r1, 0x8]
	adds r0, 0x1
	strb r0, [r1, 0x8]
	b _08025246
	.align 2, 0
_080251FC: .4byte gUnknown_02024C4C
_08025200: .4byte gBankAttacker
_08025204: .4byte gDisableStructs
_08025208: .4byte gCurrentMoveTurn
_0802520C: .4byte gNoOfAllBanks
_08025210: .4byte gProtectSuccessRates
_08025214: .4byte gBattleMoves
_08025218: .4byte gCurrentMove
_0802521C: .4byte gProtectStructs
_08025220: .4byte gBattleCommunication
_08025224:
	ldr r2, _08025258 @ =gDisableStructs
	ldr r0, _0802525C @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0
	strb r1, [r0, 0x8]
	ldr r1, _08025260 @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	ldr r2, _08025264 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
_08025246:
	ldr r1, _08025268 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08025258: .4byte gDisableStructs
_0802525C: .4byte gBankAttacker
_08025260: .4byte gBattleCommunication
_08025264: .4byte gBattleMoveFlags
_08025268: .4byte gBattlescriptCurrInstr
	thumb_func_end atk77_setprotect

	thumb_func_start atk78_faintifabilitynotdamp
atk78_faintifabilitynotdamp: @ 802526C
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r0, _08025328 @ =gBattleExecBuffer
	ldr r2, [r0]
	cmp r2, 0
	bne _08025370
	ldr r1, _0802532C @ =gBankTarget
	strb r2, [r1]
	ldr r0, _08025330 @ =gNoOfAllBanks
	ldrb r3, [r0]
	adds r5, r1, 0
	mov r8, r0
	ldr r6, _08025334 @ =gBattleMons
	cmp r2, r3
	bcs _080252B8
	adds r0, r6, 0
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x6
	beq _080252B8
	adds r2, r3, 0
	adds r4, r6, 0
	movs r3, 0x58
_0802529C:
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, r2
	bcs _080252B8
	ldrb r0, [r5]
	muls r0, r3
	adds r0, r4
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x6
	bne _0802529C
_080252B8:
	ldrb r0, [r5]
	mov r1, r8
	ldrb r1, [r1]
	cmp r0, r1
	bne _08025354
	ldr r4, _08025338 @ =gActiveBank
	ldr r7, _0802533C @ =gBankAttacker
	ldrb r0, [r7]
	strb r0, [r4]
	ldr r2, _08025340 @ =gBattleMoveDamage
	ldrb r1, [r4]
	movs r0, 0x58
	muls r0, r1
	adds r0, r6
	ldrh r0, [r0, 0x28]
	str r0, [r2]
	ldr r1, _08025344 @ =0x00007fff
	movs r0, 0
	bl EmitHealthBarUpdate
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _08025348 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	movs r0, 0
	strb r0, [r5]
	mov r2, r8
	ldrb r0, [r2]
	cmp r0, 0
	beq _08025370
	adds r3, r5, 0
	ldrb r5, [r7]
	ldr r7, _0802534C @ =gBitTable
	adds r4, r0, 0
	ldr r6, _08025350 @ =gAbsentBankFlags
_08025304:
	ldrb r2, [r3]
	cmp r2, r5
	beq _0802531A
	ldrb r0, [r6]
	ldrb r1, [r3]
	lsls r1, 2
	adds r1, r7
	ldr r1, [r1]
	ands r0, r1
	cmp r0, 0
	beq _08025370
_0802531A:
	adds r0, r2, 0x1
	strb r0, [r3]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, r4
	bcc _08025304
	b _08025370
	.align 2, 0
_08025328: .4byte gBattleExecBuffer
_0802532C: .4byte gBankTarget
_08025330: .4byte gNoOfAllBanks
_08025334: .4byte gBattleMons
_08025338: .4byte gActiveBank
_0802533C: .4byte gBankAttacker
_08025340: .4byte gBattleMoveDamage
_08025344: .4byte 0x00007fff
_08025348: .4byte gBattlescriptCurrInstr
_0802534C: .4byte gBitTable
_08025350: .4byte gAbsentBankFlags
_08025354:
	ldr r1, _0802537C @ =gLastUsedAbility
	movs r0, 0x6
	strb r0, [r1]
	ldrb r0, [r5]
	movs r1, 0x58
	muls r1, r0
	adds r1, r6
	adds r1, 0x20
	ldrb r1, [r1]
	bl RecordAbilityBattle
	ldr r1, _08025380 @ =gBattlescriptCurrInstr
	ldr r0, _08025384 @ =gUnknown_081D9834
	str r0, [r1]
_08025370:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802537C: .4byte gLastUsedAbility
_08025380: .4byte gBattlescriptCurrInstr
_08025384: .4byte gUnknown_081D9834
	thumb_func_end atk78_faintifabilitynotdamp

	thumb_func_start atk79_setuserhptozero
atk79_setuserhptozero: @ 8025388
	push {r4,lr}
	sub sp, 0x4
	ldr r0, _080253D4 @ =gBattleExecBuffer
	ldr r3, [r0]
	cmp r3, 0
	bne _080253CC
	ldr r4, _080253D8 @ =gActiveBank
	ldr r0, _080253DC @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r4]
	ldr r1, _080253E0 @ =gBattleMons
	ldrb r0, [r4]
	movs r2, 0x58
	muls r0, r2
	adds r0, r1
	strh r3, [r0, 0x28]
	ldrb r0, [r4]
	muls r0, r2
	adds r1, 0x28
	adds r0, r1
	str r0, [sp]
	movs r0, 0
	movs r1, 0x2A
	movs r2, 0
	movs r3, 0x2
	bl EmitSetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _080253E4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_080253CC:
	add sp, 0x4
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080253D4: .4byte gBattleExecBuffer
_080253D8: .4byte gActiveBank
_080253DC: .4byte gBankAttacker
_080253E0: .4byte gBattleMons
_080253E4: .4byte gBattlescriptCurrInstr
	thumb_func_end atk79_setuserhptozero

	thumb_func_start sub_80253E8
sub_80253E8: @ 80253E8
	push {r4-r7,lr}
	ldr r3, _08025460 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r4, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r4, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r4, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r4, r0
	ldr r0, _08025464 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	adds r7, r3, 0
	cmp r0, 0
	beq _08025480
	ldr r0, _08025468 @ =gBankTarget
	ldrb r1, [r0]
	adds r1, 0x1
	strb r1, [r0]
	ldr r2, _0802546C @ =gBankAttacker
	lsls r1, 24
	lsrs r1, 24
	adds r3, r0, 0
	ldr r6, _08025470 @ =gAbsentBankFlags
	ldr r5, _08025474 @ =gBitTable
	ldr r0, _08025478 @ =gNoOfAllBanks
	mov r12, r0
	ldrb r0, [r2]
	cmp r1, r0
	bne _0802543E
_0802542E:
	ldrb r0, [r3]
	adds r0, 0x1
	strb r0, [r3]
	lsls r0, 24
	lsrs r0, 24
	ldrb r1, [r2]
	cmp r0, r1
	beq _0802542E
_0802543E:
	ldrb r0, [r6]
	ldrb r1, [r3]
	lsls r1, 2
	adds r1, r5
	ldr r1, [r1]
	ands r0, r1
	cmp r0, 0
	bne _0802542E
	ldrb r0, [r3]
	mov r2, r12
	ldrb r2, [r2]
	cmp r0, r2
	bcc _0802547C
	ldr r0, [r7]
	adds r0, 0x5
	str r0, [r7]
	b _08025484
	.align 2, 0
_08025460: .4byte gBattlescriptCurrInstr
_08025464: .4byte gBattleTypeFlags
_08025468: .4byte gBankTarget
_0802546C: .4byte gBankAttacker
_08025470: .4byte gAbsentBankFlags
_08025474: .4byte gBitTable
_08025478: .4byte gNoOfAllBanks
_0802547C:
	str r4, [r7]
	b _08025484
_08025480:
	adds r0, r2, 0x5
	str r0, [r3]
_08025484:
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_80253E8

	thumb_func_start sub_802548C
sub_802548C: @ 802548C
	push {r4-r6,lr}
	ldr r4, _080254E8 @ =gBattlescriptCurrInstr
	ldr r1, [r4]
	ldrb r2, [r1, 0x1]
	ldrb r0, [r1, 0x2]
	lsls r0, 8
	orrs r2, r0
	ldrb r0, [r1, 0x3]
	lsls r0, 16
	orrs r2, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 24
	orrs r2, r0
	ldrb r0, [r1, 0x5]
	ldr r3, _080254EC @ =gBankTarget
	cmp r0, 0x1
	bne _080254B4
	ldr r0, _080254F0 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r3]
_080254B4:
	ldr r1, _080254F4 @ =gBattleMoveDamage
	ldr r6, _080254F8 @ =gBattleMons
	ldrb r0, [r3]
	movs r5, 0x58
	muls r0, r5
	adds r0, r6
	ldrh r0, [r0, 0x2C]
	lsrs r0, 1
	str r0, [r1]
	cmp r0, 0
	bne _080254CE
	movs r0, 0x1
	str r0, [r1]
_080254CE:
	ldr r0, [r1]
	negs r0, r0
	str r0, [r1]
	ldrb r0, [r3]
	muls r0, r5
	adds r0, r6
	ldrh r1, [r0, 0x28]
	ldrh r0, [r0, 0x2C]
	cmp r1, r0
	bne _080254FC
	str r2, [r4]
	b _08025502
	.align 2, 0
_080254E8: .4byte gBattlescriptCurrInstr
_080254EC: .4byte gBankTarget
_080254F0: .4byte gBankAttacker
_080254F4: .4byte gBattleMoveDamage
_080254F8: .4byte gBattleMons
_080254FC:
	ldr r0, [r4]
	adds r0, 0x6
	str r0, [r4]
_08025502:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_802548C

	thumb_func_start sub_8025508
sub_8025508: @ 8025508
	push {r4-r7,lr}
	ldr r3, _0802556C @ =0x02000000
	ldr r4, _08025570 @ =gBankAttacker
	ldrb r2, [r4]
	lsls r1, r2, 1
	ldr r5, _08025574 @ =0x000160ac
	adds r0, r1, r5
	adds r0, r3
	ldrb r7, [r0]
	ldr r0, _08025578 @ =0x000160ad
	adds r1, r0
	adds r1, r3
	ldrb r0, [r1]
	lsls r0, 8
	orrs r7, r0
	lsls r2, 2
	ldr r1, _0802557C @ =0x00016100
	adds r0, r2, r1
	adds r0, r3
	ldrb r6, [r0]
	adds r5, 0x55
	adds r0, r2, r5
	adds r0, r3
	ldrb r0, [r0]
	lsls r0, 8
	orrs r6, r0
	adds r1, 0x2
	adds r0, r2, r1
	adds r0, r3
	ldrb r5, [r0]
	ldr r0, _08025580 @ =0x00016103
	adds r2, r0
	adds r2, r3
	ldrb r0, [r2]
	lsls r0, 8
	orrs r5, r0
	cmp r7, 0
	beq _08025594
	ldr r0, _08025584 @ =0x0000ffff
	cmp r7, r0
	beq _08025594
	ldr r2, _08025588 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _0802558C @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r4, _08025590 @ =gCurrentMove
	strh r7, [r4]
	b _0802565C
	.align 2, 0
_0802556C: .4byte 0x02000000
_08025570: .4byte gBankAttacker
_08025574: .4byte 0x000160ac
_08025578: .4byte 0x000160ad
_0802557C: .4byte 0x00016100
_08025580: .4byte 0x00016103
_08025584: .4byte 0x0000ffff
_08025588: .4byte gHitMarker
_0802558C: .4byte 0xfffffbff
_08025590: .4byte gCurrentMove
_08025594:
	cmp r6, 0
	beq _08025644
	cmp r5, 0
	beq _08025618
	ldr r0, _080255C4 @ =0x0000ffff
	cmp r6, r0
	beq _08025618
	cmp r5, r0
	beq _08025618
	ldr r2, _080255C8 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _080255CC @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	bl Random
	movs r1, 0x1
	ands r1, r0
	cmp r1, 0
	beq _080255D4
	ldr r0, _080255D0 @ =gCurrentMove
	strh r6, [r0]
	b _080255D8
	.align 2, 0
_080255C4: .4byte 0x0000ffff
_080255C8: .4byte gHitMarker
_080255CC: .4byte 0xfffffbff
_080255D0: .4byte gCurrentMove
_080255D4:
	ldr r0, _08025604 @ =gCurrentMove
	strh r5, [r0]
_080255D8:
	adds r5, r0, 0
	ldrh r0, [r5]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _08025608 @ =gBankTarget
	strb r0, [r1]
	ldr r4, _0802560C @ =gBattlescriptCurrInstr
	ldr r3, _08025610 @ =gUnknown_081D6BBC
	ldr r2, _08025614 @ =gBattleMoves
	ldrh r1, [r5]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	str r0, [r4]
	b _080256C0
	.align 2, 0
_08025604: .4byte gCurrentMove
_08025608: .4byte gBankTarget
_0802560C: .4byte gBattlescriptCurrInstr
_08025610: .4byte gUnknown_081D6BBC
_08025614: .4byte gBattleMoves
_08025618:
	cmp r6, 0
	beq _08025644
	ldr r0, _08025634 @ =0x0000ffff
	cmp r6, r0
	beq _08025644
	ldr r2, _08025638 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _0802563C @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r4, _08025640 @ =gCurrentMove
	strh r6, [r4]
	b _0802565C
	.align 2, 0
_08025634: .4byte 0x0000ffff
_08025638: .4byte gHitMarker
_0802563C: .4byte 0xfffffbff
_08025640: .4byte gCurrentMove
_08025644:
	cmp r5, 0
	beq _080256A4
	ldr r0, _08025684 @ =0x0000ffff
	cmp r5, r0
	beq _080256A4
	ldr r2, _08025688 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _0802568C @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r4, _08025690 @ =gCurrentMove
	strh r5, [r4]
_0802565C:
	ldrh r0, [r4]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _08025694 @ =gBankTarget
	strb r0, [r1]
	ldr r5, _08025698 @ =gBattlescriptCurrInstr
	ldr r3, _0802569C @ =gUnknown_081D6BBC
	ldr r2, _080256A0 @ =gBattleMoves
	ldrh r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	str r0, [r5]
	b _080256C0
	.align 2, 0
_08025684: .4byte 0x0000ffff
_08025688: .4byte gHitMarker
_0802568C: .4byte 0xfffffbff
_08025690: .4byte gCurrentMove
_08025694: .4byte gBankTarget
_08025698: .4byte gBattlescriptCurrInstr
_0802569C: .4byte gUnknown_081D6BBC
_080256A0: .4byte gBattleMoves
_080256A4:
	ldr r2, _080256C8 @ =gSpecialStatuses
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r1, _080256CC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_080256C0:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080256C8: .4byte gSpecialStatuses
_080256CC: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8025508

	thumb_func_start sub_80256D0
sub_80256D0: @ 80256D0
	push {lr}
	ldr r2, _080256F0 @ =gBattleWeather
	ldrh r0, [r2]
	movs r1, 0x7
	ands r1, r0
	cmp r1, 0
	beq _080256FC
	ldr r2, _080256F4 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _080256F8 @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	b _0802570C
	.align 2, 0
_080256F0: .4byte gBattleWeather
_080256F4: .4byte gBattleMoveFlags
_080256F8: .4byte gBattleCommunication
_080256FC:
	movs r0, 0x1
	strh r0, [r2]
	ldr r0, _08025718 @ =gBattleCommunication
	strb r1, [r0, 0x5]
	ldr r0, _0802571C @ =gWishFutureKnock
	adds r0, 0x28
	movs r1, 0x5
	strb r1, [r0]
_0802570C:
	ldr r1, _08025720 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08025718: .4byte gBattleCommunication
_0802571C: .4byte gWishFutureKnock
_08025720: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80256D0

	thumb_func_start atk7E_setreflect
atk7E_setreflect: @ 8025724
	push {r4-r6,lr}
	ldr r5, _08025754 @ =gBankAttacker
	ldrb r0, [r5]
	bl GetBankIdentity
	ldr r6, _08025758 @ =gSideAffecting
	movs r4, 0x1
	adds r1, r4, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r1, [r1]
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	beq _08025764
	ldr r2, _0802575C @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08025760 @ =gBattleCommunication
	movs r0, 0
	b _080257C4
	.align 2, 0
_08025754: .4byte gBankAttacker
_08025758: .4byte gSideAffecting
_0802575C: .4byte gBattleMoveFlags
_08025760: .4byte gBattleCommunication
_08025764:
	ldrb r0, [r5]
	bl GetBankIdentity
	adds r1, r4, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r0, [r1]
	movs r2, 0x1
	orrs r0, r2
	strh r0, [r1]
	ldrb r0, [r5]
	bl GetBankIdentity
	ldr r2, _080257B4 @ =gSideTimer
	adds r1, r4, 0
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0x5
	strb r1, [r0]
	ldr r0, _080257B8 @ =gBattleTypeFlags
	ldrh r1, [r0]
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	beq _080257C0
	movs r0, 0x1
	bl CountAliveMons
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0x2
	bne _080257C0
	ldr r0, _080257BC @ =gBattleCommunication
	strb r1, [r0, 0x5]
	b _080257C6
	.align 2, 0
_080257B4: .4byte gSideTimer
_080257B8: .4byte gBattleTypeFlags
_080257BC: .4byte gBattleCommunication
_080257C0:
	ldr r1, _080257D4 @ =gBattleCommunication
	movs r0, 0x1
_080257C4:
	strb r0, [r1, 0x5]
_080257C6:
	ldr r1, _080257D8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_080257D4: .4byte gBattleCommunication
_080257D8: .4byte gBattlescriptCurrInstr
	thumb_func_end atk7E_setreflect

	thumb_func_start sub_80257DC
sub_80257DC: @ 80257DC
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r7, _0802581C @ =gBattleMoveFlags
	ldrb r5, [r7]
	movs r0, 0x29
	ands r0, r5
	cmp r0, 0
	bne _0802580E
	ldr r0, _08025820 @ =gStatuses3
	mov r9, r0
	ldr r1, _08025824 @ =gBankTarget
	mov r8, r1
	ldrb r4, [r1]
	lsls r0, r4, 2
	mov r2, r9
	adds r6, r0, r2
	ldr r2, [r6]
	movs r0, 0x4
	mov r12, r0
	adds r3, r2, 0
	ands r3, r0
	cmp r3, 0
	beq _0802582C
_0802580E:
	movs r0, 0x1
	orrs r0, r5
	strb r0, [r7]
	ldr r1, _08025828 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _0802587C
	.align 2, 0
_0802581C: .4byte gBattleMoveFlags
_08025820: .4byte gStatuses3
_08025824: .4byte gBankTarget
_08025828: .4byte gBattleCommunication
_0802582C:
	ldr r1, _08025858 @ =gBattleMons
	movs r0, 0x58
	muls r0, r4
	adds r1, r0, r1
	adds r0, r1, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0xC
	beq _08025848
	adds r0, r1, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0xC
	bne _08025860
_08025848:
	movs r0, 0x1
	orrs r0, r5
	strb r0, [r7]
	ldr r1, _0802585C @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	b _0802587C
	.align 2, 0
_08025858: .4byte gBattleMons
_0802585C: .4byte gBattleCommunication
_08025860:
	ldr r0, _08025890 @ =gBankAttacker
	ldrb r0, [r0]
	orrs r2, r0
	str r2, [r6]
	mov r2, r8
	ldrb r1, [r2]
	lsls r1, 2
	add r1, r9
	ldr r0, [r1]
	mov r2, r12
	orrs r0, r2
	str r0, [r1]
	ldr r0, _08025894 @ =gBattleCommunication
	strb r3, [r0, 0x5]
_0802587C:
	ldr r1, _08025898 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08025890: .4byte gBankAttacker
_08025894: .4byte gBattleCommunication
_08025898: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80257DC

	thumb_func_start atk80_manipulatedamage
atk80_manipulatedamage: @ 802589C
	push {r4,lr}
	ldr r1, _080258B4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	ldrb r2, [r0, 0x1]
	adds r4, r1, 0
	cmp r2, 0x1
	beq _080258CC
	cmp r2, 0x1
	bgt _080258B8
	cmp r2, 0
	beq _080258BE
	b _0802590C
	.align 2, 0
_080258B4: .4byte gBattlescriptCurrInstr
_080258B8:
	cmp r2, 0x2
	beq _08025904
	b _0802590C
_080258BE:
	ldr r1, _080258C8 @ =gBattleMoveDamage
	ldr r0, [r1]
	negs r0, r0
	b _0802590A
	.align 2, 0
_080258C8: .4byte gBattleMoveDamage
_080258CC:
	ldr r3, _080258F8 @ =gBattleMoveDamage
	ldr r0, [r3]
	lsrs r1, r0, 31
	adds r0, r1
	asrs r0, 1
	str r0, [r3]
	cmp r0, 0
	bne _080258DE
	str r2, [r3]
_080258DE:
	ldr r2, _080258FC @ =gBattleMons
	ldr r0, _08025900 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x2C]
	lsrs r1, r0, 1
	ldr r0, [r3]
	cmp r1, r0
	bge _0802590C
	str r1, [r3]
	b _0802590C
	.align 2, 0
_080258F8: .4byte gBattleMoveDamage
_080258FC: .4byte gBattleMons
_08025900: .4byte gBankTarget
_08025904:
	ldr r1, _08025918 @ =gBattleMoveDamage
	ldr r0, [r1]
	lsls r0, 1
_0802590A:
	str r0, [r1]
_0802590C:
	ldr r0, [r4]
	adds r0, 0x2
	str r0, [r4]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08025918: .4byte gBattleMoveDamage
	thumb_func_end atk80_manipulatedamage

	thumb_func_start atk81_setrest
atk81_setrest: @ 802591C
	push {r4-r7,lr}
	sub sp, 0x4
	ldr r0, _08025974 @ =gBattlescriptCurrInstr
	mov r12, r0
	ldr r1, [r0]
	ldrb r6, [r1, 0x1]
	ldrb r0, [r1, 0x2]
	lsls r0, 8
	orrs r6, r0
	ldrb r0, [r1, 0x3]
	lsls r0, 16
	orrs r6, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 24
	orrs r6, r0
	ldr r5, _08025978 @ =gActiveBank
	ldr r2, _0802597C @ =gBankTarget
	ldr r0, _08025980 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r2]
	strb r0, [r5]
	ldr r4, _08025984 @ =gBattleMoveDamage
	ldr r1, _08025988 @ =gBattleMons
	ldrb r0, [r2]
	movs r3, 0x58
	muls r0, r3
	adds r0, r1
	ldrh r0, [r0, 0x2C]
	negs r0, r0
	str r0, [r4]
	ldrb r0, [r2]
	adds r4, r0, 0
	muls r4, r3
	adds r0, r4, r1
	ldrh r3, [r0, 0x28]
	adds r7, r5, 0
	adds r5, r2, 0
	adds r2, r1, 0
	ldrh r0, [r0, 0x2C]
	cmp r3, r0
	bne _0802598C
	mov r0, r12
	str r6, [r0]
	b _080259DC
	.align 2, 0
_08025974: .4byte gBattlescriptCurrInstr
_08025978: .4byte gActiveBank
_0802597C: .4byte gBankTarget
_08025980: .4byte gBankAttacker
_08025984: .4byte gBattleMoveDamage
_08025988: .4byte gBattleMons
_0802598C:
	adds r0, r2, 0
	adds r0, 0x4C
	adds r0, r4, r0
	ldr r1, [r0]
	movs r0, 0xF8
	ands r1, r0
	cmp r1, 0
	beq _080259A8
	ldr r1, _080259A4 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _080259AC
	.align 2, 0
_080259A4: .4byte gBattleCommunication
_080259A8:
	ldr r0, _080259E4 @ =gBattleCommunication
	strb r1, [r0, 0x5]
_080259AC:
	ldrb r0, [r5]
	movs r3, 0x58
	muls r0, r3
	adds r2, 0x4C
	adds r0, r2
	movs r1, 0x3
	str r1, [r0]
	ldrb r0, [r7]
	muls r0, r3
	adds r0, r2
	str r0, [sp]
	movs r0, 0
	movs r1, 0x28
	movs r2, 0
	movs r3, 0x4
	bl EmitSetAttributes
	ldrb r0, [r7]
	bl MarkBufferBankForExecution
	ldr r1, _080259E8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_080259DC:
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080259E4: .4byte gBattleCommunication
_080259E8: .4byte gBattlescriptCurrInstr
	thumb_func_end atk81_setrest

	thumb_func_start atk82_jumpifnotfirstturn
atk82_jumpifnotfirstturn: @ 80259EC
	push {r4,r5,lr}
	ldr r5, _08025A20 @ =gBattlescriptCurrInstr
	ldr r4, [r5]
	ldrb r3, [r4, 0x1]
	ldrb r0, [r4, 0x2]
	lsls r0, 8
	orrs r3, r0
	ldrb r0, [r4, 0x3]
	lsls r0, 16
	orrs r3, r0
	ldrb r0, [r4, 0x4]
	lsls r0, 24
	orrs r3, r0
	ldr r2, _08025A24 @ =gDisableStructs
	ldr r0, _08025A28 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x16]
	cmp r0, 0
	beq _08025A2C
	adds r0, r4, 0x5
	str r0, [r5]
	b _08025A2E
	.align 2, 0
_08025A20: .4byte gBattlescriptCurrInstr
_08025A24: .4byte gDisableStructs
_08025A28: .4byte gBankAttacker
_08025A2C:
	str r3, [r5]
_08025A2E:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end atk82_jumpifnotfirstturn

	thumb_func_start sub_8025A34
sub_8025A34: @ 8025A34
	ldr r1, _08025A40 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_08025A40: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8025A34

	thumb_func_start sub_8025A44
sub_8025A44: @ 8025A44
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	lsls r0, 24
	lsrs r3, r0, 24
	movs r2, 0
	ldr r0, _08025A9C @ =gNoOfAllBanks
	ldrb r1, [r0]
	mov r8, r0
	cmp r2, r1
	bge _08025AB8
	ldr r0, _08025AA0 @ =gBattleMons
	mov r12, r0
	movs r0, 0x58
	muls r0, r3
	add r0, r12
	adds r5, r0, 0
	adds r5, 0x20
	ldr r6, _08025AA4 @ =0x02016003
	movs r3, 0
	ldr r7, _08025AA8 @ =gBattleCommunication
	adds r4, r1, 0
_08025A70:
	mov r0, r12
	adds r0, 0x50
	adds r0, r3, r0
	ldr r0, [r0]
	movs r1, 0x70
	ands r0, r1
	cmp r0, 0
	beq _08025AB0
	ldrb r0, [r5]
	cmp r0, 0x2B
	beq _08025AB0
	movs r3, 0
	strb r2, [r6]
	ldr r1, _08025AAC @ =gBankTarget
	ldrb r0, [r1]
	cmp r0, 0xFF
	beq _08025AD0
	cmp r0, r2
	beq _08025AC4
	movs r0, 0x1
	strb r0, [r7, 0x5]
	b _08025AB8
	.align 2, 0
_08025A9C: .4byte gNoOfAllBanks
_08025AA0: .4byte gBattleMons
_08025AA4: .4byte 0x02016003
_08025AA8: .4byte gBattleCommunication
_08025AAC: .4byte gBankTarget
_08025AB0:
	adds r3, 0x58
	adds r2, 0x1
	cmp r2, r4
	blt _08025A70
_08025AB8:
	mov r1, r8
	ldrb r1, [r1]
	cmp r2, r1
	beq _08025AD4
	movs r0, 0x1
	b _08025AD6
_08025AC4:
	ldr r0, _08025ACC @ =gBattleCommunication
	strb r3, [r0, 0x5]
	b _08025AB8
	.align 2, 0
_08025ACC: .4byte gBattleCommunication
_08025AD0:
	strb r2, [r1]
	b _08025AB8
_08025AD4:
	movs r0, 0
_08025AD6:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end sub_8025A44

	thumb_func_start sub_8025AE0
sub_8025AE0: @ 8025AE0
	push {r4-r6,lr}
	ldr r5, _08025B0C @ =gBattlescriptCurrInstr
	ldr r1, [r5]
	ldrb r4, [r1, 0x1]
	ldrb r0, [r1, 0x2]
	lsls r0, 8
	orrs r4, r0
	ldrb r0, [r1, 0x3]
	lsls r0, 16
	orrs r4, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 24
	orrs r4, r0
	ldr r6, _08025B10 @ =gBankTarget
	ldrb r0, [r6]
	bl sub_8025A44
	lsls r0, 24
	cmp r0, 0
	beq _08025B14
	str r4, [r5]
	b _08025B56
	.align 2, 0
_08025B0C: .4byte gBattlescriptCurrInstr
_08025B10: .4byte gBankTarget
_08025B14:
	ldr r1, _08025B44 @ =gBattleMons
	ldrb r3, [r6]
	movs r0, 0x58
	muls r0, r3
	adds r0, r1
	adds r0, 0x20
	ldrb r0, [r0]
	adds r1, r0, 0
	cmp r1, 0xF
	beq _08025B2C
	cmp r1, 0x48
	bne _08025B50
_08025B2C:
	ldr r2, _08025B48 @ =gLastUsedAbility
	strb r0, [r2]
	ldr r1, _08025B4C @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	str r4, [r5]
	ldrb r1, [r2]
	adds r0, r3, 0
	bl RecordAbilityBattle
	b _08025B56
	.align 2, 0
_08025B44: .4byte gBattleMons
_08025B48: .4byte gLastUsedAbility
_08025B4C: .4byte gBattleCommunication
_08025B50:
	ldr r0, [r5]
	adds r0, 0x5
	str r0, [r5]
_08025B56:
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end sub_8025AE0

	thumb_func_start sub_8025B5C
sub_8025B5C: @ 8025B5C
	push {r4,r5,lr}
	ldr r5, _08025B84 @ =gDisableStructs
	ldr r4, _08025B88 @ =gBankAttacker
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r1, r0, r5
	ldrb r0, [r1, 0x9]
	cmp r0, 0x3
	bne _08025B94
	ldr r2, _08025B8C @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08025B90 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _08025BBE
	.align 2, 0
_08025B84: .4byte gDisableStructs
_08025B88: .4byte gBankAttacker
_08025B8C: .4byte gBattleMoveFlags
_08025B90: .4byte gBattleCommunication
_08025B94:
	adds r0, 0x1
	movs r3, 0
	strb r0, [r1, 0x9]
	ldr r2, _08025BCC @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r2]
	movs r0, 0x1
	strb r0, [r2, 0x1]
	strb r0, [r2, 0x2]
	strb r0, [r2, 0x3]
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r5
	ldrb r0, [r0, 0x9]
	strb r0, [r2, 0x4]
	movs r0, 0xFF
	strb r0, [r2, 0x5]
	ldr r0, _08025BD0 @ =gBattleCommunication
	strb r3, [r0, 0x5]
_08025BBE:
	ldr r1, _08025BD4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08025BCC: .4byte gBattleTextBuff1
_08025BD0: .4byte gBattleCommunication
_08025BD4: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8025B5C

	thumb_func_start atk86_stockpiletobasedamage
atk86_stockpiletobasedamage: @ 8025BD8
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x10
	ldr r3, _08025C10 @ =gBattlescriptCurrInstr
	ldr r1, [r3]
	ldrb r2, [r1, 0x1]
	ldrb r0, [r1, 0x2]
	lsls r0, 8
	orrs r2, r0
	ldrb r0, [r1, 0x3]
	lsls r0, 16
	orrs r2, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 24
	orrs r2, r0
	ldr r7, _08025C14 @ =gDisableStructs
	ldr r6, _08025C18 @ =gBankAttacker
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r7
	ldrb r0, [r0, 0x9]
	cmp r0, 0
	bne _08025C1C
	str r2, [r3]
	b _08025CC2
	.align 2, 0
_08025C10: .4byte gBattlescriptCurrInstr
_08025C14: .4byte gDisableStructs
_08025C18: .4byte gBankAttacker
_08025C1C:
	ldr r0, _08025CD0 @ =gBattleCommunication
	ldrb r0, [r0, 0x6]
	cmp r0, 0x1
	beq _08025CA8
	ldr r0, _08025CD4 @ =gBattleMoveDamage
	mov r8, r0
	ldr r4, _08025CD8 @ =gSideAffecting
	ldr r5, _08025CDC @ =gBankTarget
	ldrb r0, [r5]
	bl GetBankIdentity
	movs r1, 0x1
	ands r1, r0
	lsls r1, 1
	adds r1, r4
	ldrh r3, [r1]
	ldrb r0, [r6]
	movs r4, 0x58
	muls r0, r4
	ldr r2, _08025CE0 @ =gBattleMons
	adds r0, r2
	ldrb r1, [r5]
	muls r1, r4
	adds r1, r2
	ldr r2, _08025CE4 @ =gCurrentMove
	ldrh r2, [r2]
	movs r4, 0
	str r4, [sp]
	str r4, [sp, 0x4]
	ldrb r4, [r6]
	str r4, [sp, 0x8]
	ldrb r4, [r5]
	str r4, [sp, 0xC]
	bl CalculateBaseDamage
	ldrb r2, [r6]
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r7
	ldrb r1, [r1, 0x9]
	adds r3, r0, 0
	muls r3, r1
	mov r1, r8
	str r3, [r1]
	ldr r2, _08025CE8 @ =0x02000000
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r7
	ldrb r0, [r0, 0x9]
	ldr r1, _08025CEC @ =0x00016002
	adds r2, r1
	strb r0, [r2]
	ldr r1, _08025CF0 @ =gProtectStructs
	ldrb r0, [r6]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 28
	cmp r0, 0
	bge _08025CA8
	lsls r0, r3, 4
	subs r0, r3
	movs r1, 0xA
	bl __divsi3
	mov r1, r8
	str r0, [r1]
_08025CA8:
	ldr r2, _08025CF4 @ =gDisableStructs
	ldr r0, _08025CF8 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0
	strb r1, [r0, 0x9]
	ldr r1, _08025CFC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08025CC2:
	add sp, 0x10
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08025CD0: .4byte gBattleCommunication
_08025CD4: .4byte gBattleMoveDamage
_08025CD8: .4byte gSideAffecting
_08025CDC: .4byte gBankTarget
_08025CE0: .4byte gBattleMons
_08025CE4: .4byte gCurrentMove
_08025CE8: .4byte 0x02000000
_08025CEC: .4byte 0x00016002
_08025CF0: .4byte gProtectStructs
_08025CF4: .4byte gDisableStructs
_08025CF8: .4byte gBankAttacker
_08025CFC: .4byte gBattlescriptCurrInstr
	thumb_func_end atk86_stockpiletobasedamage

	thumb_func_start sub_8025D00
sub_8025D00: @ 8025D00
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r7, _08025D40 @ =gBattlescriptCurrInstr
	ldr r1, [r7]
	ldrb r2, [r1, 0x1]
	ldrb r0, [r1, 0x2]
	lsls r0, 8
	orrs r2, r0
	ldrb r0, [r1, 0x3]
	lsls r0, 16
	orrs r2, r0
	ldrb r0, [r1, 0x4]
	lsls r0, 24
	orrs r2, r0
	ldr r0, _08025D44 @ =gDisableStructs
	mov r8, r0
	ldr r6, _08025D48 @ =gBankAttacker
	ldrb r3, [r6]
	lsls r0, r3, 3
	subs r0, r3
	lsls r0, 2
	mov r1, r8
	adds r4, r0, r1
	ldrb r1, [r4, 0x9]
	cmp r1, 0
	bne _08025D50
	str r2, [r7]
	ldr r0, _08025D4C @ =gBattleCommunication
	strb r1, [r0, 0x5]
	b _08025DD0
	.align 2, 0
_08025D40: .4byte gBattlescriptCurrInstr
_08025D44: .4byte gDisableStructs
_08025D48: .4byte gBankAttacker
_08025D4C: .4byte gBattleCommunication
_08025D50:
	ldr r1, _08025D74 @ =gBattleMons
	movs r0, 0x58
	muls r0, r3
	adds r1, r0, r1
	ldrh r0, [r1, 0x2C]
	ldrh r3, [r1, 0x28]
	cmp r0, r3
	bne _08025D80
	movs r0, 0
	strb r0, [r4, 0x9]
	str r2, [r7]
	ldr r1, _08025D78 @ =gBankTarget
	ldrb r0, [r6]
	strb r0, [r1]
	ldr r1, _08025D7C @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _08025DD0
	.align 2, 0
_08025D74: .4byte gBattleMons
_08025D78: .4byte gBankTarget
_08025D7C: .4byte gBattleCommunication
_08025D80:
	ldr r5, _08025DDC @ =gBattleMoveDamage
	ldrh r0, [r1, 0x2C]
	ldrb r1, [r4, 0x9]
	movs r2, 0x3
	subs r2, r1
	movs r4, 0x1
	adds r1, r4, 0
	lsls r1, r2
	bl __divsi3
	str r0, [r5]
	cmp r0, 0
	bne _08025D9C
	str r4, [r5]
_08025D9C:
	ldr r0, [r5]
	negs r0, r0
	str r0, [r5]
	ldr r2, _08025DE0 @ =0x02000000
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r8
	ldrb r0, [r0, 0x9]
	ldr r1, _08025DE4 @ =0x00016002
	adds r2, r1
	movs r3, 0
	strb r0, [r2]
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r8
	strb r3, [r0, 0x9]
	ldr r0, [r7]
	adds r0, 0x5
	str r0, [r7]
	ldr r1, _08025DE8 @ =gBankTarget
	ldrb r0, [r6]
	strb r0, [r1]
_08025DD0:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08025DDC: .4byte gBattleMoveDamage
_08025DE0: .4byte 0x02000000
_08025DE4: .4byte 0x00016002
_08025DE8: .4byte gBankTarget
	thumb_func_end sub_8025D00

	thumb_func_start atk88_negativedamage
atk88_negativedamage: @ 8025DEC
	push {lr}
	ldr r2, _08025E14 @ =gBattleMoveDamage
	ldr r0, _08025E18 @ =gHP_dealt
	ldr r0, [r0]
	lsrs r1, r0, 31
	adds r0, r1
	asrs r0, 1
	negs r0, r0
	str r0, [r2]
	cmp r0, 0
	bne _08025E08
	movs r0, 0x1
	negs r0, r0
	str r0, [r2]
_08025E08:
	ldr r1, _08025E1C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08025E14: .4byte gBattleMoveDamage
_08025E18: .4byte gHP_dealt
_08025E1C: .4byte gBattlescriptCurrInstr
	thumb_func_end atk88_negativedamage

	thumb_func_start ChangeStatBuffs
ChangeStatBuffs: @ 8025E20
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	mov r8, r3
	lsls r0, 24
	lsrs r6, r0, 24
	lsls r1, 24
	lsrs r7, r1, 24
	lsls r2, 24
	lsrs r5, r2, 24
	movs r0, 0
	mov r9, r0
	mov r10, r0
	movs r0, 0x40
	ands r0, r5
	cmp r0, 0
	beq _08025E54
	ldr r0, _08025E4C @ =gActiveBank
	ldr r1, _08025E50 @ =gBankAttacker
	b _08025E58
	.align 2, 0
_08025E4C: .4byte gActiveBank
_08025E50: .4byte gBankAttacker
_08025E54:
	ldr r0, _08025EF8 @ =gActiveBank
	ldr r1, _08025EFC @ =gBankTarget
_08025E58:
	ldrb r1, [r1]
	strb r1, [r0]
	movs r0, 0xBF
	ands r5, r0
	movs r0, 0x80
	ands r0, r5
	cmp r0, 0
	beq _08025E72
	mov r0, r9
	adds r0, 0x1
	lsls r0, 24
	lsrs r0, 24
	mov r9, r0
_08025E72:
	movs r0, 0x7F
	ands r5, r0
	movs r0, 0x20
	ands r0, r5
	cmp r0, 0
	beq _08025E88
	mov r0, r10
	adds r0, 0x1
	lsls r0, 24
	lsrs r0, 24
	mov r10, r0
_08025E88:
	movs r0, 0xDF
	ands r5, r0
	ldr r1, _08025F00 @ =gBattleTextBuff1
	movs r4, 0
	movs r2, 0xFD
	strb r2, [r1]
	movs r0, 0x5
	strb r0, [r1, 0x1]
	strb r7, [r1, 0x2]
	movs r3, 0x1
	negs r3, r3
	mov r12, r3
	movs r0, 0xFF
	strb r0, [r1, 0x3]
	lsls r0, r6, 24
	cmp r0, 0
	blt _08025EAC
	b _080261B0
_08025EAC:
	ldr r4, _08025F04 @ =gSideTimer
	ldr r1, _08025EF8 @ =gActiveBank
	ldrb r0, [r1]
	bl GetBankIdentity
	movs r1, 0x1
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r0, [r0, 0x2]
	cmp r0, 0
	beq _08025F54
	mov r2, r9
	cmp r2, 0
	bne _08025F54
	ldr r0, _08025F08 @ =gCurrentMove
	ldrh r0, [r0]
	cmp r0, 0xAE
	beq _08025F84
	cmp r5, 0x1
	bne _08025F74
	ldr r4, _08025F0C @ =gSpecialStatuses
	ldr r3, _08025EF8 @ =gActiveBank
	ldrb r0, [r3]
	lsls r1, r0, 2
	adds r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r0, [r1]
	lsls r0, 31
	cmp r0, 0
	beq _08025F14
	ldr r0, _08025F10 @ =gBattlescriptCurrInstr
	mov r4, r8
	str r4, [r0]
	b _08025F74
	.align 2, 0
_08025EF8: .4byte gActiveBank
_08025EFC: .4byte gBankTarget
_08025F00: .4byte gBattleTextBuff1
_08025F04: .4byte gSideTimer
_08025F08: .4byte gCurrentMove
_08025F0C: .4byte gSpecialStatuses
_08025F10: .4byte gBattlescriptCurrInstr
_08025F14:
	mov r0, r8
	bl b_movescr_stack_push
	ldr r0, _08025F40 @ =0x02000000
	ldr r6, _08025F44 @ =gActiveBank
	ldrb r1, [r6]
	ldr r2, _08025F48 @ =0x00016003
	adds r0, r2
	strb r1, [r0]
	ldr r1, _08025F4C @ =gBattlescriptCurrInstr
	ldr r0, _08025F50 @ =gUnknown_081D9128
	str r0, [r1]
	ldrb r1, [r6]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r1, [r0]
	movs r2, 0x1
	orrs r1, r2
	strb r1, [r0]
	b _08025F74
	.align 2, 0
_08025F40: .4byte 0x02000000
_08025F44: .4byte gActiveBank
_08025F48: .4byte 0x00016003
_08025F4C: .4byte gBattlescriptCurrInstr
_08025F50: .4byte gUnknown_081D9128
_08025F54:
	ldr r0, _08025F78 @ =gCurrentMove
	ldrh r0, [r0]
	cmp r0, 0xAE
	beq _08025F84
	mov r3, r10
	cmp r3, 0x1
	beq _08025F84
	movs r0, 0
	bl JumpIfMoveAffectedByProtect
	lsls r0, 24
	cmp r0, 0
	beq _08025F84
	ldr r1, _08025F7C @ =gBattlescriptCurrInstr
	ldr r0, _08025F80 @ =BattleScript_1D83D6
	str r0, [r1]
_08025F74:
	movs r0, 0x1
	b _080262A4
	.align 2, 0
_08025F78: .4byte gCurrentMove
_08025F7C: .4byte gBattlescriptCurrInstr
_08025F80: .4byte BattleScript_1D83D6
_08025F84:
	ldr r2, _08025FCC @ =gBattleMons
	ldr r1, _08025FD0 @ =gActiveBank
	ldrb r3, [r1]
	movs r4, 0x58
	adds r0, r3, 0
	muls r0, r4
	adds r0, r2
	adds r0, 0x20
	ldrb r0, [r0]
	mov r10, r2
	cmp r0, 0x1D
	beq _08025FA0
	cmp r0, 0x49
	bne _08026040
_08025FA0:
	mov r0, r9
	cmp r0, 0
	bne _08026040
	ldr r0, _08025FD4 @ =gCurrentMove
	ldrh r0, [r0]
	cmp r0, 0xAE
	beq _08026040
	cmp r5, 0x1
	bne _08025F74
	ldr r4, _08025FD8 @ =gSpecialStatuses
	lsls r0, r3, 2
	adds r0, r3
	lsls r0, 2
	adds r0, r4
	ldrb r0, [r0]
	lsls r0, 31
	cmp r0, 0
	beq _08025FE0
	ldr r0, _08025FDC @ =gBattlescriptCurrInstr
	mov r1, r8
	str r1, [r0]
	b _08025F74
	.align 2, 0
_08025FCC: .4byte gBattleMons
_08025FD0: .4byte gActiveBank
_08025FD4: .4byte gCurrentMove
_08025FD8: .4byte gSpecialStatuses
_08025FDC: .4byte gBattlescriptCurrInstr
_08025FE0:
	mov r0, r8
	bl b_movescr_stack_push
	ldr r0, _08026028 @ =0x02000000
	ldr r2, _0802602C @ =gActiveBank
	ldrb r1, [r2]
	ldr r3, _08026030 @ =0x00016003
	adds r0, r3
	strb r1, [r0]
	ldr r1, _08026034 @ =gBattlescriptCurrInstr
	ldr r0, _08026038 @ =gUnknown_081D989B
	str r0, [r1]
	ldr r1, _0802603C @ =gLastUsedAbility
	ldrb r0, [r2]
	movs r6, 0x58
	muls r0, r6
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r1]
	ldrb r0, [r2]
	ldrb r1, [r1]
	bl RecordAbilityBattle
	ldr r0, _0802602C @ =gActiveBank
	ldrb r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r1, [r0]
	movs r2, 0x1
	orrs r1, r2
	strb r1, [r0]
	b _08025F74
	.align 2, 0
_08026028: .4byte 0x02000000
_0802602C: .4byte gActiveBank
_08026030: .4byte 0x00016003
_08026034: .4byte gBattlescriptCurrInstr
_08026038: .4byte gUnknown_081D989B
_0802603C: .4byte gLastUsedAbility
_08026040:
	ldr r1, _08026090 @ =gActiveBank
	ldrb r0, [r1]
	movs r4, 0x58
	muls r0, r4
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x33
	bne _080260A8
	mov r2, r9
	cmp r2, 0
	bne _080260A8
	cmp r7, 0x6
	bne _080260A8
	cmp r5, 0x1
	bne _08025F74
	mov r0, r8
	bl b_movescr_stack_push
	ldr r0, _08026094 @ =0x02000000
	ldr r3, _08026090 @ =gActiveBank
	ldrb r1, [r3]
	ldr r6, _08026098 @ =0x00016003
	adds r0, r6
	strb r1, [r0]
	ldr r1, _0802609C @ =gBattlescriptCurrInstr
	ldr r0, _080260A0 @ =gUnknown_081D9903
	str r0, [r1]
	ldr r1, _080260A4 @ =gLastUsedAbility
	ldrb r0, [r3]
	muls r0, r4
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r1]
	ldrb r0, [r3]
	ldrb r1, [r1]
	bl RecordAbilityBattle
	b _08025F74
	.align 2, 0
_08026090: .4byte gActiveBank
_08026094: .4byte 0x02000000
_08026098: .4byte 0x00016003
_0802609C: .4byte gBattlescriptCurrInstr
_080260A0: .4byte gUnknown_081D9903
_080260A4: .4byte gLastUsedAbility
_080260A8:
	ldr r1, _080260FC @ =gActiveBank
	ldrb r0, [r1]
	movs r4, 0x58
	muls r0, r4
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x34
	bne _08026114
	mov r2, r9
	cmp r2, 0
	bne _08026114
	cmp r7, 0x1
	bne _08026114
	cmp r5, 0x1
	beq _080260CA
	b _08025F74
_080260CA:
	mov r0, r8
	bl b_movescr_stack_push
	ldr r0, _08026100 @ =0x02000000
	ldr r3, _080260FC @ =gActiveBank
	ldrb r1, [r3]
	ldr r6, _08026104 @ =0x00016003
	adds r0, r6
	strb r1, [r0]
	ldr r1, _08026108 @ =gBattlescriptCurrInstr
	ldr r0, _0802610C @ =gUnknown_081D9903
	str r0, [r1]
	ldr r1, _08026110 @ =gLastUsedAbility
	ldrb r0, [r3]
	muls r0, r4
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r1]
	ldrb r0, [r3]
	ldrb r1, [r1]
	bl RecordAbilityBattle
	b _08025F74
	.align 2, 0
_080260FC: .4byte gActiveBank
_08026100: .4byte 0x02000000
_08026104: .4byte 0x00016003
_08026108: .4byte gBattlescriptCurrInstr
_0802610C: .4byte gUnknown_081D9903
_08026110: .4byte gLastUsedAbility
_08026114:
	ldr r0, _080261A0 @ =gActiveBank
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	add r0, r10
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x13
	bne _0802612C
	cmp r5, 0
	bne _0802612C
	b _08025F74
_0802612C:
	lsls r0, r6, 24
	asrs r0, 28
	movs r1, 0x7
	ands r0, r1
	negs r0, r0
	lsls r0, 24
	ldr r3, _080261A4 @ =gBattleTextBuff2
	movs r4, 0
	movs r1, 0xFD
	strb r1, [r3]
	movs r2, 0x1
	lsrs r6, r0, 24
	asrs r0, 24
	subs r1, 0xFF
	cmp r0, r1
	bne _08026156
	strb r4, [r3, 0x1]
	movs r0, 0xD3
	strb r0, [r3, 0x2]
	strb r4, [r3, 0x3]
	movs r2, 0x4
_08026156:
	adds r0, r2, r3
	strb r4, [r0]
	adds r2, 0x1
	adds r1, r2, r3
	movs r0, 0xD4
	strb r0, [r1]
	adds r2, 0x1
	adds r0, r2, r3
	strb r4, [r0]
	adds r2, 0x1
	adds r1, r2, r3
	movs r0, 0xFF
	strb r0, [r1]
	ldr r1, _080261A0 @ =gActiveBank
	ldrb r2, [r1]
	movs r0, 0x58
	muls r0, r2
	adds r0, r7, r0
	mov r1, r10
	adds r1, 0x18
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	cmp r0, 0
	beq _08026206
	movs r1, 0
	ldr r0, _080261A8 @ =gBankTarget
	ldrb r0, [r0]
	ldr r3, _080261AC @ =gBattleCommunication
	mov r8, r3
	cmp r0, r2
	bne _0802619A
	movs r1, 0x1
_0802619A:
	mov r4, r8
	strb r1, [r4, 0x5]
	b _08026234
	.align 2, 0
_080261A0: .4byte gActiveBank
_080261A4: .4byte gBattleTextBuff2
_080261A8: .4byte gBankTarget
_080261AC: .4byte gBattleCommunication
_080261B0:
	asrs r6, r0, 28
	movs r0, 0x7
	ands r6, r0
	ldr r3, _08026210 @ =gBattleTextBuff2
	strb r2, [r3]
	movs r2, 0x1
	cmp r6, 0x2
	bne _080261CA
	strb r4, [r3, 0x1]
	movs r0, 0xD1
	strb r0, [r3, 0x2]
	strb r4, [r3, 0x3]
	movs r2, 0x4
_080261CA:
	adds r0, r2, r3
	strb r4, [r0]
	adds r2, 0x1
	adds r1, r2, r3
	movs r0, 0xD2
	strb r0, [r1]
	adds r2, 0x1
	adds r0, r2, r3
	strb r4, [r0]
	adds r2, 0x1
	adds r1, r2, r3
	ldrb r0, [r1]
	mov r2, r12
	orrs r0, r2
	strb r0, [r1]
	ldr r2, _08026214 @ =gBattleMons
	ldr r4, _08026218 @ =gActiveBank
	ldrb r3, [r4]
	movs r0, 0x58
	muls r0, r3
	adds r0, r7, r0
	adds r1, r2, 0
	adds r1, 0x18
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	mov r10, r2
	cmp r0, 0xC
	bne _08026220
_08026206:
	ldr r1, _0802621C @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	mov r8, r1
	b _08026234
	.align 2, 0
_08026210: .4byte gBattleTextBuff2
_08026214: .4byte gBattleMons
_08026218: .4byte gActiveBank
_0802621C: .4byte gBattleCommunication
_08026220:
	movs r1, 0
	ldr r0, _080262B4 @ =gBankTarget
	ldrb r0, [r0]
	ldr r2, _080262B8 @ =gBattleCommunication
	mov r8, r2
	cmp r0, r3
	bne _08026230
	movs r1, 0x1
_08026230:
	mov r3, r8
	strb r1, [r3, 0x5]
_08026234:
	ldr r2, _080262BC @ =gActiveBank
	ldrb r0, [r2]
	movs r4, 0x58
	adds r1, r0, 0
	muls r1, r4
	adds r1, r7, r1
	mov r3, r10
	adds r3, 0x18
	adds r1, r3
	lsls r0, r6, 24
	asrs r0, 24
	ldrb r6, [r1]
	adds r0, r6
	strb r0, [r1]
	ldrb r0, [r2]
	muls r0, r4
	adds r0, r7, r0
	adds r1, r0, r3
	movs r0, 0
	ldrsb r0, [r1, r0]
	cmp r0, 0
	bge _08026264
	movs r0, 0
	strb r0, [r1]
_08026264:
	ldr r1, _080262BC @ =gActiveBank
	ldrb r0, [r1]
	muls r0, r4
	adds r0, r7, r0
	adds r1, r0, r3
	movs r0, 0
	ldrsb r0, [r1, r0]
	cmp r0, 0xC
	ble _0802627A
	movs r0, 0xC
	strb r0, [r1]
_0802627A:
	mov r2, r8
	ldrb r0, [r2, 0x5]
	cmp r0, 0x2
	bne _080262A2
	movs r3, 0x1
	ands r3, r5
	cmp r3, 0
	beq _08026294
	ldr r0, _080262C0 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r2, 0x1
	orrs r1, r2
	strb r1, [r0]
_08026294:
	mov r4, r8
	ldrb r0, [r4, 0x5]
	cmp r0, 0x2
	bne _080262A2
	cmp r3, 0
	bne _080262A2
	b _08025F74
_080262A2:
	movs r0, 0
_080262A4:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
_080262B4: .4byte gBankTarget
_080262B8: .4byte gBattleCommunication
_080262BC: .4byte gActiveBank
_080262C0: .4byte gBattleMoveFlags
	thumb_func_end ChangeStatBuffs

	thumb_func_start atk89_statbuffchange
atk89_statbuffchange: @ 80262C4
	push {r4,r5,lr}
	ldr r5, _0802630C @ =gBattlescriptCurrInstr
	ldr r2, [r5]
	ldrb r3, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r3, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r3, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r3, r0
	ldr r0, _08026310 @ =0x02000000
	ldr r1, _08026314 @ =0x0001601e
	adds r0, r1
	ldrb r4, [r0]
	movs r0, 0xF0
	ands r0, r4
	lsls r0, 24
	asrs r0, 24
	movs r1, 0xF
	ands r1, r4
	ldrb r2, [r2, 0x1]
	bl ChangeStatBuffs
	lsls r0, 24
	cmp r0, 0
	bne _08026304
	ldr r0, [r5]
	adds r0, 0x6
	str r0, [r5]
_08026304:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802630C: .4byte gBattlescriptCurrInstr
_08026310: .4byte 0x02000000
_08026314: .4byte 0x0001601e
	thumb_func_end atk89_statbuffchange

	thumb_func_start atk8A_normalisebuffs
atk8A_normalisebuffs: @ 8026318
	push {r4-r7,lr}
	movs r2, 0
	ldr r0, _08026360 @ =gNoOfAllBanks
	ldrb r1, [r0]
	ldr r0, _08026364 @ =gBattlescriptCurrInstr
	mov r12, r0
	cmp r2, r1
	bge _08026350
	ldr r0, _08026368 @ =gBattleMons
	movs r4, 0x6
	adds r5, r1, 0
	movs r7, 0x58
	adds r6, r0, 0
	adds r6, 0x18
_08026334:
	adds r3, r2, 0x1
	movs r1, 0x7
	adds r0, r2, 0
	muls r0, r7
	adds r0, r6
	adds r0, 0x7
_08026340:
	strb r4, [r0]
	subs r0, 0x1
	subs r1, 0x1
	cmp r1, 0
	bge _08026340
	adds r2, r3, 0
	cmp r2, r5
	blt _08026334
_08026350:
	mov r1, r12
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08026360: .4byte gNoOfAllBanks
_08026364: .4byte gBattlescriptCurrInstr
_08026368: .4byte gBattleMons
	thumb_func_end atk8A_normalisebuffs

	thumb_func_start atk8B_setbide
atk8B_setbide: @ 802636C
	push {r4,r5,lr}
	ldr r4, _080263C4 @ =gBattleMons
	ldr r3, _080263C8 @ =gBankAttacker
	ldrb r0, [r3]
	movs r5, 0x58
	adds r2, r0, 0
	muls r2, r5
	adds r4, 0x50
	adds r2, r4
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 5
	orrs r0, r1
	str r0, [r2]
	ldr r1, _080263CC @ =gLockedMove
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r1
	ldr r1, _080263D0 @ =gCurrentMove
	ldrh r1, [r1]
	movs r2, 0
	strh r1, [r0]
	ldr r1, _080263D4 @ =gTakenDmg
	ldrb r0, [r3]
	lsls r0, 2
	adds r0, r1
	str r2, [r0]
	ldrb r0, [r3]
	adds r1, r0, 0
	muls r1, r5
	adds r1, r4
	ldr r0, [r1]
	movs r2, 0x80
	lsls r2, 2
	orrs r0, r2
	str r0, [r1]
	ldr r1, _080263D8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080263C4: .4byte gBattleMons
_080263C8: .4byte gBankAttacker
_080263CC: .4byte gLockedMove
_080263D0: .4byte gCurrentMove
_080263D4: .4byte gTakenDmg
_080263D8: .4byte gBattlescriptCurrInstr
	thumb_func_end atk8B_setbide

	thumb_func_start atk8C_confuseifrepeatingattackends
atk8C_confuseifrepeatingattackends: @ 80263DC
	push {lr}
	ldr r1, _0802640C @ =gBattleMons
	ldr r0, _08026410 @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0xC0
	lsls r1, 4
	ands r0, r1
	cmp r0, 0
	bne _080263FE
	ldr r1, _08026414 @ =gBattleCommunication
	movs r0, 0x75
	strb r0, [r1, 0x3]
_080263FE:
	ldr r1, _08026418 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_0802640C: .4byte gBattleMons
_08026410: .4byte gBankAttacker
_08026414: .4byte gBattleCommunication
_08026418: .4byte gBattlescriptCurrInstr
	thumb_func_end atk8C_confuseifrepeatingattackends

	thumb_func_start atk8D_setloopcounter
atk8D_setloopcounter: @ 802641C
	push {r4,r5,lr}
	ldr r0, _08026430 @ =gBattlescriptCurrInstr
	ldr r0, [r0]
	ldrb r1, [r0, 0x1]
	cmp r1, 0
	beq _08026438
	ldr r0, _08026434 @ =gMultiHitCounter
	strb r1, [r0]
	b _08026452
	.align 2, 0
_08026430: .4byte gBattlescriptCurrInstr
_08026434: .4byte gMultiHitCounter
_08026438:
	ldr r4, _08026460 @ =gMultiHitCounter
	bl Random
	movs r5, 0x3
	ands r0, r5
	strb r0, [r4]
	cmp r0, 0x1
	bls _0802644E
	bl Random
	ands r0, r5
_0802644E:
	adds r0, 0x2
	strb r0, [r4]
_08026452:
	ldr r1, _08026464 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08026460: .4byte gMultiHitCounter
_08026464: .4byte gBattlescriptCurrInstr
	thumb_func_end atk8D_setloopcounter

	thumb_func_start sub_8026468
sub_8026468: @ 8026468
	push {r4,lr}
	ldr r1, _080264A8 @ =0x02000000
	ldr r0, _080264AC @ =0x000160e0
	adds r2, r1, r0
	movs r3, 0
	movs r0, 0xFD
	strb r0, [r2]
	ldr r2, _080264B0 @ =0x000160e1
	adds r0, r1, r2
	movs r2, 0x1
	strb r2, [r0]
	ldr r4, _080264B4 @ =0x000160e2
	adds r0, r1, r4
	strb r2, [r0]
	adds r4, 0x1
	adds r0, r1, r4
	strb r2, [r0]
	ldr r2, _080264B8 @ =0x000160e4
	adds r0, r1, r2
	strb r3, [r0]
	adds r4, 0x2
	adds r1, r4
	movs r0, 0xFF
	strb r0, [r1]
	ldr r1, _080264BC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080264A8: .4byte 0x02000000
_080264AC: .4byte 0x000160e0
_080264B0: .4byte 0x000160e1
_080264B4: .4byte 0x000160e2
_080264B8: .4byte 0x000160e4
_080264BC: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8026468

	thumb_func_start sub_80264C0
sub_80264C0: @ 80264C0
	push {r4-r7,lr}
	ldr r6, _080264F4 @ =gBattleMons
	ldr r7, _080264F8 @ =gBankAttacker
	ldrb r0, [r7]
	movs r5, 0x58
	adds r1, r0, 0
	muls r1, r5
	adds r1, r6
	adds r1, 0x2A
	ldr r4, _080264FC @ =gBankTarget
	ldrb r3, [r4]
	adds r0, r3, 0
	muls r0, r5
	adds r0, r6
	adds r0, 0x2A
	ldrb r1, [r1]
	ldrb r0, [r0]
	cmp r1, r0
	bcc _0802650C
	ldr r0, _08026500 @ =0x02000000
	ldr r2, _08026504 @ =0x00016064
	adds r1, r3, r2
	adds r1, r0
	ldr r2, _08026508 @ =gBattlePartyID
	lsls r0, r3, 1
	b _08026568
	.align 2, 0
_080264F4: .4byte gBattleMons
_080264F8: .4byte gBankAttacker
_080264FC: .4byte gBankTarget
_08026500: .4byte 0x02000000
_08026504: .4byte 0x00016064
_08026508: .4byte gBattlePartyID
_0802650C:
	bl Random
	movs r3, 0xFF
	ands r3, r0
	ldrb r0, [r7]
	muls r0, r5
	adds r0, r6
	adds r0, 0x2A
	ldrb r2, [r0]
	ldrb r4, [r4]
	adds r0, r4, 0
	muls r0, r5
	adds r0, r6
	adds r0, 0x2A
	ldrb r1, [r0]
	adds r2, r1
	adds r0, r3, 0
	muls r0, r2
	asrs r0, 8
	adds r0, 0x1
	lsrs r1, 2
	cmp r0, r1
	bhi _0802655C
	ldr r3, _08026558 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	movs r0, 0
	b _08026576
	.align 2, 0
_08026558: .4byte gBattlescriptCurrInstr
_0802655C:
	ldr r0, _0802657C @ =0x02000000
	ldr r2, _08026580 @ =0x00016064
	adds r1, r4, r2
	adds r1, r0
	ldr r2, _08026584 @ =gBattlePartyID
	lsls r0, r4, 1
_08026568:
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1]
	ldr r1, _08026588 @ =gBattlescriptCurrInstr
	ldr r0, _0802658C @ =gUnknown_081D90FC
	str r0, [r1]
	movs r0, 0x1
_08026576:
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
_0802657C: .4byte 0x02000000
_08026580: .4byte 0x00016064
_08026584: .4byte gBattlePartyID
_08026588: .4byte gBattlescriptCurrInstr
_0802658C: .4byte gUnknown_081D90FC
	thumb_func_end sub_80264C0

	thumb_func_start sub_8026590
sub_8026590: @ 8026590
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r4, _08026628 @ =gBattleTypeFlags
	ldrh r1, [r4]
	movs r0, 0x8
	ands r0, r1
	cmp r0, 0
	bne _080265A4
	b _0802687C
_080265A4:
	ldr r5, _0802662C @ =gBankTarget
	ldrb r0, [r5]
	bl GetBankSide
	lsls r0, 24
	ldr r1, _08026630 @ =gEnemyParty
	mov r8, r1
	cmp r0, 0
	bne _080265BA
	ldr r2, _08026634 @ =gPlayerParty
	mov r8, r2
_080265BA:
	ldrh r1, [r4]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08026638
	movs r7, 0
	movs r6, 0
	ldrb r0, [r5]
	bl sub_803FC34
	lsls r0, 24
	lsrs r0, 24
	bl sub_803FBFC
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0x1
	bne _080265E0
	movs r6, 0x3
_080265E0:
	adds r5, r6, 0
	adds r0, r5, 0x3
	cmp r5, r0
	bge _08026678
_080265E8:
	movs r0, 0x64
	muls r0, r5
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _0802661A
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _0802661A
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _0802661A
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
_0802661A:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	adds r0, r6, 0x3
	cmp r5, r0
	blt _080265E8
	b _08026678
	.align 2, 0
_08026628: .4byte gBattleTypeFlags
_0802662C: .4byte gBankTarget
_08026630: .4byte gEnemyParty
_08026634: .4byte gPlayerParty
_08026638:
	movs r7, 0
	movs r5, 0
_0802663C:
	movs r0, 0x64
	muls r0, r5
	mov r2, r8
	adds r4, r2, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _0802666E
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0
	bne _0802666E
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _0802666E
	adds r0, r7, 0x1
	lsls r0, 24
	lsrs r7, r0, 24
_0802666E:
	adds r0, r5, 0x1
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x5
	bls _0802663C
_08026678:
	cmp r7, 0x1
	bhi _08026688
	ldr r0, _080266BC @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x41
	ands r0, r1
	cmp r0, 0x1
	bne _080266A0
_08026688:
	cmp r7, 0x2
	bhi _080266C4
	ldr r0, _080266BC @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080266C4
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	bne _080266C4
_080266A0:
	ldr r3, _080266C0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08026880
	.align 2, 0
_080266BC: .4byte gBattleTypeFlags
_080266C0: .4byte gBattlescriptCurrInstr
_080266C4:
	bl sub_80264C0
	lsls r0, 24
	cmp r0, 0
	bne _080266D0
	b _08026880
_080266D0:
	ldr r0, _08026710 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08026774
_080266DC:
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x3
	bl __umodsi3
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r0, _08026714 @ =gBankTarget
	ldrb r0, [r0]
	bl sub_803FC34
	lsls r0, 24
	lsrs r0, 24
	bl sub_803FBFC
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0x1
	bne _08026718
	adds r0, r6, 0x3
	lsls r0, 24
	lsrs r5, r0, 24
	b _0802671A
	.align 2, 0
_08026710: .4byte gBattleTypeFlags
_08026714: .4byte gBankTarget
_08026718:
	adds r5, r6, 0
_0802671A:
	ldr r4, _0802676C @ =gBattlePartyID
	ldr r0, _08026770 @ =gBankTarget
	ldrb r2, [r0]
	lsls r1, r2, 1
	adds r1, r4
	lsls r0, r5, 16
	lsrs r3, r0, 16
	ldrh r1, [r1]
	cmp r3, r1
	beq _080266DC
	movs r0, 0x2
	eors r2, r0
	lsls r0, r2, 1
	adds r0, r4
	ldrh r0, [r0]
	cmp r3, r0
	beq _080266DC
	movs r0, 0x64
	muls r0, r5
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _080266DC
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0x1
	beq _080266DC
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _080266DC
	b _08026832
	.align 2, 0
_0802676C: .4byte gBattlePartyID
_08026770: .4byte gBankTarget
_08026774:
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _080267E4
	ldr r6, _080267DC @ =gBattlePartyID
_0802677E:
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x6
	bl __umodsi3
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r0, _080267E0 @ =gBankTarget
	ldrb r1, [r0]
	lsls r0, r1, 1
	adds r0, r6
	adds r2, r5, 0
	ldrh r0, [r0]
	cmp r2, r0
	beq _0802677E
	movs r0, 0x2
	eors r1, r0
	lsls r0, r1, 1
	adds r0, r6
	ldrh r0, [r0]
	cmp r2, r0
	beq _0802677E
	movs r0, 0x64
	muls r0, r5
	mov r2, r8
	adds r4, r2, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _0802677E
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0x1
	beq _0802677E
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _0802677E
	b _08026832
	.align 2, 0
_080267DC: .4byte gBattlePartyID
_080267E0: .4byte gBankTarget
_080267E4:
	ldr r6, _0802686C @ =gBattlePartyID
_080267E6:
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x6
	bl __umodsi3
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r0, _08026870 @ =gBankTarget
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r6
	ldrh r0, [r0]
	cmp r5, r0
	beq _080267E6
	movs r0, 0x64
	muls r0, r5
	mov r1, r8
	adds r4, r1, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	cmp r0, 0
	beq _080267E6
	adds r0, r4, 0
	movs r1, 0x2D
	bl GetMonData
	cmp r0, 0x1
	beq _080267E6
	adds r0, r4, 0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _080267E6
_08026832:
	ldr r0, _08026874 @ =0x02000000
	ldr r4, _08026870 @ =gBankTarget
	ldrb r1, [r4]
	ldr r2, _08026878 @ =0x00016068
	adds r1, r2
	adds r1, r0
	strb r5, [r1]
	bl IsLinkDoubleBattle
	lsls r0, 24
	cmp r0, 0
	bne _08026850
	ldrb r0, [r4]
	bl sub_8012258
_08026850:
	ldrb r0, [r4]
	adds r1, r5, 0
	movs r2, 0
	bl sub_8094B6C
	ldrb r1, [r4]
	movs r0, 0x2
	eors r0, r1
	adds r1, r5, 0
	movs r2, 0x1
	bl sub_8094B6C
	b _08026880
	.align 2, 0
_0802686C: .4byte gBattlePartyID
_08026870: .4byte gBankTarget
_08026874: .4byte 0x02000000
_08026878: .4byte 0x00016068
_0802687C:
	bl sub_80264C0
_08026880:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end sub_8026590

	thumb_func_start sub_802688C
sub_802688C: @ 802688C
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	movs r6, 0
	ldr r2, _08026920 @ =gBattleMons
	ldr r3, _08026924 @ =gBankAttacker
	ldrb r1, [r3]
	movs r0, 0x58
	muls r0, r1
	adds r1, r2, 0
	adds r1, 0xC
	adds r0, r1
	ldrh r0, [r0]
	mov r8, r2
	cmp r0, 0
	beq _080268CE
	movs r5, 0x58
	adds r2, r1, 0
_080268B4:
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
	cmp r6, 0x3
	bhi _080268CE
	lsls r1, r6, 1
	ldrb r0, [r3]
	muls r0, r5
	adds r1, r0
	adds r1, r2
	ldrh r0, [r1]
	cmp r0, 0
	bne _080268B4
_080268CE:
	movs r3, 0
	cmp r3, r6
	bcs _08026950
	ldr r0, _08026928 @ =gBattleMoves
	mov r10, r0
	ldr r5, _08026920 @ =gBattleMons
	mov r12, r5
	ldr r7, _08026924 @ =gBankAttacker
	ldrb r0, [r7]
	movs r4, 0x58
	adds r5, r0, 0
	muls r5, r4
	movs r0, 0xC
	add r0, r12
	mov r9, r0
_080268EC:
	lsls r0, r3, 1
	adds r0, r5
	add r0, r9
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	add r0, r10
	ldrb r2, [r0, 0x2]
	cmp r2, 0x9
	bne _0802692E
	mov r0, r8
	adds r1, r5, r0
	adds r0, r1, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0x7
	beq _0802691A
	adds r0, r1, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0x7
	bne _0802692C
_0802691A:
	movs r2, 0x7
	b _0802692E
	.align 2, 0
_08026920: .4byte gBattleMons
_08026924: .4byte gBankAttacker
_08026928: .4byte gBattleMoves
_0802692C:
	movs r2, 0
_0802692E:
	ldrb r0, [r7]
	muls r0, r4
	add r0, r12
	adds r1, r0, 0
	adds r1, 0x21
	ldrb r1, [r1]
	cmp r2, r1
	beq _08026946
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r2, r0
	bne _08026950
_08026946:
	adds r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
	cmp r3, r6
	bcc _080268EC
_08026950:
	cmp r3, r6
	bne _08026974
	ldr r3, _08026970 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08026A18
	.align 2, 0
_08026970: .4byte gBattlescriptCurrInstr
_08026974:
	movs r7, 0x3
	ldr r5, _080269CC @ =gBattleMoves
	mov r9, r5
_0802697A:
	bl Random
	adds r3, r0, 0
	ands r3, r7
	cmp r3, r6
	bcs _0802697A
	ldr r4, _080269D0 @ =gBattleMons
	lsls r1, r3, 1
	ldr r3, _080269D4 @ =gBankAttacker
	ldrb r2, [r3]
	movs r0, 0x58
	adds r5, r2, 0
	muls r5, r0
	adds r1, r5
	adds r0, r4, 0
	adds r0, 0xC
	adds r1, r0
	ldrh r1, [r1]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	add r0, r9
	ldrb r2, [r0, 0x2]
	mov r8, r4
	adds r4, r3, 0
	cmp r2, 0x9
	bne _080269DA
	mov r0, r8
	adds r2, r5, r0
	adds r0, r2, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0x7
	beq _080269C8
	adds r0, r2, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0x7
	bne _080269D8
_080269C8:
	movs r2, 0x7
	b _080269DA
	.align 2, 0
_080269CC: .4byte gBattleMoves
_080269D0: .4byte gBattleMons
_080269D4: .4byte gBankAttacker
_080269D8:
	movs r2, 0
_080269DA:
	ldrb r0, [r4]
	movs r3, 0x58
	muls r0, r3
	add r0, r8
	adds r1, r0, 0
	adds r1, 0x21
	ldrb r5, [r1]
	cmp r2, r5
	beq _0802697A
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r2, r0
	beq _0802697A
	strb r2, [r1]
	ldrb r0, [r4]
	muls r0, r3
	add r0, r8
	adds r0, 0x22
	strb r2, [r0]
	ldr r1, _08026A28 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x3
	strb r0, [r1, 0x1]
	strb r2, [r1, 0x2]
	movs r0, 0xFF
	strb r0, [r1, 0x3]
	ldr r1, _08026A2C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08026A18:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08026A28: .4byte gBattleTextBuff1
_08026A2C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802688C

	thumb_func_start atk91_givemoney
atk91_givemoney: @ 8026A30
	push {r4,lr}
	ldr r0, _08026A8C @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	bne _08026AAC
	ldr r4, _08026A90 @ =gPaydayMoney
	ldrh r0, [r4]
	cmp r0, 0
	beq _08026AAC
	ldr r0, _08026A94 @ =gSaveBlock1 + 0x490
	ldrh r2, [r4]
	ldr r1, _08026A98 @ =0x02000000
	ldr r3, _08026A9C @ =0x00016056
	adds r1, r3
	ldrb r1, [r1]
	muls r1, r2
	bl sub_80B79B8
	ldr r1, _08026AA0 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x1
	strb r0, [r1, 0x1]
	movs r0, 0x2
	strb r0, [r1, 0x2]
	movs r0, 0x5
	strb r0, [r1, 0x3]
	ldrh r2, [r4]
	strb r2, [r1, 0x4]
	movs r0, 0xFF
	lsls r0, 8
	ands r0, r2
	lsrs r0, 8
	strb r0, [r1, 0x5]
	movs r0, 0xFF
	strb r0, [r1, 0x6]
	ldr r4, _08026AA4 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	adds r0, 0x1
	bl b_movescr_stack_push
	ldr r0, _08026AA8 @ =gUnknown_081D95DB
	str r0, [r4]
	b _08026AB4
	.align 2, 0
_08026A8C: .4byte gBattleTypeFlags
_08026A90: .4byte gPaydayMoney
_08026A94: .4byte gSaveBlock1 + 0x490
_08026A98: .4byte 0x02000000
_08026A9C: .4byte 0x00016056
_08026AA0: .4byte gBattleTextBuff1
_08026AA4: .4byte gBattlescriptCurrInstr
_08026AA8: .4byte gUnknown_081D95DB
_08026AAC:
	ldr r1, _08026ABC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_08026AB4:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08026ABC: .4byte gBattlescriptCurrInstr
	thumb_func_end atk91_givemoney

	thumb_func_start atk92_setlightscreen
atk92_setlightscreen: @ 8026AC0
	push {r4-r6,lr}
	ldr r4, _08026AF0 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankIdentity
	ldr r6, _08026AF4 @ =gSideAffecting
	movs r5, 0x1
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r1, [r1]
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _08026B00
	ldr r2, _08026AF8 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08026AFC @ =gBattleCommunication
	movs r0, 0
	b _08026B60
	.align 2, 0
_08026AF0: .4byte gBankAttacker
_08026AF4: .4byte gSideAffecting
_08026AF8: .4byte gBattleMoveFlags
_08026AFC: .4byte gBattleCommunication
_08026B00:
	ldrb r0, [r4]
	bl GetBankIdentity
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r0, [r1]
	movs r2, 0x2
	orrs r0, r2
	strh r0, [r1]
	ldrb r0, [r4]
	bl GetBankIdentity
	ldr r2, _08026B50 @ =gSideTimer
	adds r1, r5, 0
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0x5
	strb r1, [r0, 0x1]
	ldr r0, _08026B54 @ =gBattleTypeFlags
	ldrh r1, [r0]
	adds r0, r5, 0
	ands r0, r1
	cmp r0, 0
	beq _08026B5C
	movs r0, 0x1
	bl CountAliveMons
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x2
	bne _08026B5C
	ldr r1, _08026B58 @ =gBattleCommunication
	movs r0, 0x4
	b _08026B60
	.align 2, 0
_08026B50: .4byte gSideTimer
_08026B54: .4byte gBattleTypeFlags
_08026B58: .4byte gBattleCommunication
_08026B5C:
	ldr r1, _08026B70 @ =gBattleCommunication
	movs r0, 0x3
_08026B60:
	strb r0, [r1, 0x5]
	ldr r1, _08026B74 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08026B70: .4byte gBattleCommunication
_08026B74: .4byte gBattlescriptCurrInstr
	thumb_func_end atk92_setlightscreen

	thumb_func_start sub_8026B78
sub_8026B78: @ 8026B78
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r7, _08026BA8 @ =gBattleMons
	ldr r6, _08026BAC @ =gBankTarget
	ldrb r2, [r6]
	movs r5, 0x58
	adds r0, r2, 0
	muls r0, r5
	adds r1, r0, r7
	ldrh r0, [r1, 0x2E]
	cmp r0, 0xAF
	bne _08026BB4
	ldr r1, _08026BB0 @ =gEnigmaBerries
	lsls r0, r2, 3
	subs r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r4, [r0, 0x7]
	ldrb r6, [r0, 0x1A]
	b _08026BCE
	.align 2, 0
_08026BA8: .4byte gBattleMons
_08026BAC: .4byte gBankTarget
_08026BB0: .4byte gEnigmaBerries
_08026BB4:
	ldrh r0, [r1, 0x2E]
	bl ItemId_GetHoldEffect
	lsls r0, 24
	lsrs r4, r0, 24
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r7
	ldrh r0, [r0, 0x2E]
	bl ItemId_GetHoldEffectParam
	lsls r0, 24
	lsrs r6, r0, 24
_08026BCE:
	ldr r1, _08026C4C @ =gStringBank
	ldr r5, _08026C50 @ =gBankTarget
	ldrb r0, [r5]
	strb r0, [r1]
	cmp r4, 0x27
	bne _08026C0C
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x64
	bl __umodsi3
	lsls r0, 16
	lsrs r0, 16
	cmp r0, r6
	bcs _08026C0C
	ldrb r0, [r5]
	movs r1, 0x27
	bl RecordItemBattle
	ldr r2, _08026C54 @ =gSpecialStatuses
	ldrb r1, [r5]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x80
	orrs r1, r2
	strb r1, [r0]
_08026C0C:
	ldr r0, _08026C58 @ =gBattleMons
	mov r8, r0
	ldr r1, _08026C50 @ =gBankTarget
	ldrb r2, [r1]
	movs r6, 0x58
	adds r0, r2, 0
	muls r0, r6
	mov r3, r8
	adds r5, r0, r3
	adds r0, r5, 0
	adds r0, 0x20
	ldrb r3, [r0]
	mov r10, r8
	cmp r3, 0x5
	bne _08026C6C
	ldr r2, _08026C5C @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r0, _08026C60 @ =gLastUsedAbility
	strb r3, [r0]
	ldr r1, _08026C64 @ =gBattlescriptCurrInstr
	ldr r0, _08026C68 @ =gUnknown_081D9826
	str r0, [r1]
	ldr r1, _08026C50 @ =gBankTarget
	ldrb r0, [r1]
	movs r1, 0x5
	bl RecordAbilityBattle
	b _08026E40
	.align 2, 0
_08026C4C: .4byte gStringBank
_08026C50: .4byte gBankTarget
_08026C54: .4byte gSpecialStatuses
_08026C58: .4byte gBattleMons
_08026C5C: .4byte gBattleMoveFlags
_08026C60: .4byte gLastUsedAbility
_08026C64: .4byte gBattlescriptCurrInstr
_08026C68: .4byte gUnknown_081D9826
_08026C6C:
	ldr r1, _08026CE0 @ =gStatuses3
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x18
	ands r0, r1
	cmp r0, 0
	bne _08026CF4
	ldr r1, _08026CE4 @ =gBattleMoves
	ldr r0, _08026CE8 @ =gCurrentMove
	ldrh r0, [r0]
	lsls r2, r0, 1
	adds r2, r0
	lsls r2, 2
	adds r2, r1
	ldr r7, _08026CEC @ =gBankAttacker
	ldrb r0, [r7]
	muls r0, r6
	add r0, r10
	adds r0, 0x2A
	ldrb r0, [r0]
	adds r1, r5, 0
	adds r1, 0x2A
	ldrb r1, [r1]
	subs r0, r1
	ldrb r2, [r2, 0x3]
	adds r0, r2
	lsls r0, 16
	lsrs r4, r0, 16
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x64
	bl __umodsi3
	lsls r0, 16
	lsrs r0, 16
	adds r0, 0x1
	cmp r0, r4
	bge _08026CDC
	ldrb r0, [r7]
	adds r1, r0, 0
	muls r1, r6
	add r1, r10
	adds r1, 0x2A
	ldr r2, _08026CF0 @ =gBankTarget
	ldrb r0, [r2]
	muls r0, r6
	add r0, r10
	adds r0, 0x2A
	ldrb r1, [r1]
	movs r4, 0x1
	ldrb r0, [r0]
	cmp r1, r0
	bcs _08026D20
_08026CDC:
	mov r10, r8
	b _08026DE0
	.align 2, 0
_08026CE0: .4byte gStatuses3
_08026CE4: .4byte gBattleMoves
_08026CE8: .4byte gCurrentMove
_08026CEC: .4byte gBankAttacker
_08026CF0: .4byte gBankTarget
_08026CF4:
	ldr r0, _08026D4C @ =gDisableStructs
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r0
	ldr r2, _08026D50 @ =gBankAttacker
	ldrb r0, [r1, 0x15]
	movs r4, 0
	ldrb r3, [r2]
	cmp r0, r3
	bne _08026D20
	ldrb r0, [r2]
	muls r0, r6
	add r0, r10
	adds r0, 0x2A
	adds r1, r5, 0
	adds r1, 0x2A
	ldrb r0, [r0]
	ldrb r1, [r1]
	cmp r0, r1
	bcc _08026D20
	movs r4, 0x1
_08026D20:
	cmp r4, 0
	beq _08026DE0
	ldr r0, _08026D54 @ =gProtectStructs
	ldr r1, _08026D58 @ =gBankTarget
	ldrb r2, [r1]
	lsls r1, r2, 4
	adds r1, r0
	ldrb r0, [r1]
	lsls r0, 30
	cmp r0, 0
	bge _08026D64
	ldr r1, _08026D5C @ =gBattleMoveDamage
	movs r0, 0x58
	muls r0, r2
	add r0, r10
	ldrh r0, [r0, 0x28]
	subs r0, 0x1
	str r0, [r1]
	ldr r2, _08026D60 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x40
	b _08026DC6
	.align 2, 0
_08026D4C: .4byte gDisableStructs
_08026D50: .4byte gBankAttacker
_08026D54: .4byte gProtectStructs
_08026D58: .4byte gBankTarget
_08026D5C: .4byte gBattleMoveDamage
_08026D60: .4byte gBattleMoveFlags
_08026D64:
	ldr r0, _08026DA0 @ =gSpecialStatuses
	lsls r1, r2, 2
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1]
	lsrs r0, 7
	cmp r0, 0
	beq _08026DB4
	ldr r1, _08026DA4 @ =gBattleMoveDamage
	movs r3, 0x58
	adds r0, r2, 0
	muls r0, r3
	add r0, r10
	ldrh r0, [r0, 0x28]
	subs r0, 0x1
	str r0, [r1]
	ldr r2, _08026DA8 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x80
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08026DAC @ =gLastUsedItem
	ldr r2, _08026DB0 @ =gBankTarget
	ldrb r0, [r2]
	muls r0, r3
	add r0, r10
	ldrh r0, [r0, 0x2E]
	strh r0, [r1]
	b _08026DCA
	.align 2, 0
_08026DA0: .4byte gSpecialStatuses
_08026DA4: .4byte gBattleMoveDamage
_08026DA8: .4byte gBattleMoveFlags
_08026DAC: .4byte gLastUsedItem
_08026DB0: .4byte gBankTarget
_08026DB4:
	ldr r1, _08026DD4 @ =gBattleMoveDamage
	movs r0, 0x58
	muls r0, r2
	add r0, r10
	ldrh r0, [r0, 0x28]
	str r0, [r1]
	ldr r2, _08026DD8 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x10
_08026DC6:
	orrs r0, r1
	strb r0, [r2]
_08026DCA:
	ldr r1, _08026DDC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08026E40
	.align 2, 0
_08026DD4: .4byte gBattleMoveDamage
_08026DD8: .4byte gBattleMoveFlags
_08026DDC: .4byte gBattlescriptCurrInstr
_08026DE0:
	ldr r2, _08026E10 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r0, _08026E14 @ =gBankAttacker
	ldrb r0, [r0]
	movs r2, 0x58
	adds r1, r0, 0
	muls r1, r2
	add r1, r10
	adds r1, 0x2A
	ldr r3, _08026E18 @ =gBankTarget
	ldrb r0, [r3]
	muls r0, r2
	add r0, r10
	adds r0, 0x2A
	ldrb r1, [r1]
	ldrb r0, [r0]
	cmp r1, r0
	bcc _08026E20
	ldr r1, _08026E1C @ =gBattleCommunication
	movs r0, 0
	b _08026E24
	.align 2, 0
_08026E10: .4byte gBattleMoveFlags
_08026E14: .4byte gBankAttacker
_08026E18: .4byte gBankTarget
_08026E1C: .4byte gBattleCommunication
_08026E20:
	ldr r1, _08026E50 @ =gBattleCommunication
	movs r0, 0x1
_08026E24:
	strb r0, [r1, 0x5]
	ldr r3, _08026E54 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08026E40:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08026E50: .4byte gBattleCommunication
_08026E54: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8026B78

	thumb_func_start atk94_gethalfcurrentenemyhp
atk94_gethalfcurrentenemyhp: @ 8026E58
	push {lr}
	ldr r3, _08026E84 @ =gBattleMoveDamage
	ldr r2, _08026E88 @ =gBattleMons
	ldr r0, _08026E8C @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x28]
	lsrs r0, 1
	str r0, [r3]
	cmp r0, 0
	bne _08026E76
	movs r0, 0x1
	str r0, [r3]
_08026E76:
	ldr r1, _08026E90 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08026E84: .4byte gBattleMoveDamage
_08026E88: .4byte gBattleMons
_08026E8C: .4byte gBankTarget
_08026E90: .4byte gBattlescriptCurrInstr
	thumb_func_end atk94_gethalfcurrentenemyhp

	thumb_func_start sub_8026E94
sub_8026E94: @ 8026E94
	push {lr}
	ldr r2, _08026EB4 @ =gBattleWeather
	ldrh r1, [r2]
	movs r0, 0x18
	ands r0, r1
	cmp r0, 0
	beq _08026EC0
	ldr r2, _08026EB8 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08026EBC @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	b _08026ED2
	.align 2, 0
_08026EB4: .4byte gBattleWeather
_08026EB8: .4byte gBattleMoveFlags
_08026EBC: .4byte gBattleCommunication
_08026EC0:
	movs r0, 0x8
	strh r0, [r2]
	ldr r1, _08026EE0 @ =gBattleCommunication
	movs r0, 0x3
	strb r0, [r1, 0x5]
	ldr r0, _08026EE4 @ =gWishFutureKnock
	adds r0, 0x28
	movs r1, 0x5
	strb r1, [r0]
_08026ED2:
	ldr r1, _08026EE8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08026EE0: .4byte gBattleCommunication
_08026EE4: .4byte gWishFutureKnock
_08026EE8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8026E94

	thumb_func_start sub_8026EEC
sub_8026EEC: @ 8026EEC
	push {r4,r5,lr}
	sub sp, 0x4
	movs r0, 0
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0xD
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0
	beq _08026F0A
	b _0802701C
_08026F0A:
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0x4D
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	beq _08026F20
	b _0802701C
_08026F20:
	ldr r2, _08026F94 @ =gBattleWeather
	ldrh r1, [r2]
	movs r0, 0x18
	ands r0, r1
	adds r4, r2, 0
	ldr r5, _08026F98 @ =gBankAttacker
	cmp r0, 0
	beq _08026FAE
	ldr r0, _08026F9C @ =gBattleMons
	ldrb r2, [r5]
	movs r1, 0x58
	muls r1, r2
	adds r3, r1, r0
	adds r0, r3, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0x5
	beq _08026FA8
	cmp r0, 0x8
	beq _08026FA8
	cmp r0, 0x4
	beq _08026FA8
	adds r0, r3, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0x5
	beq _08026FA8
	cmp r0, 0x8
	beq _08026FA8
	cmp r0, 0x4
	beq _08026FA8
	adds r0, r3, 0
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x8
	beq _08026FA8
	ldr r0, _08026FA0 @ =gStatuses3
	lsls r1, r2, 2
	adds r1, r0
	ldr r1, [r1]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08026FA8
	movs r0, 0x80
	lsls r0, 11
	ands r1, r0
	cmp r1, 0
	bne _08026FA8
	ldr r1, _08026FA4 @ =gBattleMoveDamage
	ldrh r0, [r3, 0x2C]
	lsrs r0, 4
	str r0, [r1]
	cmp r0, 0
	bne _08026FAE
	movs r0, 0x1
	b _08026FAC
	.align 2, 0
_08026F94: .4byte gBattleWeather
_08026F98: .4byte gBankAttacker
_08026F9C: .4byte gBattleMons
_08026FA0: .4byte gStatuses3
_08026FA4: .4byte gBattleMoveDamage
_08026FA8:
	ldr r1, _08027004 @ =gBattleMoveDamage
	movs r0, 0
_08026FAC:
	str r0, [r1]
_08026FAE:
	ldrh r1, [r4]
	movs r4, 0x80
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	beq _08027024
	ldr r1, _08027008 @ =gBattleMons
	ldrb r3, [r5]
	movs r0, 0x58
	muls r0, r3
	adds r2, r0, r1
	adds r0, r2, 0
	adds r0, 0x21
	ldrb r0, [r0]
	cmp r0, 0xF
	beq _08027010
	adds r0, r2, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0xF
	beq _08027010
	ldr r0, _0802700C @ =gStatuses3
	lsls r1, r3, 2
	adds r1, r0
	ldr r1, [r1]
	adds r0, r1, 0
	ands r0, r4
	cmp r0, 0
	bne _08027010
	movs r0, 0x80
	lsls r0, 11
	ands r1, r0
	cmp r1, 0
	bne _08027010
	ldr r1, _08027004 @ =gBattleMoveDamage
	ldrh r0, [r2, 0x2C]
	lsrs r0, 4
	str r0, [r1]
	cmp r0, 0
	bne _08027024
	movs r0, 0x1
	str r0, [r1]
	b _08027024
	.align 2, 0
_08027004: .4byte gBattleMoveDamage
_08027008: .4byte gBattleMons
_0802700C: .4byte gStatuses3
_08027010:
	ldr r1, _08027018 @ =gBattleMoveDamage
	movs r0, 0
	str r0, [r1]
	b _08027024
	.align 2, 0
_08027018: .4byte gBattleMoveDamage
_0802701C:
	ldr r1, _08027050 @ =gBattleMoveDamage
	movs r0, 0
	str r0, [r1]
	ldr r5, _08027054 @ =gBankAttacker
_08027024:
	ldr r0, _08027058 @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _0802705C @ =gBitTable
	ldrb r0, [r5]
	lsls r0, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	beq _0802703E
	ldr r1, _08027050 @ =gBattleMoveDamage
	movs r0, 0
	str r0, [r1]
_0802703E:
	ldr r1, _08027060 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	add sp, 0x4
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08027050: .4byte gBattleMoveDamage
_08027054: .4byte gBankAttacker
_08027058: .4byte gAbsentBankFlags
_0802705C: .4byte gBitTable
_08027060: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8026EEC

	thumb_func_start sub_8027064
sub_8027064: @ 8027064
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r4, _08027090 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	cmp r0, 0
	bne _0802709C
	ldr r1, _08027094 @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r1, r0
	ldr r0, _08027098 @ =gPlayerParty
	b _080270AC
	.align 2, 0
_08027090: .4byte gBankAttacker
_08027094: .4byte gBattlePartyID
_08027098: .4byte gPlayerParty
_0802709C:
	ldr r1, _080270D0 @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r1, r0
	ldr r0, _080270D4 @ =gEnemyParty
_080270AC:
	adds r5, r1, r0
	ldr r4, _080270D8 @ =gBankTarget
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	cmp r0, 0
	bne _080270E0
	ldr r1, _080270D0 @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r1, r0
	ldr r0, _080270DC @ =gPlayerParty
	b _080270F0
	.align 2, 0
_080270D0: .4byte gBattlePartyID
_080270D4: .4byte gEnemyParty
_080270D8: .4byte gBankTarget
_080270DC: .4byte gPlayerParty
_080270E0:
	ldr r1, _0802714C @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r1, r0
	ldr r0, _08027150 @ =gEnemyParty
_080270F0:
	adds r4, r1, r0
	adds r0, r5, 0
	movs r1, 0xB
	bl GetMonData
	lsls r0, 16
	lsrs r0, 16
	mov r10, r0
	adds r0, r5, 0
	movs r1, 0
	bl GetMonData
	mov r9, r0
	adds r0, r4, 0
	movs r1, 0xB
	bl GetMonData
	lsls r0, 16
	lsrs r0, 16
	mov r8, r0
	adds r0, r4, 0
	movs r1, 0
	bl GetMonData
	adds r7, r0, 0
	ldr r5, _08027154 @ =gBankTarget
	ldrb r0, [r5]
	movs r6, 0x58
	muls r0, r6
	ldr r1, _08027158 @ =gBattleMons
	adds r0, r1
	adds r0, 0x20
	ldrb r2, [r0]
	cmp r2, 0xC
	bne _08027168
	ldr r1, _0802715C @ =gBattlescriptCurrInstr
	ldr r0, _08027160 @ =gUnknown_081D98C9
	str r0, [r1]
	ldr r0, _08027164 @ =gLastUsedAbility
	strb r2, [r0]
	ldrb r0, [r5]
	movs r1, 0xC
	bl RecordAbilityBattle
	b _0802721C
	.align 2, 0
_0802714C: .4byte gBattlePartyID
_08027150: .4byte gEnemyParty
_08027154: .4byte gBankTarget
_08027158: .4byte gBattleMons
_0802715C: .4byte gBattlescriptCurrInstr
_08027160: .4byte gUnknown_081D98C9
_08027164: .4byte gLastUsedAbility
_08027168:
	mov r0, r10
	mov r1, r9
	bl GetGenderFromSpeciesAndPersonality
	adds r4, r0, 0
	mov r0, r8
	adds r1, r7, 0
	bl GetGenderFromSpeciesAndPersonality
	lsls r4, 24
	lsls r0, 24
	cmp r4, r0
	beq _080271CA
	ldr r1, _080271E8 @ =gStatuses3
	ldrb r2, [r5]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _080271EC @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	bne _080271CA
	adds r0, r2, 0
	muls r0, r6
	ldr r4, _080271F0 @ =gBattleMons
	adds r4, 0x50
	adds r0, r4
	ldr r0, [r0]
	movs r1, 0xF0
	lsls r1, 12
	ands r0, r1
	cmp r0, 0
	bne _080271CA
	mov r0, r10
	mov r1, r9
	bl GetGenderFromSpeciesAndPersonality
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0xFF
	beq _080271CA
	mov r0, r8
	adds r1, r7, 0
	bl GetGenderFromSpeciesAndPersonality
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0xFF
	bne _080271F8
_080271CA:
	ldr r3, _080271F4 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802721C
	.align 2, 0
_080271E8: .4byte gStatuses3
_080271EC: .4byte 0x000400c0
_080271F0: .4byte gBattleMons
_080271F4: .4byte gBattlescriptCurrInstr
_080271F8:
	ldrb r0, [r5]
	adds r2, r0, 0
	muls r2, r6
	adds r2, r4
	ldr r1, _0802722C @ =gBitTable
	ldr r0, _08027230 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r1
	ldr r1, [r0]
	lsls r1, 16
	ldr r0, [r2]
	orrs r0, r1
	str r0, [r2]
	ldr r1, _08027234 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802721C:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802722C: .4byte gBitTable
_08027230: .4byte gBankAttacker
_08027234: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8027064

	thumb_func_start sub_8027238
sub_8027238: @ 8027238
	push {r4-r7,lr}
	ldr r0, _08027280 @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	bne _08027324
	ldr r5, _08027284 @ =gBattlescriptCurrInstr
	ldr r1, [r5]
	ldrb r0, [r1, 0x1]
	cmp r0, 0x4
	beq _08027290
	bl GetBattleBank
	ldr r4, _08027288 @ =gActiveBank
	strb r0, [r4]
	ldr r3, _0802728C @ =gBattleMons
	ldrb r1, [r4]
	movs r0, 0x58
	adds r2, r1, 0
	muls r2, r0
	adds r0, r3, 0
	adds r0, 0x4C
	adds r0, r2, r0
	ldr r1, [r0]
	adds r3, 0x50
	adds r2, r3
	ldr r2, [r2]
	movs r0, 0
	bl EmitStatusIconUpdate
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r0, [r5]
	adds r0, 0x2
	str r0, [r5]
	b _08027324
	.align 2, 0
_08027280: .4byte gBattleExecBuffer
_08027284: .4byte gBattlescriptCurrInstr
_08027288: .4byte gActiveBank
_0802728C: .4byte gBattleMons
_08027290:
	ldr r4, _0802732C @ =gActiveBank
	ldr r5, _08027330 @ =gBankAttacker
	ldrb r0, [r5]
	strb r0, [r4]
	ldr r6, _08027334 @ =gAbsentBankFlags
	ldrb r1, [r6]
	ldr r7, _08027338 @ =gBitTable
	ldrb r2, [r4]
	lsls r0, r2, 2
	adds r0, r7
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _080272CC
	ldr r3, _0802733C @ =gBattleMons
	movs r0, 0x58
	muls r2, r0
	adds r0, r3, 0
	adds r0, 0x4C
	adds r0, r2, r0
	ldr r1, [r0]
	adds r3, 0x50
	adds r2, r3
	ldr r2, [r2]
	movs r0, 0
	bl EmitStatusIconUpdate
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_080272CC:
	ldr r0, _08027340 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0802731C
	ldrb r0, [r5]
	bl GetBankIdentity
	movs r1, 0x2
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	strb r0, [r4]
	ldrb r1, [r6]
	ldrb r2, [r4]
	lsls r0, r2, 2
	adds r0, r7
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _0802731C
	ldr r3, _0802733C @ =gBattleMons
	movs r0, 0x58
	muls r2, r0
	adds r0, r3, 0
	adds r0, 0x4C
	adds r0, r2, r0
	ldr r1, [r0]
	adds r3, 0x50
	adds r2, r3
	ldr r2, [r2]
	movs r0, 0
	bl EmitStatusIconUpdate
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_0802731C:
	ldr r1, _08027344 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x2
	str r0, [r1]
_08027324:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802732C: .4byte gActiveBank
_08027330: .4byte gBankAttacker
_08027334: .4byte gAbsentBankFlags
_08027338: .4byte gBitTable
_0802733C: .4byte gBattleMons
_08027340: .4byte gBattleTypeFlags
_08027344: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8027238

	thumb_func_start sub_8027348
sub_8027348: @ 8027348
	push {r4-r6,lr}
	ldr r6, _08027378 @ =gSideTimer
	ldr r4, _0802737C @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankIdentity
	movs r5, 0x1
	adds r1, r5, 0
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	ldrb r0, [r0, 0x2]
	cmp r0, 0
	beq _08027388
	ldr r2, _08027380 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x20
	orrs r0, r1
	strb r0, [r2]
	ldr r0, _08027384 @ =gBattleCommunication
	strb r5, [r0, 0x5]
	b _080273C0
	.align 2, 0
_08027378: .4byte gSideTimer
_0802737C: .4byte gBankAttacker
_08027380: .4byte gBattleMoveFlags
_08027384: .4byte gBattleCommunication
_08027388:
	ldrb r0, [r4]
	bl GetBankIdentity
	adds r1, r5, 0
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r6
	movs r1, 0x5
	strb r1, [r0, 0x2]
	ldrb r0, [r4]
	bl GetBankIdentity
	ldr r2, _080273D0 @ =gSideAffecting
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r2
	ldrh r2, [r1]
	movs r3, 0x80
	lsls r3, 1
	adds r0, r3, 0
	movs r3, 0
	orrs r0, r2
	strh r0, [r1]
	ldr r0, _080273D4 @ =gBattleCommunication
	strb r3, [r0, 0x5]
_080273C0:
	ldr r1, _080273D8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_080273D0: .4byte gSideAffecting
_080273D4: .4byte gBattleCommunication
_080273D8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8027348

	thumb_func_start atk9A_setincreasedcriticalchance
atk9A_setincreasedcriticalchance: @ 80273DC
	push {lr}
	ldr r1, _0802740C @ =gBattleMons
	ldr r0, _08027410 @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r1, [r0]
	movs r3, 0x80
	lsls r3, 13
	adds r2, r1, 0
	ands r2, r3
	cmp r2, 0
	beq _0802741C
	ldr r2, _08027414 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x20
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08027418 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _08027424
	.align 2, 0
_0802740C: .4byte gBattleMons
_08027410: .4byte gBankAttacker
_08027414: .4byte gBattleMoveFlags
_08027418: .4byte gBattleCommunication
_0802741C:
	orrs r1, r3
	str r1, [r0]
	ldr r0, _08027430 @ =gBattleCommunication
	strb r2, [r0, 0x5]
_08027424:
	ldr r1, _08027434 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08027430: .4byte gBattleCommunication
_08027434: .4byte gBattlescriptCurrInstr
	thumb_func_end atk9A_setincreasedcriticalchance

	thumb_func_start atk9B_transformdataexecution
atk9B_transformdataexecution: @ 8027438
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r1, _08027490 @ =gUnknown_02024BE8
	ldr r2, _08027494 @ =0x0000ffff
	adds r0, r2, 0
	strh r0, [r1]
	ldr r1, _08027498 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	ldr r7, _0802749C @ =gBattleMons
	ldr r0, _080274A0 @ =gBankTarget
	mov r12, r0
	ldrb r1, [r0]
	movs r6, 0x58
	adds r0, r1, 0
	muls r0, r6
	adds r5, r7, 0
	adds r5, 0x50
	adds r0, r5
	ldr r0, [r0]
	movs r4, 0x80
	lsls r4, 14
	ands r0, r4
	cmp r0, 0
	bne _0802747E
	ldr r0, _080274A4 @ =gStatuses3
	lsls r1, 2
	adds r1, r0
	ldr r2, [r1]
	ldr r0, _080274A8 @ =0x000400c0
	ands r2, r0
	cmp r2, 0
	beq _080274B4
_0802747E:
	ldr r2, _080274AC @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x20
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _080274B0 @ =gBattleCommunication
	movs r0, 0x1
	b _080275C8
	.align 2, 0
_08027490: .4byte gUnknown_02024BE8
_08027494: .4byte 0x0000ffff
_08027498: .4byte gBattlescriptCurrInstr
_0802749C: .4byte gBattleMons
_080274A0: .4byte gBankTarget
_080274A4: .4byte gStatuses3
_080274A8: .4byte 0x000400c0
_080274AC: .4byte gBattleMoveFlags
_080274B0: .4byte gBattleCommunication
_080274B4:
	ldr r3, _08027588 @ =gBankAttacker
	ldrb r0, [r3]
	adds r1, r0, 0
	muls r1, r6
	adds r1, r5
	ldr r0, [r1]
	orrs r0, r4
	str r0, [r1]
	ldr r4, _0802758C @ =gDisableStructs
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r4
	strh r2, [r0, 0x4]
	ldrb r0, [r3]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r2, [r1, 0xB]
	movs r0, 0x10
	negs r0, r0
	ands r0, r2
	strb r0, [r1, 0xB]
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r4
	mov r2, r12
	ldrb r1, [r2]
	muls r1, r6
	adds r2, r7, 0
	adds r2, 0x48
	adds r1, r2
	ldr r1, [r1]
	str r1, [r0]
	ldrb r0, [r3]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	adds r1, r4
	ldrb r2, [r1, 0x18]
	movs r0, 0xF
	ands r0, r2
	strb r0, [r1, 0x18]
	ldr r1, _08027590 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x6
	strb r0, [r1, 0x1]
	mov r2, r12
	ldrb r0, [r2]
	muls r0, r6
	adds r0, r7
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r2]
	muls r0, r6
	adds r0, r7
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldrb r0, [r3]
	muls r0, r6
	adds r5, r0, r7
	ldrb r0, [r2]
	muls r0, r6
	adds r2, r0, r7
	movs r4, 0
	adds r6, r3, 0
	ldr r0, _08027594 @ =gActiveBank
	mov r8, r0
_0802754C:
	adds r0, r5, r4
	adds r1, r2, r4
	ldrb r1, [r1]
	strb r1, [r0]
	adds r4, 0x1
	cmp r4, 0x23
	bls _0802754C
	movs r4, 0
	ldr r7, _08027598 @ =gBattleMoves
	ldr r3, _0802759C @ =gUnknown_02024A8C
	adds r5, r3, 0
	adds r5, 0x18
_08027564:
	lsls r1, r4, 1
	ldrb r2, [r6]
	movs r0, 0x58
	muls r2, r0
	adds r1, r2
	adds r1, r3
	ldrh r1, [r1]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r7
	ldrb r1, [r0, 0x4]
	cmp r1, 0x4
	bhi _080275A0
	adds r0, r4, r2
	adds r0, r5
	b _080275A6
	.align 2, 0
_08027588: .4byte gBankAttacker
_0802758C: .4byte gDisableStructs
_08027590: .4byte gBattleTextBuff1
_08027594: .4byte gActiveBank
_08027598: .4byte gBattleMoves
_0802759C: .4byte gUnknown_02024A8C
_080275A0:
	adds r0, r4, r2
	adds r0, r5
	movs r1, 0x5
_080275A6:
	strb r1, [r0]
	adds r4, 0x1
	cmp r4, 0x3
	ble _08027564
	ldrb r0, [r6]
	mov r1, r8
	strb r0, [r1]
	movs r0, 0
	movs r1, 0x2
	bl EmitResetActionMoveSelection
	mov r2, r8
	ldrb r0, [r2]
	bl MarkBufferBankForExecution
	ldr r1, _080275D4 @ =gBattleCommunication
	movs r0, 0
_080275C8:
	strb r0, [r1, 0x5]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080275D4: .4byte gBattleCommunication
	thumb_func_end atk9B_transformdataexecution

	thumb_func_start sub_80275D8
sub_80275D8: @ 80275D8
	push {r4-r7,lr}
	ldr r7, _08027608 @ =gBattleMons
	ldr r6, _0802760C @ =gBankAttacker
	ldrb r0, [r6]
	movs r5, 0x58
	muls r0, r5
	adds r3, r0, r7
	ldrh r0, [r3, 0x2C]
	lsrs r1, r0, 2
	adds r2, r1, 0
	cmp r1, 0
	bne _080275F2
	movs r2, 0x1
_080275F2:
	ldrh r0, [r3, 0x28]
	cmp r0, r2
	bhi _08027618
	ldr r1, _08027610 @ =gBattleMoveDamage
	movs r0, 0
	str r0, [r1]
	ldr r1, _08027614 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _0802766C
	.align 2, 0
_08027608: .4byte gBattleMons
_0802760C: .4byte gBankAttacker
_08027610: .4byte gBattleMoveDamage
_08027614: .4byte gBattleCommunication
_08027618:
	ldr r4, _0802767C @ =gBattleMoveDamage
	str r1, [r4]
	cmp r1, 0
	bne _08027624
	movs r0, 0x1
	str r0, [r4]
_08027624:
	ldrb r0, [r6]
	adds r2, r0, 0
	muls r2, r5
	adds r3, r7, 0
	adds r3, 0x50
	adds r2, r3
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 17
	orrs r0, r1
	str r0, [r2]
	ldrb r0, [r6]
	adds r1, r0, 0
	muls r1, r5
	adds r1, r3
	ldr r0, [r1]
	ldr r2, _08027680 @ =0xffff1fff
	ands r0, r2
	str r0, [r1]
	ldr r2, _08027684 @ =gDisableStructs
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	ldr r1, [r4]
	movs r2, 0
	strb r1, [r0, 0xA]
	ldr r0, _08027688 @ =gBattleCommunication
	strb r2, [r0, 0x5]
	ldr r2, _0802768C @ =gHitMarker
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 1
	orrs r0, r1
	str r0, [r2]
_0802766C:
	ldr r1, _08027690 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802767C: .4byte gBattleMoveDamage
_08027680: .4byte 0xffff1fff
_08027684: .4byte gDisableStructs
_08027688: .4byte gBattleCommunication
_0802768C: .4byte gHitMarker
_08027690: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80275D8

	thumb_func_start sub_8027694
sub_8027694: @ 8027694
	push {r4,r5,lr}
	lsls r0, 16
	lsrs r2, r0, 16
	movs r3, 0
	ldr r0, _080276D4 @ =gUnknown_081FACFE
	ldrh r1, [r0]
	ldr r4, _080276D8 @ =0x0000fffe
	adds r5, r0, 0
	cmp r1, r4
	beq _080276BC
	cmp r1, r2
	beq _080276BC
	adds r1, r5, 0
_080276AE:
	adds r1, 0x2
	adds r3, 0x1
	ldrh r0, [r1]
	cmp r0, r4
	beq _080276BC
	cmp r0, r2
	bne _080276AE
_080276BC:
	lsls r0, r3, 1
	adds r0, r5
	ldrh r1, [r0]
	ldr r0, _080276D8 @ =0x0000fffe
	eors r1, r0
	negs r0, r1
	orrs r0, r1
	lsrs r0, 31
	pop {r4,r5}
	pop {r1}
	bx r1
	.align 2, 0
_080276D4: .4byte gUnknown_081FACFE
_080276D8: .4byte 0x0000fffe
	thumb_func_end sub_8027694

	thumb_func_start atk9D_copyattack
atk9D_copyattack: @ 80276DC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r0, _08027754 @ =gUnknown_02024BE8
	ldr r1, _08027758 @ =0x0000ffff
	adds r7, r1, 0
	strh r7, [r0]
	ldr r5, _0802775C @ =gLastUsedMove
	ldr r6, _08027760 @ =gBankTarget
	ldrb r0, [r6]
	lsls r0, 1
	adds r0, r5
	ldrh r0, [r0]
	bl sub_8027694
	lsls r0, 24
	cmp r0, 0
	bne _08027736
	ldr r3, _08027764 @ =gBattleMons
	ldr r2, _08027768 @ =gBankAttacker
	ldrb r1, [r2]
	movs r0, 0x58
	adds r4, r1, 0
	muls r4, r0
	adds r0, r3, 0
	adds r0, 0x50
	adds r0, r4, r0
	ldr r1, [r0]
	movs r0, 0x80
	lsls r0, 14
	ands r1, r0
	mov r12, r3
	mov r9, r2
	cmp r1, 0
	bne _08027736
	ldrb r0, [r6]
	lsls r0, 1
	adds r0, r5
	ldrh r1, [r0]
	cmp r1, 0
	beq _08027736
	cmp r1, r7
	bne _08027770
_08027736:
	ldr r3, _0802776C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _080278A8
	.align 2, 0
_08027754: .4byte gUnknown_02024BE8
_08027758: .4byte 0x0000ffff
_0802775C: .4byte gLastUsedMove
_08027760: .4byte gBankTarget
_08027764: .4byte gBattleMons
_08027768: .4byte gBankAttacker
_0802776C: .4byte gBattlescriptCurrInstr
_08027770:
	movs r2, 0
	mov r3, r12
	adds r3, 0xC
	adds r0, r4, r3
	ldrh r0, [r0]
	ldr r4, _08027800 @ =gBattlescriptCurrInstr
	mov r10, r4
	cmp r0, r1
	beq _080277AA
	mov r8, r3
	adds r7, r5, 0
	adds r5, r6, 0
	mov r4, r9
	movs r3, 0x58
_0802778C:
	adds r2, 0x1
	cmp r2, 0x3
	bgt _080277AA
	lsls r1, r2, 1
	ldrb r0, [r4]
	muls r0, r3
	adds r1, r0
	add r1, r8
	ldrb r0, [r5]
	lsls r0, 1
	adds r0, r7
	ldrh r1, [r1]
	ldrh r0, [r0]
	cmp r1, r0
	bne _0802778C
_080277AA:
	cmp r2, 0x4
	bne _0802788C
	ldr r5, _08027804 @ =gCurrMovePos
	ldrb r1, [r5]
	lsls r1, 1
	mov r2, r9
	ldrb r0, [r2]
	movs r6, 0x58
	muls r0, r6
	adds r1, r0
	mov r0, r12
	adds r0, 0xC
	adds r1, r0
	ldr r2, _08027808 @ =gLastUsedMove
	ldr r3, _0802780C @ =gBankTarget
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strh r0, [r1]
	ldr r4, _08027810 @ =gBattleMoves
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r4, [r0, 0x4]
	cmp r4, 0x4
	bhi _08027814
	mov r1, r9
	ldrb r0, [r1]
	muls r0, r6
	ldrb r1, [r5]
	adds r0, r1
	mov r1, r12
	adds r1, 0x24
	adds r0, r1
	strb r4, [r0]
	b _08027828
	.align 2, 0
_08027800: .4byte gBattlescriptCurrInstr
_08027804: .4byte gCurrMovePos
_08027808: .4byte gLastUsedMove
_0802780C: .4byte gBankTarget
_08027810: .4byte gBattleMoves
_08027814:
	mov r4, r9
	ldrb r0, [r4]
	muls r0, r6
	ldrb r1, [r5]
	adds r0, r1
	mov r1, r12
	adds r1, 0x24
	adds r0, r1
	movs r1, 0x5
	strb r1, [r0]
_08027828:
	ldr r1, _08027880 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _08027884 @ =gDisableStructs
	mov r2, r9
	ldrb r0, [r2]
	lsls r2, r0, 3
	subs r2, r0
	lsls r2, 2
	adds r2, r1
	ldrb r4, [r2, 0x18]
	lsrs r3, r4, 4
	ldr r1, _08027888 @ =gBitTable
	ldrb r0, [r5]
	lsls r0, 2
	adds r0, r1
	ldr r1, [r0]
	orrs r1, r3
	lsls r1, 4
	movs r0, 0xF
	ands r0, r4
	orrs r0, r1
	strb r0, [r2, 0x18]
	mov r4, r10
	ldr r0, [r4]
	adds r0, 0x5
	str r0, [r4]
	b _080278A8
	.align 2, 0
_08027880: .4byte gBattleTextBuff1
_08027884: .4byte gDisableStructs
_08027888: .4byte gBitTable
_0802788C:
	mov r0, r10
	ldr r2, [r0]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	mov r2, r10
	str r1, [r2]
_080278A8:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end atk9D_copyattack

	thumb_func_start sub_80278B8
sub_80278B8: @ 80278B8
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r7, _08027938 @ =gCurrentMove
	movs r6, 0xB1
	lsls r6, 1
	ldr r5, _0802793C @ =gUnknown_081FACFE
	ldr r0, _08027940 @ =gBattlescriptCurrInstr
	mov r8, r0
_080278CA:
	bl Random
	ldr r2, _08027944 @ =0x000001ff
	adds r1, r2, 0
	ands r0, r1
	adds r0, 0x1
	strh r0, [r7]
	cmp r0, r6
	bhi _080278CA
	movs r0, 0x3
_080278DE:
	subs r0, 0x1
	cmp r0, 0
	bge _080278DE
	ldr r4, _08027938 @ =gCurrentMove
	ldrh r2, [r4]
	ldr r3, _08027948 @ =0x0000ffff
	subs r0, r5, 0x2
_080278EC:
	adds r0, 0x2
	ldrh r1, [r0]
	cmp r1, r2
	beq _080278F8
	cmp r1, r3
	bne _080278EC
_080278F8:
	ldr r0, _08027948 @ =0x0000ffff
	cmp r1, r0
	bne _080278CA
	ldr r2, _0802794C @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _08027950 @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r3, _08027954 @ =gUnknown_081D6BBC
	ldr r2, _08027958 @ =gBattleMoves
	ldrh r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	mov r1, r8
	str r0, [r1]
	ldrh r0, [r4]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _0802795C @ =gBankTarget
	strb r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08027938: .4byte gCurrentMove
_0802793C: .4byte gUnknown_081FACFE
_08027940: .4byte gBattlescriptCurrInstr
_08027944: .4byte 0x000001ff
_08027948: .4byte 0x0000ffff
_0802794C: .4byte gHitMarker
_08027950: .4byte 0xfffffbff
_08027954: .4byte gUnknown_081D6BBC
_08027958: .4byte gBattleMoves
_0802795C: .4byte gBankTarget
	thumb_func_end sub_80278B8

	thumb_func_start sub_8027960
sub_8027960: @ 8027960
	ldr r3, _08027980 @ =gBattleMoveDamage
	ldr r2, _08027984 @ =gBattleMons
	ldr r0, _08027988 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x2A
	ldrb r0, [r0]
	str r0, [r3]
	ldr r1, _0802798C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_08027980: .4byte gBattleMoveDamage
_08027984: .4byte gBattleMons
_08027988: .4byte gBankAttacker
_0802798C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8027960

	thumb_func_start atkA0_psywavedamageeffect
atkA0_psywavedamageeffect: @ 8027990
	push {r4,lr}
	movs r4, 0xF
_08027994:
	bl Random
	adds r3, r4, 0
	ands r3, r0
	cmp r3, 0xA
	bgt _08027994
	lsls r0, r3, 2
	adds r0, r3
	lsls r3, r0, 1
	ldr r4, _080279D4 @ =gBattleMoveDamage
	ldr r2, _080279D8 @ =gBattleMons
	ldr r0, _080279DC @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x2A
	ldrb r1, [r0]
	adds r0, r3, 0
	adds r0, 0x32
	muls r0, r1
	movs r1, 0x64
	bl __divsi3
	str r0, [r4]
	ldr r1, _080279E0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080279D4: .4byte gBattleMoveDamage
_080279D8: .4byte gBattleMons
_080279DC: .4byte gBankAttacker
_080279E0: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA0_psywavedamageeffect

	thumb_func_start atkA1_counterdamagecalculator
atkA1_counterdamagecalculator: @ 80279E4
	push {r4-r6,lr}
	ldr r4, _08027A54 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r5, _08027A58 @ =gProtectStructs
	ldrb r0, [r4]
	lsls r0, 4
	adds r0, r5
	ldrb r0, [r0, 0xC]
	bl GetBankSide
	lsls r0, 24
	lsrs r2, r0, 24
	ldrb r0, [r4]
	lsls r1, r0, 4
	adds r0, r5, 0x4
	adds r0, r1, r0
	ldr r3, [r0]
	cmp r3, 0
	beq _08027A98
	cmp r6, r2
	beq _08027A98
	ldr r6, _08027A5C @ =gBattleMons
	adds r0, r1, r5
	ldrb r0, [r0, 0xC]
	movs r4, 0x58
	muls r0, r4
	adds r0, r6
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _08027A98
	ldr r1, _08027A60 @ =gBattleMoveDamage
	lsls r0, r3, 1
	str r0, [r1]
	ldr r1, _08027A64 @ =gSideTimer
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r1, r0, r1
	ldrb r0, [r1, 0x8]
	cmp r0, 0
	beq _08027A6C
	ldrb r1, [r1, 0x9]
	adds r0, r1, 0
	muls r0, r4
	adds r0, r6
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _08027A6C
	ldr r0, _08027A68 @ =gBankTarget
	strb r1, [r0]
	b _08027A7C
	.align 2, 0
_08027A54: .4byte gBankAttacker
_08027A58: .4byte gProtectStructs
_08027A5C: .4byte gBattleMons
_08027A60: .4byte gBattleMoveDamage
_08027A64: .4byte gSideTimer
_08027A68: .4byte gBankTarget
_08027A6C:
	ldr r2, _08027A88 @ =gBankTarget
	ldr r1, _08027A8C @ =gProtectStructs
	ldr r0, _08027A90 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0, 0xC]
	strb r0, [r2]
_08027A7C:
	ldr r1, _08027A94 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08027AC8
	.align 2, 0
_08027A88: .4byte gBankTarget
_08027A8C: .4byte gProtectStructs
_08027A90: .4byte gBankAttacker
_08027A94: .4byte gBattlescriptCurrInstr
_08027A98:
	ldr r2, _08027AD0 @ =gSpecialStatuses
	ldr r0, _08027AD4 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r3, _08027AD8 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08027AC8:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08027AD0: .4byte gSpecialStatuses
_08027AD4: .4byte gBankAttacker
_08027AD8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA1_counterdamagecalculator

	thumb_func_start atkA2_mirrorcoatdamagecalculator
atkA2_mirrorcoatdamagecalculator: @ 8027ADC
	push {r4-r6,lr}
	ldr r4, _08027B4C @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r6, r0, 24
	ldr r5, _08027B50 @ =gProtectStructs
	ldrb r0, [r4]
	lsls r0, 4
	adds r0, r5
	ldrb r0, [r0, 0xD]
	bl GetBankSide
	lsls r0, 24
	lsrs r2, r0, 24
	ldrb r0, [r4]
	lsls r1, r0, 4
	adds r0, r5, 0
	adds r0, 0x8
	adds r0, r1, r0
	ldr r3, [r0]
	cmp r3, 0
	beq _08027B90
	cmp r6, r2
	beq _08027B90
	ldr r6, _08027B54 @ =gBattleMons
	adds r0, r1, r5
	ldrb r0, [r0, 0xD]
	movs r4, 0x58
	muls r0, r4
	adds r0, r6
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _08027B90
	ldr r1, _08027B58 @ =gBattleMoveDamage
	lsls r0, r3, 1
	str r0, [r1]
	ldr r1, _08027B5C @ =gSideTimer
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r1, r0, r1
	ldrb r0, [r1, 0x8]
	cmp r0, 0
	beq _08027B64
	ldrb r1, [r1, 0x9]
	adds r0, r1, 0
	muls r0, r4
	adds r0, r6
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _08027B64
	ldr r0, _08027B60 @ =gBankTarget
	strb r1, [r0]
	b _08027B74
	.align 2, 0
_08027B4C: .4byte gBankAttacker
_08027B50: .4byte gProtectStructs
_08027B54: .4byte gBattleMons
_08027B58: .4byte gBattleMoveDamage
_08027B5C: .4byte gSideTimer
_08027B60: .4byte gBankTarget
_08027B64:
	ldr r2, _08027B80 @ =gBankTarget
	ldr r1, _08027B84 @ =gProtectStructs
	ldr r0, _08027B88 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0, 0xD]
	strb r0, [r2]
_08027B74:
	ldr r1, _08027B8C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08027BC0
	.align 2, 0
_08027B80: .4byte gBankTarget
_08027B84: .4byte gProtectStructs
_08027B88: .4byte gBankAttacker
_08027B8C: .4byte gBattlescriptCurrInstr
_08027B90:
	ldr r2, _08027BC8 @ =gSpecialStatuses
	ldr r0, _08027BCC @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r3, _08027BD0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08027BC0:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08027BC8: .4byte gSpecialStatuses
_08027BCC: .4byte gBankAttacker
_08027BD0: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA2_mirrorcoatdamagecalculator

	thumb_func_start atkA3_disablelastusedattack
atkA3_disablelastusedattack: @ 8027BD4
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	movs r4, 0
	ldr r2, _08027CD4 @ =gBattleMons
	ldr r3, _08027CD8 @ =gBankTarget
	ldrb r1, [r3]
	movs r0, 0x58
	muls r0, r1
	adds r7, r2, 0
	adds r7, 0xC
	adds r0, r7
	ldr r5, _08027CDC @ =gLastUsedMove
	lsls r1, 1
	adds r1, r5
	ldrh r0, [r0]
	mov r9, r2
	adds r6, r3, 0
	ldr r2, _08027CE0 @ =gDisableStructs
	mov r8, r2
	ldrh r1, [r1]
	cmp r0, r1
	beq _08027C28
	mov r12, r6
	movs r3, 0x58
_08027C08:
	adds r4, 0x1
	cmp r4, 0x3
	bgt _08027C28
	lsls r2, r4, 1
	mov r0, r12
	ldrb r1, [r0]
	adds r0, r1, 0
	muls r0, r3
	adds r2, r0
	adds r2, r7
	lsls r1, 1
	adds r1, r5
	ldrh r0, [r2]
	ldrh r1, [r1]
	cmp r0, r1
	bne _08027C08
_08027C28:
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r8
	ldrh r0, [r0, 0x4]
	cmp r0, 0
	bne _08027CEC
	cmp r4, 0x4
	beq _08027CEC
	movs r5, 0x58
	adds r0, r1, 0
	muls r0, r5
	adds r0, r4, r0
	mov r1, r9
	adds r1, 0x24
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0
	beq _08027CEC
	ldr r1, _08027CE4 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	lsls r2, r4, 1
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r2, r0
	mov r3, r9
	adds r3, 0xC
	adds r0, r3
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r2, r0
	adds r0, r3
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r8
	muls r1, r5
	adds r2, r1
	adds r2, r3
	ldrh r1, [r2]
	strh r1, [r0, 0x4]
	bl Random
	ldrb r2, [r6]
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	add r1, r8
	movs r2, 0x3
	ands r2, r0
	adds r2, 0x2
	ldrb r3, [r1, 0xB]
	movs r0, 0x10
	negs r0, r0
	ands r0, r3
	orrs r0, r2
	strb r0, [r1, 0xB]
	ldrb r0, [r6]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	add r1, r8
	ldrb r3, [r1, 0xB]
	lsls r2, r3, 28
	lsrs r2, 24
	movs r0, 0xF
	ands r0, r3
	orrs r0, r2
	strb r0, [r1, 0xB]
	ldr r1, _08027CE8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08027D06
	.align 2, 0
_08027CD4: .4byte gBattleMons
_08027CD8: .4byte gBankTarget
_08027CDC: .4byte gLastUsedMove
_08027CE0: .4byte gDisableStructs
_08027CE4: .4byte gBattleTextBuff1
_08027CE8: .4byte gBattlescriptCurrInstr
_08027CEC:
	ldr r3, _08027D14 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08027D06:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08027D14: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA3_disablelastusedattack

	thumb_func_start atkA4_setencore
atkA4_setencore: @ 8027D18
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	movs r5, 0
	ldr r3, _08027E0C @ =gBattleMons
	ldr r4, _08027E10 @ =gBankTarget
	ldrb r1, [r4]
	movs r0, 0x58
	muls r0, r1
	adds r6, r3, 0
	adds r6, 0xC
	adds r0, r6
	ldr r2, _08027E14 @ =gLastUsedMove
	lsls r1, 1
	adds r1, r2
	ldrh r0, [r0]
	mov r10, r3
	mov r8, r2
	ldr r2, _08027E18 @ =gDisableStructs
	mov r9, r2
	ldrh r1, [r1]
	cmp r0, r1
	beq _08027D72
	mov r12, r4
	adds r7, r6, 0
	mov r6, r8
	movs r3, 0x58
_08027D52:
	adds r5, 0x1
	cmp r5, 0x3
	bgt _08027D72
	lsls r2, r5, 1
	mov r0, r12
	ldrb r1, [r0]
	adds r0, r1, 0
	muls r0, r3
	adds r2, r0
	adds r2, r7
	lsls r1, 1
	adds r1, r6
	ldrh r0, [r2]
	ldrh r1, [r1]
	cmp r0, r1
	bne _08027D52
_08027D72:
	ldrb r0, [r4]
	lsls r0, 1
	add r0, r8
	ldrh r2, [r0]
	cmp r2, 0xA5
	beq _08027D86
	cmp r2, 0xE3
	beq _08027D86
	cmp r2, 0x77
	bne _08027D88
_08027D86:
	movs r5, 0x4
_08027D88:
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	mov r2, r9
	adds r3, r0, r2
	ldrh r0, [r3, 0x6]
	cmp r0, 0
	bne _08027E20
	cmp r5, 0x4
	beq _08027E20
	movs r0, 0x58
	adds r2, r1, 0
	muls r2, r0
	adds r0, r5, r2
	mov r1, r10
	adds r1, 0x24
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0
	beq _08027E20
	lsls r0, r5, 1
	adds r0, r2
	subs r1, 0x18
	adds r0, r1
	ldrh r0, [r0]
	strh r0, [r3, 0x6]
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r9
	strb r5, [r0, 0xC]
	bl Random
	ldrb r2, [r4]
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	add r1, r9
	movs r2, 0x3
	ands r2, r0
	adds r2, 0x3
	ldrb r3, [r1, 0xE]
	movs r0, 0x10
	negs r0, r0
	ands r0, r3
	orrs r0, r2
	strb r0, [r1, 0xE]
	ldrb r0, [r4]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	add r1, r9
	ldrb r3, [r1, 0xE]
	lsls r2, r3, 28
	lsrs r2, 24
	movs r0, 0xF
	ands r0, r3
	orrs r0, r2
	strb r0, [r1, 0xE]
	ldr r1, _08027E1C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08027E3A
	.align 2, 0
_08027E0C: .4byte gBattleMons
_08027E10: .4byte gBankTarget
_08027E14: .4byte gLastUsedMove
_08027E18: .4byte gDisableStructs
_08027E1C: .4byte gBattlescriptCurrInstr
_08027E20:
	ldr r3, _08027E48 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08027E3A:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08027E48: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA4_setencore

	thumb_func_start sub_8027E4C
sub_8027E4C: @ 8027E4C
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r7, _08027EEC @ =gBattleMons
	ldr r0, _08027EF0 @ =gBankTarget
	mov r8, r0
	ldrb r0, [r0]
	movs r6, 0x58
	adds r2, r0, 0
	muls r2, r6
	adds r0, r7, 0
	adds r0, 0x50
	adds r0, r2, r0
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 17
	ands r0, r1
	cmp r0, 0
	bne _08027F18
	ldr r1, _08027EF4 @ =gBankAttacker
	mov r12, r1
	ldrb r0, [r1]
	muls r0, r6
	adds r0, r7
	ldrh r4, [r0, 0x28]
	adds r0, r2, r7
	ldrh r2, [r0, 0x28]
	adds r4, r2
	asrs r4, 1
	ldr r5, _08027EF8 @ =gBattleMoveDamage
	mov r9, r5
	subs r2, r4
	str r2, [r5]
	ldr r3, _08027EFC @ =0x02000000
	ldr r1, _08027F00 @ =0x00016014
	adds r0, r3, r1
	strb r2, [r0]
	movs r0, 0xFF
	lsls r0, 8
	ands r0, r2
	asrs r0, 8
	ldr r5, _08027F04 @ =0x00016015
	adds r1, r3, r5
	strb r0, [r1]
	movs r0, 0xFF
	lsls r0, 16
	ands r0, r2
	asrs r0, 16
	adds r5, 0x1
	adds r1, r3, r5
	strb r0, [r1]
	lsrs r2, 24
	ldr r0, _08027F08 @ =0x00016017
	adds r3, r0
	strb r2, [r3]
	mov r1, r12
	ldrb r0, [r1]
	muls r0, r6
	adds r0, r7
	ldrh r0, [r0, 0x28]
	subs r0, r4
	mov r5, r9
	str r0, [r5]
	ldr r2, _08027F0C @ =gSpecialStatuses
	mov r0, r8
	ldrb r1, [r0]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r2, 0x4
	adds r0, r2
	ldr r1, _08027F10 @ =0x0000ffff
	str r1, [r0]
	ldr r1, _08027F14 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08027F32
	.align 2, 0
_08027EEC: .4byte gBattleMons
_08027EF0: .4byte gBankTarget
_08027EF4: .4byte gBankAttacker
_08027EF8: .4byte gBattleMoveDamage
_08027EFC: .4byte 0x02000000
_08027F00: .4byte 0x00016014
_08027F04: .4byte 0x00016015
_08027F08: .4byte 0x00016017
_08027F0C: .4byte gSpecialStatuses
_08027F10: .4byte 0x0000ffff
_08027F14: .4byte gBattlescriptCurrInstr
_08027F18:
	ldr r3, _08027F40 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08027F32:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08027F40: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8027E4C

	thumb_func_start sub_8027F44
sub_8027F44: @ 8027F44
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r1, _08027FA8 @ =gMoveHitWith
	ldr r4, _08027FAC @ =gBankAttacker
	ldrb r0, [r4]
	lsls r0, 1
	adds r2, r0, r1
	ldrh r1, [r2]
	cmp r1, 0
	beq _08027F8C
	ldr r0, _08027FB0 @ =0x0000ffff
	cmp r1, r0
	beq _08027F8C
	ldrh r0, [r2]
	bl IsTwoTurnsMove
	lsls r0, 24
	cmp r0, 0
	beq _08028024
	ldr r2, _08027FB4 @ =gProtectStructs
	ldrb r0, [r4]
	lsls r1, r0, 4
	adds r0, r2, 0x4
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	bne _08028024
	adds r0, r2, 0
	adds r0, 0x8
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	bne _08028024
_08027F8C:
	ldr r3, _08027FB8 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08028110
	.align 2, 0
_08027FA8: .4byte gMoveHitWith
_08027FAC: .4byte gBankAttacker
_08027FB0: .4byte 0x0000ffff
_08027FB4: .4byte gProtectStructs
_08027FB8: .4byte gBattlescriptCurrInstr
_08027FBC:
	mov r0, r12
	strb r5, [r0]
	mov r1, r10
	ldrb r0, [r1]
	muls r0, r2
	adds r0, r7
	adds r0, 0x22
	strb r5, [r0]
	ldr r1, _08027FE0 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x3
	strb r0, [r1, 0x1]
	strb r5, [r1, 0x2]
	movs r0, 0xFF
	strb r0, [r1, 0x3]
	ldr r1, _08027FE4 @ =gBattlescriptCurrInstr
	b _08028012
	.align 2, 0
_08027FE0: .4byte gBattleTextBuff1
_08027FE4: .4byte gBattlescriptCurrInstr
_08027FE8:
	mov r0, r8
	adds r0, 0x1
	adds r0, r3
	ldrb r2, [r0]
	strb r2, [r4]
	mov r4, r10
	ldrb r0, [r4]
	muls r0, r6
	ldr r7, _0802801C @ =gBattleMons
	adds r0, r7
	adds r0, 0x22
	strb r2, [r0]
	ldr r1, _08028020 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x3
	strb r0, [r1, 0x1]
	strb r2, [r1, 0x2]
	movs r0, 0xFF
	strb r0, [r1, 0x3]
	mov r1, r12
_08028012:
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08028110
	.align 2, 0
_0802801C: .4byte gBattleMons
_08028020: .4byte gBattleTextBuff1
_08028024:
	movs r4, 0
	mov r8, r4
	movs r7, 0x7F
	mov r9, r7
_0802802C:
	bl Random
	mov r4, r9
	ands r4, r0
	cmp r4, 0x70
	bhi _0802802C
	lsls r0, r4, 1
	adds r4, r0, r4
	ldr r6, _08028120 @ =gTypeEffectiveness
	adds r3, r4, r6
	ldr r1, _08028124 @ =gUnknown_02024C44
	ldr r2, _08028128 @ =gBankAttacker
	ldrb r5, [r2]
	lsls r0, r5, 1
	adds r0, r1
	ldrb r1, [r3]
	mov r10, r2
	ldrh r0, [r0]
	cmp r1, r0
	bne _08028088
	adds r0, r4, 0x2
	adds r0, r6
	ldrb r0, [r0]
	cmp r0, 0x5
	bhi _08028088
	ldr r7, _0802812C @ =gBattleMons
	movs r2, 0x58
	adds r0, r5, 0
	muls r0, r2
	adds r3, r0, r7
	movs r0, 0x21
	adds r0, r3
	mov r12, r0
	adds r0, r4, 0x1
	adds r0, r6
	ldrb r5, [r0]
	mov r1, r12
	ldrb r0, [r1]
	adds r1, r5, 0
	cmp r0, r1
	beq _08028088
	adds r0, r3, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, r1
	bne _08027FBC
_08028088:
	movs r7, 0x1
	add r8, r7
	ldr r0, _08028130 @ =0x000003e7
	cmp r8, r0
	ble _0802802C
	movs r0, 0
	mov r8, r0
	ldr r1, _08028134 @ =gBattlescriptCurrInstr
	mov r12, r1
	ldr r3, _08028120 @ =gTypeEffectiveness
	adds r0, r4, 0x1
	adds r0, r3
	mov r9, r0
	adds r5, r3, 0
_080280A4:
	ldrb r1, [r5]
	cmp r1, 0xFF
	bgt _080280AE
	cmp r1, 0xFE
	bge _080280E8
_080280AE:
	mov r4, r10
	ldrb r2, [r4]
	lsls r0, r2, 1
	ldr r7, _08028124 @ =gUnknown_02024C44
	adds r0, r7
	ldrh r0, [r0]
	cmp r1, r0
	bne _080280E8
	ldrb r0, [r5, 0x2]
	cmp r0, 0x5
	bhi _080280E8
	movs r6, 0x58
	adds r0, r2, 0
	muls r0, r6
	ldr r1, _0802812C @ =gBattleMons
	adds r2, r0, r1
	adds r4, r2, 0
	adds r4, 0x21
	ldrb r0, [r4]
	mov r7, r9
	ldrb r1, [r7]
	cmp r0, r1
	beq _080280E8
	adds r0, r2, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, r1
	beq _080280E8
	b _08027FE8
_080280E8:
	adds r5, 0x3
	movs r0, 0x3
	add r8, r0
	ldr r0, _08028138 @ =0x0000014f
	cmp r8, r0
	bls _080280A4
	mov r1, r12
	ldr r2, [r1]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	mov r4, r12
	str r1, [r4]
_08028110:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028120: .4byte gTypeEffectiveness
_08028124: .4byte gUnknown_02024C44
_08028128: .4byte gBankAttacker
_0802812C: .4byte gBattleMons
_08028130: .4byte 0x000003e7
_08028134: .4byte gBattlescriptCurrInstr
_08028138: .4byte 0x0000014f
	thumb_func_end sub_8027F44

	thumb_func_start atkA7_setalwayshitflag
atkA7_setalwayshitflag: @ 802813C
	push {r4,lr}
	ldr r4, _08028180 @ =gStatuses3
	ldr r3, _08028184 @ =gBankTarget
	ldrb r1, [r3]
	lsls r1, 2
	adds r1, r4
	ldr r0, [r1]
	movs r2, 0x19
	negs r2, r2
	ands r0, r2
	str r0, [r1]
	ldrb r1, [r3]
	lsls r1, 2
	adds r1, r4
	ldr r0, [r1]
	movs r2, 0x10
	orrs r0, r2
	str r0, [r1]
	ldr r2, _08028188 @ =gDisableStructs
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	ldr r1, _0802818C @ =gBankAttacker
	ldrb r1, [r1]
	strb r1, [r0, 0x15]
	ldr r1, _08028190 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08028180: .4byte gStatuses3
_08028184: .4byte gBankTarget
_08028188: .4byte gDisableStructs
_0802818C: .4byte gBankAttacker
_08028190: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA7_setalwayshitflag

	thumb_func_start atkA8_copymovepermanently
atkA8_copymovepermanently: @ 8028194
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x14
	ldr r0, _080282F4 @ =gUnknown_02024BE8
	ldr r1, _080282F8 @ =0x0000ffff
	adds r5, r1, 0
	strh r5, [r0]
	ldr r3, _080282FC @ =gBattleMons
	ldr r2, _08028300 @ =gBankAttacker
	ldrb r1, [r2]
	movs r0, 0x58
	adds r4, r1, 0
	muls r4, r0
	adds r0, r3, 0
	adds r0, 0x50
	adds r0, r4, r0
	ldr r1, [r0]
	movs r0, 0x80
	lsls r0, 14
	ands r1, r0
	mov r12, r3
	mov r10, r2
	cmp r1, 0
	beq _080281CC
	b _08028320
_080281CC:
	ldr r0, _08028304 @ =gUnknown_02024C2C
	ldr r2, _08028308 @ =gBankTarget
	ldrb r1, [r2]
	lsls r1, 1
	adds r1, r0
	ldrh r1, [r1]
	mov r9, r0
	mov r8, r2
	cmp r1, 0xA5
	bne _080281E2
	b _08028320
_080281E2:
	cmp r1, 0
	bne _080281E8
	b _08028320
_080281E8:
	cmp r1, r5
	bne _080281EE
	b _08028320
_080281EE:
	cmp r1, 0xA6
	bne _080281F4
	b _08028320
_080281F4:
	movs r7, 0
	mov r5, r9
	mov r0, r12
	adds r0, 0xC
	adds r1, r4, r0
	mov r3, r8
_08028200:
	ldrh r2, [r1]
	cmp r2, 0xA6
	beq _08028212
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r5
	ldrh r0, [r0]
	cmp r2, r0
	beq _0802821A
_08028212:
	adds r1, 0x2
	adds r7, 0x1
	cmp r7, 0x3
	ble _08028200
_0802821A:
	cmp r7, 0x4
	beq _08028220
	b _08028320
_08028220:
	ldr r4, _0802830C @ =gCurrMovePos
	ldrb r1, [r4]
	lsls r1, 1
	mov r2, r10
	ldrb r0, [r2]
	movs r3, 0x58
	muls r0, r3
	adds r1, r0
	mov r6, r12
	adds r6, 0xC
	adds r1, r6
	mov r2, r8
	ldrb r0, [r2]
	lsls r0, 1
	add r0, r9
	ldrh r0, [r0]
	strh r0, [r1]
	mov r1, r10
	ldrb r0, [r1]
	adds r2, r0, 0
	muls r2, r3
	ldrb r4, [r4]
	adds r2, r4
	mov r5, r12
	adds r5, 0x24
	adds r2, r5
	ldr r4, _08028310 @ =gBattleMoves
	mov r1, r8
	ldrb r0, [r1]
	lsls r0, 1
	add r0, r9
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r0, [r0, 0x4]
	strb r0, [r2]
	ldr r1, _08028314 @ =gActiveBank
	mov r2, r10
	ldrb r0, [r2]
	strb r0, [r1]
	movs r7, 0
	ldrb r0, [r2]
	muls r0, r3
	adds r4, r0, r5
	adds r3, r0, 0
	add r2, sp, 0x4
	add r5, sp, 0xC
_08028282:
	adds r0, r3, r6
	ldrh r0, [r0]
	strh r0, [r2]
	adds r1, r5, r7
	ldrb r0, [r4]
	strb r0, [r1]
	adds r4, 0x1
	adds r3, 0x2
	adds r2, 0x2
	adds r7, 0x1
	cmp r7, 0x3
	ble _08028282
	add r2, sp, 0x4
	mov r0, r10
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	add r0, r12
	adds r0, 0x3B
	ldrb r0, [r0]
	strb r0, [r2, 0xC]
	str r2, [sp]
	movs r0, 0
	movs r1, 0x3
	movs r2, 0
	movs r3, 0x10
	bl EmitSetAttributes
	ldr r0, _08028314 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r1, _08028318 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	ldr r3, _08028304 @ =gUnknown_02024C2C
	ldr r2, _08028308 @ =gBankTarget
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r2]
	lsls r0, 1
	adds r0, r3
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _0802831C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802833A
	.align 2, 0
_080282F4: .4byte gUnknown_02024BE8
_080282F8: .4byte 0x0000ffff
_080282FC: .4byte gBattleMons
_08028300: .4byte gBankAttacker
_08028304: .4byte gUnknown_02024C2C
_08028308: .4byte gBankTarget
_0802830C: .4byte gCurrMovePos
_08028310: .4byte gBattleMoves
_08028314: .4byte gActiveBank
_08028318: .4byte gBattleTextBuff1
_0802831C: .4byte gBattlescriptCurrInstr
_08028320:
	ldr r3, _0802834C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802833A:
	add sp, 0x14
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802834C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkA8_copymovepermanently

	thumb_func_start IsTwoTurnsMove
IsTwoTurnsMove: @ 8028350
	push {lr}
	lsls r0, 16
	lsrs r0, 16
	ldr r2, _08028380 @ =gBattleMoves
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r0, [r1]
	cmp r0, 0x91
	beq _0802837A
	cmp r0, 0x27
	beq _0802837A
	cmp r0, 0x4B
	beq _0802837A
	cmp r0, 0x97
	beq _0802837A
	cmp r0, 0x9B
	beq _0802837A
	cmp r0, 0x1A
	bne _08028384
_0802837A:
	movs r0, 0x1
	b _08028386
	.align 2, 0
_08028380: .4byte gBattleMoves
_08028384:
	movs r0, 0
_08028386:
	pop {r1}
	bx r1
	thumb_func_end IsTwoTurnsMove

	thumb_func_start sub_802838C
sub_802838C: @ 802838C
	push {lr}
	lsls r0, 16
	lsrs r1, r0, 16
	cmp r1, 0
	beq _080283AA
	cmp r1, 0xD6
	beq _080283AA
	movs r0, 0x89
	lsls r0, 1
	cmp r1, r0
	beq _080283AA
	cmp r1, 0x77
	beq _080283AA
	cmp r1, 0x76
	bne _080283AE
_080283AA:
	movs r0, 0x1
	b _080283B0
_080283AE:
	movs r0, 0
_080283B0:
	pop {r1}
	bx r1
	thumb_func_end sub_802838C

	thumb_func_start AttacksThisTurn
AttacksThisTurn: @ 80283B4
	push {lr}
	lsls r1, 16
	lsrs r2, r1, 16
	ldr r1, _0802840C @ =gBattleMoves
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0]
	adds r3, r1, 0
	cmp r0, 0x97
	bne _080283D8
	ldr r0, _08028410 @ =gBattleWeather
	ldrh r1, [r0]
	movs r0, 0x60
	ands r0, r1
	cmp r0, 0
	bne _08028418
_080283D8:
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r3
	ldrb r0, [r0]
	cmp r0, 0x91
	beq _080283FA
	cmp r0, 0x27
	beq _080283FA
	cmp r0, 0x4B
	beq _080283FA
	cmp r0, 0x97
	beq _080283FA
	cmp r0, 0x9B
	beq _080283FA
	cmp r0, 0x1A
	bne _08028418
_080283FA:
	ldr r0, _08028414 @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 20
	ands r0, r1
	cmp r0, 0
	beq _08028418
	movs r0, 0x1
	b _0802841A
	.align 2, 0
_0802840C: .4byte gBattleMoves
_08028410: .4byte gBattleWeather
_08028414: .4byte gHitMarker
_08028418:
	movs r0, 0x2
_0802841A:
	pop {r1}
	bx r1
	thumb_func_end AttacksThisTurn

	thumb_func_start sub_8028420
sub_8028420: @ 8028420
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	movs r6, 0
	movs r5, 0
	ldr r0, _080284B0 @ =gBankAttacker
	mov r9, r0
	movs r1, 0x58
	mov r8, r1
	ldr r7, _080284B4 @ =gUnknown_02024A8C
	movs r0, 0x84
	lsls r0, 1
	mov r10, r0
_0802843E:
	lsls r4, r5, 1
	mov r1, r9
	ldrb r0, [r1]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	adds r0, r4, r0
	adds r0, r7
	ldrh r0, [r0]
	bl sub_802838C
	lsls r0, 24
	cmp r0, 0
	bne _0802847E
	mov r1, r9
	ldrb r0, [r1]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	adds r0, r4, r0
	adds r0, r7
	ldrh r1, [r0]
	cmp r1, r10
	beq _0802847E
	cmp r1, 0xFD
	beq _0802847E
	adds r0, r1, 0
	bl IsTwoTurnsMove
	lsls r0, 24
	cmp r0, 0
	beq _0802848C
_0802847E:
	ldr r1, _080284B8 @ =gBitTable
	lsls r0, r5, 2
	adds r0, r1
	ldr r0, [r0]
	orrs r6, r0
	lsls r0, r6, 24
	lsrs r6, r0, 24
_0802848C:
	adds r5, 0x1
	cmp r5, 0x3
	ble _0802843E
	ldr r0, _080284B0 @ =gBankAttacker
	ldrb r0, [r0]
	adds r1, r6, 0
	movs r2, 0xFD
	bl sub_8015A98
	lsls r0, 24
	lsrs r6, r0, 24
	cmp r6, 0xF
	bne _080284C0
	ldr r1, _080284BC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08028524
	.align 2, 0
_080284B0: .4byte gBankAttacker
_080284B4: .4byte gUnknown_02024A8C
_080284B8: .4byte gBitTable
_080284BC: .4byte gBattlescriptCurrInstr
_080284C0:
	movs r7, 0x3
	ldr r4, _08028534 @ =gBitTable
_080284C4:
	bl Random
	adds r5, r7, 0
	ands r5, r0
	lsls r0, r5, 2
	adds r0, r4
	ldr r0, [r0]
	ands r0, r6
	cmp r0, 0
	bne _080284C4
	ldr r4, _08028538 @ =gUnknown_02024BEA
	ldr r2, _0802853C @ =gBattleMons
	lsls r1, r5, 1
	ldr r0, _08028540 @ =gBankAttacker
	ldrb r3, [r0]
	movs r0, 0x58
	muls r0, r3
	adds r1, r0
	adds r2, 0xC
	adds r1, r2
	ldrh r0, [r1]
	strh r0, [r4]
	ldr r0, _08028544 @ =gCurrMovePos
	strb r5, [r0]
	ldr r2, _08028548 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _0802854C @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldrh r0, [r4]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _08028550 @ =gBankTarget
	strb r0, [r1]
	ldr r3, _08028554 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08028524:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028534: .4byte gBitTable
_08028538: .4byte gUnknown_02024BEA
_0802853C: .4byte gBattleMons
_08028540: .4byte gBankAttacker
_08028544: .4byte gCurrMovePos
_08028548: .4byte gHitMarker
_0802854C: .4byte 0xfffffbff
_08028550: .4byte gBankTarget
_08028554: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028420

	thumb_func_start sub_8028558
sub_8028558: @ 8028558
	ldr r1, _0802857C @ =gBattleMons
	ldr r0, _08028580 @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r2, r0
	adds r1, 0x50
	adds r2, r1
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 18
	orrs r0, r1
	str r0, [r2]
	ldr r1, _08028584 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_0802857C: .4byte gBattleMons
_08028580: .4byte gBankAttacker
_08028584: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028558

	thumb_func_start DestinyBondFlagUpdate
DestinyBondFlagUpdate: @ 8028588
	push {r4,r5,lr}
	ldr r0, _080285D8 @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r4, _080285DC @ =gBankTarget
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r3, r0, 24
	ldr r1, _080285E0 @ =gBattleMons
	ldrb r2, [r4]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 18
	ands r0, r1
	cmp r0, 0
	beq _080285D2
	cmp r5, r3
	beq _080285D2
	ldr r2, _080285E4 @ =gHitMarker
	ldr r1, [r2]
	movs r0, 0x80
	lsls r0, 17
	ands r0, r1
	cmp r0, 0
	bne _080285D2
	movs r0, 0x40
	orrs r1, r0
	str r1, [r2]
_080285D2:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080285D8: .4byte gBankAttacker
_080285DC: .4byte gBankTarget
_080285E0: .4byte gBattleMons
_080285E4: .4byte gHitMarker
	thumb_func_end DestinyBondFlagUpdate

	thumb_func_start atkAB_802A458
atkAB_802A458: @ 80285E8
	push {lr}
	bl DestinyBondFlagUpdate
	ldr r1, _080285FC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_080285FC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkAB_802A458

	thumb_func_start atkAC_remaininghptopower
atkAC_remaininghptopower: @ 8028600
	push {lr}
	ldr r2, _08028654 @ =gBattleMons
	ldr r0, _08028658 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r1, r0
	adds r1, r2
	movs r2, 0x28
	ldrsh r0, [r1, r2]
	movs r2, 0x2C
	ldrsh r1, [r1, r2]
	movs r2, 0x30
	bl GetScaledHPFraction
	lsls r0, 24
	lsrs r1, r0, 24
	movs r3, 0
	ldr r0, _0802865C @ =gUnknown_081FAD26
	ldrb r2, [r0]
	cmp r1, r2
	ble _0802863A
	adds r2, r0, 0
_0802862C:
	adds r3, 0x2
	cmp r3, 0xB
	bgt _0802863A
	adds r0, r3, r2
	ldrb r0, [r0]
	cmp r1, r0
	bgt _0802862C
_0802863A:
	ldr r2, _08028660 @ =gDynamicBasePower
	ldr r1, _0802865C @ =gUnknown_081FAD26
	adds r0, r3, 0x1
	adds r0, r1
	ldrb r0, [r0]
	strh r0, [r2]
	ldr r1, _08028664 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08028654: .4byte gBattleMons
_08028658: .4byte gBankAttacker
_0802865C: .4byte gUnknown_081FAD26
_08028660: .4byte gDynamicBasePower
_08028664: .4byte gBattlescriptCurrInstr
	thumb_func_end atkAC_remaininghptopower

	thumb_func_start sub_8028668
sub_8028668: @ 8028668
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	ldr r4, _080287F8 @ =gLastUsedMove
	ldr r1, _080287FC @ =gBankTarget
	ldrb r2, [r1]
	lsls r0, r2, 1
	adds r0, r4
	ldrh r3, [r0]
	mov r8, r1
	cmp r3, 0
	bne _08028688
	b _08028828
_08028688:
	ldr r0, _08028800 @ =0x0000ffff
	cmp r3, r0
	bne _08028690
	b _08028828
_08028690:
	ldr r1, _08028804 @ =gStatuses3
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _08028808 @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	beq _080286A2
	b _08028828
_080286A2:
	movs r7, 0
	ldr r0, _0802880C @ =gBattleMons
	movs r1, 0x58
	muls r1, r2
	adds r2, r0, 0
	adds r2, 0xC
	adds r1, r2
	ldrh r1, [r1]
	cmp r3, r1
	beq _080286DA
	adds r6, r4, 0
	mov r5, r8
	adds r4, r2, 0
	movs r3, 0x58
_080286BE:
	adds r7, 0x1
	cmp r7, 0x3
	bgt _080286DA
	ldrb r0, [r5]
	lsls r2, r0, 1
	adds r2, r6
	lsls r1, r7, 1
	muls r0, r3
	adds r1, r0
	adds r1, r4
	ldrh r0, [r2]
	ldrh r1, [r1]
	cmp r0, r1
	bne _080286BE
_080286DA:
	cmp r7, 0x4
	bne _080286E0
	b _08028828
_080286E0:
	mov r4, r8
	ldrb r0, [r4]
	movs r1, 0x58
	mov r9, r1
	mov r3, r9
	muls r3, r0
	adds r0, r3, 0
	adds r0, r7, r0
	ldr r1, _0802880C @ =gBattleMons
	adds r1, 0x24
	mov r10, r1
	add r0, r10
	ldrb r0, [r0]
	cmp r0, 0x1
	bhi _08028700
	b _08028828
_08028700:
	bl Random
	movs r1, 0x3
	ands r1, r0
	adds r6, r1, 0x2
	ldrb r0, [r4]
	mov r3, r9
	muls r3, r0
	adds r0, r3, 0
	adds r0, r7, r0
	add r0, r10
	ldrb r0, [r0]
	cmp r0, r6
	bge _0802871E
	adds r6, r0, 0
_0802871E:
	ldr r1, _08028810 @ =gBattleTextBuff1
	movs r5, 0xFD
	strb r5, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	ldr r2, _080287F8 @ =gLastUsedMove
	mov r3, r8
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r4, _08028814 @ =gBattleTextBuff2
	adds r0, r4, 0
	adds r1, r6, 0
	movs r2, 0
	movs r3, 0x1
	bl ConvertIntToDecimalStringN
	strb r5, [r4]
	movs r0, 0x1
	strb r0, [r4, 0x1]
	strb r0, [r4, 0x2]
	strb r0, [r4, 0x3]
	strb r6, [r4, 0x4]
	subs r0, 0x2
	strb r0, [r4, 0x5]
	mov r1, r8
	ldrb r0, [r1]
	mov r1, r9
	muls r1, r0
	adds r1, r7, r1
	add r1, r10
	ldrb r0, [r1]
	subs r0, r6
	strb r0, [r1]
	ldr r4, _08028818 @ =gActiveBank
	mov r3, r8
	ldrb r0, [r3]
	strb r0, [r4]
	ldr r1, _0802881C @ =gDisableStructs
	ldrb r3, [r4]
	lsls r0, r3, 3
	subs r0, r3
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r0, 0x18]
	lsrs r1, 4
	ldr r2, _08028820 @ =gBitTable
	lsls r0, r7, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _080287D2
	mov r2, r9
	muls r2, r3
	ldr r0, _0802880C @ =gBattleMons
	adds r0, 0x50
	adds r0, r2, r0
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 14
	ands r0, r1
	cmp r0, 0
	bne _080287D2
	adds r1, r7, 0
	adds r1, 0x9
	lsls r1, 24
	lsrs r1, 24
	mov r3, r10
	adds r0, r2, r3
	adds r0, r7
	str r0, [sp]
	movs r0, 0
	movs r2, 0
	movs r3, 0x1
	bl EmitSetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
_080287D2:
	ldr r1, _08028824 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	ldr r1, _0802880C @ =gBattleMons
	ldr r0, _080287FC @ =gBankTarget
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r0, r7, r0
	adds r1, 0x24
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0
	bne _08028842
	adds r0, r2, 0
	bl CancelMultiTurnMoves
	b _08028842
	.align 2, 0
_080287F8: .4byte gLastUsedMove
_080287FC: .4byte gBankTarget
_08028800: .4byte 0x0000ffff
_08028804: .4byte gStatuses3
_08028808: .4byte 0x000400c0
_0802880C: .4byte gBattleMons
_08028810: .4byte gBattleTextBuff1
_08028814: .4byte gBattleTextBuff2
_08028818: .4byte gActiveBank
_0802881C: .4byte gDisableStructs
_08028820: .4byte gBitTable
_08028824: .4byte gBattlescriptCurrInstr
_08028828:
	ldr r3, _08028854 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08028842:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028854: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028668

	thumb_func_start sub_8028858
sub_8028858: @ 8028858
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	sub sp, 0x8
	movs r4, 0
	str r4, [sp, 0x4]
	movs r7, 0
	ldr r0, _080288AC @ =gCurrentMove
	ldrh r0, [r0]
	cmp r0, 0xD7
	beq _08028872
	b _08028A26
_08028872:
	ldr r5, _080288B0 @ =gBattleCommunication
	strb r7, [r5, 0x5]
	ldr r6, _080288B4 @ =gBankAttacker
	ldrb r0, [r6]
	bl GetBankSide
	lsls r0, 24
	ldr r1, _080288B8 @ =gEnemyParty
	mov r9, r1
	cmp r0, 0
	bne _0802888C
	ldr r2, _080288BC @ =gPlayerParty
	mov r9, r2
_0802888C:
	ldr r4, _080288C0 @ =gBattleMons
	ldrb r3, [r6]
	movs r0, 0x58
	adds r2, r3, 0
	muls r2, r0
	adds r0, r2, r4
	adds r1, r0, 0
	adds r1, 0x20
	ldrb r0, [r1]
	cmp r0, 0x2B
	beq _080288C4
	adds r0, r4, 0
	adds r0, 0x4C
	adds r0, r2, r0
	str r7, [r0]
	b _080288D4
	.align 2, 0
_080288AC: .4byte gCurrentMove
_080288B0: .4byte gBattleCommunication
_080288B4: .4byte gBankAttacker
_080288B8: .4byte gEnemyParty
_080288BC: .4byte gPlayerParty
_080288C0: .4byte gBattleMons
_080288C4:
	ldrb r1, [r1]
	adds r0, r3, 0
	bl RecordAbilityBattle
	ldrb r0, [r5, 0x5]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r5, 0x5]
_080288D4:
	ldr r4, _08028934 @ =gActiveBank
	ldr r0, _08028938 @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankIdentity
	movs r6, 0x2
	eors r0, r6
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	ldr r1, _0802893C @ =0x02000000
	ldr r2, _08028940 @ =0x00016003
	adds r1, r2
	strb r0, [r1]
	strb r0, [r4]
	ldr r0, _08028944 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08028964
	ldr r0, _08028948 @ =gAbsentBankFlags
	ldrb r2, [r0]
	ldr r1, _0802894C @ =gBitTable
	ldrb r3, [r4]
	lsls r0, r3, 2
	adds r0, r1
	ldr r0, [r0]
	ands r2, r0
	cmp r2, 0
	bne _08028964
	ldr r5, _08028950 @ =gBattleMons
	movs r0, 0x58
	adds r4, r3, 0
	muls r4, r0
	adds r0, r4, r5
	adds r1, r0, 0
	adds r1, 0x20
	ldrb r0, [r1]
	cmp r0, 0x2B
	beq _08028954
	adds r0, r5, 0
	adds r0, 0x4C
	adds r0, r4, r0
	str r2, [r0]
	b _08028964
	.align 2, 0
_08028934: .4byte gActiveBank
_08028938: .4byte gBankAttacker
_0802893C: .4byte 0x02000000
_08028940: .4byte 0x00016003
_08028944: .4byte gBattleTypeFlags
_08028948: .4byte gAbsentBankFlags
_0802894C: .4byte gBitTable
_08028950: .4byte gBattleMons
_08028954:
	ldrb r1, [r1]
	adds r0, r3, 0
	bl RecordAbilityBattle
	ldr r1, _080289AC @ =gBattleCommunication
	ldrb r0, [r1, 0x5]
	orrs r0, r6
	strb r0, [r1, 0x5]
_08028964:
	movs r6, 0
	ldr r0, _080289B0 @ =gBattleMons
	mov r8, r0
_0802896A:
	movs r0, 0x64
	adds r4, r6, 0
	muls r4, r0
	add r4, r9
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	lsls r0, 16
	lsrs r5, r0, 16
	adds r0, r4, 0
	movs r1, 0x2E
	bl GetMonData
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r5, 0
	beq _08028A1E
	movs r0, 0xCE
	lsls r0, 1
	cmp r5, r0
	beq _08028A1E
	ldr r2, _080289B4 @ =gBattlePartyID
	ldr r0, _080289B8 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 1
	adds r0, r2
	ldrh r0, [r0]
	cmp r0, r6
	bne _080289BC
	movs r0, 0x58
	muls r0, r1
	b _080289EC
	.align 2, 0
_080289AC: .4byte gBattleCommunication
_080289B0: .4byte gBattleMons
_080289B4: .4byte gBattlePartyID
_080289B8: .4byte gBankAttacker
_080289BC:
	ldr r0, _080289F4 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08028A04
	ldr r0, _080289F8 @ =gActiveBank
	ldrb r3, [r0]
	lsls r0, r3, 1
	adds r0, r2
	ldrh r0, [r0]
	cmp r0, r6
	bne _08028A04
	ldr r0, _080289FC @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _08028A00 @ =gBitTable
	lsls r0, r3, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _08028A04
	movs r0, 0x58
	muls r0, r3
_080289EC:
	add r0, r8
	adds r0, 0x20
	ldrb r0, [r0]
	b _08028A10
	.align 2, 0
_080289F4: .4byte gBattleTypeFlags
_080289F8: .4byte gActiveBank
_080289FC: .4byte gAbsentBankFlags
_08028A00: .4byte gBitTable
_08028A04:
	adds r0, r5, 0
	adds r1, r4, 0
	bl GetAbilityBySpecies
	lsls r0, 24
	lsrs r0, 24
_08028A10:
	cmp r0, 0x2B
	beq _08028A1E
	movs r0, 0x1
	lsls r0, r6
	orrs r7, r0
	lsls r0, r7, 24
	lsrs r7, r0, 24
_08028A1E:
	adds r6, 0x1
	cmp r6, 0x5
	ble _0802896A
	b _08028A7E
_08028A26:
	ldr r1, _08028AB4 @ =gBattleCommunication
	movs r0, 0x4
	strb r0, [r1, 0x5]
	movs r7, 0x3F
	ldr r2, _08028AB8 @ =gBattleMons
	ldr r1, _08028ABC @ =gBankAttacker
	ldrb r0, [r1]
	movs r6, 0x58
	muls r0, r6
	adds r5, r2, 0
	adds r5, 0x4C
	adds r0, r5
	str r4, [r0]
	ldrb r0, [r1]
	bl GetBankIdentity
	movs r1, 0x2
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	ldr r3, _08028AC0 @ =gActiveBank
	strb r0, [r3]
	ldr r0, _08028AC4 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08028A7E
	ldr r0, _08028AC8 @ =gAbsentBankFlags
	ldrb r2, [r0]
	ldr r1, _08028ACC @ =gBitTable
	ldrb r3, [r3]
	lsls r0, r3, 2
	adds r0, r1
	ldr r0, [r0]
	ands r2, r0
	cmp r2, 0
	bne _08028A7E
	adds r0, r3, 0
	muls r0, r6
	adds r0, r5
	str r2, [r0]
_08028A7E:
	ldr r4, _08028AC0 @ =gActiveBank
	ldr r0, _08028ABC @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r4]
	add r1, sp, 0x4
	str r1, [sp]
	movs r0, 0
	movs r1, 0x28
	adds r2, r7, 0
	movs r3, 0x4
	bl EmitSetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _08028AD0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	add sp, 0x8
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028AB4: .4byte gBattleCommunication
_08028AB8: .4byte gBattleMons
_08028ABC: .4byte gBankAttacker
_08028AC0: .4byte gActiveBank
_08028AC4: .4byte gBattleTypeFlags
_08028AC8: .4byte gAbsentBankFlags
_08028ACC: .4byte gBitTable
_08028AD0: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028858

	thumb_func_start sub_8028AD4
sub_8028AD4: @ 8028AD4
	push {r4-r7,lr}
	ldr r7, _08028B24 @ =gBattleMons
	ldr r0, _08028B28 @ =gBankTarget
	ldrb r3, [r0]
	movs r6, 0x58
	adds r1, r3, 0
	muls r1, r6
	adds r0, r7, 0
	adds r0, 0x50
	adds r4, r1, r0
	ldr r2, [r4]
	movs r5, 0x80
	lsls r5, 21
	adds r0, r2, 0
	ands r0, r5
	cmp r0, 0
	bne _08028B06
	ldr r1, _08028B2C @ =gStatuses3
	lsls r0, r3, 2
	adds r0, r1
	ldr r0, [r0]
	ldr r1, _08028B30 @ =0x000400c0
	ands r0, r1
	cmp r0, 0
	beq _08028B38
_08028B06:
	ldr r3, _08028B34 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08028B5C
	.align 2, 0
_08028B24: .4byte gBattleMons
_08028B28: .4byte gBankTarget
_08028B2C: .4byte gStatuses3
_08028B30: .4byte 0x000400c0
_08028B34: .4byte gBattlescriptCurrInstr
_08028B38:
	orrs r2, r5
	str r2, [r4]
	ldr r1, _08028B64 @ =gBattleMoveDamage
	ldr r0, _08028B68 @ =gBankAttacker
	ldrb r0, [r0]
	muls r0, r6
	adds r0, r7
	ldrh r0, [r0, 0x2C]
	lsrs r0, 1
	str r0, [r1]
	cmp r0, 0
	bne _08028B54
	movs r0, 0x1
	str r0, [r1]
_08028B54:
	ldr r1, _08028B6C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08028B5C:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028B64: .4byte gBattleMoveDamage
_08028B68: .4byte gBankAttacker
_08028B6C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028AD4

	thumb_func_start sub_8028B70
sub_8028B70: @ 8028B70
	push {r4,lr}
	ldr r4, _08028BC4 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	movs r1, 0x1
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	ldr r1, _08028BC8 @ =gSideTimer
	lsls r2, r0, 1
	adds r0, r2, r0
	lsls r0, 2
	adds r3, r0, r1
	ldrb r0, [r3, 0x6]
	cmp r0, 0x3
	bne _08028BD4
	ldr r2, _08028BCC @ =gSpecialStatuses
	ldrb r1, [r4]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r3, _08028BD0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08028BEE
	.align 2, 0
_08028BC4: .4byte gBankAttacker
_08028BC8: .4byte gSideTimer
_08028BCC: .4byte gSpecialStatuses
_08028BD0: .4byte gBattlescriptCurrInstr
_08028BD4:
	ldr r1, _08028BF4 @ =gSideAffecting
	adds r1, r2, r1
	ldrh r2, [r1]
	movs r0, 0x10
	orrs r0, r2
	strh r0, [r1]
	ldrb r0, [r3, 0x6]
	adds r0, 0x1
	strb r0, [r3, 0x6]
	ldr r1, _08028BF8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08028BEE:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08028BF4: .4byte gSideAffecting
_08028BF8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028B70

	thumb_func_start sub_8028BFC
sub_8028BFC: @ 8028BFC
	ldr r1, _08028C20 @ =gBattleMons
	ldr r0, _08028C24 @ =gBankTarget
	ldrb r2, [r0]
	movs r0, 0x58
	muls r2, r0
	adds r1, 0x50
	adds r2, r1
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 22
	orrs r0, r1
	str r0, [r2]
	ldr r1, _08028C28 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_08028C20: .4byte gBattleMons
_08028C24: .4byte gBankTarget
_08028C28: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028BFC

	thumb_func_start atkB2_setperishsong
atkB2_setperishsong: @ 8028C2C
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	movs r6, 0
	movs r3, 0
	ldr r0, _08028C70 @ =gNoOfAllBanks
	adds r7, r0, 0
	ldr r0, _08028C74 @ =gBankAttacker
	mov r8, r0
	ldrb r1, [r7]
	cmp r6, r1
	bge _08028C98
	movs r5, 0x20
	ldr r0, _08028C78 @ =gBattleMons
	mov r12, r0
	ldr r0, _08028C7C @ =gDisableStructs
	adds r4, r0, 0
	adds r4, 0xF
	ldr r2, _08028C80 @ =gStatuses3
_08028C54:
	ldr r1, [r2]
	adds r0, r1, 0
	ands r0, r5
	cmp r0, 0
	bne _08028C6C
	movs r0, 0x58
	muls r0, r3
	add r0, r12
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x2B
	bne _08028C84
_08028C6C:
	adds r6, 0x1
	b _08028C8C
	.align 2, 0
_08028C70: .4byte gNoOfAllBanks
_08028C74: .4byte gBankAttacker
_08028C78: .4byte gBattleMons
_08028C7C: .4byte gDisableStructs
_08028C80: .4byte gStatuses3
_08028C84:
	orrs r1, r5
	str r1, [r2]
	movs r0, 0x33
	strb r0, [r4]
_08028C8C:
	adds r4, 0x1C
	adds r2, 0x4
	adds r3, 0x1
	ldrb r0, [r7]
	cmp r3, r0
	blt _08028C54
_08028C98:
	mov r1, r8
	ldrb r0, [r1]
	bl sub_80153D0
	ldr r0, _08028CC4 @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r6, r0
	bne _08028CCC
	ldr r3, _08028CC8 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08028CD4
	.align 2, 0
_08028CC4: .4byte gNoOfAllBanks
_08028CC8: .4byte gBattlescriptCurrInstr
_08028CCC:
	ldr r1, _08028CE0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08028CD4:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028CE0: .4byte gBattlescriptCurrInstr
	thumb_func_end atkB2_setperishsong

	thumb_func_start atkB3_rolloutdamagecalculation
atkB3_rolloutdamagecalculation: @ 8028CE4
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r0, _08028D08 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	beq _08028D18
	ldr r0, _08028D0C @ =gBankAttacker
	ldrb r0, [r0]
	bl CancelMultiTurnMoves
	ldr r1, _08028D10 @ =gBattlescriptCurrInstr
	ldr r0, _08028D14 @ =BattleScript_1D6F74
	str r0, [r1]
	b _08028E30
	.align 2, 0
_08028D08: .4byte gBattleMoveFlags
_08028D0C: .4byte gBankAttacker
_08028D10: .4byte gBattlescriptCurrInstr
_08028D14: .4byte BattleScript_1D6F74
_08028D18:
	ldr r2, _08028E3C @ =gBattleMons
	ldr r1, _08028E40 @ =gBankAttacker
	ldrb r3, [r1]
	movs r5, 0x58
	adds r0, r3, 0
	muls r0, r5
	adds r4, r2, 0
	adds r4, 0x50
	adds r0, r4
	ldr r0, [r0]
	movs r7, 0x80
	lsls r7, 5
	ands r0, r7
	adds r6, r1, 0
	mov r9, r2
	ldr r1, _08028E44 @ =gDisableStructs
	mov r12, r1
	ldr r2, _08028E48 @ =gCurrentMove
	mov r8, r2
	cmp r0, 0
	bne _08028D8A
	lsls r0, r3, 3
	subs r0, r3
	lsls r0, 2
	add r0, r12
	ldrb r2, [r0, 0x11]
	movs r1, 0x10
	negs r1, r1
	ands r1, r2
	movs r2, 0x5
	orrs r1, r2
	strb r1, [r0, 0x11]
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	add r0, r12
	ldrb r2, [r0, 0x11]
	movs r1, 0xF
	ands r1, r2
	movs r2, 0x50
	orrs r1, r2
	strb r1, [r0, 0x11]
	ldrb r0, [r6]
	adds r1, r0, 0
	muls r1, r5
	adds r1, r4
	ldr r0, [r1]
	orrs r0, r7
	str r0, [r1]
	ldr r1, _08028E4C @ =gLockedMove
	ldrb r0, [r6]
	lsls r0, 1
	adds r0, r1
	mov r2, r8
	ldrh r1, [r2]
	strh r1, [r0]
_08028D8A:
	ldrb r0, [r6]
	lsls r2, r0, 3
	subs r2, r0
	lsls r2, 2
	add r2, r12
	ldrb r3, [r2, 0x11]
	lsls r1, r3, 28
	lsrs r1, 28
	subs r1, 0x1
	movs r0, 0xF
	ands r1, r0
	movs r0, 0x10
	negs r0, r0
	ands r0, r3
	orrs r0, r1
	strb r0, [r2, 0x11]
	cmp r1, 0
	bne _08028DBE
	ldrb r0, [r6]
	adds r1, r0, 0
	muls r1, r5
	adds r1, r4
	ldr r0, [r1]
	ldr r2, _08028E50 @ =0xffffefff
	ands r0, r2
	str r0, [r1]
_08028DBE:
	ldr r3, _08028E54 @ =gDynamicBasePower
	ldr r2, _08028E58 @ =gBattleMoves
	mov r0, r8
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x1]
	strh r0, [r3]
	movs r2, 0x1
	ldrb r1, [r6]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	mov r1, r12
	adds r4, r0, r1
	ldrb r0, [r4, 0x11]
	lsls r0, 28
	lsrs r0, 28
	movs r1, 0x5
	subs r1, r0
	ldr r7, _08028E5C @ =gBattlescriptCurrInstr
	adds r5, r3, 0
	cmp r2, r1
	bge _08028E0C
	adds r1, r5, 0
	adds r3, r4, 0
	movs r4, 0x5
_08028DF8:
	ldrh r0, [r1]
	lsls r0, 1
	strh r0, [r1]
	adds r2, 0x1
	ldrb r0, [r3, 0x11]
	lsls r0, 28
	lsrs r0, 28
	subs r0, r4, r0
	cmp r2, r0
	blt _08028DF8
_08028E0C:
	ldrb r1, [r6]
	movs r0, 0x58
	muls r0, r1
	mov r1, r9
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 23
	ands r0, r1
	cmp r0, 0
	beq _08028E2A
	ldrh r0, [r5]
	lsls r0, 1
	strh r0, [r5]
_08028E2A:
	ldr r0, [r7]
	adds r0, 0x1
	str r0, [r7]
_08028E30:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08028E3C: .4byte gBattleMons
_08028E40: .4byte gBankAttacker
_08028E44: .4byte gDisableStructs
_08028E48: .4byte gCurrentMove
_08028E4C: .4byte gLockedMove
_08028E50: .4byte 0xffffefff
_08028E54: .4byte gDynamicBasePower
_08028E58: .4byte gBattleMoves
_08028E5C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkB3_rolloutdamagecalculation

	thumb_func_start atkB4_jumpifconfusedandattackmaxed
atkB4_jumpifconfusedandattackmaxed: @ 8028E60
	push {r4,r5,lr}
	ldr r5, _08028EB0 @ =gBattleMons
	ldr r0, _08028EB4 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	adds r3, r1, 0
	muls r3, r0
	adds r0, r5, 0
	adds r0, 0x50
	adds r0, r3, r0
	ldr r0, [r0]
	movs r1, 0x7
	ands r0, r1
	ldr r4, _08028EB8 @ =gBattlescriptCurrInstr
	cmp r0, 0
	beq _08028EBC
	ldr r2, [r4]
	ldrb r0, [r2, 0x1]
	adds r0, r3
	adds r1, r5, 0
	adds r1, 0x18
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	cmp r0, 0xC
	bne _08028EBC
	ldrb r1, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r1, r0
	str r1, [r4]
	b _08028EC2
	.align 2, 0
_08028EB0: .4byte gBattleMons
_08028EB4: .4byte gBankTarget
_08028EB8: .4byte gBattlescriptCurrInstr
_08028EBC:
	ldr r0, [r4]
	adds r0, 0x6
	str r0, [r4]
_08028EC2:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end atkB4_jumpifconfusedandattackmaxed

	thumb_func_start sub_8028EC8
sub_8028EC8: @ 8028EC8
	push {r4,r5,lr}
	ldr r0, _08028EF0 @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	beq _08028F04
	ldr r2, _08028EF4 @ =gDisableStructs
	ldr r0, _08028EF8 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0
	strb r1, [r0, 0x10]
	ldr r1, _08028EFC @ =gBattlescriptCurrInstr
	ldr r0, _08028F00 @ =BattleScript_1D6F74
	str r0, [r1]
	b _08028F5C
	.align 2, 0
_08028EF0: .4byte gBattleMoveFlags
_08028EF4: .4byte gDisableStructs
_08028EF8: .4byte gBankAttacker
_08028EFC: .4byte gBattlescriptCurrInstr
_08028F00: .4byte BattleScript_1D6F74
_08028F04:
	ldr r5, _08028F64 @ =gDisableStructs
	ldr r4, _08028F68 @ =gBankAttacker
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r1, r0, r5
	ldrb r0, [r1, 0x10]
	cmp r0, 0x5
	beq _08028F1C
	adds r0, 0x1
	strb r0, [r1, 0x10]
_08028F1C:
	ldr r3, _08028F6C @ =gDynamicBasePower
	ldr r2, _08028F70 @ =gBattleMoves
	ldr r0, _08028F74 @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x1]
	strh r0, [r3]
	movs r2, 0x1
	ldrb r1, [r4]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r5
	ldr r4, _08028F78 @ =gBattlescriptCurrInstr
	ldrb r1, [r0, 0x10]
	cmp r2, r1
	bge _08028F56
	adds r1, r3, 0
	adds r3, r0, 0
_08028F48:
	ldrh r0, [r1]
	lsls r0, 1
	strh r0, [r1]
	adds r2, 0x1
	ldrb r0, [r3, 0x10]
	cmp r2, r0
	blt _08028F48
_08028F56:
	ldr r0, [r4]
	adds r0, 0x1
	str r0, [r4]
_08028F5C:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08028F64: .4byte gDisableStructs
_08028F68: .4byte gBankAttacker
_08028F6C: .4byte gDynamicBasePower
_08028F70: .4byte gBattleMoves
_08028F74: .4byte gCurrentMove
_08028F78: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8028EC8

	thumb_func_start atkB6_happinesstodamagecalculation
atkB6_happinesstodamagecalculation: @ 8028F7C
	push {r4,lr}
	ldr r2, _08028FA8 @ =gBattleMoves
	ldr r0, _08028FAC @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	cmp r0, 0x79
	bne _08028FBC
	ldr r4, _08028FB0 @ =gDynamicBasePower
	ldr r2, _08028FB4 @ =gBattleMons
	ldr r0, _08028FB8 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x2B
	ldrb r1, [r0]
	b _08028FD2
	.align 2, 0
_08028FA8: .4byte gBattleMoves
_08028FAC: .4byte gCurrentMove
_08028FB0: .4byte gDynamicBasePower
_08028FB4: .4byte gBattleMons
_08028FB8: .4byte gBankAttacker
_08028FBC:
	ldr r4, _08028FF0 @ =gDynamicBasePower
	ldr r2, _08028FF4 @ =gBattleMons
	ldr r0, _08028FF8 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x2B
	ldrb r0, [r0]
	movs r1, 0xFF
	subs r1, r0
_08028FD2:
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 1
	movs r1, 0x19
	bl __divsi3
	strh r0, [r4]
	ldr r1, _08028FFC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08028FF0: .4byte gDynamicBasePower
_08028FF4: .4byte gBattleMons
_08028FF8: .4byte gBankAttacker
_08028FFC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkB6_happinesstodamagecalculation

	thumb_func_start atkB7_presentdamagecalculation
atkB7_presentdamagecalculation: @ 8029000
	push {r4,lr}
	bl Random
	movs r4, 0xFF
	ands r4, r0
	cmp r4, 0x65
	bgt _0802901C
	ldr r1, _08029018 @ =gDynamicBasePower
	movs r0, 0x28
	strh r0, [r1]
	b _0802905E
	.align 2, 0
_08029018: .4byte gDynamicBasePower
_0802901C:
	cmp r4, 0xB1
	bgt _0802902C
	ldr r1, _08029028 @ =gDynamicBasePower
	movs r0, 0x50
	strh r0, [r1]
	b _0802905E
	.align 2, 0
_08029028: .4byte gDynamicBasePower
_0802902C:
	cmp r4, 0xCB
	bgt _0802903C
	ldr r1, _08029038 @ =gDynamicBasePower
	movs r0, 0x78
	strh r0, [r1]
	b _0802905E
	.align 2, 0
_08029038: .4byte gDynamicBasePower
_0802903C:
	ldr r3, _08029068 @ =gBattleMoveDamage
	ldr r2, _0802906C @ =gBattleMons
	ldr r0, _08029070 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x2C]
	lsrs r0, 2
	str r0, [r3]
	cmp r0, 0
	bne _08029058
	movs r0, 0x1
	str r0, [r3]
_08029058:
	ldr r0, [r3]
	negs r0, r0
	str r0, [r3]
_0802905E:
	cmp r4, 0xCB
	bgt _0802907C
	ldr r1, _08029074 @ =gBattlescriptCurrInstr
	ldr r0, _08029078 @ =BattleScript_1D6F44
	b _080290AC
	.align 2, 0
_08029068: .4byte gBattleMoveDamage
_0802906C: .4byte gBattleMons
_08029070: .4byte gBankTarget
_08029074: .4byte gBattlescriptCurrInstr
_08029078: .4byte BattleScript_1D6F44
_0802907C:
	ldr r2, _08029098 @ =gBattleMons
	ldr r0, _0802909C @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r1, [r0, 0x2C]
	ldrh r0, [r0, 0x28]
	cmp r1, r0
	bne _080290A8
	ldr r1, _080290A0 @ =gBattlescriptCurrInstr
	ldr r0, _080290A4 @ =BattleScript_1D83B5
	b _080290AC
	.align 2, 0
_08029098: .4byte gBattleMons
_0802909C: .4byte gBankTarget
_080290A0: .4byte gBattlescriptCurrInstr
_080290A4: .4byte BattleScript_1D83B5
_080290A8:
	ldr r1, _080290B4 @ =gBattlescriptCurrInstr
	ldr r0, _080290B8 @ =BattleScript_1D839B
_080290AC:
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_080290B4: .4byte gBattlescriptCurrInstr
_080290B8: .4byte BattleScript_1D839B
	thumb_func_end atkB7_presentdamagecalculation

	thumb_func_start sub_80290BC
sub_80290BC: @ 80290BC
	push {r4-r6,lr}
	ldr r4, _080290F0 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankIdentity
	ldr r6, _080290F4 @ =gSideAffecting
	movs r5, 0x1
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r1, [r1]
	movs r0, 0x20
	ands r0, r1
	cmp r0, 0
	beq _08029100
	ldr r2, _080290F8 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _080290FC @ =gBattleCommunication
	movs r0, 0
	strb r0, [r1, 0x5]
	b _08029132
	.align 2, 0
_080290F0: .4byte gBankAttacker
_080290F4: .4byte gSideAffecting
_080290F8: .4byte gBattleMoveFlags
_080290FC: .4byte gBattleCommunication
_08029100:
	ldrb r0, [r4]
	bl GetBankIdentity
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	adds r1, r6
	ldrh r0, [r1]
	movs r2, 0x20
	orrs r0, r2
	strh r0, [r1]
	ldrb r0, [r4]
	bl GetBankIdentity
	ldr r2, _08029140 @ =gSideTimer
	adds r1, r5, 0
	ands r1, r0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	movs r1, 0x5
	strb r1, [r0, 0x7]
	ldr r0, _08029144 @ =gBattleCommunication
	strb r1, [r0, 0x5]
_08029132:
	ldr r1, _08029148 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_08029140: .4byte gSideTimer
_08029144: .4byte gBattleCommunication
_08029148: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80290BC

	thumb_func_start atkB9_magnitudedamagecalculation
atkB9_magnitudedamagecalculation: @ 802914C
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x64
	bl __umodsi3
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, 0x4
	bgt _08029178
	ldr r1, _08029174 @ =gDynamicBasePower
	movs r0, 0xA
	strh r0, [r1]
	movs r3, 0x4
	b _080291E4
	.align 2, 0
_08029174: .4byte gDynamicBasePower
_08029178:
	cmp r3, 0xE
	bgt _0802918C
	ldr r1, _08029188 @ =gDynamicBasePower
	movs r0, 0x1E
	strh r0, [r1]
	movs r3, 0x5
	b _080291E4
	.align 2, 0
_08029188: .4byte gDynamicBasePower
_0802918C:
	cmp r3, 0x22
	bgt _080291A0
	ldr r1, _0802919C @ =gDynamicBasePower
	movs r0, 0x32
	strh r0, [r1]
	movs r3, 0x6
	b _080291E4
	.align 2, 0
_0802919C: .4byte gDynamicBasePower
_080291A0:
	cmp r3, 0x40
	bgt _080291B4
	ldr r1, _080291B0 @ =gDynamicBasePower
	movs r0, 0x46
	strh r0, [r1]
	movs r3, 0x7
	b _080291E4
	.align 2, 0
_080291B0: .4byte gDynamicBasePower
_080291B4:
	cmp r3, 0x54
	bgt _080291C8
	ldr r1, _080291C4 @ =gDynamicBasePower
	movs r0, 0x5A
	strh r0, [r1]
	movs r3, 0x8
	b _080291E4
	.align 2, 0
_080291C4: .4byte gDynamicBasePower
_080291C8:
	cmp r3, 0x5E
	bgt _080291DC
	ldr r1, _080291D8 @ =gDynamicBasePower
	movs r0, 0x6E
	strh r0, [r1]
	movs r3, 0x9
	b _080291E4
	.align 2, 0
_080291D8: .4byte gDynamicBasePower
_080291DC:
	ldr r1, _08029250 @ =gDynamicBasePower
	movs r0, 0x96
	strh r0, [r1]
	movs r3, 0xA
_080291E4:
	ldr r1, _08029254 @ =gBattleTextBuff1
	movs r2, 0
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x1
	strb r0, [r1, 0x1]
	strb r0, [r1, 0x2]
	movs r0, 0x2
	strb r0, [r1, 0x3]
	strb r3, [r1, 0x4]
	movs r0, 0xFF
	strb r0, [r1, 0x5]
	ldr r1, _08029258 @ =gBankTarget
	strb r2, [r1]
	ldr r0, _0802925C @ =gNoOfAllBanks
	ldrb r3, [r0]
	adds r6, r1, 0
	ldr r0, _08029260 @ =gBattlescriptCurrInstr
	mov r8, r0
	cmp r2, r3
	bcs _0802923C
	adds r4, r6, 0
	ldr r0, _08029264 @ =gBankAttacker
	ldrb r5, [r0]
	ldr r1, _08029268 @ =gBitTable
	mov r12, r1
	ldr r7, _0802926C @ =gAbsentBankFlags
_0802921A:
	ldrb r2, [r4]
	cmp r2, r5
	beq _08029230
	ldrb r0, [r7]
	ldrb r1, [r6]
	lsls r1, 2
	add r1, r12
	ldr r1, [r1]
	ands r0, r1
	cmp r0, 0
	beq _0802923C
_08029230:
	adds r0, r2, 0x1
	strb r0, [r4]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, r3
	bcc _0802921A
_0802923C:
	mov r1, r8
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029250: .4byte gDynamicBasePower
_08029254: .4byte gBattleTextBuff1
_08029258: .4byte gBankTarget
_0802925C: .4byte gNoOfAllBanks
_08029260: .4byte gBattlescriptCurrInstr
_08029264: .4byte gBankAttacker
_08029268: .4byte gBitTable
_0802926C: .4byte gAbsentBankFlags
	thumb_func_end atkB9_magnitudedamagecalculation

	thumb_func_start sub_8029270
sub_8029270: @ 8029270
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r0, _08029294 @ =gMultiHitCounter
	ldrb r0, [r0]
	cmp r0, 0x1
	bne _080292A0
	ldr r0, _08029298 @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	cmp r0, 0
	bne _0802929C
	movs r0, 0x1
	b _080292BA
	.align 2, 0
_08029294: .4byte gMultiHitCounter
_08029298: .4byte gBankAttacker
_0802929C:
	movs r0, 0
	b _080292BA
_080292A0:
	ldr r0, _080292B4 @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	cmp r0, 0
	bne _080292B8
	movs r0, 0x3
	b _080292BA
	.align 2, 0
_080292B4: .4byte gBankAttacker
_080292B8:
	movs r0, 0x2
_080292BA:
	bl GetBankByPlayerAI
	ldr r1, _0802937C @ =gBankTarget
	strb r0, [r1]
	ldr r0, _08029380 @ =gActionForBanks
	ldr r1, _0802937C @ =gBankTarget
	mov r9, r1
	ldrb r3, [r1]
	adds r0, r3, r0
	ldrb r0, [r0]
	cmp r0, 0
	bne _080293BC
	ldr r5, _08029384 @ =gBankAttacker
	ldr r0, _08029388 @ =0x02000000
	ldr r2, _0802938C @ =0x00016010
	adds r1, r3, r2
	adds r1, r0
	ldrb r2, [r5]
	mov r10, r0
	ldrb r1, [r1]
	cmp r2, r1
	bne _080293BC
	ldr r4, _08029390 @ =gBattleMons
	movs r2, 0x58
	adds r0, r3, 0
	muls r0, r2
	adds r1, r4, 0
	adds r1, 0x4C
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x27
	ands r0, r1
	cmp r0, 0
	bne _080293BC
	ldrb r0, [r5]
	muls r0, r2
	adds r0, r4
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	beq _080293BC
	ldr r0, _08029394 @ =gDisableStructs
	lsls r1, r3, 3
	subs r1, r3
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x18]
	lsls r0, 31
	cmp r0, 0
	bne _080293BC
	ldr r0, _08029398 @ =gChosenMovesByBanks
	lsls r1, r3, 1
	adds r1, r0
	ldrh r0, [r1]
	cmp r0, 0xE4
	bne _080293BC
	movs r1, 0
	ldr r0, _0802939C @ =gNoOfAllBanks
	ldr r7, _080293A0 @ =gCurrentMove
	mov r8, r7
	ldr r2, _080293A4 @ =gHitMarker
	mov r12, r2
	ldrb r7, [r0]
	cmp r1, r7
	bge _0802935A
	ldr r6, _080293A8 @ =gTurnOrder
	mov r5, r9
	ldr r4, _080293AC @ =gUnknown_02024A76
	movs r3, 0xB
	adds r2, r0, 0
_08029344:
	adds r0, r1, r6
	ldrb r0, [r0]
	ldrb r7, [r5]
	cmp r0, r7
	bne _08029352
	adds r0, r1, r4
	strb r3, [r0]
_08029352:
	adds r1, 0x1
	ldrb r0, [r2]
	cmp r1, r0
	blt _08029344
_0802935A:
	movs r0, 0xE4
	mov r1, r8
	strh r0, [r1]
	ldr r2, _080293B0 @ =gBattlescriptCurrInstr
	ldr r0, [r2]
	adds r0, 0x5
	str r0, [r2]
	ldr r1, _080293B4 @ =0x00016002
	add r1, r10
	movs r0, 0x1
	strb r0, [r1]
	mov r7, r12
	ldr r0, [r7]
	ldr r1, _080293B8 @ =0xfffffbff
	ands r0, r1
	str r0, [r7]
	b _080293D6
	.align 2, 0
_0802937C: .4byte gBankTarget
_08029380: .4byte gActionForBanks
_08029384: .4byte gBankAttacker
_08029388: .4byte 0x02000000
_0802938C: .4byte 0x00016010
_08029390: .4byte gBattleMons
_08029394: .4byte gDisableStructs
_08029398: .4byte gChosenMovesByBanks
_0802939C: .4byte gNoOfAllBanks
_080293A0: .4byte gCurrentMove
_080293A4: .4byte gHitMarker
_080293A8: .4byte gTurnOrder
_080293AC: .4byte gUnknown_02024A76
_080293B0: .4byte gBattlescriptCurrInstr
_080293B4: .4byte 0x00016002
_080293B8: .4byte 0xfffffbff
_080293BC:
	ldr r3, _080293E4 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_080293D6:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080293E4: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8029270

	thumb_func_start sub_80293E8
sub_80293E8: @ 80293E8
	push {lr}
	ldr r2, _08029408 @ =gBattleWeather
	ldrh r1, [r2]
	movs r0, 0x60
	ands r0, r1
	cmp r0, 0
	beq _08029414
	ldr r2, _0802940C @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08029410 @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	b _08029426
	.align 2, 0
_08029408: .4byte gBattleWeather
_0802940C: .4byte gBattleMoveFlags
_08029410: .4byte gBattleCommunication
_08029414:
	movs r0, 0x20
	strh r0, [r2]
	ldr r1, _08029434 @ =gBattleCommunication
	movs r0, 0x4
	strb r0, [r1, 0x5]
	ldr r0, _08029438 @ =gWishFutureKnock
	adds r0, 0x28
	movs r1, 0x5
	strb r1, [r0]
_08029426:
	ldr r1, _0802943C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08029434: .4byte gBattleCommunication
_08029438: .4byte gWishFutureKnock
_0802943C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_80293E8

	thumb_func_start atkBC_maxattackhalvehp
atkBC_maxattackhalvehp: @ 8029440
	push {r4,r5,lr}
	ldr r5, _0802948C @ =gBattleMons
	ldr r4, _08029490 @ =gBankAttacker
	ldrb r0, [r4]
	movs r3, 0x58
	muls r0, r3
	adds r2, r0, r5
	ldrh r0, [r2, 0x2C]
	lsrs r1, r0, 1
	cmp r1, 0
	bne _08029458
	movs r1, 0x1
_08029458:
	movs r0, 0x19
	ldrsb r0, [r2, r0]
	cmp r0, 0xB
	bgt _0802949C
	ldrh r0, [r2, 0x28]
	cmp r0, r1
	bls _0802949C
	movs r0, 0xC
	strb r0, [r2, 0x19]
	ldr r1, _08029494 @ =gBattleMoveDamage
	ldrb r0, [r4]
	muls r0, r3
	adds r0, r5
	ldrh r0, [r0, 0x2C]
	lsrs r0, 1
	str r0, [r1]
	cmp r0, 0
	bne _08029480
	movs r0, 0x1
	str r0, [r1]
_08029480:
	ldr r1, _08029498 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _080294B6
	.align 2, 0
_0802948C: .4byte gBattleMons
_08029490: .4byte gBankAttacker
_08029494: .4byte gBattleMoveDamage
_08029498: .4byte gBattlescriptCurrInstr
_0802949C:
	ldr r3, _080294BC @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_080294B6:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_080294BC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkBC_maxattackhalvehp

	thumb_func_start atkBD_copyfoestats
atkBD_copyfoestats: @ 80294C0
	push {r4-r7,lr}
	movs r2, 0
	ldr r7, _080294F8 @ =gBattlescriptCurrInstr
	ldr r6, _080294FC @ =gBankAttacker
	movs r4, 0x58
	ldr r3, _08029500 @ =gUnknown_02024A98
	ldr r5, _08029504 @ =gBankTarget
_080294CE:
	ldrb r0, [r6]
	adds r1, r0, 0
	muls r1, r4
	adds r1, r2, r1
	adds r1, r3
	ldrb r0, [r5]
	muls r0, r4
	adds r0, r2, r0
	adds r0, r3
	ldrb r0, [r0]
	strb r0, [r1]
	adds r2, 0x1
	cmp r2, 0x7
	ble _080294CE
	ldr r0, [r7]
	adds r0, 0x5
	str r0, [r7]
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_080294F8: .4byte gBattlescriptCurrInstr
_080294FC: .4byte gBankAttacker
_08029500: .4byte gUnknown_02024A98
_08029504: .4byte gBankTarget
	thumb_func_end atkBD_copyfoestats

	thumb_func_start atkBE_breakfree
atkBE_breakfree: @ 8029508
	push {r4,r5,lr}
	ldr r1, _08029570 @ =gBattleMons
	ldr r5, _08029574 @ =gBankAttacker
	ldrb r2, [r5]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r3, r0, r1
	ldr r1, [r3]
	movs r0, 0xE0
	lsls r0, 8
	ands r0, r1
	cmp r0, 0
	beq _08029594
	ldr r0, _08029578 @ =0xffff1fff
	ands r1, r0
	str r1, [r3]
	ldr r1, _0802957C @ =gBankTarget
	ldr r2, _08029580 @ =0x02000000
	ldrb r0, [r5]
	ldr r3, _08029584 @ =0x00016020
	adds r0, r3
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1]
	ldr r1, _08029588 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x2
	strb r0, [r1, 0x1]
	ldrb r0, [r5]
	lsls r0, 1
	subs r3, 0x1C
	adds r0, r3
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1, 0x2]
	ldrb r0, [r5]
	lsls r0, 1
	adds r3, 0x1
	adds r0, r3
	adds r0, r2
	ldrb r0, [r0]
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	bl b_movescr_stack_push_cursor
	ldr r1, _0802958C @ =gBattlescriptCurrInstr
	ldr r0, _08029590 @ =gUnknown_081D92C2
	b _0802963E
	.align 2, 0
_08029570: .4byte gBattleMons
_08029574: .4byte gBankAttacker
_08029578: .4byte 0xffff1fff
_0802957C: .4byte gBankTarget
_08029580: .4byte 0x02000000
_08029584: .4byte 0x00016020
_08029588: .4byte gBattleTextBuff1
_0802958C: .4byte gBattlescriptCurrInstr
_08029590: .4byte gUnknown_081D92C2
_08029594:
	ldr r4, _080295C8 @ =gStatuses3
	lsls r0, r2, 2
	adds r3, r0, r4
	ldr r1, [r3]
	movs r0, 0x4
	ands r0, r1
	cmp r0, 0
	beq _080295D4
	movs r0, 0x5
	negs r0, r0
	ands r1, r0
	str r1, [r3]
	ldrb r1, [r5]
	lsls r1, 2
	adds r1, r4
	ldr r0, [r1]
	movs r2, 0x4
	negs r2, r2
	ands r0, r2
	str r0, [r1]
	bl b_movescr_stack_push_cursor
	ldr r1, _080295CC @ =gBattlescriptCurrInstr
	ldr r0, _080295D0 @ =gUnknown_081D92C9
	b _0802963E
	.align 2, 0
_080295C8: .4byte gStatuses3
_080295CC: .4byte gBattlescriptCurrInstr
_080295D0: .4byte gUnknown_081D92C9
_080295D4:
	adds r0, r2, 0
	bl GetBankSide
	ldr r4, _08029624 @ =gSideAffecting
	lsls r0, 24
	lsrs r0, 23
	adds r0, r4
	ldrh r1, [r0]
	movs r0, 0x10
	ands r0, r1
	cmp r0, 0
	beq _08029638
	ldrb r0, [r5]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 23
	adds r0, r4
	ldrh r2, [r0]
	ldr r1, _08029628 @ =0x0000ffef
	ands r1, r2
	movs r4, 0
	strh r1, [r0]
	ldrb r0, [r5]
	bl GetBankSide
	ldr r2, _0802962C @ =gSideTimer
	lsls r0, 24
	lsrs r0, 24
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	strb r4, [r1, 0x6]
	bl b_movescr_stack_push_cursor
	ldr r1, _08029630 @ =gBattlescriptCurrInstr
	ldr r0, _08029634 @ =gUnknown_081D92D0
	b _0802963E
	.align 2, 0
_08029624: .4byte gSideAffecting
_08029628: .4byte 0x0000ffef
_0802962C: .4byte gSideTimer
_08029630: .4byte gBattlescriptCurrInstr
_08029634: .4byte gUnknown_081D92D0
_08029638:
	ldr r1, _08029648 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
_0802963E:
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08029648: .4byte gBattlescriptCurrInstr
	thumb_func_end atkBE_breakfree

	thumb_func_start sub_802964C
sub_802964C: @ 802964C
	ldr r1, _08029670 @ =gBattleMons
	ldr r0, _08029674 @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r2, r0
	adds r1, 0x50
	adds r2, r1
	ldr r0, [r2]
	movs r1, 0x80
	lsls r1, 23
	orrs r0, r1
	str r0, [r2]
	ldr r1, _08029678 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_08029670: .4byte gBattleMons
_08029674: .4byte gBankAttacker
_08029678: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802964C

	thumb_func_start atkC0_recoverbasedonsunlight
atkC0_recoverbasedonsunlight: @ 802967C
	push {r4-r7,lr}
	sub sp, 0x4
	ldr r1, _080296E8 @ =gBankTarget
	ldr r5, _080296EC @ =gBankAttacker
	ldrb r0, [r5]
	strb r0, [r1]
	ldr r7, _080296F0 @ =gBattleMons
	ldrb r0, [r5]
	movs r6, 0x58
	muls r0, r6
	adds r0, r7
	ldrh r1, [r0, 0x28]
	ldrh r0, [r0, 0x2C]
	cmp r1, r0
	beq _0802975C
	ldr r4, _080296F4 @ =gBattleWeather
	ldrh r0, [r4]
	cmp r0, 0
	beq _080296CE
	movs r0, 0
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0xD
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0
	bne _080296CE
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0x4D
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	beq _080296FC
_080296CE:
	ldr r3, _080296F8 @ =gBattleMoveDamage
	ldr r2, _080296F0 @ =gBattleMons
	ldr r0, _080296EC @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x2C]
	lsrs r0, 1
	str r0, [r3]
	adds r1, r3, 0
	b _08029736
	.align 2, 0
_080296E8: .4byte gBankTarget
_080296EC: .4byte gBankAttacker
_080296F0: .4byte gBattleMons
_080296F4: .4byte gBattleWeather
_080296F8: .4byte gBattleMoveDamage
_080296FC:
	ldrh r1, [r4]
	movs r0, 0x60
	ands r0, r1
	cmp r0, 0
	beq _08029728
	ldr r4, _08029724 @ =gBattleMoveDamage
	ldrb r0, [r5]
	muls r0, r6
	adds r0, r7
	ldrh r1, [r0, 0x2C]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	movs r1, 0x1E
	bl __divsi3
	str r0, [r4]
	adds r1, r4, 0
	b _08029736
	.align 2, 0
_08029724: .4byte gBattleMoveDamage
_08029728:
	ldr r1, _08029754 @ =gBattleMoveDamage
	ldrb r0, [r5]
	muls r0, r6
	adds r0, r7
	ldrh r0, [r0, 0x2C]
	lsrs r0, 2
	str r0, [r1]
_08029736:
	adds r2, r1, 0
	ldr r0, [r2]
	cmp r0, 0
	bne _08029742
	movs r0, 0x1
	str r0, [r2]
_08029742:
	ldr r0, [r1]
	negs r0, r0
	str r0, [r1]
	ldr r1, _08029758 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _08029776
	.align 2, 0
_08029754: .4byte gBattleMoveDamage
_08029758: .4byte gBattlescriptCurrInstr
_0802975C:
	ldr r3, _08029780 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08029776:
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029780: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC0_recoverbasedonsunlight

	thumb_func_start sub_8029784
sub_8029784: @ 8029784
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r2, _08029894 @ =gBattleMons
	ldr r0, _08029898 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	adds r4, r1, 0
	muls r4, r0
	adds r4, r2
	ldrb r0, [r4, 0x14]
	mov r10, r0
	mov r7, r10
	lsls r7, 27
	adds r0, r7, 0
	lsrs r0, 27
	mov r10, r0
	movs r1, 0x2
	mov r2, r10
	ands r2, r1
	asrs r2, 1
	ldrh r7, [r4, 0x14]
	mov r9, r7
	mov r0, r9
	lsls r0, 22
	mov r9, r0
	lsrs r3, r0, 27
	adds r0, r1, 0
	ands r0, r3
	orrs r2, r0
	ldrb r7, [r4, 0x15]
	mov r8, r7
	mov r0, r8
	lsls r0, 25
	mov r8, r0
	lsrs r3, r0, 27
	adds r0, r1, 0
	ands r0, r3
	lsls r0, 1
	orrs r2, r0
	ldr r6, [r4, 0x14]
	lsls r6, 12
	lsrs r3, r6, 27
	adds r0, r1, 0
	ands r0, r3
	lsls r0, 2
	orrs r2, r0
	ldrh r5, [r4, 0x16]
	lsls r5, 23
	lsrs r3, r5, 27
	adds r0, r1, 0
	ands r0, r3
	lsls r0, 3
	orrs r2, r0
	ldrb r3, [r4, 0x17]
	lsls r3, 26
	lsrs r0, r3, 27
	ands r1, r0
	lsls r1, 4
	orrs r2, r1
	movs r1, 0x1
	adds r4, r1, 0
	mov r7, r10
	ands r4, r7
	mov r0, r9
	lsrs r0, 27
	mov r9, r0
	adds r0, r1, 0
	mov r7, r9
	ands r0, r7
	lsls r0, 1
	orrs r4, r0
	mov r0, r8
	lsrs r0, 27
	mov r8, r0
	adds r0, r1, 0
	mov r7, r8
	ands r0, r7
	lsls r0, 2
	orrs r4, r0
	lsrs r6, 27
	adds r0, r1, 0
	ands r0, r6
	lsls r0, 3
	orrs r4, r0
	lsrs r5, 27
	adds r0, r1, 0
	ands r0, r5
	lsls r0, 4
	orrs r4, r0
	lsrs r3, 27
	ands r1, r3
	lsls r1, 5
	orrs r4, r1
	ldr r5, _0802989C @ =gDynamicBasePower
	lsls r0, r2, 2
	adds r0, r2
	lsls r0, 3
	movs r1, 0x3F
	bl __divsi3
	adds r0, 0x1E
	strh r0, [r5]
	ldr r5, _080298A0 @ =0x02000000
	lsls r0, r4, 4
	subs r0, r4
	movs r1, 0x3F
	bl __divsi3
	adds r1, r0, 0x1
	ldr r0, _080298A4 @ =0x0001601c
	adds r5, r0
	strb r1, [r5]
	lsls r0, r1, 24
	lsrs r0, 24
	cmp r0, 0x8
	bls _08029876
	adds r0, r1, 0x1
	strb r0, [r5]
_08029876:
	ldrb r0, [r5]
	movs r1, 0xC0
	orrs r0, r1
	strb r0, [r5]
	ldr r1, _080298A8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029894: .4byte gBattleMons
_08029898: .4byte gBankAttacker
_0802989C: .4byte gDynamicBasePower
_080298A0: .4byte 0x02000000
_080298A4: .4byte 0x0001601c
_080298A8: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8029784

	thumb_func_start atkC2_selectnexttarget
atkC2_selectnexttarget: @ 80298AC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r0, _08029908 @ =gBankTarget
	movs r1, 0
	strb r1, [r0]
	ldr r1, _0802990C @ =gNoOfAllBanks
	ldrb r1, [r1]
	adds r6, r0, 0
	ldr r0, _08029910 @ =gBattlescriptCurrInstr
	mov r8, r0
	cmp r1, 0
	beq _080298F6
	adds r3, r6, 0
	ldr r0, _08029914 @ =gBankAttacker
	ldrb r5, [r0]
	ldr r0, _08029918 @ =gBitTable
	mov r12, r0
	adds r4, r1, 0
	ldr r7, _0802991C @ =gAbsentBankFlags
_080298D4:
	ldrb r2, [r3]
	cmp r2, r5
	beq _080298EA
	ldrb r0, [r7]
	ldrb r1, [r6]
	lsls r1, 2
	add r1, r12
	ldr r1, [r1]
	ands r0, r1
	cmp r0, 0
	beq _080298F6
_080298EA:
	adds r0, r2, 0x1
	strb r0, [r3]
	lsls r0, 24
	lsrs r0, 24
	cmp r0, r4
	bcc _080298D4
_080298F6:
	mov r1, r8
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029908: .4byte gBankTarget
_0802990C: .4byte gNoOfAllBanks
_08029910: .4byte gBattlescriptCurrInstr
_08029914: .4byte gBankAttacker
_08029918: .4byte gBitTable
_0802991C: .4byte gAbsentBankFlags
	thumb_func_end atkC2_selectnexttarget

	thumb_func_start atkC3_setfutureattack
atkC3_setfutureattack: @ 8029920
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x10
	ldr r0, _08029958 @ =gWishFutureKnock
	mov r8, r0
	ldr r7, _0802995C @ =gBankTarget
	ldrb r1, [r7]
	adds r0, r1, r0
	ldrb r6, [r0]
	cmp r6, 0
	beq _08029964
	ldr r3, _08029960 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08029A2E
	.align 2, 0
_08029958: .4byte gWishFutureKnock
_0802995C: .4byte gBankTarget
_08029960: .4byte gBattlescriptCurrInstr
_08029964:
	lsls r1, 1
	mov r0, r8
	adds r0, 0x18
	adds r1, r0
	ldr r2, _08029A04 @ =gCurrentMove
	mov r9, r2
	ldrh r0, [r2]
	strh r0, [r1]
	mov r0, r8
	adds r0, 0x4
	ldrb r4, [r7]
	adds r0, r4
	ldr r5, _08029A08 @ =gBankAttacker
	ldrb r1, [r5]
	strb r1, [r0]
	ldrb r0, [r7]
	add r0, r8
	movs r1, 0x3
	strb r1, [r0]
	ldr r4, _08029A0C @ =gSideAffecting
	ldrb r0, [r7]
	bl GetBankIdentity
	movs r1, 0x1
	mov r10, r1
	ands r1, r0
	lsls r1, 1
	adds r1, r4
	ldrh r3, [r1]
	ldrb r0, [r5]
	movs r4, 0x58
	muls r0, r4
	ldr r2, _08029A10 @ =gBattleMons
	adds r0, r2
	ldrb r1, [r7]
	muls r1, r4
	adds r1, r2
	mov r4, r9
	ldrh r2, [r4]
	str r6, [sp]
	str r6, [sp, 0x4]
	ldrb r4, [r5]
	str r4, [sp, 0x8]
	ldrb r4, [r7]
	str r4, [sp, 0xC]
	bl CalculateBaseDamage
	ldrb r1, [r7]
	lsls r1, 2
	mov r2, r8
	adds r2, 0x8
	adds r1, r2
	str r0, [r1]
	ldr r1, _08029A14 @ =gProtectStructs
	ldrb r0, [r5]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 28
	cmp r0, 0
	bge _080299F2
	ldrb r4, [r7]
	lsls r4, 2
	adds r4, r2
	ldr r1, [r4]
	lsls r0, r1, 4
	subs r0, r1
	movs r1, 0xA
	bl __divsi3
	str r0, [r4]
_080299F2:
	mov r0, r9
	ldrh r1, [r0]
	ldr r0, _08029A18 @ =0x00000161
	cmp r1, r0
	bne _08029A20
	ldr r0, _08029A1C @ =gBattleCommunication
	mov r1, r10
	strb r1, [r0, 0x5]
	b _08029A26
	.align 2, 0
_08029A04: .4byte gCurrentMove
_08029A08: .4byte gBankAttacker
_08029A0C: .4byte gSideAffecting
_08029A10: .4byte gBattleMons
_08029A14: .4byte gProtectStructs
_08029A18: .4byte 0x00000161
_08029A1C: .4byte gBattleCommunication
_08029A20:
	ldr r1, _08029A40 @ =gBattleCommunication
	movs r0, 0
	strb r0, [r1, 0x5]
_08029A26:
	ldr r1, _08029A44 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08029A2E:
	add sp, 0x10
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029A40: .4byte gBattleCommunication
_08029A44: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC3_setfutureattack

	thumb_func_start atkC4_802B910
atkC4_802B910: @ 8029A48
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	ldr r0, _08029A8C @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	ldr r7, _08029A90 @ =gEnemyParty
	cmp r0, 0
	bne _08029A62
	ldr r7, _08029A94 @ =gPlayerParty
_08029A62:
	ldr r2, _08029A98 @ =gBattleMons
	ldr r0, _08029A9C @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	bne _08029AA4
	ldr r3, _08029AA0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	b _08029C40
	.align 2, 0
_08029A8C: .4byte gBankAttacker
_08029A90: .4byte gEnemyParty
_08029A94: .4byte gPlayerParty
_08029A98: .4byte gBattleMons
_08029A9C: .4byte gBankTarget
_08029AA0: .4byte gBattlescriptCurrInstr
_08029AA4:
	ldr r6, _08029BE0 @ =gBattleCommunication
	ldrb r0, [r6]
	mov r8, r0
	cmp r0, 0x5
	bls _08029AB0
	b _08029C0C
_08029AB0:
	adds r4, r6, 0
	movs r5, 0x64
_08029AB4:
	ldrb r0, [r4]
	muls r0, r5
	adds r0, r7, r0
	movs r1, 0x39
	bl GetMonData
	cmp r0, 0
	beq _08029AF8
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r7, r0
	movs r1, 0x41
	bl GetMonData
	cmp r0, 0
	beq _08029AF8
	ldrb r0, [r4]
	muls r0, r5
	adds r0, r7, r0
	movs r1, 0x41
	bl GetMonData
	movs r1, 0xCE
	lsls r1, 1
	cmp r0, r1
	beq _08029AF8
	ldrb r0, [r4]
	muls r0, r5
	adds r0, r7, r0
	movs r1, 0x37
	bl GetMonData
	cmp r0, 0
	beq _08029B08
_08029AF8:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	adds r6, r4, 0
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x5
	bls _08029AB4
_08029B08:
	ldr r1, _08029BE0 @ =gBattleCommunication
	mov r9, r1
	ldrb r2, [r1]
	cmp r2, 0x5
	bhi _08029C0C
	ldr r1, _08029BE4 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x4
	strb r0, [r1, 0x1]
	ldr r6, _08029BE8 @ =gBankAttacker
	ldrb r0, [r6]
	strb r0, [r1, 0x2]
	strb r2, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _08029BEC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x9
	str r0, [r1]
	ldr r2, _08029BF0 @ =gBattleMoveDamage
	mov r8, r2
	ldr r5, _08029BF4 @ =gBaseStats
	mov r1, r9
	ldrb r0, [r1]
	movs r4, 0x64
	muls r0, r4
	adds r0, r7, r0
	movs r1, 0xB
	bl GetMonData
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	adds r1, r5
	ldrb r3, [r1, 0x1]
	mov r2, r8
	str r3, [r2]
	ldr r2, _08029BF8 @ =gBattleMoves
	ldr r0, _08029BFC @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0, 0x1]
	muls r0, r3
	mov r1, r8
	str r0, [r1]
	mov r2, r9
	ldrb r0, [r2]
	muls r0, r4
	adds r0, r7, r0
	movs r1, 0x38
	bl GetMonData
	lsls r0, 1
	movs r1, 0x5
	bl __udivsi3
	adds r0, 0x2
	mov r2, r8
	ldr r1, [r2]
	muls r0, r1
	str r0, [r2]
	ldr r3, _08029C00 @ =gBattleMons
	ldr r1, _08029C04 @ =gBankTarget
	ldrb r2, [r1]
	movs r1, 0x58
	muls r1, r2
	adds r1, r3
	ldrh r2, [r1]
	lsls r1, r2, 3
	subs r1, r2
	lsls r1, 2
	adds r1, r5
	ldrb r1, [r1, 0x2]
	bl __divsi3
	mov r1, r8
	str r0, [r1]
	movs r1, 0x32
	bl __divsi3
	adds r2, r0, 0x2
	mov r0, r8
	str r2, [r0]
	ldr r1, _08029C08 @ =gProtectStructs
	ldrb r0, [r6]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 28
	cmp r0, 0
	bge _08029BD4
	lsls r0, r2, 4
	subs r0, r2
	movs r1, 0xA
	bl __divsi3
	mov r1, r8
	str r0, [r1]
_08029BD4:
	mov r2, r9
	ldrb r0, [r2]
	adds r0, 0x1
	strb r0, [r2]
	b _08029C46
	.align 2, 0
_08029BE0: .4byte gBattleCommunication
_08029BE4: .4byte gBattleTextBuff1
_08029BE8: .4byte gBankAttacker
_08029BEC: .4byte gBattlescriptCurrInstr
_08029BF0: .4byte gBattleMoveDamage
_08029BF4: .4byte gBaseStats
_08029BF8: .4byte gBattleMoves
_08029BFC: .4byte gCurrentMove
_08029C00: .4byte gBattleMons
_08029C04: .4byte gBankTarget
_08029C08: .4byte gProtectStructs
_08029C0C:
	mov r0, r8
	cmp r0, 0
	beq _08029C2C
	ldr r3, _08029C28 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	b _08029C40
	.align 2, 0
_08029C28: .4byte gBattlescriptCurrInstr
_08029C2C:
	ldr r3, _08029C54 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x5]
	ldrb r0, [r2, 0x6]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x7]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x8]
_08029C40:
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_08029C46:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_08029C54: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC4_802B910

	thumb_func_start atkC5_hidepreattack
atkC5_hidepreattack: @ 8029C58
	push {lr}
	ldr r0, _08029C6C @ =gCurrentMove
	ldrh r1, [r0]
	cmp r1, 0x5B
	beq _08029C98
	cmp r1, 0x5B
	bgt _08029C70
	cmp r1, 0x13
	beq _08029C7C
	b _08029CC4
	.align 2, 0
_08029C6C: .4byte gCurrentMove
_08029C70:
	ldr r0, _08029C8C @ =0x00000123
	cmp r1, r0
	beq _08029CB0
	adds r0, 0x31
	cmp r1, r0
	bne _08029CC4
_08029C7C:
	ldr r2, _08029C90 @ =gStatuses3
	ldr r0, _08029C94 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x40
	b _08029CC0
	.align 2, 0
_08029C8C: .4byte 0x00000123
_08029C90: .4byte gStatuses3
_08029C94: .4byte gBankAttacker
_08029C98:
	ldr r2, _08029CA8 @ =gStatuses3
	ldr r0, _08029CAC @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x80
	b _08029CC0
	.align 2, 0
_08029CA8: .4byte gStatuses3
_08029CAC: .4byte gBankAttacker
_08029CB0:
	ldr r2, _08029CD0 @ =gStatuses3
	ldr r0, _08029CD4 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x80
	lsls r2, 11
_08029CC0:
	orrs r0, r2
	str r0, [r1]
_08029CC4:
	ldr r1, _08029CD8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08029CD0: .4byte gStatuses3
_08029CD4: .4byte gBankAttacker
_08029CD8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC5_hidepreattack

	thumb_func_start atkC6_unhidepostattack
atkC6_unhidepostattack: @ 8029CDC
	push {lr}
	ldr r0, _08029CF0 @ =gCurrentMove
	ldrh r1, [r0]
	cmp r1, 0x5B
	beq _08029D20
	cmp r1, 0x5B
	bgt _08029CF4
	cmp r1, 0x13
	beq _08029D00
	b _08029D4E
	.align 2, 0
_08029CF0: .4byte gCurrentMove
_08029CF4:
	ldr r0, _08029D14 @ =0x00000123
	cmp r1, r0
	beq _08029D3C
	adds r0, 0x31
	cmp r1, r0
	bne _08029D4E
_08029D00:
	ldr r2, _08029D18 @ =gStatuses3
	ldr r0, _08029D1C @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x41
	negs r2, r2
	b _08029D4A
	.align 2, 0
_08029D14: .4byte 0x00000123
_08029D18: .4byte gStatuses3
_08029D1C: .4byte gBankAttacker
_08029D20:
	ldr r2, _08029D34 @ =gStatuses3
	ldr r0, _08029D38 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x81
	negs r2, r2
	b _08029D4A
	.align 2, 0
_08029D34: .4byte gStatuses3
_08029D38: .4byte gBankAttacker
_08029D3C:
	ldr r2, _08029D5C @ =gStatuses3
	ldr r0, _08029D60 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	ldr r2, _08029D64 @ =0xfffbffff
_08029D4A:
	ands r0, r2
	str r0, [r1]
_08029D4E:
	ldr r1, _08029D68 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08029D5C: .4byte gStatuses3
_08029D60: .4byte gBankAttacker
_08029D64: .4byte 0xfffbffff
_08029D68: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC6_unhidepostattack

	thumb_func_start atkC7_setminimize
atkC7_setminimize: @ 8029D6C
	push {lr}
	ldr r0, _08029D9C @ =gHitMarker
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 18
	ands r0, r1
	cmp r0, 0
	beq _08029D90
	ldr r2, _08029DA0 @ =gStatuses3
	ldr r0, _08029DA4 @ =gBankAttacker
	ldrb r1, [r0]
	lsls r1, 2
	adds r1, r2
	ldr r0, [r1]
	movs r2, 0x80
	lsls r2, 1
	orrs r0, r2
	str r0, [r1]
_08029D90:
	ldr r1, _08029DA8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08029D9C: .4byte gHitMarker
_08029DA0: .4byte gStatuses3
_08029DA4: .4byte gBankAttacker
_08029DA8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC7_setminimize

	thumb_func_start sub_8029DAC
sub_8029DAC: @ 8029DAC
	push {lr}
	ldr r3, _08029DD0 @ =gBattleWeather
	ldrh r1, [r3]
	movs r2, 0x80
	adds r0, r2, 0
	ands r0, r1
	cmp r0, 0
	beq _08029DDC
	ldr r2, _08029DD4 @ =gBattleMoveFlags
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _08029DD8 @ =gBattleCommunication
	movs r0, 0x2
	strb r0, [r1, 0x5]
	b _08029DEA
	.align 2, 0
_08029DD0: .4byte gBattleWeather
_08029DD4: .4byte gBattleMoveFlags
_08029DD8: .4byte gBattleCommunication
_08029DDC:
	strh r2, [r3]
	ldr r0, _08029DF8 @ =gBattleCommunication
	movs r1, 0x5
	strb r1, [r0, 0x5]
	ldr r0, _08029DFC @ =gWishFutureKnock
	adds r0, 0x28
	strb r1, [r0]
_08029DEA:
	ldr r1, _08029E00 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_08029DF8: .4byte gBattleCommunication
_08029DFC: .4byte gWishFutureKnock
_08029E00: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_8029DAC

	thumb_func_start atkC9_jumpifattackandspecialattackcannotfall
atkC9_jumpifattackandspecialattackcannotfall: @ 8029E04
	push {r4,lr}
	ldr r2, _08029E48 @ =gBattleMons
	ldr r0, _08029E4C @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r1, r0, r2
	movs r0, 0x19
	ldrsb r0, [r1, r0]
	adds r3, r2, 0
	cmp r0, 0
	bne _08029E58
	movs r0, 0x1C
	ldrsb r0, [r1, r0]
	cmp r0, 0
	bne _08029E58
	ldr r0, _08029E50 @ =gBattleCommunication
	ldrb r0, [r0, 0x6]
	cmp r0, 0x1
	beq _08029E58
	ldr r3, _08029E54 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _08029E84
	.align 2, 0
_08029E48: .4byte gBattleMons
_08029E4C: .4byte gBankTarget
_08029E50: .4byte gBattleCommunication
_08029E54: .4byte gBattlescriptCurrInstr
_08029E58:
	ldr r4, _08029E8C @ =gActiveBank
	ldr r0, _08029E90 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r4]
	ldr r2, _08029E94 @ =gBattleMoveDamage
	ldrb r1, [r4]
	movs r0, 0x58
	muls r0, r1
	adds r0, r3
	ldrh r0, [r0, 0x28]
	str r0, [r2]
	ldr r1, _08029E98 @ =0x00007fff
	movs r0, 0
	bl EmitHealthBarUpdate
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _08029E9C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_08029E84:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08029E8C: .4byte gActiveBank
_08029E90: .4byte gBankAttacker
_08029E94: .4byte gBattleMoveDamage
_08029E98: .4byte 0x00007fff
_08029E9C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkC9_jumpifattackandspecialattackcannotfall

	thumb_func_start atkCA_setforcedtarget
atkCA_setforcedtarget: @ 8029EA0
	push {r4,r5,lr}
	ldr r4, _08029EE0 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	ldr r5, _08029EE4 @ =gSideTimer
	lsls r0, 24
	lsrs r0, 24
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r5
	movs r0, 0x1
	strb r0, [r1, 0x8]
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r5
	ldrb r0, [r4]
	strb r0, [r1, 0x9]
	ldr r1, _08029EE8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_08029EE0: .4byte gBankAttacker
_08029EE4: .4byte gSideTimer
_08029EE8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCA_setforcedtarget

	thumb_func_start atkCB_setcharge
atkCB_setcharge: @ 8029EEC
	push {r4,lr}
	ldr r0, _08029F40 @ =gStatuses3
	ldr r3, _08029F44 @ =gBankAttacker
	ldrb r1, [r3]
	lsls r1, 2
	adds r1, r0
	ldr r0, [r1]
	movs r2, 0x80
	lsls r2, 2
	orrs r0, r2
	str r0, [r1]
	ldr r4, _08029F48 @ =gDisableStructs
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r2, [r0, 0x12]
	movs r1, 0x10
	negs r1, r1
	ands r1, r2
	movs r2, 0x2
	orrs r1, r2
	strb r1, [r0, 0x12]
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r2, [r0, 0x12]
	movs r1, 0xF
	ands r1, r2
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0, 0x12]
	ldr r1, _08029F4C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08029F40: .4byte gStatuses3
_08029F44: .4byte gBankAttacker
_08029F48: .4byte gDisableStructs
_08029F4C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCB_setcharge

	thumb_func_start atkCC_callterrainattack
atkCC_callterrainattack: @ 8029F50
	push {r4,lr}
	ldr r2, _08029FA0 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _08029FA4 @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r4, _08029FA8 @ =gCurrentMove
	ldr r1, _08029FAC @ =gNaturePowerMoves
	ldr r0, _08029FB0 @ =gBattleTerrain
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r1
	ldrh r0, [r0]
	strh r0, [r4]
	ldrh r0, [r4]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _08029FB4 @ =gBankTarget
	strb r0, [r1]
	ldr r3, _08029FB8 @ =gUnknown_081D6BBC
	ldr r2, _08029FBC @ =gBattleMoves
	ldrh r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	bl b_movescr_stack_push
	ldr r1, _08029FC0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_08029FA0: .4byte gHitMarker
_08029FA4: .4byte 0xfffffbff
_08029FA8: .4byte gCurrentMove
_08029FAC: .4byte gNaturePowerMoves
_08029FB0: .4byte gBattleTerrain
_08029FB4: .4byte gBankTarget
_08029FB8: .4byte gUnknown_081D6BBC
_08029FBC: .4byte gBattleMoves
_08029FC0: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCC_callterrainattack

	thumb_func_start atkCD_cureifburnedparalysedorpoisoned
atkCD_cureifburnedparalysedorpoisoned: @ 8029FC4
	push {r4-r6,lr}
	sub sp, 0x4
	ldr r1, _0802A010 @ =gBattleMons
	ldr r3, _0802A014 @ =gBankAttacker
	ldrb r0, [r3]
	movs r6, 0x58
	muls r0, r6
	adds r5, r1, 0
	adds r5, 0x4C
	adds r2, r0, r5
	ldr r0, [r2]
	movs r1, 0xD8
	ands r0, r1
	cmp r0, 0
	beq _0802A020
	movs r0, 0
	str r0, [r2]
	ldr r1, _0802A018 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	ldr r4, _0802A01C @ =gActiveBank
	ldrb r0, [r3]
	strb r0, [r4]
	ldrb r0, [r4]
	muls r0, r6
	adds r0, r5
	str r0, [sp]
	movs r0, 0
	movs r1, 0x28
	movs r2, 0
	movs r3, 0x4
	bl EmitSetAttributes
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	b _0802A03A
	.align 2, 0
_0802A010: .4byte gBattleMons
_0802A014: .4byte gBankAttacker
_0802A018: .4byte gBattlescriptCurrInstr
_0802A01C: .4byte gActiveBank
_0802A020:
	ldr r3, _0802A044 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A03A:
	add sp, 0x4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0802A044: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCD_cureifburnedparalysedorpoisoned

	thumb_func_start atkCE_settorment
atkCE_settorment: @ 802A048
	push {lr}
	ldr r1, _0802A080 @ =gBattleMons
	ldr r0, _0802A084 @ =gBankTarget
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r1, [r0]
	movs r2, 0x80
	lsls r2, 24
	cmp r1, 0
	bge _0802A08C
	ldr r3, _0802A088 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A098
	.align 2, 0
_0802A080: .4byte gBattleMons
_0802A084: .4byte gBankTarget
_0802A088: .4byte gBattlescriptCurrInstr
_0802A08C:
	orrs r1, r2
	str r1, [r0]
	ldr r1, _0802A09C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A098:
	pop {r0}
	bx r0
	.align 2, 0
_0802A09C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCE_settorment

	thumb_func_start atkCF_jumpifnodamage
atkCF_jumpifnodamage: @ 802A0A0
	push {lr}
	ldr r2, _0802A0CC @ =gProtectStructs
	ldr r0, _0802A0D0 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r1, r0, 4
	adds r0, r2, 0x4
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	bne _0802A0C0
	adds r0, r2, 0
	adds r0, 0x8
	adds r0, r1, r0
	ldr r0, [r0]
	cmp r0, 0
	beq _0802A0D8
_0802A0C0:
	ldr r1, _0802A0D4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802A0F2
	.align 2, 0
_0802A0CC: .4byte gProtectStructs
_0802A0D0: .4byte gBankAttacker
_0802A0D4: .4byte gBattlescriptCurrInstr
_0802A0D8:
	ldr r3, _0802A0F8 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A0F2:
	pop {r0}
	bx r0
	.align 2, 0
_0802A0F8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkCF_jumpifnodamage

	thumb_func_start atkD0_settaunt
atkD0_settaunt: @ 802A0FC
	push {r4,lr}
	ldr r4, _0802A140 @ =gDisableStructs
	ldr r3, _0802A144 @ =gBankTarget
	ldrb r0, [r3]
	lsls r1, r0, 3
	subs r1, r0
	lsls r1, 2
	adds r2, r1, r4
	ldrb r1, [r2, 0x13]
	lsls r0, r1, 28
	cmp r0, 0
	bne _0802A14C
	movs r0, 0x10
	negs r0, r0
	ands r0, r1
	movs r1, 0x2
	orrs r0, r1
	strb r0, [r2, 0x13]
	ldrb r1, [r3]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r4
	ldrb r2, [r0, 0x13]
	movs r1, 0xF
	ands r1, r2
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0, 0x13]
	ldr r1, _0802A148 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802A166
	.align 2, 0
_0802A140: .4byte gDisableStructs
_0802A144: .4byte gBankTarget
_0802A148: .4byte gBattlescriptCurrInstr
_0802A14C:
	ldr r3, _0802A16C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A166:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802A16C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkD0_settaunt

	thumb_func_start sub_802A170
sub_802A170: @ 802A170
	push {r4,lr}
	ldr r4, _0802A1D8 @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankIdentity
	movs r1, 0x2
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	ldr r3, _0802A1DC @ =gBankTarget
	strb r0, [r3]
	ldr r0, _0802A1E0 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0802A1F4
	ldr r0, _0802A1E4 @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _0802A1E8 @ =gBitTable
	ldrb r3, [r3]
	lsls r0, r3, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _0802A1F4
	ldr r1, _0802A1EC @ =gProtectStructs
	ldrb r0, [r4]
	lsls r0, 4
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 28
	cmp r0, 0
	blt _0802A1F4
	lsls r0, r3, 4
	adds r2, r0, r1
	ldrb r1, [r2]
	lsls r0, r1, 28
	cmp r0, 0
	blt _0802A1F4
	movs r0, 0x8
	orrs r0, r1
	strb r0, [r2]
	ldr r1, _0802A1F0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802A20E
	.align 2, 0
_0802A1D8: .4byte gBankAttacker
_0802A1DC: .4byte gBankTarget
_0802A1E0: .4byte gBattleTypeFlags
_0802A1E4: .4byte gAbsentBankFlags
_0802A1E8: .4byte gBitTable
_0802A1EC: .4byte gProtectStructs
_0802A1F0: .4byte gBattlescriptCurrInstr
_0802A1F4:
	ldr r3, _0802A214 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A20E:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802A214: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802A170

	thumb_func_start sub_802A218
sub_802A218: @ 802A218
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	ldr r0, _0802A30C @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x1
	bne _0802A24C
	ldr r0, _0802A310 @ =gBattleTypeFlags
	ldrh r1, [r0]
	ldr r0, _0802A314 @ =0x00000902
	ands r0, r1
	cmp r0, 0
	bne _0802A24C
	ldr r0, _0802A318 @ =gTrainerBattleOpponent
	ldrh r1, [r0]
	movs r0, 0x80
	lsls r0, 3
	cmp r1, r0
	bne _0802A2EE
_0802A24C:
	ldr r4, _0802A30C @ =gBankAttacker
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r0, _0802A310 @ =gBattleTypeFlags
	ldrh r1, [r0]
	ldr r0, _0802A314 @ =0x00000902
	ands r0, r1
	cmp r0, 0
	bne _0802A290
	ldr r0, _0802A318 @ =gTrainerBattleOpponent
	ldrh r1, [r0]
	movs r0, 0x80
	lsls r0, 3
	cmp r1, r0
	beq _0802A290
	ldr r0, _0802A31C @ =gWishFutureKnock
	adds r0, 0x29
	adds r0, r2, r0
	ldrb r1, [r0]
	ldr r3, _0802A320 @ =gBitTable
	ldr r2, _0802A324 @ =gBattlePartyID
	ldrb r0, [r4]
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	lsls r0, 2
	adds r0, r3
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _0802A2EE
_0802A290:
	ldr r0, _0802A328 @ =gBattleMons
	mov r9, r0
	ldr r1, _0802A30C @ =gBankAttacker
	ldrb r4, [r1]
	movs r2, 0x58
	mov r8, r2
	mov r0, r8
	muls r0, r4
	mov r3, r9
	adds r5, r0, r3
	ldrh r3, [r5, 0x2E]
	adds r1, r3, 0
	cmp r1, 0
	bne _0802A2BE
	ldr r0, _0802A32C @ =gBankTarget
	ldrb r0, [r0]
	mov r2, r8
	muls r2, r0
	adds r0, r2, 0
	add r0, r9
	ldrh r0, [r0, 0x2E]
	cmp r0, 0
	beq _0802A2EE
_0802A2BE:
	cmp r1, 0xAF
	beq _0802A2EE
	ldr r7, _0802A32C @ =gBankTarget
	ldrb r0, [r7]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	mov r1, r9
	adds r2, r0, r1
	ldrh r1, [r2, 0x2E]
	cmp r1, 0xAF
	beq _0802A2EE
	adds r0, r3, 0
	subs r0, 0x79
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0xB
	bls _0802A2EE
	adds r0, r1, 0
	subs r0, 0x79
	lsls r0, 16
	lsrs r0, 16
	cmp r0, 0xB
	bhi _0802A334
_0802A2EE:
	ldr r3, _0802A330 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A49A
	.align 2, 0
_0802A30C: .4byte gBankAttacker
_0802A310: .4byte gBattleTypeFlags
_0802A314: .4byte 0x00000902
_0802A318: .4byte gTrainerBattleOpponent
_0802A31C: .4byte gWishFutureKnock
_0802A320: .4byte gBitTable
_0802A324: .4byte gBattlePartyID
_0802A328: .4byte gBattleMons
_0802A32C: .4byte gBankTarget
_0802A330: .4byte gBattlescriptCurrInstr
_0802A334:
	adds r0, r2, 0
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x3C
	bne _0802A36C
	ldr r1, _0802A360 @ =gBattlescriptCurrInstr
	ldr r0, _0802A364 @ =BattleScript_NoItemSteal
	str r0, [r1]
	ldr r1, _0802A368 @ =gLastUsedAbility
	ldrb r0, [r7]
	mov r2, r8
	muls r2, r0
	adds r0, r2, 0
	add r0, r9
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r1]
	ldrb r0, [r7]
	ldrb r1, [r1]
	bl RecordAbilityBattle
	b _0802A49A
	.align 2, 0
_0802A360: .4byte gBattlescriptCurrInstr
_0802A364: .4byte BattleScript_NoItemSteal
_0802A368: .4byte gLastUsedAbility
_0802A36C:
	lsls r0, r4, 1
	ldr r4, _0802A458 @ =0x020160f0
	adds r6, r0, r4
	ldrh r5, [r5, 0x2E]
	mov r10, r5
	strh r1, [r6]
	ldr r3, _0802A45C @ =gBankAttacker
	ldrb r0, [r3]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	add r0, r9
	movs r1, 0
	strh r1, [r0, 0x2E]
	ldrb r0, [r7]
	mov r2, r8
	muls r2, r0
	adds r0, r2, 0
	add r0, r9
	mov r3, r10
	strh r3, [r0, 0x2E]
	ldr r5, _0802A460 @ =gActiveBank
	ldr r1, _0802A45C @ =gBankAttacker
	ldrb r0, [r1]
	strb r0, [r5]
	str r6, [sp]
	movs r0, 0
	movs r1, 0x2
	movs r2, 0
	movs r3, 0x2
	bl EmitSetAttributes
	ldr r2, _0802A45C @ =gBankAttacker
	ldrb r0, [r2]
	bl MarkBufferBankForExecution
	ldrb r0, [r7]
	strb r0, [r5]
	ldrb r0, [r7]
	mov r3, r8
	muls r3, r0
	adds r0, r3, 0
	mov r1, r9
	adds r1, 0x2E
	adds r0, r1
	str r0, [sp]
	movs r0, 0
	movs r1, 0x2
	movs r2, 0
	movs r3, 0x2
	bl EmitSetAttributes
	ldrb r0, [r7]
	bl MarkBufferBankForExecution
	ldr r0, _0802A464 @ =0xfffe9f10
	adds r4, r0
	ldrb r0, [r7]
	lsls r0, 1
	ldr r2, _0802A468 @ =0x000160e8
	adds r0, r2
	adds r0, r4
	movs r1, 0
	strb r1, [r0]
	ldrb r0, [r7]
	lsls r0, 1
	ldr r1, _0802A46C @ =0x000160e9
	adds r0, r1
	adds r0, r4
	movs r3, 0
	strb r3, [r0]
	ldr r3, _0802A45C @ =gBankAttacker
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r2
	adds r0, r4
	movs r2, 0
	strb r2, [r0]
	ldrb r0, [r3]
	lsls r0, 1
	adds r0, r1
	adds r0, r4
	strb r2, [r0]
	ldr r1, _0802A470 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	ldr r1, _0802A474 @ =gBattleTextBuff1
	movs r3, 0xFD
	strb r3, [r1]
	movs r2, 0xA
	strb r2, [r1, 0x1]
	ldrh r0, [r6]
	strb r0, [r1, 0x2]
	ldrh r0, [r6]
	lsrs r0, 8
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _0802A478 @ =gBattleTextBuff2
	strb r3, [r1]
	strb r2, [r1, 0x1]
	mov r3, r10
	strb r3, [r1, 0x2]
	mov r2, r10
	lsrs r0, r2, 8
	strb r0, [r1, 0x3]
	movs r0, 0x1
	negs r0, r0
	strb r0, [r1, 0x4]
	cmp r2, 0
	beq _0802A480
	ldrh r0, [r6]
	cmp r0, 0
	beq _0802A494
	ldr r1, _0802A47C @ =gBattleCommunication
	movs r0, 0x2
	b _0802A498
	.align 2, 0
_0802A458: .4byte 0x020160f0
_0802A45C: .4byte gBankAttacker
_0802A460: .4byte gActiveBank
_0802A464: .4byte 0xfffe9f10
_0802A468: .4byte 0x000160e8
_0802A46C: .4byte 0x000160e9
_0802A470: .4byte gBattlescriptCurrInstr
_0802A474: .4byte gBattleTextBuff1
_0802A478: .4byte gBattleTextBuff2
_0802A47C: .4byte gBattleCommunication
_0802A480:
	ldrh r0, [r6]
	cmp r0, 0
	beq _0802A494
	ldr r0, _0802A490 @ =gBattleCommunication
	movs r3, 0
	strb r3, [r0, 0x5]
	b _0802A49A
	.align 2, 0
_0802A490: .4byte gBattleCommunication
_0802A494:
	ldr r1, _0802A4AC @ =gBattleCommunication
	movs r0, 0x1
_0802A498:
	strb r0, [r1, 0x5]
_0802A49A:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802A4AC: .4byte gBattleCommunication
	thumb_func_end sub_802A218

	thumb_func_start sub_802A4B0
sub_802A4B0: @ 802A4B0
	push {r4,lr}
	ldr r3, _0802A4F0 @ =gBattleMons
	ldr r4, _0802A4F4 @ =gBankTarget
	ldrb r0, [r4]
	movs r2, 0x58
	muls r0, r2
	adds r0, r3
	adds r0, 0x20
	ldrb r1, [r0]
	adds r0, r1, 0
	cmp r0, 0
	beq _0802A504
	cmp r0, 0x19
	beq _0802A504
	ldr r0, _0802A4F8 @ =gBankAttacker
	ldrb r0, [r0]
	muls r0, r2
	adds r0, r3
	adds r0, 0x20
	strb r1, [r0]
	ldr r1, _0802A4FC @ =gLastUsedAbility
	ldrb r0, [r4]
	muls r0, r2
	adds r0, r3
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r1]
	ldr r1, _0802A500 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802A51E
	.align 2, 0
_0802A4F0: .4byte gBattleMons
_0802A4F4: .4byte gBankTarget
_0802A4F8: .4byte gBankAttacker
_0802A4FC: .4byte gLastUsedAbility
_0802A500: .4byte gBattlescriptCurrInstr
_0802A504:
	ldr r3, _0802A524 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A51E:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802A524: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802A4B0

	thumb_func_start atkD4_802C408
atkD4_802C408: @ 802A528
	push {r4-r7,lr}
	ldr r7, _0802A53C @ =gBattlescriptCurrInstr
	ldr r2, [r7]
	ldrb r3, [r2, 0x1]
	cmp r3, 0
	beq _0802A540
	cmp r3, 0x1
	beq _0802A578
	b _0802A5F4
	.align 2, 0
_0802A53C: .4byte gBattlescriptCurrInstr
_0802A540:
	ldr r1, _0802A56C @ =gWishFutureKnock
	ldr r4, _0802A570 @ =gBankAttacker
	adds r0, r1, 0
	adds r0, 0x20
	ldrb r5, [r4]
	adds r3, r0, r5
	ldrb r0, [r3]
	cmp r0, 0
	bne _0802A5C4
	movs r0, 0x2
	strb r0, [r3]
	ldrb r0, [r4]
	adds r1, 0x24
	adds r1, r0, r1
	ldr r2, _0802A574 @ =gBattlePartyID
	lsls r0, 1
	adds r0, r2
	ldrh r0, [r0]
	strb r0, [r1]
	ldr r0, [r7]
	adds r0, 0x6
	b _0802A5F2
	.align 2, 0
_0802A56C: .4byte gWishFutureKnock
_0802A570: .4byte gBankAttacker
_0802A574: .4byte gBattlePartyID
_0802A578:
	ldr r1, _0802A5DC @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x4
	strb r0, [r1, 0x1]
	ldr r4, _0802A5E0 @ =gBankTarget
	ldrb r0, [r4]
	strb r0, [r1, 0x2]
	ldr r0, _0802A5E4 @ =gWishFutureKnock
	adds r0, 0x24
	ldrb r5, [r4]
	adds r0, r5
	ldrb r0, [r0]
	strb r0, [r1, 0x3]
	movs r0, 0xFF
	strb r0, [r1, 0x4]
	ldr r1, _0802A5E8 @ =gBattleMoveDamage
	ldr r6, _0802A5EC @ =gBattleMons
	ldrb r0, [r4]
	movs r5, 0x58
	muls r0, r5
	adds r0, r6
	ldrh r0, [r0, 0x2C]
	lsrs r0, 1
	str r0, [r1]
	cmp r0, 0
	bne _0802A5B0
	str r3, [r1]
_0802A5B0:
	ldr r0, [r1]
	negs r0, r0
	str r0, [r1]
	ldrb r0, [r4]
	muls r0, r5
	adds r0, r6
	ldrh r1, [r0, 0x28]
	ldrh r0, [r0, 0x2C]
	cmp r1, r0
	bne _0802A5F0
_0802A5C4:
	ldrb r1, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r1, r0
	str r1, [r7]
	b _0802A5F4
	.align 2, 0
_0802A5DC: .4byte gBattleTextBuff1
_0802A5E0: .4byte gBankTarget
_0802A5E4: .4byte gWishFutureKnock
_0802A5E8: .4byte gBattleMoveDamage
_0802A5EC: .4byte gBattleMons
_0802A5F0:
	adds r0, r2, 0x6
_0802A5F2:
	str r0, [r7]
_0802A5F4:
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end atkD4_802C408

	thumb_func_start sub_802A5FC
sub_802A5FC: @ 802A5FC
	push {lr}
	ldr r1, _0802A634 @ =gStatuses3
	ldr r0, _0802A638 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 2
	adds r2, r0, r1
	ldr r1, [r2]
	movs r3, 0x80
	lsls r3, 3
	adds r0, r1, 0
	ands r0, r3
	cmp r0, 0
	beq _0802A640
	ldr r3, _0802A63C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A64C
	.align 2, 0
_0802A634: .4byte gStatuses3
_0802A638: .4byte gBankAttacker
_0802A63C: .4byte gBattlescriptCurrInstr
_0802A640:
	orrs r1, r3
	str r1, [r2]
	ldr r1, _0802A650 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A64C:
	pop {r0}
	bx r0
	.align 2, 0
_0802A650: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802A5FC

	thumb_func_start atkD6_doubledamagedealtifdamaged
atkD6_doubledamagedealtifdamaged: @ 802A654
	push {lr}
	ldr r3, _0802A6A4 @ =gProtectStructs
	ldr r0, _0802A6A8 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r2, r0, 4
	adds r0, r3, 0x4
	adds r0, r2, r0
	ldr r0, [r0]
	cmp r0, 0
	beq _0802A674
	adds r0, r2, r3
	ldr r1, _0802A6AC @ =gBankTarget
	ldrb r0, [r0, 0xC]
	ldrb r1, [r1]
	cmp r0, r1
	beq _0802A68C
_0802A674:
	adds r0, r3, 0
	adds r0, 0x8
	adds r0, r2, r0
	ldr r0, [r0]
	cmp r0, 0
	beq _0802A696
	adds r0, r2, r3
	ldr r1, _0802A6AC @ =gBankTarget
	ldrb r0, [r0, 0xD]
	ldrb r1, [r1]
	cmp r0, r1
	bne _0802A696
_0802A68C:
	ldr r0, _0802A6B0 @ =0x02000000
	ldr r1, _0802A6B4 @ =0x0001601f
	adds r0, r1
	movs r1, 0x2
	strb r1, [r0]
_0802A696:
	ldr r1, _0802A6B8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_0802A6A4: .4byte gProtectStructs
_0802A6A8: .4byte gBankAttacker
_0802A6AC: .4byte gBankTarget
_0802A6B0: .4byte 0x02000000
_0802A6B4: .4byte 0x0001601f
_0802A6B8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkD6_doubledamagedealtifdamaged

	thumb_func_start sub_802A6BC
sub_802A6BC: @ 802A6BC
	push {r4,lr}
	ldr r1, _0802A700 @ =gStatuses3
	ldr r0, _0802A704 @ =gBankTarget
	ldrb r3, [r0]
	lsls r0, r3, 2
	adds r4, r0, r1
	ldr r2, [r4]
	movs r0, 0xC0
	lsls r0, 5
	ands r0, r2
	cmp r0, 0
	bne _0802A6E4
	ldr r1, _0802A708 @ =gBattleMons
	movs r0, 0x58
	muls r0, r3
	adds r1, 0x4C
	adds r0, r1
	ldrb r0, [r0]
	cmp r0, 0
	beq _0802A710
_0802A6E4:
	ldr r3, _0802A70C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A720
	.align 2, 0
_0802A700: .4byte gStatuses3
_0802A704: .4byte gBankTarget
_0802A708: .4byte gBattleMons
_0802A70C: .4byte gBattlescriptCurrInstr
_0802A710:
	movs r0, 0x80
	lsls r0, 5
	orrs r2, r0
	str r2, [r4]
	ldr r1, _0802A728 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A720:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802A728: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802A6BC

	thumb_func_start atkD8_setdamagetohealthdifference
atkD8_setdamagetohealthdifference: @ 802A72C
	push {lr}
	ldr r2, _0802A768 @ =gBattleMons
	ldr r0, _0802A76C @ =gBankTarget
	ldrb r0, [r0]
	movs r1, 0x58
	muls r0, r1
	adds r3, r0, r2
	ldr r0, _0802A770 @ =gBankAttacker
	ldrb r0, [r0]
	muls r0, r1
	adds r1, r0, r2
	ldrh r0, [r3, 0x28]
	ldrh r2, [r1, 0x28]
	cmp r0, r2
	bhi _0802A778
	ldr r3, _0802A774 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A78A
	.align 2, 0
_0802A768: .4byte gBattleMons
_0802A76C: .4byte gBankTarget
_0802A770: .4byte gBankAttacker
_0802A774: .4byte gBattlescriptCurrInstr
_0802A778:
	ldr r2, _0802A790 @ =gBattleMoveDamage
	ldrh r0, [r3, 0x28]
	ldrh r1, [r1, 0x28]
	subs r0, r1
	str r0, [r2]
	ldr r1, _0802A794 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A78A:
	pop {r0}
	bx r0
	.align 2, 0
_0802A790: .4byte gBattleMoveDamage
_0802A794: .4byte gBattlescriptCurrInstr
	thumb_func_end atkD8_setdamagetohealthdifference

	thumb_func_start atkD9_scaledamagebyhealthratio
atkD9_scaledamagebyhealthratio: @ 802A798
	push {r4,lr}
	ldr r4, _0802A7E4 @ =gDynamicBasePower
	ldrh r0, [r4]
	cmp r0, 0
	bne _0802A7D4
	ldr r2, _0802A7E8 @ =gBattleMoves
	ldr r0, _0802A7EC @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r3, [r0, 0x1]
	ldr r2, _0802A7F0 @ =gBattleMons
	ldr r0, _0802A7F4 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r1, r0
	adds r1, r2
	ldrh r0, [r1, 0x28]
	muls r0, r3
	ldrh r1, [r1, 0x2C]
	bl __divsi3
	strh r0, [r4]
	lsls r0, 16
	cmp r0, 0
	bne _0802A7D4
	movs r0, 0x1
	strh r0, [r4]
_0802A7D4:
	ldr r1, _0802A7F8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802A7E4: .4byte gDynamicBasePower
_0802A7E8: .4byte gBattleMoves
_0802A7EC: .4byte gCurrentMove
_0802A7F0: .4byte gBattleMons
_0802A7F4: .4byte gBankAttacker
_0802A7F8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkD9_scaledamagebyhealthratio

	thumb_func_start atkDA_abilityswap
atkDA_abilityswap: @ 802A7FC
	push {r4-r6,lr}
	ldr r5, _0802A860 @ =gBattleMons
	ldr r0, _0802A864 @ =gBankAttacker
	ldrb r0, [r0]
	movs r4, 0x58
	muls r0, r4
	adds r0, r5
	adds r2, r0, 0
	adds r2, 0x20
	ldrb r1, [r2]
	cmp r1, 0
	bne _0802A824
	ldr r0, _0802A868 @ =gBankTarget
	ldrb r0, [r0]
	muls r0, r4
	adds r0, r5
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0
	beq _0802A844
_0802A824:
	cmp r1, 0x19
	beq _0802A844
	ldr r6, _0802A868 @ =gBankTarget
	ldrb r0, [r6]
	muls r0, r4
	adds r0, r5
	adds r0, 0x20
	ldrb r3, [r0]
	cmp r3, 0x19
	beq _0802A844
	ldr r0, _0802A86C @ =gBattleMoveFlags
	ldrb r1, [r0]
	movs r0, 0x29
	ands r0, r1
	cmp r0, 0
	beq _0802A874
_0802A844:
	ldr r3, _0802A870 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A88A
	.align 2, 0
_0802A860: .4byte gBattleMons
_0802A864: .4byte gBankAttacker
_0802A868: .4byte gBankTarget
_0802A86C: .4byte gBattleMoveFlags
_0802A870: .4byte gBattlescriptCurrInstr
_0802A874:
	ldrb r1, [r2]
	strb r3, [r2]
	ldrb r0, [r6]
	muls r0, r4
	adds r0, r5
	adds r0, 0x20
	strb r1, [r0]
	ldr r1, _0802A890 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A88A:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0802A890: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDA_abilityswap

	thumb_func_start atkDB_imprisoneffect
atkDB_imprisoneffect: @ 802A894
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	movs r0, 0
	mov r8, r0
	ldr r1, _0802A8B8 @ =gStatuses3
	ldr r0, _0802A8BC @ =gBankAttacker
	ldrb r2, [r0]
	lsls r0, r2, 2
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 6
	ands r0, r1
	cmp r0, 0
	beq _0802A8E8
	b _0802A95E
	.align 2, 0
_0802A8B8: .4byte gStatuses3
_0802A8BC: .4byte gBankAttacker
_0802A8C0:
	ldr r0, _0802A8E0 @ =gStatuses3
	mov r2, r9
	ldrb r1, [r2]
	lsls r1, 2
	adds r1, r0
	ldr r0, [r1]
	movs r2, 0x80
	lsls r2, 6
	orrs r0, r2
	str r0, [r1]
	ldr r1, _0802A8E4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802A956
	.align 2, 0
_0802A8E0: .4byte gStatuses3
_0802A8E4: .4byte gBattlescriptCurrInstr
_0802A8E8:
	adds r0, r2, 0
	bl sub_801529C
	movs r6, 0
	b _0802A94E
_0802A8F2:
	adds r0, r6, 0
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	cmp r8, r0
	beq _0802A948
	movs r4, 0
	ldr r7, _0802A984 @ =gBankAttacker
	mov r9, r7
	ldr r0, _0802A988 @ =gBattleMons
	mov r12, r0
	mov r1, r9
	ldrb r0, [r1]
	mov r2, r12
	adds r2, 0xC
	movs r1, 0x58
	muls r0, r1
	adds r3, r0, r2
	adds r5, r6, 0
	muls r5, r1
_0802A91C:
	movs r2, 0
	ldrh r1, [r3]
	mov r0, r12
	adds r0, 0xC
	adds r0, r5, r0
_0802A926:
	ldrh r7, [r0]
	cmp r1, r7
	bne _0802A930
	cmp r1, 0
	bne _0802A938
_0802A930:
	adds r0, 0x2
	adds r2, 0x1
	cmp r2, 0x3
	ble _0802A926
_0802A938:
	cmp r2, 0x4
	bne _0802A944
	adds r3, 0x2
	adds r4, 0x1
	cmp r4, 0x3
	ble _0802A91C
_0802A944:
	cmp r4, 0x4
	bne _0802A8C0
_0802A948:
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
_0802A94E:
	ldr r0, _0802A98C @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r6, r0
	bcc _0802A8F2
_0802A956:
	ldr r0, _0802A98C @ =gNoOfAllBanks
	ldrb r0, [r0]
	cmp r6, r0
	bne _0802A978
_0802A95E:
	ldr r3, _0802A990 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802A978:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802A984: .4byte gBankAttacker
_0802A988: .4byte gBattleMons
_0802A98C: .4byte gNoOfAllBanks
_0802A990: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDB_imprisoneffect

	thumb_func_start atkDC_setgrudge
atkDC_setgrudge: @ 802A994
	push {lr}
	ldr r1, _0802A9CC @ =gStatuses3
	ldr r0, _0802A9D0 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 2
	adds r2, r0, r1
	ldr r1, [r2]
	movs r3, 0x80
	lsls r3, 7
	adds r0, r1, 0
	ands r0, r3
	cmp r0, 0
	beq _0802A9D8
	ldr r3, _0802A9D4 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802A9E4
	.align 2, 0
_0802A9CC: .4byte gStatuses3
_0802A9D0: .4byte gBankAttacker
_0802A9D4: .4byte gBattlescriptCurrInstr
_0802A9D8:
	orrs r1, r3
	str r1, [r2]
	ldr r1, _0802A9E8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802A9E4:
	pop {r0}
	bx r0
	.align 2, 0
_0802A9E8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDC_setgrudge

	thumb_func_start atkDD_weightdamagecalculation
atkDD_weightdamagecalculation: @ 802A9EC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	movs r5, 0
	ldr r2, _0802AA50 @ =gWeightDamage
	ldrh r0, [r2]
	ldr r1, _0802AA54 @ =0x0000ffff
	cmp r0, r1
	beq _0802AA64
	adds r6, r2, 0
	ldr r0, _0802AA58 @ =gBattleMons
	mov r8, r0
	adds r7, r1, 0
	adds r4, r6, 0
_0802AA08:
	ldr r0, _0802AA5C @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	add r0, r8
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x1
	bl GetPokedexHeightWeight
	ldrh r1, [r4]
	lsls r0, 16
	lsrs r0, 16
	cmp r1, r0
	bhi _0802AA36
	adds r4, 0x4
	adds r5, 0x2
	ldrh r0, [r4]
	cmp r0, r7
	bne _0802AA08
_0802AA36:
	lsls r0, r5, 1
	adds r0, r6
	ldrh r1, [r0]
	ldr r0, _0802AA54 @ =0x0000ffff
	cmp r1, r0
	beq _0802AA64
	ldr r0, _0802AA60 @ =gDynamicBasePower
	adds r1, r5, 0x1
	lsls r1, 1
	adds r1, r6
	ldrh r1, [r1]
	strh r1, [r0]
	b _0802AA6A
	.align 2, 0
_0802AA50: .4byte gWeightDamage
_0802AA54: .4byte 0x0000ffff
_0802AA58: .4byte gBattleMons
_0802AA5C: .4byte gBankTarget
_0802AA60: .4byte gDynamicBasePower
_0802AA64:
	ldr r1, _0802AA7C @ =gDynamicBasePower
	movs r0, 0x78
	strh r0, [r1]
_0802AA6A:
	ldr r1, _0802AA80 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802AA7C: .4byte gDynamicBasePower
_0802AA80: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDD_weightdamagecalculation

	thumb_func_start atkDE_asistattackselect
atkDE_asistattackselect: @ 802AA84
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x8
	movs r0, 0
	mov r10, r0
	ldr r0, _0802AB9C @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankIdentity
	movs r1, 0x1
	ands r1, r0
	ldr r0, _0802ABA0 @ =gPlayerParty
	str r0, [sp]
	cmp r1, 0
	beq _0802AAAC
	ldr r1, _0802ABA4 @ =gEnemyParty
	str r1, [sp]
_0802AAAC:
	movs r2, 0
_0802AAAE:
	ldr r1, _0802ABA8 @ =gBattlePartyID
	ldr r0, _0802AB9C @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r1
	adds r1, r2, 0x1
	str r1, [sp, 0x4]
	ldrh r0, [r0]
	cmp r2, r0
	beq _0802AB54
	movs r0, 0x64
	adds r6, r2, 0
	muls r6, r0
	ldr r0, [sp]
	adds r4, r0, r6
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	cmp r0, 0
	beq _0802AB54
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	movs r1, 0xCE
	lsls r1, 1
	cmp r0, r1
	beq _0802AB54
	movs r5, 0
	ldr r1, _0802ABAC @ =0x0000ffff
	mov r8, r1
	mov r9, r6
	mov r1, r10
	lsls r0, r1, 1
	ldr r1, _0802ABB0 @ =0x02016024
	adds r6, r0, r1
_0802AAF8:
	movs r7, 0
	adds r1, r5, 0
	adds r1, 0xD
	ldr r0, [sp]
	add r0, r9
	bl GetMonData
	lsls r0, 16
	lsrs r4, r0, 16
	adds r0, r4, 0
	bl sub_802838C
	lsls r0, 24
	adds r1, r5, 0x1
	cmp r0, 0
	bne _0802AB4E
	ldr r0, _0802ABB4 @ =gUnknown_081FACFE
	ldrh r2, [r0]
	adds r3, r0, 0
	cmp r2, r8
	beq _0802AB42
	cmp r4, r2
	beq _0802AB38
	ldr r5, _0802ABAC @ =0x0000ffff
	adds r2, r3, 0
_0802AB2A:
	adds r2, 0x2
	adds r7, 0x1
	ldrh r0, [r2]
	cmp r0, r5
	beq _0802AB42
	cmp r4, r0
	bne _0802AB2A
_0802AB38:
	lsls r0, r7, 1
	adds r0, r3
	ldrh r0, [r0]
	cmp r0, r8
	bne _0802AB4E
_0802AB42:
	cmp r4, 0
	beq _0802AB4E
	strh r4, [r6]
	adds r6, 0x2
	movs r0, 0x1
	add r10, r0
_0802AB4E:
	adds r5, r1, 0
	cmp r5, 0x3
	ble _0802AAF8
_0802AB54:
	ldr r2, [sp, 0x4]
	cmp r2, 0x5
	ble _0802AAAE
	mov r1, r10
	cmp r1, 0
	beq _0802ABCC
	ldr r2, _0802ABB8 @ =gHitMarker
	ldr r0, [r2]
	ldr r1, _0802ABBC @ =0xfffffbff
	ands r0, r1
	str r0, [r2]
	ldr r4, _0802ABC0 @ =gUnknown_02024BEA
	bl Random
	movs r1, 0xFF
	ands r1, r0
	mov r0, r10
	muls r0, r1
	asrs r0, 8
	lsls r0, 1
	ldr r1, _0802ABB0 @ =0x02016024
	adds r0, r1
	ldrh r0, [r0]
	strh r0, [r4]
	ldrh r0, [r4]
	movs r1, 0
	bl sub_801B5C0
	ldr r1, _0802ABC4 @ =gBankTarget
	strb r0, [r1]
	ldr r1, _0802ABC8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802ABE6
	.align 2, 0
_0802AB9C: .4byte gBankAttacker
_0802ABA0: .4byte gPlayerParty
_0802ABA4: .4byte gEnemyParty
_0802ABA8: .4byte gBattlePartyID
_0802ABAC: .4byte 0x0000ffff
_0802ABB0: .4byte 0x02016024
_0802ABB4: .4byte gUnknown_081FACFE
_0802ABB8: .4byte gHitMarker
_0802ABBC: .4byte 0xfffffbff
_0802ABC0: .4byte gUnknown_02024BEA
_0802ABC4: .4byte gBankTarget
_0802ABC8: .4byte gBattlescriptCurrInstr
_0802ABCC:
	ldr r3, _0802ABF8 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802ABE6:
	add sp, 0x8
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802ABF8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDE_asistattackselect

	thumb_func_start atkDF_setmagiccoat
atkDF_setmagiccoat: @ 802ABFC
	push {lr}
	ldr r1, _0802AC44 @ =gBankTarget
	ldr r3, _0802AC48 @ =gBankAttacker
	ldrb r0, [r3]
	strb r0, [r1]
	ldr r2, _0802AC4C @ =gSpecialStatuses
	ldrb r1, [r3]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r0, _0802AC50 @ =gCurrentMoveTurn
	ldrb r1, [r0]
	ldr r0, _0802AC54 @ =gNoOfAllBanks
	ldrb r0, [r0]
	subs r0, 0x1
	cmp r1, r0
	bne _0802AC5C
	ldr r3, _0802AC58 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802AC74
	.align 2, 0
_0802AC44: .4byte gBankTarget
_0802AC48: .4byte gBankAttacker
_0802AC4C: .4byte gSpecialStatuses
_0802AC50: .4byte gCurrentMoveTurn
_0802AC54: .4byte gNoOfAllBanks
_0802AC58: .4byte gBattlescriptCurrInstr
_0802AC5C:
	ldr r0, _0802AC78 @ =gProtectStructs
	ldrb r1, [r3]
	lsls r1, 4
	adds r1, r0
	ldrb r0, [r1]
	movs r2, 0x10
	orrs r0, r2
	strb r0, [r1]
	ldr r1, _0802AC7C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802AC74:
	pop {r0}
	bx r0
	.align 2, 0
_0802AC78: .4byte gProtectStructs
_0802AC7C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkDF_setmagiccoat

	thumb_func_start atkE0_setstealstatchange
atkE0_setstealstatchange: @ 802AC80
	push {lr}
	ldr r2, _0802ACC4 @ =gSpecialStatuses
	ldr r3, _0802ACC8 @ =gBankAttacker
	ldrb r1, [r3]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r1, [r0]
	movs r2, 0x20
	orrs r1, r2
	strb r1, [r0]
	ldr r0, _0802ACCC @ =gCurrentMoveTurn
	ldrb r1, [r0]
	ldr r0, _0802ACD0 @ =gNoOfAllBanks
	ldrb r0, [r0]
	subs r0, 0x1
	cmp r1, r0
	bne _0802ACD8
	ldr r3, _0802ACD4 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802ACEE
	.align 2, 0
_0802ACC4: .4byte gSpecialStatuses
_0802ACC8: .4byte gBankAttacker
_0802ACCC: .4byte gCurrentMoveTurn
_0802ACD0: .4byte gNoOfAllBanks
_0802ACD4: .4byte gBattlescriptCurrInstr
_0802ACD8:
	ldr r0, _0802ACF4 @ =gProtectStructs
	ldrb r1, [r3]
	lsls r1, 4
	adds r1, r0
	ldrb r0, [r1]
	orrs r0, r2
	strb r0, [r1]
	ldr r1, _0802ACF8 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802ACEE:
	pop {r0}
	bx r0
	.align 2, 0
_0802ACF4: .4byte gProtectStructs
_0802ACF8: .4byte gBattlescriptCurrInstr
	thumb_func_end atkE0_setstealstatchange

	thumb_func_start atkE1_802CBE4
atkE1_802CBE4: @ 802ACFC
	push {r4-r6,lr}
	ldr r4, _0802ADA0 @ =0x02000000
	ldr r1, _0802ADA4 @ =0x000160dd
	adds r0, r4, r1
	ldrb r0, [r0]
	subs r1, 0xDA
	adds r4, r1
	strb r0, [r4]
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r2, _0802ADA8 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r2]
	movs r0, 0x9
	strb r0, [r2, 0x1]
	ldr r3, _0802ADAC @ =gBattleMons
	ldrb r1, [r4]
	movs r0, 0x58
	muls r0, r1
	adds r0, r3
	adds r0, 0x20
	ldrb r0, [r0]
	strb r0, [r2, 0x2]
	movs r0, 0xFF
	strb r0, [r2, 0x3]
	ldr r2, _0802ADB0 @ =gBankTarget
	ldr r1, _0802ADB4 @ =gNoOfAllBanks
	ldrb r0, [r2]
	ldrb r1, [r1]
	cmp r0, r1
	bcs _0802AD84
	adds r4, r2, 0
	ldr r6, _0802ADB8 @ =gBitTable
_0802AD44:
	ldrb r0, [r4]
	bl GetBankSide
	lsls r0, 24
	lsrs r0, 24
	cmp r0, r5
	beq _0802AD66
	ldr r0, _0802ADBC @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldrb r0, [r4]
	lsls r0, 2
	adds r0, r6
	ldr r0, [r0]
	ands r1, r0
	ldr r2, _0802ADB4 @ =gNoOfAllBanks
	cmp r1, 0
	beq _0802AD7A
_0802AD66:
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
	ldr r1, _0802ADB4 @ =gNoOfAllBanks
	lsls r0, 24
	lsrs r0, 24
	adds r2, r1, 0
	ldrb r1, [r2]
	cmp r0, r1
	bcc _0802AD44
_0802AD7A:
	ldr r0, _0802ADB0 @ =gBankTarget
	ldrb r0, [r0]
	ldrb r2, [r2]
	cmp r0, r2
	bcc _0802ADC4
_0802AD84:
	ldr r3, _0802ADC0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802ADCC
	.align 2, 0
_0802ADA0: .4byte 0x02000000
_0802ADA4: .4byte 0x000160dd
_0802ADA8: .4byte gBattleTextBuff1
_0802ADAC: .4byte gBattleMons
_0802ADB0: .4byte gBankTarget
_0802ADB4: .4byte gNoOfAllBanks
_0802ADB8: .4byte gBitTable
_0802ADBC: .4byte gAbsentBankFlags
_0802ADC0: .4byte gBattlescriptCurrInstr
_0802ADC4:
	ldr r1, _0802ADD4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802ADCC:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0802ADD4: .4byte gBattlescriptCurrInstr
	thumb_func_end atkE1_802CBE4

	thumb_func_start sub_802ADD8
sub_802ADD8: @ 802ADD8
	push {r4-r7,lr}
	sub sp, 0x4
	ldr r6, _0802AE44 @ =gBattlescriptCurrInstr
	ldr r0, [r6]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r5, _0802AE48 @ =gActiveBank
	strb r0, [r5]
	ldr r4, _0802AE4C @ =gBattleMons
	ldrb r0, [r5]
	movs r1, 0x58
	mov r12, r1
	mov r1, r12
	muls r1, r0
	adds r0, r1, r4
	adds r0, 0x20
	ldrb r0, [r0]
	cmp r0, 0x1E
	bne _0802AE34
	adds r4, 0x4C
	adds r1, r4
	movs r0, 0
	str r0, [r1]
	ldr r2, _0802AE50 @ =gBitTable
	ldr r1, _0802AE54 @ =0x02000000
	ldrb r3, [r5]
	ldr r7, _0802AE58 @ =0x00016064
	adds r0, r3, r7
	adds r0, r1
	ldrb r0, [r0]
	lsls r0, 2
	adds r0, r2
	ldrb r2, [r0]
	mov r0, r12
	muls r0, r3
	adds r0, r4
	str r0, [sp]
	movs r0, 0
	movs r1, 0x28
	movs r3, 0x4
	bl EmitSetAttributes
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
_0802AE34:
	ldr r0, [r6]
	adds r0, 0x2
	str r0, [r6]
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802AE44: .4byte gBattlescriptCurrInstr
_0802AE48: .4byte gActiveBank
_0802AE4C: .4byte gBattleMons
_0802AE50: .4byte gBitTable
_0802AE54: .4byte 0x02000000
_0802AE58: .4byte 0x00016064
	thumb_func_end sub_802ADD8

	thumb_func_start atkE3_jumpiffainted
atkE3_jumpiffainted: @ 802AE5C
	push {r4,lr}
	ldr r4, _0802AE98 @ =gBattlescriptCurrInstr
	ldr r0, [r4]
	ldrb r0, [r0, 0x1]
	bl GetBattleBank
	ldr r1, _0802AE9C @ =gActiveBank
	strb r0, [r1]
	ldr r2, _0802AEA0 @ =gBattleMons
	ldrb r1, [r1]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0, 0x28]
	cmp r0, 0
	bne _0802AEA4
	ldr r2, [r4]
	ldrb r1, [r2, 0x2]
	ldrb r0, [r2, 0x3]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x5]
	lsls r0, 24
	orrs r1, r0
	str r1, [r4]
	b _0802AEAA
	.align 2, 0
_0802AE98: .4byte gBattlescriptCurrInstr
_0802AE9C: .4byte gActiveBank
_0802AEA0: .4byte gBattleMons
_0802AEA4:
	ldr r0, [r4]
	adds r0, 0x6
	str r0, [r4]
_0802AEAA:
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end atkE3_jumpiffainted

	thumb_func_start sub_802AEB0
sub_802AEB0: @ 802AEB0
	push {lr}
	ldr r0, _0802AEC4 @ =gBattleTerrain
	ldrb r0, [r0]
	cmp r0, 0x7
	bhi _0802AF4C
	lsls r0, 2
	ldr r1, _0802AEC8 @ =_0802AECC
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_0802AEC4: .4byte gBattleTerrain
_0802AEC8: .4byte _0802AECC
	.align 2, 0
_0802AECC:
	.4byte _0802AEEC
	.4byte _0802AEF8
	.4byte _0802AF04
	.4byte _0802AF10
	.4byte _0802AF1C
	.4byte _0802AF28
	.4byte _0802AF34
	.4byte _0802AF40
_0802AEEC:
	ldr r1, _0802AEF4 @ =gBattleCommunication
	movs r0, 0x2
	b _0802AF50
	.align 2, 0
_0802AEF4: .4byte gBattleCommunication
_0802AEF8:
	ldr r1, _0802AF00 @ =gBattleCommunication
	movs r0, 0x1
	b _0802AF50
	.align 2, 0
_0802AF00: .4byte gBattleCommunication
_0802AF04:
	ldr r1, _0802AF0C @ =gBattleCommunication
	movs r0, 0x1B
	b _0802AF50
	.align 2, 0
_0802AF0C: .4byte gBattleCommunication
_0802AF10:
	ldr r1, _0802AF18 @ =gBattleCommunication
	movs r0, 0x17
	b _0802AF50
	.align 2, 0
_0802AF18: .4byte gBattleCommunication
_0802AF1C:
	ldr r1, _0802AF24 @ =gBattleCommunication
	movs r0, 0x16
	b _0802AF50
	.align 2, 0
_0802AF24: .4byte gBattleCommunication
_0802AF28:
	ldr r1, _0802AF30 @ =gBattleCommunication
	movs r0, 0x18
	b _0802AF50
	.align 2, 0
_0802AF30: .4byte gBattleCommunication
_0802AF34:
	ldr r1, _0802AF3C @ =gBattleCommunication
	movs r0, 0x7
	b _0802AF50
	.align 2, 0
_0802AF3C: .4byte gBattleCommunication
_0802AF40:
	ldr r1, _0802AF48 @ =gBattleCommunication
	movs r0, 0x8
	b _0802AF50
	.align 2, 0
_0802AF48: .4byte gBattleCommunication
_0802AF4C:
	ldr r1, _0802AF60 @ =gBattleCommunication
	movs r0, 0x5
_0802AF50:
	strb r0, [r1, 0x3]
	ldr r1, _0802AF64 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r0}
	bx r0
	.align 2, 0
_0802AF60: .4byte gBattleCommunication
_0802AF64: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802AEB0

	thumb_func_start sub_802AF68
sub_802AF68: @ 802AF68
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	movs r7, 0
	ldr r0, _0802AFB4 @ =gBaseStats
	mov r9, r0
	ldr r1, _0802AFB8 @ =gPickupItems
	mov r8, r1
_0802AF7A:
	movs r0, 0x64
	adds r4, r7, 0
	muls r4, r0
	ldr r0, _0802AFBC @ =gPlayerParty
	adds r4, r0
	adds r0, r4, 0
	movs r1, 0x41
	bl GetMonData
	lsls r0, 16
	lsrs r5, r0, 16
	adds r0, r4, 0
	movs r1, 0xC
	bl GetMonData
	lsls r0, 16
	lsrs r6, r0, 16
	adds r0, r4, 0
	movs r1, 0x2E
	bl GetMonData
	cmp r0, 0
	beq _0802AFC0
	lsls r0, r5, 3
	subs r0, r5
	lsls r0, 2
	add r0, r9
	ldrb r0, [r0, 0x17]
	b _0802AFCA
	.align 2, 0
_0802AFB4: .4byte gBaseStats
_0802AFB8: .4byte gPickupItems
_0802AFBC: .4byte gPlayerParty
_0802AFC0:
	lsls r0, r5, 3
	subs r0, r5
	lsls r0, 2
	add r0, r9
	ldrb r0, [r0, 0x16]
_0802AFCA:
	adds r4, r7, 0x1
	cmp r0, 0x35
	bne _0802B032
	cmp r5, 0
	beq _0802B032
	movs r0, 0xCE
	lsls r0, 1
	cmp r5, r0
	beq _0802B032
	cmp r6, 0
	bne _0802B032
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0xA
	bl __umodsi3
	lsls r0, 16
	cmp r0, 0
	bne _0802B032
	bl Random
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x64
	bl __umodsi3
	lsls r0, 16
	lsrs r3, r0, 16
	movs r2, 0
	mov r1, r8
	ldrh r0, [r1, 0x2]
	cmp r0, r3
	bgt _0802B020
	adds r1, 0x2
_0802B012:
	adds r1, 0x4
	adds r2, 0x2
	cmp r2, 0x11
	bgt _0802B020
	ldrh r0, [r1]
	cmp r0, r3
	ble _0802B012
_0802B020:
	movs r0, 0x64
	muls r0, r7
	ldr r1, _0802B04C @ =gPlayerParty
	adds r0, r1
	lsls r2, 1
	add r2, r8
	movs r1, 0xC
	bl SetMonData
_0802B032:
	adds r7, r4, 0
	cmp r7, 0x5
	ble _0802AF7A
	ldr r1, _0802B050 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802B04C: .4byte gPlayerParty
_0802B050: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802AF68

	thumb_func_start atkE6_castform_transform
atkE6_castform_transform: @ 802B054
	push {r4,lr}
	ldr r4, _0802B0A8 @ =gActiveBank
	ldr r3, _0802B0AC @ =0x02000000
	ldr r1, _0802B0B0 @ =0x00016003
	adds r0, r3, r1
	ldrb r0, [r0]
	strb r0, [r4]
	ldr r1, _0802B0B4 @ =gBattleMons
	ldrb r2, [r4]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x50
	adds r0, r1
	ldr r0, [r0]
	movs r1, 0x80
	lsls r1, 17
	ands r0, r1
	cmp r0, 0
	beq _0802B086
	ldr r0, _0802B0B8 @ =0x0001609b
	adds r2, r3, r0
	ldrb r1, [r2]
	movs r0, 0x80
	orrs r0, r1
	strb r0, [r2]
_0802B086:
	ldr r1, _0802B0B8 @ =0x0001609b
	adds r0, r3, r1
	ldrb r2, [r0]
	movs r0, 0
	movs r1, 0
	bl EmitBattleAnimation
	ldrb r0, [r4]
	bl MarkBufferBankForExecution
	ldr r1, _0802B0BC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802B0A8: .4byte gActiveBank
_0802B0AC: .4byte 0x02000000
_0802B0B0: .4byte 0x00016003
_0802B0B4: .4byte gBattleMons
_0802B0B8: .4byte 0x0001609b
_0802B0BC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkE6_castform_transform

	thumb_func_start atkE7_castform_switch
atkE7_castform_switch: @ 802B0C0
	push {r4,r5,lr}
	ldr r1, _0802B0F4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	ldr r5, _0802B0F8 @ =0x02000000
	ldr r1, _0802B0FC @ =0x00016003
	adds r0, r5, r1
	ldrb r0, [r0]
	bl castform_switch
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0
	beq _0802B0EC
	ldr r0, _0802B100 @ =gUnknown_081D977D
	bl b_push_move_exec
	subs r1, r4, 0x1
	ldr r2, _0802B104 @ =0x0001609b
	adds r0, r5, r2
	strb r1, [r0]
_0802B0EC:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802B0F4: .4byte gBattlescriptCurrInstr
_0802B0F8: .4byte 0x02000000
_0802B0FC: .4byte 0x00016003
_0802B100: .4byte gUnknown_081D977D
_0802B104: .4byte 0x0001609b
	thumb_func_end atkE7_castform_switch

	thumb_func_start atkE8_settypebasedhalvers
atkE8_settypebasedhalvers: @ 802B108
	push {r4,lr}
	movs r4, 0
	ldr r2, _0802B144 @ =gBattleMoves
	ldr r0, _0802B148 @ =gCurrentMove
	ldrh r1, [r0]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	ldrb r0, [r0]
	cmp r0, 0xC9
	bne _0802B158
	ldr r1, _0802B14C @ =gStatuses3
	ldr r0, _0802B150 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 2
	adds r2, r0, r1
	ldr r1, [r2]
	movs r3, 0x80
	lsls r3, 9
	adds r0, r1, 0
	ands r0, r3
	cmp r0, 0
	bne _0802B17C
	orrs r1, r3
	str r1, [r2]
	ldr r0, _0802B154 @ =gBattleCommunication
	strb r4, [r0, 0x5]
	b _0802B180
	.align 2, 0
_0802B144: .4byte gBattleMoves
_0802B148: .4byte gCurrentMove
_0802B14C: .4byte gStatuses3
_0802B150: .4byte gBankAttacker
_0802B154: .4byte gBattleCommunication
_0802B158:
	ldr r1, _0802B18C @ =gStatuses3
	ldr r0, _0802B190 @ =gBankAttacker
	ldrb r0, [r0]
	lsls r0, 2
	adds r2, r0, r1
	ldr r1, [r2]
	movs r3, 0x80
	lsls r3, 10
	adds r0, r1, 0
	ands r0, r3
	cmp r0, 0
	bne _0802B17C
	orrs r1, r3
	str r1, [r2]
	ldr r1, _0802B194 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	movs r4, 0x1
_0802B17C:
	cmp r4, 0
	beq _0802B19C
_0802B180:
	ldr r1, _0802B198 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802B1B6
	.align 2, 0
_0802B18C: .4byte gStatuses3
_0802B190: .4byte gBankAttacker
_0802B194: .4byte gBattleCommunication
_0802B198: .4byte gBattlescriptCurrInstr
_0802B19C:
	ldr r3, _0802B1BC @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802B1B6:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802B1BC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkE8_settypebasedhalvers

	thumb_func_start sub_802B1C0
sub_802B1C0: @ 802B1C0
	push {lr}
	sub sp, 0x4
	movs r0, 0
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0xD
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0
	bne _0802B276
	str r0, [sp]
	movs r0, 0x13
	movs r1, 0
	movs r2, 0x4D
	movs r3, 0
	bl AbilityBattleEffects
	lsls r0, 24
	cmp r0, 0
	bne _0802B276
	ldr r3, _0802B218 @ =gBattleWeather
	ldrb r0, [r3]
	ldr r2, _0802B21C @ =0x02000000
	cmp r0, 0
	beq _0802B202
	ldr r0, _0802B220 @ =0x0001601f
	adds r1, r2, r0
	movs r0, 0x2
	strb r0, [r1]
_0802B202:
	ldrh r1, [r3]
	movs r0, 0x7
	ands r0, r1
	cmp r0, 0
	beq _0802B228
	ldr r0, _0802B224 @ =0x0001601c
	adds r1, r2, r0
	movs r0, 0x8B
	strb r0, [r1]
	b _0802B276
	.align 2, 0
_0802B218: .4byte gBattleWeather
_0802B21C: .4byte 0x02000000
_0802B220: .4byte 0x0001601f
_0802B224: .4byte 0x0001601c
_0802B228:
	movs r0, 0x18
	ands r0, r1
	cmp r0, 0
	beq _0802B240
	ldr r0, _0802B23C @ =0x0001601c
	adds r1, r2, r0
	movs r0, 0x85
	strb r0, [r1]
	b _0802B276
	.align 2, 0
_0802B23C: .4byte 0x0001601c
_0802B240:
	movs r0, 0x60
	ands r0, r1
	cmp r0, 0
	beq _0802B258
	ldr r0, _0802B254 @ =0x0001601c
	adds r1, r2, r0
	movs r0, 0x8A
	strb r0, [r1]
	b _0802B276
	.align 2, 0
_0802B254: .4byte 0x0001601c
_0802B258:
	movs r3, 0x80
	adds r0, r3, 0
	ands r0, r1
	cmp r0, 0
	beq _0802B270
	ldr r0, _0802B26C @ =0x0001601c
	adds r1, r2, r0
	movs r0, 0x8F
	strb r0, [r1]
	b _0802B276
	.align 2, 0
_0802B26C: .4byte 0x0001601c
_0802B270:
	ldr r1, _0802B284 @ =0x0001601c
	adds r0, r2, r1
	strb r3, [r0]
_0802B276:
	ldr r1, _0802B288 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	add sp, 0x4
	pop {r0}
	bx r0
	.align 2, 0
_0802B284: .4byte 0x0001601c
_0802B288: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B1C0

	thumb_func_start atkEA_recycleitem
atkEA_recycleitem: @ 802B28C
	push {r4-r7,lr}
	sub sp, 0x4
	ldr r7, _0802B2F0 @ =gActiveBank
	ldr r0, _0802B2F4 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r7]
	ldrb r2, [r7]
	lsls r1, r2, 1
	ldr r0, _0802B2F8 @ =0x020160cc
	adds r6, r1, r0
	ldrh r5, [r6]
	cmp r5, 0
	beq _0802B308
	ldr r4, _0802B2FC @ =gBattleMons
	movs r3, 0x58
	adds r0, r2, 0
	muls r0, r3
	adds r0, r4
	ldrh r0, [r0, 0x2E]
	cmp r0, 0
	bne _0802B308
	ldr r1, _0802B300 @ =gLastUsedItem
	strh r5, [r1]
	strh r0, [r6]
	ldrb r0, [r7]
	muls r0, r3
	adds r0, r4
	ldrh r1, [r1]
	strh r1, [r0, 0x2E]
	ldrb r0, [r7]
	muls r0, r3
	adds r1, r4, 0
	adds r1, 0x2E
	adds r0, r1
	str r0, [sp]
	movs r0, 0
	movs r1, 0x2
	movs r2, 0
	movs r3, 0x2
	bl EmitSetAttributes
	ldrb r0, [r7]
	bl MarkBufferBankForExecution
	ldr r1, _0802B304 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802B322
	.align 2, 0
_0802B2F0: .4byte gActiveBank
_0802B2F4: .4byte gBankAttacker
_0802B2F8: .4byte 0x020160cc
_0802B2FC: .4byte gBattleMons
_0802B300: .4byte gLastUsedItem
_0802B304: .4byte gBattlescriptCurrInstr
_0802B308:
	ldr r3, _0802B32C @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802B322:
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802B32C: .4byte gBattlescriptCurrInstr
	thumb_func_end atkEA_recycleitem

	thumb_func_start atkEB_settypetoterrain
atkEB_settypetoterrain: @ 802B330
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	ldr r0, _0802B3A0 @ =gBattleMons
	mov r8, r0
	ldr r7, _0802B3A4 @ =gBankAttacker
	ldrb r0, [r7]
	movs r6, 0x58
	muls r0, r6
	mov r1, r8
	adds r3, r0, r1
	movs r0, 0x21
	adds r0, r3
	mov r12, r0
	ldr r5, _0802B3A8 @ =gTerrainToType
	ldr r4, _0802B3AC @ =gBattleTerrain
	ldrb r0, [r4]
	adds r0, r5
	ldrb r2, [r0]
	mov r1, r12
	ldrb r0, [r1]
	adds r1, r2, 0
	cmp r0, r1
	beq _0802B3B8
	adds r0, r3, 0
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, r1
	beq _0802B3B8
	mov r0, r12
	strb r2, [r0]
	ldrb r0, [r7]
	adds r1, r0, 0
	muls r1, r6
	add r1, r8
	ldrb r0, [r4]
	adds r0, r5
	ldrb r0, [r0]
	adds r1, 0x22
	strb r0, [r1]
	ldr r1, _0802B3B0 @ =gBattleTextBuff1
	movs r0, 0xFD
	strb r0, [r1]
	movs r0, 0x3
	strb r0, [r1, 0x1]
	ldrb r0, [r4]
	adds r0, r5
	ldrb r0, [r0]
	strb r0, [r1, 0x2]
	movs r0, 0xFF
	strb r0, [r1, 0x3]
	ldr r1, _0802B3B4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802B3D2
	.align 2, 0
_0802B3A0: .4byte gBattleMons
_0802B3A4: .4byte gBankAttacker
_0802B3A8: .4byte gTerrainToType
_0802B3AC: .4byte gBattleTerrain
_0802B3B0: .4byte gBattleTextBuff1
_0802B3B4: .4byte gBattlescriptCurrInstr
_0802B3B8:
	ldr r3, _0802B3DC @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802B3D2:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802B3DC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkEB_settypetoterrain

	thumb_func_start sub_802B3E0
sub_802B3E0: @ 802B3E0
	push {r4,r5,lr}
	ldr r5, _0802B45C @ =gBankAttacker
	ldrb r0, [r5]
	bl GetBankIdentity
	movs r1, 0x2
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	bl GetBankByPlayerAI
	ldr r4, _0802B460 @ =gActiveBank
	strb r0, [r4]
	ldr r0, _0802B464 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0802B490
	ldr r0, _0802B468 @ =gAbsentBankFlags
	ldrb r1, [r0]
	ldr r2, _0802B46C @ =gBitTable
	ldrb r3, [r4]
	lsls r0, r3, 2
	adds r0, r2
	ldr r0, [r0]
	ands r1, r0
	cmp r1, 0
	bne _0802B490
	ldr r0, _0802B470 @ =gActionForBanks
	adds r0, r3, r0
	ldrb r0, [r0]
	cmp r0, 0
	bne _0802B490
	ldr r1, _0802B474 @ =gChosenMovesByBanks
	lsls r0, r3, 1
	adds r0, r1
	ldrh r2, [r0]
	cmp r2, 0xE4
	bne _0802B490
	ldr r0, _0802B478 @ =gUnknown_02024A76
	adds r0, r3, r0
	movs r1, 0xB
	strb r1, [r0]
	ldr r0, _0802B47C @ =gCurrentMove
	strh r2, [r0]
	ldr r1, _0802B480 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	ldr r1, _0802B484 @ =0x02000000
	ldr r0, _0802B488 @ =0x00016002
	adds r2, r1, r0
	movs r0, 0x1
	strb r0, [r2]
	ldrb r0, [r5]
	ldr r2, _0802B48C @ =0x000160a7
	adds r1, r2
	strb r0, [r1]
	ldrb r0, [r4]
	strb r0, [r5]
	b _0802B4AA
	.align 2, 0
_0802B45C: .4byte gBankAttacker
_0802B460: .4byte gActiveBank
_0802B464: .4byte gBattleTypeFlags
_0802B468: .4byte gAbsentBankFlags
_0802B46C: .4byte gBitTable
_0802B470: .4byte gActionForBanks
_0802B474: .4byte gChosenMovesByBanks
_0802B478: .4byte gUnknown_02024A76
_0802B47C: .4byte gCurrentMove
_0802B480: .4byte gBattlescriptCurrInstr
_0802B484: .4byte 0x02000000
_0802B488: .4byte 0x00016002
_0802B48C: .4byte 0x000160a7
_0802B490:
	ldr r3, _0802B4B0 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802B4AA:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802B4B0: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B3E0

	thumb_func_start sub_802B4B4
sub_802B4B4: @ 802B4B4
	push {r4,r5,lr}
	ldr r1, _0802B4DC @ =gEffectBank
	ldr r3, _0802B4E0 @ =gBankAttacker
	ldrb r0, [r3]
	strb r0, [r1]
	ldr r2, _0802B4E4 @ =gBankTarget
	lsls r0, 24
	lsrs r0, 24
	adds r4, r1, 0
	ldrb r1, [r2]
	cmp r0, r1
	bne _0802B4F0
	ldr r0, _0802B4E8 @ =0x02000000
	ldr r5, _0802B4EC @ =0x00016003
	adds r1, r0, r5
	ldrb r1, [r1]
	strb r1, [r2]
	strb r1, [r3]
	b _0802B4FA
	.align 2, 0
_0802B4DC: .4byte gEffectBank
_0802B4E0: .4byte gBankAttacker
_0802B4E4: .4byte gBankTarget
_0802B4E8: .4byte 0x02000000
_0802B4EC: .4byte 0x00016003
_0802B4F0:
	ldr r0, _0802B510 @ =0x02000000
	ldr r3, _0802B514 @ =0x00016003
	adds r1, r0, r3
	ldrb r1, [r1]
	strb r1, [r2]
_0802B4FA:
	ldrb r1, [r4]
	ldr r5, _0802B514 @ =0x00016003
	adds r0, r5
	strb r1, [r0]
	ldr r1, _0802B518 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
_0802B510: .4byte 0x02000000
_0802B514: .4byte 0x00016003
_0802B518: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B4B4

	thumb_func_start sub_802B51C
sub_802B51C: @ 802B51C
	push {r4,lr}
	ldr r0, _0802B56C @ =gBankAttacker
	ldrb r0, [r0]
	bl GetBankSide
	movs r1, 0x1
	eors r0, r1
	lsls r0, 24
	lsrs r0, 24
	ldr r1, _0802B570 @ =gSideTimer
	lsls r3, r0, 1
	adds r0, r3, r0
	lsls r0, 2
	adds r4, r0, r1
	ldrb r0, [r4]
	cmp r0, 0
	bne _0802B544
	ldrb r2, [r4, 0x1]
	cmp r2, 0
	beq _0802B58C
_0802B544:
	ldr r2, _0802B574 @ =gSideAffecting
	adds r2, r3, r2
	ldrh r1, [r2]
	ldr r0, _0802B578 @ =0x0000fffe
	ands r0, r1
	movs r3, 0
	ldr r1, _0802B57C @ =0x0000fffd
	ands r0, r1
	strh r0, [r2]
	strb r3, [r4]
	strb r3, [r4, 0x1]
	ldr r0, _0802B580 @ =0x02000000
	ldr r2, _0802B584 @ =0x00016002
	adds r1, r0, r2
	movs r2, 0x1
	strb r2, [r1]
	ldr r3, _0802B588 @ =0x000160a1
	adds r0, r3
	b _0802B598
	.align 2, 0
_0802B56C: .4byte gBankAttacker
_0802B570: .4byte gSideTimer
_0802B574: .4byte gSideAffecting
_0802B578: .4byte 0x0000fffe
_0802B57C: .4byte 0x0000fffd
_0802B580: .4byte 0x02000000
_0802B584: .4byte 0x00016002
_0802B588: .4byte 0x000160a1
_0802B58C:
	ldr r0, _0802B5A8 @ =0x02000000
	ldr r3, _0802B5AC @ =0x00016002
	adds r1, r0, r3
	strb r2, [r1]
	ldr r1, _0802B5B0 @ =0x000160a1
	adds r0, r1
_0802B598:
	strb r2, [r0]
	ldr r1, _0802B5B4 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
_0802B5A8: .4byte 0x02000000
_0802B5AC: .4byte 0x00016002
_0802B5B0: .4byte 0x000160a1
_0802B5B4: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B51C

	thumb_func_start sub_802B5B8
sub_802B5B8: @ 802B5B8
	push {r4-r7,lr}
	movs r4, 0
	ldr r0, _0802B5F8 @ =gBattleExecBuffer
	ldr r0, [r0]
	cmp r0, 0
	beq _0802B5C6
	b _0802B94E
_0802B5C6:
	ldr r5, _0802B5FC @ =gActiveBank
	ldr r0, _0802B600 @ =gBankAttacker
	ldrb r0, [r0]
	strb r0, [r5]
	ldr r6, _0802B604 @ =gBankTarget
	movs r1, 0x1
	eors r0, r1
	strb r0, [r6]
	ldr r0, _0802B608 @ =gBattleTypeFlags
	ldrh r1, [r0]
	movs r0, 0x8
	ands r0, r1
	cmp r0, 0
	beq _0802B614
	movs r0, 0
	movs r1, 0x5
	bl dp01_build_cmdbuf_x0D_a
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r1, _0802B60C @ =gBattlescriptCurrInstr
	ldr r0, _0802B610 @ =gUnknown_081D9F35
	b _0802B94C
	.align 2, 0
_0802B5F8: .4byte gBattleExecBuffer
_0802B5FC: .4byte gActiveBank
_0802B600: .4byte gBankAttacker
_0802B604: .4byte gBankTarget
_0802B608: .4byte gBattleTypeFlags
_0802B60C: .4byte gBattlescriptCurrInstr
_0802B610: .4byte gUnknown_081D9F35
_0802B614:
	movs r0, 0x80
	lsls r0, 2
	ands r0, r1
	cmp r0, 0
	beq _0802B63C
	movs r0, 0
	movs r1, 0x4
	bl dp01_build_cmdbuf_x0D_a
	ldrb r0, [r5]
	bl MarkBufferBankForExecution
	ldr r1, _0802B634 @ =gBattlescriptCurrInstr
	ldr r0, _0802B638 @ =gUnknown_081D9F00
	b _0802B94C
	.align 2, 0
_0802B634: .4byte gBattlescriptCurrInstr
_0802B638: .4byte gUnknown_081D9F00
_0802B63C:
	ldr r0, _0802B660 @ =gLastUsedItem
	ldrh r0, [r0]
	cmp r0, 0x5
	bne _0802B66C
	ldr r0, _0802B664 @ =0x02000000
	ldr r1, _0802B668 @ =0x00016089
	adds r0, r1
	ldrb r0, [r0]
	lsls r1, r0, 2
	adds r1, r0
	lsls r0, r1, 8
	subs r0, r1
	movs r1, 0x64
	bl __divsi3
	lsls r0, 24
	lsrs r5, r0, 24
	b _0802B684
	.align 2, 0
_0802B660: .4byte gLastUsedItem
_0802B664: .4byte 0x02000000
_0802B668: .4byte 0x00016089
_0802B66C:
	ldr r3, _0802B6A0 @ =gBaseStats
	ldr r2, _0802B6A4 @ =gBattleMons
	ldrb r1, [r6]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r1, [r0]
	lsls r0, r1, 3
	subs r0, r1
	lsls r0, 2
	adds r0, r3
	ldrb r5, [r0, 0x8]
_0802B684:
	ldr r2, _0802B6A8 @ =gLastUsedItem
	ldrh r0, [r2]
	cmp r0, 0x5
	bhi _0802B68E
	b _0802B784
_0802B68E:
	subs r0, 0x6
	cmp r0, 0x6
	bls _0802B696
	b _0802B78E
_0802B696:
	lsls r0, 2
	ldr r1, _0802B6AC @ =_0802B6B0
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_0802B6A0: .4byte gBaseStats
_0802B6A4: .4byte gBattleMons
_0802B6A8: .4byte gLastUsedItem
_0802B6AC: .4byte _0802B6B0
	.align 2, 0
_0802B6B0:
	.4byte _0802B6CC
	.4byte _0802B6FC
	.4byte _0802B70E
	.4byte _0802B73C
	.4byte _0802B76C
	.4byte _0802B72E
	.4byte _0802B72E
_0802B6CC:
	ldr r2, _0802B6F4 @ =gBattleMons
	ldr r0, _0802B6F8 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r1, r0, 0
	adds r1, 0x21
	ldrb r1, [r1]
	cmp r1, 0xB
	beq _0802B760
	adds r0, 0x22
	ldrb r0, [r0]
	cmp r0, 0xB
	beq _0802B760
	cmp r1, 0x6
	beq _0802B760
	cmp r0, 0x6
	beq _0802B760
	b _0802B72E
	.align 2, 0
_0802B6F4: .4byte gBattleMons
_0802B6F8: .4byte gBankTarget
_0802B6FC:
	bl sav1_map_get_light_level
	lsls r0, 24
	lsrs r0, 24
	movs r4, 0xA
	cmp r0, 0x5
	bne _0802B78E
	movs r4, 0x23
	b _0802B78E
_0802B70E:
	ldr r2, _0802B734 @ =gBattleMons
	ldr r0, _0802B738 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	adds r0, 0x2A
	ldrb r1, [r0]
	cmp r1, 0x27
	bhi _0802B72E
	movs r0, 0x28
	subs r0, r1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x9
	bhi _0802B78E
_0802B72E:
	movs r4, 0xA
	b _0802B78E
	.align 2, 0
_0802B734: .4byte gBattleMons
_0802B738: .4byte gBankTarget
_0802B73C:
	ldr r2, _0802B764 @ =gBattleMons
	ldr r0, _0802B768 @ =gBankTarget
	ldrb r1, [r0]
	movs r0, 0x58
	muls r0, r1
	adds r0, r2
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x1
	bl GetNationalPokedexFlag
	lsls r0, 24
	movs r4, 0xA
	cmp r0, 0
	beq _0802B78E
_0802B760:
	movs r4, 0x1E
	b _0802B78E
	.align 2, 0
_0802B764: .4byte gBattleMons
_0802B768: .4byte gBankTarget
_0802B76C:
	ldr r0, _0802B780 @ =gBattleResults
	ldrb r0, [r0, 0x13]
	adds r0, 0xA
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x28
	bls _0802B78E
	movs r4, 0x28
	b _0802B78E
	.align 2, 0
_0802B780: .4byte gBattleResults
_0802B784:
	ldr r1, _0802B7F4 @ =gBallCatchBonuses
	ldrh r0, [r2]
	subs r0, 0x2
	adds r0, r1
	ldrb r4, [r0]
_0802B78E:
	adds r0, r5, 0
	muls r0, r4
	movs r1, 0xA
	bl __divsi3
	ldr r5, _0802B7F8 @ =gBattleMons
	ldr r1, _0802B7FC @ =gBankTarget
	ldrb r1, [r1]
	movs r7, 0x58
	adds r4, r1, 0
	muls r4, r7
	adds r3, r4, r5
	ldrh r2, [r3, 0x2C]
	lsls r1, r2, 1
	adds r1, r2
	ldrh r2, [r3, 0x28]
	lsls r2, 1
	subs r2, r1, r2
	muls r0, r2
	bl __divsi3
	adds r6, r0, 0
	adds r5, 0x4C
	adds r4, r5
	ldr r4, [r4]
	movs r0, 0x27
	ands r0, r4
	cmp r0, 0
	beq _0802B7CA
	lsls r6, 1
_0802B7CA:
	ands r4, r7
	cmp r4, 0
	beq _0802B7DC
	lsls r0, r6, 4
	subs r0, r6
	movs r1, 0xA
	bl __udivsi3
	adds r6, r0, 0
_0802B7DC:
	ldr r1, _0802B800 @ =gLastUsedItem
	ldrh r0, [r1]
	cmp r0, 0x5
	beq _0802B81C
	cmp r0, 0x1
	bne _0802B808
	ldr r0, _0802B804 @ =gBattleResults
	ldrb r1, [r0, 0x5]
	movs r2, 0x2
	orrs r1, r2
	strb r1, [r0, 0x5]
	b _0802B81C
	.align 2, 0
_0802B7F4: .4byte gBallCatchBonuses
_0802B7F8: .4byte gBattleMons
_0802B7FC: .4byte gBankTarget
_0802B800: .4byte gLastUsedItem
_0802B804: .4byte gBattleResults
_0802B808:
	ldr r0, _0802B860 @ =gBattleResults
	ldrh r1, [r1]
	adds r0, r1
	adds r1, r0, 0
	adds r1, 0x34
	ldrb r0, [r1]
	cmp r0, 0xFE
	bhi _0802B81C
	adds r0, 0x1
	strb r0, [r1]
_0802B81C:
	cmp r6, 0xFE
	bls _0802B880
	movs r0, 0
	movs r1, 0x4
	bl dp01_build_cmdbuf_x0D_a
	ldr r0, _0802B864 @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	ldr r1, _0802B868 @ =gBattlescriptCurrInstr
	ldr r0, _0802B86C @ =gUnknown_081D9EC2
	str r0, [r1]
	ldr r1, _0802B870 @ =gBattlePartyID
	ldr r0, _0802B874 @ =gBankTarget
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0802B878 @ =gEnemyParty
	adds r0, r1
	ldr r2, _0802B87C @ =gLastUsedItem
	movs r1, 0x26
	bl SetMonData
	bl CalculatePlayerPartyCount
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x6
	beq _0802B90E
	b _0802B938
	.align 2, 0
_0802B860: .4byte gBattleResults
_0802B864: .4byte gActiveBank
_0802B868: .4byte gBattlescriptCurrInstr
_0802B86C: .4byte gUnknown_081D9EC2
_0802B870: .4byte gBattlePartyID
_0802B874: .4byte gBankTarget
_0802B878: .4byte gEnemyParty
_0802B87C: .4byte gLastUsedItem
_0802B880:
	movs r0, 0xFF
	lsls r0, 16
	adds r1, r6, 0
	bl __udivsi3
	bl Sqrt
	lsls r0, 16
	lsrs r0, 16
	bl Sqrt
	lsls r0, 16
	lsrs r6, r0, 16
	ldr r0, _0802B8A8 @ =0x000ffff0
	adds r1, r6, 0
	bl __udivsi3
	adds r6, r0, 0
	movs r4, 0
	b _0802B8B2
	.align 2, 0
_0802B8A8: .4byte 0x000ffff0
_0802B8AC:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
_0802B8B2:
	cmp r4, 0x3
	bhi _0802B8C2
	bl Random
	lsls r0, 16
	lsrs r0, 16
	cmp r0, r6
	bcc _0802B8AC
_0802B8C2:
	ldr r5, _0802B918 @ =gLastUsedItem
	ldrh r0, [r5]
	cmp r0, 0x1
	bne _0802B8CC
	movs r4, 0x4
_0802B8CC:
	movs r0, 0
	adds r1, r4, 0
	bl dp01_build_cmdbuf_x0D_a
	ldr r0, _0802B91C @ =gActiveBank
	ldrb r0, [r0]
	bl MarkBufferBankForExecution
	cmp r4, 0x4
	bne _0802B944
	ldr r1, _0802B920 @ =gBattlescriptCurrInstr
	ldr r0, _0802B924 @ =gUnknown_081D9EC2
	str r0, [r1]
	ldr r1, _0802B928 @ =gBattlePartyID
	ldr r0, _0802B92C @ =gBankTarget
	ldrb r0, [r0]
	lsls r0, 1
	adds r0, r1
	ldrh r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0802B930 @ =gEnemyParty
	adds r0, r1
	movs r1, 0x26
	adds r2, r5, 0
	bl SetMonData
	bl CalculatePlayerPartyCount
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x6
	bne _0802B938
_0802B90E:
	ldr r1, _0802B934 @ =gBattleCommunication
	movs r0, 0
	strb r0, [r1, 0x5]
	b _0802B94E
	.align 2, 0
_0802B918: .4byte gLastUsedItem
_0802B91C: .4byte gActiveBank
_0802B920: .4byte gBattlescriptCurrInstr
_0802B924: .4byte gUnknown_081D9EC2
_0802B928: .4byte gBattlePartyID
_0802B92C: .4byte gBankTarget
_0802B930: .4byte gEnemyParty
_0802B934: .4byte gBattleCommunication
_0802B938:
	ldr r1, _0802B940 @ =gBattleCommunication
	movs r0, 0x1
	strb r0, [r1, 0x5]
	b _0802B94E
	.align 2, 0
_0802B940: .4byte gBattleCommunication
_0802B944:
	ldr r0, _0802B954 @ =gBattleCommunication
	strb r4, [r0, 0x5]
	ldr r1, _0802B958 @ =gBattlescriptCurrInstr
	ldr r0, _0802B95C @ =gUnknown_081D9F0A
_0802B94C:
	str r0, [r1]
_0802B94E:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802B954: .4byte gBattleCommunication
_0802B958: .4byte gBattlescriptCurrInstr
_0802B95C: .4byte gUnknown_081D9F0A
	thumb_func_end sub_802B5B8

	thumb_func_start sub_802B960
sub_802B960: @ 802B960
	push {r4-r6,lr}
	mov r6, r9
	mov r5, r8
	push {r5,r6}
	ldr r0, _0802B9C8 @ =gBattlePartyID
	mov r9, r0
	ldr r5, _0802B9CC @ =gBankAttacker
	ldrb r0, [r5]
	movs r4, 0x1
	eors r0, r4
	lsls r0, 1
	add r0, r9
	ldrh r0, [r0]
	movs r1, 0x64
	mov r8, r1
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	ldr r6, _0802B9D0 @ =gEnemyParty
	adds r0, r6
	bl GiveMonToPlayer
	ldr r2, _0802B9D4 @ =gBattleResults
	ldr r1, _0802B9D8 @ =gBattleMons
	ldrb r0, [r5]
	eors r4, r0
	movs r0, 0x58
	muls r0, r4
	adds r0, r1
	ldrh r0, [r0]
	strh r0, [r2, 0x28]
	lsls r4, 1
	add r4, r9
	ldrh r0, [r4]
	mov r1, r8
	muls r1, r0
	adds r0, r1, 0
	adds r0, r6
	adds r2, 0x2A
	movs r1, 0x2
	bl GetMonData
	ldr r1, _0802B9DC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0802B9C8: .4byte gBattlePartyID
_0802B9CC: .4byte gBankAttacker
_0802B9D0: .4byte gEnemyParty
_0802B9D4: .4byte gBattleResults
_0802B9D8: .4byte gBattleMons
_0802B9DC: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B960

	thumb_func_start sub_802B9E0
sub_802B9E0: @ 802B9E0
	push {r4-r6,lr}
	ldr r4, _0802BA20 @ =gBattleMons
	ldr r6, _0802BA24 @ =gBankTarget
	ldrb r0, [r6]
	movs r5, 0x58
	muls r0, r5
	adds r0, r4
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x1
	bl GetNationalPokedexFlag
	lsls r0, 24
	cmp r0, 0
	beq _0802BA2C
	ldr r3, _0802BA28 @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
	b _0802BA82
	.align 2, 0
_0802BA20: .4byte gBattleMons
_0802BA24: .4byte gBankTarget
_0802BA28: .4byte gBattlescriptCurrInstr
_0802BA2C:
	ldrb r0, [r6]
	muls r0, r5
	adds r0, r4
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	movs r1, 0x3
	bl GetNationalPokedexFlag
	ldrb r0, [r6]
	adds r2, r0, 0
	muls r2, r5
	adds r0, r2, r4
	ldrh r0, [r0]
	cmp r0, 0xC9
	bne _0802BA5C
	ldr r0, _0802BA88 @ =gSaveBlock2
	adds r1, r4, 0
	adds r1, 0x48
	adds r1, r2, r1
	ldr r1, [r1]
	str r1, [r0, 0x1C]
_0802BA5C:
	ldrb r0, [r6]
	adds r2, r0, 0
	muls r2, r5
	adds r0, r2, r4
	ldrh r1, [r0]
	movs r0, 0x9A
	lsls r0, 1
	cmp r1, r0
	bne _0802BA7A
	ldr r0, _0802BA88 @ =gSaveBlock2
	adds r1, r4, 0
	adds r1, 0x48
	adds r1, r2, r1
	ldr r1, [r1]
	str r1, [r0, 0x20]
_0802BA7A:
	ldr r1, _0802BA8C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
_0802BA82:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
_0802BA88: .4byte gSaveBlock2
_0802BA8C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802B9E0

	thumb_func_start sub_802BA90
sub_802BA90: @ 802BA90
	push {r4-r7,lr}
	sub sp, 0x4
	ldr r7, _0802BAA8 @ =gBattleCommunication
	ldrb r1, [r7]
	cmp r1, 0x1
	beq _0802BAC6
	cmp r1, 0x1
	bgt _0802BAAC
	cmp r1, 0
	beq _0802BAB8
	b _0802BBC4
	.align 2, 0
_0802BAA8: .4byte gBattleCommunication
_0802BAAC:
	cmp r1, 0x2
	beq _0802BB10
	cmp r1, 0x3
	bne _0802BAB6
	b _0802BBB0
_0802BAB6:
	b _0802BBC4
_0802BAB8:
	movs r0, 0x1
	negs r0, r0
	str r1, [sp]
	movs r1, 0
	movs r2, 0
	movs r3, 0x10
	b _0802BB6E
_0802BAC6:
	ldr r0, _0802BB04 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0802BBC4
	ldr r4, _0802BB08 @ =gBattleMons
	ldr r6, _0802BB0C @ =gBankTarget
	ldrb r0, [r6]
	movs r5, 0x58
	muls r0, r5
	adds r0, r4
	ldrh r0, [r0]
	bl SpeciesToNationalPokedexNum
	lsls r0, 16
	lsrs r0, 16
	ldrb r1, [r6]
	adds r2, r1, 0
	muls r2, r5
	adds r1, r4, 0
	adds r1, 0x54
	adds r1, r2, r1
	ldr r1, [r1]
	adds r4, 0x48
	adds r2, r4
	ldr r2, [r2]
	bl sub_809070C
	strb r0, [r7, 0x1]
	b _0802BB72
	.align 2, 0
_0802BB04: .4byte gPaletteFade
_0802BB08: .4byte gBattleMons
_0802BB0C: .4byte gBankTarget
_0802BB10:
	ldr r0, _0802BB7C @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0802BBC4
	ldr r0, _0802BB80 @ =gMain
	ldr r1, [r0, 0x4]
	ldr r0, _0802BB84 @ =sub_800F808
	cmp r1, r0
	bne _0802BBC4
	ldr r2, _0802BB88 @ =gTasks
	ldrb r1, [r7, 0x1]
	lsls r0, r1, 2
	adds r0, r1
	lsls r0, 3
	adds r0, r2
	ldrb r4, [r0, 0x4]
	cmp r4, 0
	bne _0802BBC4
	ldr r0, _0802BB8C @ =gBattleTerrainTiles_Building
	ldr r1, _0802BB90 @ =0x06008000
	bl LZDecompressVram
	ldr r0, _0802BB94 @ =gBattleTerrainTilemap_Building
	ldr r1, _0802BB98 @ =0x0600d000
	bl LZDecompressVram
	ldr r0, _0802BB9C @ =gBattleTerrainPalette_BattleTower
	movs r1, 0x20
	movs r2, 0x60
	bl LoadCompressedPalette
	ldr r1, _0802BBA0 @ =REG_BG3CNT
	ldr r2, _0802BBA4 @ =0x00005a0b
	adds r0, r2, 0
	strh r0, [r1]
	ldr r1, _0802BBA8 @ =gUnknown_030041B0
	movs r2, 0x80
	lsls r2, 1
	adds r0, r2, 0
	strh r0, [r1]
	ldr r0, _0802BBAC @ =0x0000fffc
	str r4, [sp]
	movs r1, 0
	movs r2, 0x10
	movs r3, 0
_0802BB6E:
	bl BeginNormalPaletteFade
_0802BB72:
	ldrb r0, [r7]
	adds r0, 0x1
	strb r0, [r7]
	b _0802BBC4
	.align 2, 0
_0802BB7C: .4byte gPaletteFade
_0802BB80: .4byte gMain
_0802BB84: .4byte sub_800F808
_0802BB88: .4byte gTasks
_0802BB8C: .4byte gBattleTerrainTiles_Building
_0802BB90: .4byte 0x06008000
_0802BB94: .4byte gBattleTerrainTilemap_Building
_0802BB98: .4byte 0x0600d000
_0802BB9C: .4byte gBattleTerrainPalette_BattleTower
_0802BBA0: .4byte REG_BG3CNT
_0802BBA4: .4byte 0x00005a0b
_0802BBA8: .4byte gUnknown_030041B0
_0802BBAC: .4byte 0x0000fffc
_0802BBB0:
	ldr r0, _0802BBCC @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0802BBC4
	ldr r1, _0802BBD0 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
_0802BBC4:
	add sp, 0x4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802BBCC: .4byte gPaletteFade
_0802BBD0: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802BA90

	thumb_func_start sub_802BBD4
sub_802BBD4: @ 802BBD4
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	ldr r4, [sp, 0x20]
	lsls r0, 24
	lsrs r6, r0, 24
	lsls r1, 24
	lsrs r1, 24
	mov r12, r1
	lsls r2, 24
	lsrs r5, r2, 24
	lsls r3, 24
	lsrs r7, r3, 24
	lsls r4, 24
	lsrs r4, 24
	mov r8, r4
	mov r2, r12
	cmp r2, r7
	bgt _0802BC5A
	lsls r1, r6, 1
	ldr r0, _0802BC20 @ =0x0600c000
	adds r1, r0
	mov r9, r1
_0802BC06:
	adds r1, r6, 0
	adds r0, r2, 0x1
	mov r10, r0
	cmp r1, r5
	bgt _0802BC54
	lsls r0, r2, 6
	mov r4, r9
	adds r3, r4, r0
_0802BC16:
	cmp r2, r12
	bne _0802BC28
	ldr r0, _0802BC24 @ =0x00001022
	b _0802BC36
	.align 2, 0
_0802BC20: .4byte 0x0600c000
_0802BC24: .4byte 0x00001022
_0802BC28:
	cmp r2, r7
	bne _0802BC34
	ldr r0, _0802BC30 @ =0x00001028
	b _0802BC36
	.align 2, 0
_0802BC30: .4byte 0x00001028
_0802BC34:
	ldr r0, _0802BC68 @ =0x00001025
_0802BC36:
	cmp r1, r6
	beq _0802BC42
	adds r0, 0x1
	cmp r1, r5
	bne _0802BC42
	adds r0, 0x1
_0802BC42:
	mov r4, r8
	cmp r4, 0
	beq _0802BC4A
	movs r0, 0
_0802BC4A:
	strh r0, [r3]
	adds r3, 0x2
	adds r1, 0x1
	cmp r1, r5
	ble _0802BC16
_0802BC54:
	mov r2, r10
	cmp r2, r7
	ble _0802BC06
_0802BC5A:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802BC68: .4byte 0x00001025
	thumb_func_end sub_802BBD4

	thumb_func_start sub_802BC6C
sub_802BC6C: @ 802BC6C
	push {lr}
	ldr r0, _0802BC88 @ =gBattleCommunication
	ldrb r1, [r0, 0x1]
	lsls r1, 28
	movs r0, 0x90
	lsls r0, 23
	adds r1, r0
	lsrs r1, 24
	movs r0, 0xC8
	bl sub_814A880
	pop {r0}
	bx r0
	.align 2, 0
_0802BC88: .4byte gBattleCommunication
	thumb_func_end sub_802BC6C

	thumb_func_start nullsub_6
nullsub_6: @ 802BC8C
	bx lr
	thumb_func_end nullsub_6

	thumb_func_start atkF3_receive_new_pokemon_maybe
atkF3_receive_new_pokemon_maybe: @ 802BC90
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x8
	ldr r0, _0802BCB4 @ =gBattleCommunication
	ldrb r1, [r0]
	adds r4, r0, 0
	cmp r1, 0x4
	bls _0802BCA8
	b _0802BEDA
_0802BCA8:
	lsls r0, r1, 2
	ldr r1, _0802BCB8 @ =_0802BCBC
	adds r0, r1
	ldr r0, [r0]
	mov pc, r0
	.align 2, 0
_0802BCB4: .4byte gBattleCommunication
_0802BCB8: .4byte _0802BCBC
	.align 2, 0
_0802BCBC:
	.4byte _0802BCD0
	.4byte _0802BCEC
	.4byte _0802BD84
	.4byte _0802BE50
	.4byte _0802BEA4
_0802BCD0:
	bl sub_8023A80
	ldr r0, _0802BCE8 @ =gBattleCommunication
	ldrb r1, [r0]
	adds r1, 0x1
	movs r2, 0
	strb r1, [r0]
	strb r2, [r0, 0x1]
	bl sub_802BC6C
	b _0802BEDA
	.align 2, 0
_0802BCE8: .4byte gBattleCommunication
_0802BCEC:
	ldr r0, _0802BD60 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _0802BD10
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	beq _0802BD10
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_0802BD10:
	ldr r0, _0802BD60 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _0802BD36
	ldr r4, _0802BD64 @ =gBattleCommunication
	ldrb r0, [r4, 0x1]
	cmp r0, 0
	bne _0802BD36
	movs r0, 0x5
	bl PlaySE
	bl nullsub_6
	movs r0, 0x1
	strb r0, [r4, 0x1]
	bl sub_802BC6C
_0802BD36:
	ldr r0, _0802BD60 @ =gMain
	ldrh r1, [r0, 0x2E]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0802BD68
	movs r0, 0x5
	bl PlaySE
	ldr r1, _0802BD64 @ =gBattleCommunication
	ldrb r0, [r1, 0x1]
	cmp r0, 0
	bne _0802BD7A
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	movs r0, 0x3
	bl BeginFastPaletteFade
	b _0802BEDA
	.align 2, 0
_0802BD60: .4byte gMain
_0802BD64: .4byte gBattleCommunication
_0802BD68:
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	bne _0802BD72
	b _0802BEDA
_0802BD72:
	movs r0, 0x5
	bl PlaySE
	ldr r1, _0802BD80 @ =gBattleCommunication
_0802BD7A:
	movs r0, 0x4
	strb r0, [r1]
	b _0802BEDA
	.align 2, 0
_0802BD80: .4byte gBattleCommunication
_0802BD84:
	ldr r0, _0802BE34 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _0802BD92
	b _0802BEDA
_0802BD92:
	ldr r7, _0802BE38 @ =gBattlePartyID
	ldr r0, _0802BE3C @ =gBankAttacker
	mov r10, r0
	ldrb r0, [r0]
	movs r4, 0x1
	eors r0, r4
	lsls r0, 1
	adds r0, r7
	ldrh r0, [r0]
	movs r1, 0x64
	mov r9, r1
	mov r1, r9
	muls r1, r0
	adds r0, r1, 0
	ldr r1, _0802BE40 @ =gEnemyParty
	mov r8, r1
	add r0, r8
	movs r1, 0x2
	ldr r2, _0802BE44 @ =0x02016079
	bl GetMonData
	mov r1, r10
	ldrb r0, [r1]
	eors r0, r4
	lsls r0, 1
	adds r0, r7
	ldrh r0, [r0]
	mov r1, r9
	muls r1, r0
	adds r0, r1, 0
	add r0, r8
	movs r1, 0xB
	bl GetMonData
	adds r6, r0, 0
	lsls r6, 16
	lsrs r6, 16
	mov r1, r10
	ldrb r0, [r1]
	eors r0, r4
	lsls r0, 1
	adds r0, r7
	ldrh r0, [r0]
	mov r1, r9
	muls r1, r0
	adds r0, r1, 0
	add r0, r8
	bl GetMonGender
	adds r5, r0, 0
	lsls r5, 24
	lsrs r5, 24
	mov r1, r10
	ldrb r0, [r1]
	eors r4, r0
	lsls r4, 1
	adds r4, r7
	ldrh r0, [r4]
	mov r1, r9
	muls r1, r0
	adds r0, r1, 0
	add r0, r8
	movs r1, 0
	movs r2, 0
	bl GetMonData
	str r0, [sp]
	ldr r0, _0802BE48 @ =sub_800F808
	str r0, [sp, 0x4]
	movs r0, 0x2
	ldr r1, _0802BE44 @ =0x02016079
	adds r2, r6, 0
	adds r3, r5, 0
	bl DoNamingScreen
	ldr r1, _0802BE4C @ =gBattleCommunication
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	b _0802BEDA
	.align 2, 0
_0802BE34: .4byte gPaletteFade
_0802BE38: .4byte gBattlePartyID
_0802BE3C: .4byte gBankAttacker
_0802BE40: .4byte gEnemyParty
_0802BE44: .4byte 0x02016079
_0802BE48: .4byte sub_800F808
_0802BE4C: .4byte gBattleCommunication
_0802BE50:
	ldr r0, _0802BE88 @ =gMain
	ldr r1, [r0, 0x4]
	ldr r0, _0802BE8C @ =sub_800F808
	cmp r1, r0
	bne _0802BEDA
	ldr r0, _0802BE90 @ =gPaletteFade
	ldrb r1, [r0, 0x7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _0802BEDA
	ldr r2, _0802BE94 @ =gBattlePartyID
	ldr r0, _0802BE98 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x1
	eors r0, r1
	lsls r0, 1
	adds r0, r2
	ldrh r1, [r0]
	movs r0, 0x64
	muls r0, r1
	ldr r1, _0802BE9C @ =gEnemyParty
	adds r0, r1
	ldr r2, _0802BEA0 @ =0x02016079
	movs r1, 0x2
	bl SetMonData
	b _0802BEC0
	.align 2, 0
_0802BE88: .4byte gMain
_0802BE8C: .4byte sub_800F808
_0802BE90: .4byte gPaletteFade
_0802BE94: .4byte gBattlePartyID
_0802BE98: .4byte gBankAttacker
_0802BE9C: .4byte gEnemyParty
_0802BEA0: .4byte 0x02016079
_0802BEA4:
	bl CalculatePlayerPartyCount
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0x6
	bne _0802BEC0
	ldr r1, _0802BEBC @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x5
	str r0, [r1]
	b _0802BEDA
	.align 2, 0
_0802BEBC: .4byte gBattlescriptCurrInstr
_0802BEC0:
	ldr r3, _0802BEEC @ =gBattlescriptCurrInstr
	ldr r2, [r3]
	ldrb r1, [r2, 0x1]
	ldrb r0, [r2, 0x2]
	lsls r0, 8
	orrs r1, r0
	ldrb r0, [r2, 0x3]
	lsls r0, 16
	orrs r1, r0
	ldrb r0, [r2, 0x4]
	lsls r0, 24
	orrs r1, r0
	str r1, [r3]
_0802BEDA:
	add sp, 0x8
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
_0802BEEC: .4byte gBattlescriptCurrInstr
	thumb_func_end atkF3_receive_new_pokemon_maybe

	thumb_func_start sub_802BEF0
sub_802BEF0: @ 802BEF0
	ldr r2, _0802BF10 @ =gBattleMons
	ldr r0, _0802BF14 @ =gBankAttacker
	ldrb r1, [r0]
	movs r0, 0x58
	muls r1, r0
	adds r1, r2
	ldr r0, _0802BF18 @ =gBattleMoveDamage
	ldr r2, [r0]
	ldrh r0, [r1, 0x28]
	subs r0, r2
	strh r0, [r1, 0x28]
	ldr r1, _0802BF1C @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_0802BF10: .4byte gBattleMons
_0802BF14: .4byte gBankAttacker
_0802BF18: .4byte gBattleMoveDamage
_0802BF1C: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802BEF0

	thumb_func_start sub_802BF20
sub_802BF20: @ 802BF20
	ldr r1, _0802BF3C @ =gBattleMons
	ldr r0, _0802BF40 @ =gBankAttacker
	ldrb r2, [r0]
	movs r0, 0x58
	muls r0, r2
	adds r1, 0x4C
	adds r0, r1
	movs r1, 0
	str r1, [r0]
	ldr r1, _0802BF44 @ =gBattlescriptCurrInstr
	ldr r0, [r1]
	adds r0, 0x1
	str r0, [r1]
	bx lr
	.align 2, 0
_0802BF3C: .4byte gBattleMons
_0802BF40: .4byte gBankAttacker
_0802BF44: .4byte gBattlescriptCurrInstr
	thumb_func_end sub_802BF20

	thumb_func_start sub_802BF48
sub_802BF48: @ 802BF48
	ldr r1, _0802BF50 @ =gFightStateTracker
	movs r0, 0xC
	strb r0, [r1]
	bx lr
	.align 2, 0
_0802BF50: .4byte gFightStateTracker
	thumb_func_end sub_802BF48

	thumb_func_start sub_802BF54
sub_802BF54: @ 802BF54
	ldr r1, _0802BF64 @ =gFightStateTracker
	movs r0, 0xC
	strb r0, [r1]
	ldr r1, _0802BF68 @ =gCurrentMoveTurn
	ldr r0, _0802BF6C @ =gNoOfAllBanks
	ldrb r0, [r0]
	strb r0, [r1]
	bx lr
	.align 2, 0
_0802BF64: .4byte gFightStateTracker
_0802BF68: .4byte gCurrentMoveTurn
_0802BF6C: .4byte gNoOfAllBanks
	thumb_func_end sub_802BF54

	.align 2, 0 @ Don't pad with nop.
