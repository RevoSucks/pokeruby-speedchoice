#include "global.h"
#include "battle.h"
#include "battle_move_effects.h"
#include "moves.h"
#include "abilities.h"
#include "item.h"
#include "items.h"
#include "data2.h"
#include "hold_effects.h"
#include "rng.h"
#include "species.h"
#include "pokemon.h"
#include "battle_buffer_emits.h"
#include "speedchoice.h"

//extern needed variables
extern u8 gCritMultiplier;
extern s32 gBattleMoveDamage;
extern u32 gStatuses3[4];
extern u16 gBattleTypeFlags;
extern const u32 gBitTable[];
extern const struct BaseStats gBaseStats[];
extern struct BattleEnigmaBerry gEnigmaBerries[4];
extern struct BattlePokemon gBattleMons[4];
extern u8 gActiveBank;
extern u32 gBattleExecBuffer;
extern u8 gNoOfAllBanks;
extern u16 gBattlePartyID[4];
extern u8 gTurnOrder[4];
extern u16 gCurrentMove;
extern u8 gLastUsedAbility;
extern u8 gStringBank;
extern u8 gAbsentBankFlags;
extern u8 gMultiHitCounter;
extern u16 gLastUsedMove[4];
extern u16 gLockedMove[4];
extern u16 gChosenMovesByBanks[4];
extern u16 gSideAffecting[2];
extern u16 gPauseCounterBattle;
extern u16 gPaydayMoney;
extern u16 gRandomTurnNumber;
extern u8 gBattleOutcome;
extern s8 gBattleTerrain;
extern u16 gTrainerBattleOpponent;
extern u8 gBankAttacker;
extern u8 gBankTarget;
extern u8* gBattlescriptCurrInstr;
extern u8 gCurrMovePos;
extern u8 gFightStateTracker;
extern u32 gHitMarker;
extern u8 gBattleMoveFlags;
extern u8 gBattleCommunication[];
extern u16 gMoveHitWith[4];
extern u16 gUnknown_02024C44[4];
extern u8 gStringBank;
extern const u16 gCriticalHitChance[5];
extern u16 gDynamicBasePower;
extern const u8 gTypeEffectiveness[];
extern u16 gLastUsedItem;
extern u16 gBattleMovePower;
extern s32 gHP_dealt;
extern s32 gTakenDmg[4];
extern u8 gTakenDmgBanks[4];
extern const u16 gMissStrings[];
extern const u32 gStatusFlagsForMoveEffects[];
extern u8 gSentPokesToOpponent[2];
extern u8 gBank1;
extern u16 gExpShareExp;
extern u8 gBattleTextBuff1[];
extern u8 gBattleTextBuff2[];
extern u8 gBattleTextBuff3[];
extern u8 gLeveledUpInBattle;
extern void (*gBattleMainFunc)(void);

struct stat_fractions{
    u8 dividend;
    u8 divisor;
    u16 pad;
};

extern const struct stat_fractions gAccuracyStageRatios[0xC];

//extern functions
bool8 CantUseMove(void);
void PressurePPLose(u8 bank_atk, u8 bank_def, u16 move);
void CancelMultiTurnMoves(u8 bank);
u8 AbilityBattleEffects(u8 caseID, u8 bank, u8 ability, u8 special_arg, u16 move);
void b_movescr_stack_push(u8* BS_ptr);
void b_movescr_stack_push_cursor(void);
void RecordAbilityBattle(u8 bank, u8 ability);
void RecordItemBattle(u8 bank, u8 item);
int IsPokeDisobedient(void);
bool8 IsTwoTurnsMove(u16 move);
void DestinyBondFlagUpdate(void);
void b_wonderguard_and_levitate(void);
void PrepareStringBattle(u16 stringID, u8 bank);
u8 GetBankIdentity(u8 bank);
u8 GetBankSide(u8 bank);
u8 GetBattleBank(u8 bankValue);
s32 CalculateBaseDamage(struct BattlePokemon *attacker, struct BattlePokemon *defender, u32 move, u16 a4, u16 powerOverride, u8 typeOverride, u8 bank_atk, u8 bank_def);
u8 AttacksThisTurn(u8 bank, u16 move); //Note: returns 1 if it's a charging turn, otherwise 2
void UndoEffectsAfterFainting(void);
void BattleMusicStop(void);
void PlayBGM(u16 songID);
void MonGainEVs(struct Pokemon*, u16 defeatedSpecies);
extern u8 BattleBufferB[4][0x200];
void sub_80324F8(struct Pokemon*, u8 bank);
void AdjustFriendship(struct Pokemon*, u8 value);
bool8 IsTradedMon(struct Pokemon*);
void b_movescr_stack_pop_cursor(void);

//extern BattleScripts
extern u8 BattleScript_EndTurn[];
extern u8 BattleScript_NoPPForMove[];
extern u8 BattleScript_MagicCoatBounce[];
extern u8 BattleScript_TookAttack[];
extern u8 BattleScript_SnatchedMove[];
extern u8 BattleScript_Pausex20[];
extern u8 BattleScript_SubstituteFade[];
extern u8 BattleScript_HangedOnMsg[];
extern u8 BattleScript_OneHitKOMsg[];
extern u8 BattleScript_EnduredMsg[];
extern u8 BattleScript_PSNPrevention[];
extern u8 BattleScript_BRNPrevention[];
extern u8 BattleScript_PRLZPrevention[];
extern u8 BattleScript_FlinchPrevention[];
extern u8 BattleScript_StatUp[];
extern u8 BattleScript_StatDown[];
extern u8 BattleScript_NoItemSteal[];
extern u8 BattleScript_ItemSteal[];
extern u8 BattleScript_RapidSpinAway[];
extern u8 BattleScript_TargetPRLZHeal[];
extern u8 BattleScript_KnockedOff[];
extern u8 BattleScript_LevelUp[];

//useful macros
//read via orr
#define BSScriptRead32(ptr) ((ptr)[0] | (ptr)[1] << 8 | (ptr)[2] << 16 | (ptr)[3] << 24)
#define BSScriptRead16(ptr) ((ptr)[0] | (ptr)[1] << 8)
#define BSScriptRead8(ptr) ((ptr)[0])
#define BSScriptReadPtr(ptr) ((u8*) BSScriptRead32(ptr))

//read via add
#define BS2ScriptRead32(ptr) ((ptr)[0] + ((ptr)[1] << 8) + ((ptr)[2] << 16) + ((ptr)[3] << 24))
#define BS2ScriptRead16(ptr) ((ptr)[0] + ((ptr)[1] << 8))
#define BS2ScriptReadPtr(ptr) ((u8*) BS2ScriptRead32(ptr))

#define ATLEAST_ONE(value)(value != 0 ? value : 1)
#define ATLEAST_ONE_PTR(value)(*value != 0 ? *value : (*value = 1))

#define MOVE_MISSED             0x1
#define MOVE_SUPEREFFECTIVE     0x2
#define MOVE_NOTVERYEFFECTIVE   0x4
#define MOVE_NOTAFFECTED        0x8
#define MOVE_ONEHITKO           0x10
#define MOVE_FAILED             0x20
#define MOVE_ENDURED            0x40
#define MOVE_HANGEDON           0x80

#define MOVE_NO_EFFECT ((MOVE_MISSED | MOVE_NOTAFFECTED | MOVE_FAILED))

#define TargetProtectAffected ((gProtectStructs[gBankTarget].Protected && gBattleMoves[gCurrentMove].flags & PROTECT_AFFECTED))

#define ABILITY_CHECK_OTHER_SIDE    0xC
#define ABILITY_CHECK_BANK_SIDE     0xD
#define ABILITY_COUNT_OTHER_SIDE    0x10
#define ABILITY_COUNT_BANK_SIDE     0x11
#define ABILITT_COUNT_ON_FIELD      0x12
#define ABILITY_CHECK_ON_FIELD      0x13

#define WeatherHasEffect ((!AbilityBattleEffects(ABILITY_CHECK_ON_FIELD, 0, ABILITY_CLOUD_NINE, 0, 0) && !AbilityBattleEffects(ABILITY_CHECK_ON_FIELD, 0, ABILITY_AIR_LOCK, 0, 0)))

#define HP_BUFF         0x0
#define ATK_BUFF        0x1
#define DEF_BUFF        0x2
#define SPD_BUFF        0x3
#define SPATK_BUFF      0x4
#define SPDEF_BUFF      0x5
#define ACC_BUFF        0x6
#define EVASION_BUFF    0x7

//array entries for battle communication
#define MOVE_EFFECT_BYTE    0x3
#define MULTISTRING_CHOOSER 0x5
#define MSG_DISPLAY         0x7

#define TARGET_SELECTED         0x0
#define TARGET_DEPENDS          0x1
#define TARGET_BOTH             0x8
#define TARGET_FOES_AND_ALLY    0x20
#define TARGET_OPPONENTS_FIELD  0x40

#define TYPE_FORESIGHT  0xFE
#define TYPE_ENDTABLE   0xFF

#define CMP_EQUAL               0x0
#define CMP_NOT_EQUAL           0x1
#define CMP_GREATER_THAN        0x2
#define CMP_LESS_THAN           0x3
#define CMP_COMMON_BITS         0x4
#define CMP_NO_COMMON_BITS      0x5

#define BATTLE_WON  0x1
#define BATTLE_LOST 0x2
#define BATTLE_DREW 0x3
#define BATTLE_RAN  0x4
#define BATTLE_PLAYER_TELEPORTED    0x5
#define BATTLE_POKE_FLED            0x6
#define BATTLE_CAUGHT               0x7
#define BATTLE_OPPONENT_TELEPORTED  0xA

void atk00_attackcanceler(void)
{
    int i;
    if (gBattleOutcome)
        {gFightStateTracker = 0xC; return;}
    if (gBattleMons[gBankAttacker].hp == 0 && !(gHitMarker & HITMARKER_NO_ATTACKSTRING))
    {
        gHitMarker |= HITMARKER_x80000;
        gBattlescriptCurrInstr = BattleScript_EndTurn;
        return;
    }
    if (CantUseMove()) {return;}
    if (AbilityBattleEffects(2, gBankTarget, 0, 0, 0)) {return;}
    if (!gBattleMons[gBankAttacker].pp[gCurrMovePos] && gCurrentMove != MOVE_STRUGGLE && !(gHitMarker & 0x800200)
        && !(gBattleMons[gBankAttacker].status2 & STATUS2_MULTIPLETURNS))
        {
            gBattlescriptCurrInstr = BattleScript_NoPPForMove;
            gBattleMoveFlags |= MOVE_MISSED;
            return;
        }
    gHitMarker &= ~(HITMARKER_x800000);
    if (!(gHitMarker & HITMARKER_OBEYS) && !(gBattleMons[gBankAttacker].status2 & STATUS2_MULTIPLETURNS))
    {
        u8 disobedient = IsPokeDisobedient();
        asm("":::"r0"); //It's impossible to match
        asm("":::"r1");
        if ((disobedient))
        {
            if (disobedient == 2) {gHitMarker |= HITMARKER_OBEYS;}
            else {gBattleMoveFlags |= MOVE_MISSED;}
            return;
        }
    }
    gHitMarker |= HITMARKER_OBEYS;
    if (gProtectStructs[gBankTarget].BounceMove && gBattleMoves[gCurrentMove].flags & MAGICCOAT_AFFECTED)
    {
        PressurePPLose(gBankAttacker, gBankTarget, MOVE_MAGIC_COAT);
        gProtectStructs[gBankTarget].BounceMove = 0;
        b_movescr_stack_push_cursor();
        gBattlescriptCurrInstr = BattleScript_MagicCoatBounce;
        return;
    }
    for (i = 0; i < gNoOfAllBanks; i++)
    {
        if ((gProtectStructs[gTurnOrder[i]].StealMove) && gBattleMoves[gCurrentMove].flags & SNATCH_AFFECTED)
        {
            PressurePPLose(gBankAttacker, gTurnOrder[i], MOVE_SNATCH);
            gProtectStructs[gTurnOrder[i]].StealMove = 0;
            BATTLE_STRUCT->ScriptingActive = gTurnOrder[i];
            b_movescr_stack_push_cursor();
            gBattlescriptCurrInstr = BattleScript_SnatchedMove;
            return;
        }
    }
    if (gSpecialStatuses[gBankTarget].lightning_rod_redirected)
    {
        gSpecialStatuses[gBankTarget].lightning_rod_redirected = 0;
        gLastUsedAbility = ABILITY_LIGHTNING_ROD;
        b_movescr_stack_push_cursor();
        gBattlescriptCurrInstr = BattleScript_TookAttack;
        RecordAbilityBattle(gBankTarget, gLastUsedAbility);
    }
    else if (TargetProtectAffected &&
        (gCurrentMove != MOVE_CURSE || (gBattleMons[gBankAttacker].type1 == TYPE_GHOST || gBattleMons[gBankAttacker].type2 == TYPE_GHOST)) &&
        ((!IsTwoTurnsMove(gCurrentMove) || (gBattleMons[gBankAttacker].status2 & STATUS2_MULTIPLETURNS))))
    {
        CancelMultiTurnMoves(gBankAttacker);
        gBattleMoveFlags |= MOVE_MISSED;
        gMoveHitWith[gBankTarget] = 0;
        gUnknown_02024C44[gBankTarget] = 0;
        gBattleCommunication[6] = 1;
        gBattlescriptCurrInstr++;
    }
    else
        gBattlescriptCurrInstr++;
}

void JumpIfMoveFailed(u8 adder, u16 move)
{
    void* to_store = gBattlescriptCurrInstr + adder;
    if (gBattleMoveFlags & MOVE_NO_EFFECT)
    {
        gMoveHitWith[gBankTarget] = 0;
        gUnknown_02024C44[gBankTarget] = 0;
        to_store = BSScriptReadPtr(gBattlescriptCurrInstr + 1);
    }
    else
    {
        DestinyBondFlagUpdate();
        if (AbilityBattleEffects(3, gBankTarget, 0, 0, move)) {return;}
    }
    gBattlescriptCurrInstr = to_store;
}

void atk40_jump_if_move_affected_by_protect(void)
{
    if (TargetProtectAffected)
    {
        gBattleMoveFlags |= MOVE_MISSED;
        JumpIfMoveFailed(5, 0);
        gBattleCommunication[6] = 1;
    }
    else
        gBattlescriptCurrInstr += 5;
}

bool8 JumpIfMoveAffectedByProtect(u16 move)
{
    bool8 affected = 0;
    if (TargetProtectAffected)
    {
        gBattleMoveFlags |= MOVE_MISSED;
        JumpIfMoveFailed(7, move);
        gBattleCommunication[6] = 1;
        affected = 1;
    }
    return affected;
}

bool8 AccuracyCalcHelper(u16 move)
{
    if (gStatuses3[gBankTarget] & STATUS3_ALWAYS_HITS && gDisableStructs[gBankTarget].BankWithSureHit == gBankAttacker)
    {
        JumpIfMoveFailed(7, move);
        return 1;
    }

    if (!(gHitMarker & HITMARKER_IGNORE_ON_AIR) && gStatuses3[gBankTarget] & STATUS3_ON_AIR)
    {
        gBattleMoveFlags |= MOVE_MISSED;
        JumpIfMoveFailed(7, move);
        return 1;
    }
    gHitMarker &= ~HITMARKER_IGNORE_ON_AIR;

    if (!(gHitMarker & HITMARKER_IGNORE_UNDERGROUND) && gStatuses3[gBankTarget] & STATUS3_UNDERGROUND)
    {
        gBattleMoveFlags |= MOVE_MISSED;
        JumpIfMoveFailed(7, move);
        return 1;
    }
    gHitMarker &= ~HITMARKER_IGNORE_UNDERGROUND;

    if (!(gHitMarker & HITMARKER_IGNORE_UNDERWATER) && gStatuses3[gBankTarget] & STATUS3_UNDERWATER)
    {
        gBattleMoveFlags |= MOVE_MISSED;
        JumpIfMoveFailed(7, move);
        return 1;
    }
    gHitMarker &= ~HITMARKER_IGNORE_UNDERWATER;

    if ((WeatherHasEffect && (gBattleWeather & WEATHER_RAINY) && gBattleMoves[move].effect == EFFECT_THUNDER)
        || (gBattleMoves[move].effect == EFFECT_ALWAYS_HIT || gBattleMoves[move].effect == EFFECT_VITAL_THROW))
        {
            JumpIfMoveFailed(7, move);
            return 1;
        }
    return 0;
}

void atk01_accuracycheck(void)
{
    u16 move = BSScriptRead16(gBattlescriptCurrInstr + 5);
    if (move == 0xFFFE || move == 0xFFFF)
    {
        if (gStatuses3[gBankTarget] & STATUS3_ALWAYS_HITS && move == 0xFFFF && gDisableStructs[gBankTarget].BankWithSureHit == gBankAttacker)
            gBattlescriptCurrInstr += 7;
        else if (gStatuses3[gBankTarget] & (STATUS3_ON_AIR | STATUS3_UNDERGROUND | STATUS3_UNDERWATER))
            gBattlescriptCurrInstr = BSScriptReadPtr(gBattlescriptCurrInstr + 1);
        else if (!JumpIfMoveAffectedByProtect(0))
            gBattlescriptCurrInstr += 7;
    }
    else
    {
        u8 type; s8 buff; u8 MoveAcc; u16 calc; u8 hold_effect; u8 quality;
        if (move == 0) {move = gCurrentMove;}

        if (BATTLE_STRUCT->DynamicMoveType)
            type = BATTLE_STRUCT->DynamicMoveType & 0x3F;
        else
            type = gBattleMoves[move].type;

        if (JumpIfMoveAffectedByProtect(move)) {return;}
        if (AccuracyCalcHelper(move)) {return;}

        if (gBattleMons[gBankTarget].status2 & STATUS2_FORESIGHT)
        {
            u8 acc = gBattleMons[gBankAttacker].statStages[ACC_BUFF];
            buff = acc;
        }

        else
        {
            u8 acc = gBattleMons[gBankAttacker].statStages[ACC_BUFF];
            buff = acc + 6 - gBattleMons[gBankTarget].statStages[EVASION_BUFF];
        }

        if (buff < 0)   {buff = 0;}
        if (buff > 0xC) {buff = 0xC;}

        MoveAcc = gBattleMoves[move].accuracy;
        //check Thunder on sunny weather
        if (WeatherHasEffect && gBattleWeather & WEATHER_SUNNY && gBattleMoves[move].effect == EFFECT_THUNDER)
            MoveAcc = 50;

        calc = gAccuracyStageRatios[buff].dividend * MoveAcc;
        calc /= gAccuracyStageRatios[buff].divisor;

        if (gBattleMons[gBankAttacker].ability == ABILITY_COMPOUND_EYES)
            calc = (calc * 130) / 100; //1.3 compound eyes boost
        if (WeatherHasEffect && gBattleMons[gBankTarget].ability == ABILITY_SAND_VEIL && gBattleWeather & WEATHER_SANDSTORMY)
            calc = (calc * 80) / 100; //1.2 sand veil loss;
        if (gBattleMons[gBankAttacker].ability == ABILITY_HUSTLE && type < 9)
            calc = (calc * 80) / 100; //1.2 hustle loss;

        if (gBattleMons[gBankTarget].item == ITEM_ENIGMA_BERRY)
            hold_effect = gEnigmaBerries[gBankTarget].holdEffect, quality = gEnigmaBerries[gBankTarget].holdEffectParam;
        else
        {
            hold_effect = ItemId_GetHoldEffect(gBattleMons[gBankTarget].item);
            quality = ItemId_GetHoldEffectParam(gBattleMons[gBankTarget].item);
        }

        gStringBank = gBankTarget;

        if (hold_effect == HOLD_EFFECT_EVASION_UP)
            calc = (calc * (100 - quality)) / 100;

        //final calculation
        if ((Random() % 100 + 1) > calc)
        {
            gBattleMoveFlags |= MOVE_MISSED;
            if (gBattleTypeFlags & BATTLE_TYPE_DOUBLE && (gBattleMoves[move].target == 0x8 || gBattleMoves[move].target == 0x20))
                gBattleCommunication[6] = 2;
            else
                gBattleCommunication[6] = 0;
            b_wonderguard_and_levitate();

        }
        JumpIfMoveFailed(7, move);
    }
}

void atk02_attackstring(void)
{
    if (gBattleExecBuffer) {return;}
    if (!(gHitMarker & (HITMARKER_NO_ATTACKSTRING | HITMARKER_ATTACKSTRING_PRINTED)))
    {
        PrepareStringBattle(4, gBankAttacker);
        gHitMarker |= HITMARKER_ATTACKSTRING_PRINTED;
    }
    gBattlescriptCurrInstr++;
    gBattleCommunication[MSG_DISPLAY] = 0;
}

void atk03_ppreduce(void)
{
    int to_deduct = 1;
    if (gBattleExecBuffer) {return;}
    if (!gSpecialStatuses[gBankAttacker].flag20)
    {
        switch (gBattleMoves[gCurrentMove].target)
        {
        case TARGET_FOES_AND_ALLY:
            to_deduct += AbilityBattleEffects(ABILITT_COUNT_ON_FIELD, gBankAttacker, ABILITY_PRESSURE, 0, 0);
            break;
        case TARGET_BOTH:
        case TARGET_OPPONENTS_FIELD:
            to_deduct += AbilityBattleEffects(ABILITY_COUNT_OTHER_SIDE, gBankAttacker, ABILITY_PRESSURE, 0, 0);
            break;
        default:
            if (gBankAttacker != gBankTarget && gBattleMons[gBankTarget].ability == ABILITY_PRESSURE)
                to_deduct++;
            break;
        }
    }
    if (!(gHitMarker & (HITMARKER_NO_PPDEDUCT | HITMARKER_NO_ATTACKSTRING)) && gBattleMons[gBankAttacker].pp[gCurrMovePos])
    {
        gProtectStructs[gBankAttacker].NotFirstStrike = 1;
        if (gBattleMons[gBankAttacker].pp[gCurrMovePos] > to_deduct)
            gBattleMons[gBankAttacker].pp[gCurrMovePos] -= to_deduct;
        else
            gBattleMons[gBankAttacker].pp[gCurrMovePos] = 0;

        if (!(gBattleMons[gBankAttacker].status2 & STATUS2_TRANSFORMED)
            && !((gDisableStructs[gBankAttacker].TruantCounter >> 4) & gBitTable[gCurrMovePos]))
        {
            gActiveBank = gBankAttacker;
            EmitSetAttributes(0, REQUEST_PPMOVE1_BATTLE + gCurrMovePos, 0, 1, &gBattleMons[gBankAttacker].pp[gCurrMovePos]);
            MarkBufferBankForExecution(gBankAttacker);
        }
    }
    gHitMarker &= ~(HITMARKER_NO_PPDEDUCT);
    gBattlescriptCurrInstr++;
}

void atk04_critcalc(void)
{
    u8 hold_effect; u16 item; u16 crit_chance; int adderv3, adderv5, adderv6, adderv7, adderv8, adderv9, adderv10, adderv11; u16 adderv12;
    item = gBattleMons[gBankAttacker].item;
    if (item == ITEM_ENIGMA_BERRY)
        hold_effect = gEnigmaBerries[gBankAttacker].holdEffect;
    else
        hold_effect = ItemId_GetHoldEffect(item);

    gStringBank = gBankAttacker;

    if (gBattleMons[gBankAttacker].status2 & STATUS2_FOCUS_ENERGRY)
        adderv3 = 2;
    else
        adderv3 = 0;

    if (gBattleMoves[gCurrentMove].effect == EFFECT_HIGH_CRITICAL) {adderv3++;}
    adderv5 = adderv3;
    if (gBattleMoves[gCurrentMove].effect == EFFECT_SKY_ATTACK) {adderv5 = adderv3 + 1;}

    if (gBattleMoves[gCurrentMove].effect == EFFECT_BLAZE_KICK) {adderv5++;}
    adderv6 = adderv5;
    if (gBattleMoves[gCurrentMove].effect == EFFECT_POISON_TAIL) {adderv6 = adderv5 + 1;}

    adderv7 = 0;
    if (hold_effect == HOLD_EFFECT_LUCKY_PUNCH && gBattleMons[gBankAttacker].species == SPECIES_CHANSEY) {adderv7 = 1;}
    adderv8 = 2 * adderv7;
    adderv9 = 0;
    if (hold_effect == HOLD_EFFECT_STICK && gBattleMons[gBankAttacker].species == SPECIES_FARFETCHD) {adderv9 = 1;}
    adderv11 = 2 * adderv9;
    if (hold_effect == HOLD_EFFECT_SCOPE_LENS)
        {adderv10 = 1 + adderv6 + adderv8; adderv12 = adderv10 + adderv11;}
    else
        {adderv10 = adderv6 + adderv8; adderv12 = adderv10 + adderv11;}

    crit_chance = adderv12;

    if (crit_chance > 4) {crit_chance = 4;}

    if ((gBattleMons[gBankTarget].ability != ABILITY_BATTLE_ARMOR && gBattleMons[gBankTarget].ability != ABILITY_SHELL_ARMOR)
        && !(gStatuses3[gBankAttacker] & STATUS3_CANT_SCORE_A_CRIT)
        && !(gBattleTypeFlags & (BATTLE_TYPE_WALLY_TUTORIAL | BATTLE_TYPE_FIRST_BATTLE))
        && !(Random() % gCriticalHitChance[crit_chance]))
            gCritMultiplier = 2;

    else
        gCritMultiplier = 1;
    gBattlescriptCurrInstr++;
}

void atk05_damagecalc1(void)
{
    u16 side_hword = gSideAffecting[GetBankIdentity(gBankTarget) & 1];
    gBattleMoveDamage = CalculateBaseDamage(&gBattleMons[gBankAttacker], &gBattleMons[gBankTarget], gCurrentMove,
                                            side_hword, gDynamicBasePower,
                                            BATTLE_STRUCT->DynamicMoveType, gBankAttacker, gBankTarget);
    gBattleMoveDamage = gBattleMoveDamage * gCritMultiplier * BATTLE_STRUCT->DmgMultiplier;

    if (gStatuses3[gBankAttacker] & STATUS3_CHARGED_UP && gBattleMoves[gCurrentMove].type == TYPE_ELECTRIC)
        gBattleMoveDamage *= 2;
    if (gProtectStructs[gBankAttacker].HelpingHand)
        gBattleMoveDamage = gBattleMoveDamage * 15 / 10;

    gBattlescriptCurrInstr++;
}

void AI_CalcDmg(u8 BankAtk, u8 BankDef)
{
    u16 side_hword = gSideAffecting[GetBankIdentity(BankDef) & 1];
    gBattleMoveDamage = CalculateBaseDamage(&gBattleMons[BankAtk], &gBattleMons[BankDef], gCurrentMove,
                                            side_hword, gDynamicBasePower,
                                            BATTLE_STRUCT->DynamicMoveType, BankAtk, BankDef);
    gDynamicBasePower = 0;
    gBattleMoveDamage = gBattleMoveDamage * gCritMultiplier * BATTLE_STRUCT->DmgMultiplier;

    if (gStatuses3[BankAtk] & STATUS3_CHARGED_UP && gBattleMoves[gCurrentMove].type == TYPE_ELECTRIC)
        gBattleMoveDamage *= 2;
    if (gProtectStructs[BankAtk].HelpingHand)
        gBattleMoveDamage = gBattleMoveDamage * 15 / 10;
}

void ModulateDmgByType(u8 multiplier)
{
    gBattleMoveDamage = gBattleMoveDamage * multiplier / 10;
    if (gBattleMoveDamage == 0 && multiplier != 0) {gBattleMoveDamage = 1;}

    switch (multiplier)
    {
    case 0: //no effect
        gBattleMoveFlags |= MOVE_NOTAFFECTED;
        gBattleMoveFlags &= ~MOVE_NOTVERYEFFECTIVE;
        gBattleMoveFlags &= ~MOVE_SUPEREFFECTIVE;
        break;
    case 5: //not very effecting
        if (gBattleMoves[gCurrentMove].power && !(gBattleMoveFlags & MOVE_NO_EFFECT))
        {
            if (gBattleMoveFlags & MOVE_SUPEREFFECTIVE)
                gBattleMoveFlags &= ~MOVE_SUPEREFFECTIVE;
            else
                gBattleMoveFlags |= MOVE_NOTVERYEFFECTIVE;
        }
        break;
    case 20: //super effective
        if (gBattleMoves[gCurrentMove].power && !(gBattleMoveFlags & MOVE_NO_EFFECT))
        {
            if (gBattleMoveFlags & MOVE_NOTVERYEFFECTIVE)
                gBattleMoveFlags &= ~MOVE_NOTVERYEFFECTIVE;
            else
                gBattleMoveFlags |= MOVE_SUPEREFFECTIVE;
        }
        break;
    }
}

void atk06_typecalc(void)
{
    int i = 0;
    u8 move_type;
    if (gCurrentMove == MOVE_STRUGGLE) {goto END;}

    if (BATTLE_STRUCT->DynamicMoveType)
        move_type = BATTLE_STRUCT->DynamicMoveType & 0x3F;
    else
        move_type = gBattleMoves[gCurrentMove].type;

    //check stab
    if (gBattleMons[gBankAttacker].type1 == move_type || gBattleMons[gBankAttacker].type2 == move_type)
    {
        gBattleMoveDamage = gBattleMoveDamage * 15;
        gBattleMoveDamage = gBattleMoveDamage / 10;
    }

    if (gBattleMons[gBankTarget].ability == ABILITY_LEVITATE && move_type == TYPE_GROUND)
    {
        gLastUsedAbility = gBattleMons[gBankTarget].ability;
        gBattleMoveFlags |= (MOVE_MISSED | MOVE_NOTAFFECTED);
        gMoveHitWith[gBankTarget] = 0;
        gUnknown_02024C44[gBankTarget] = 0;
        gBattleCommunication[6] = move_type;
        RecordAbilityBattle(gBankTarget, gLastUsedAbility);
    }
    else
    {
        while (gTypeEffectiveness[i]!= TYPE_ENDTABLE)
        {
            if (gTypeEffectiveness[i] == TYPE_FORESIGHT)
            {
                if (gBattleMons[gBankTarget].status2 & STATUS2_FORESIGHT) {break;}
                else {i += 3; continue;}
            }

            if (gTypeEffectiveness[i] == move_type)
            {
                //check type1
                if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type1)
                    ModulateDmgByType(gTypeEffectiveness[i + 2]);
                //check type2
                if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type2 &&
                    gBattleMons[gBankTarget].type1 != gBattleMons[gBankTarget].type2)
                    ModulateDmgByType(gTypeEffectiveness[i + 2]);
            }
            i += 3;
        }
    }

    if (gBattleMons[gBankTarget].ability == ABILITY_WONDER_GUARD && AttacksThisTurn(gBankAttacker, gCurrentMove) == 2 &&
        (!(gBattleMoveFlags & MOVE_SUPEREFFECTIVE) || ((gBattleMoveFlags & (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE)) == (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE))) &&
        gBattleMoves[gCurrentMove].power)
    {
        gLastUsedAbility = ABILITY_WONDER_GUARD;
        gBattleMoveFlags |= MOVE_MISSED;
        gMoveHitWith[gBankTarget] = 0;
        gUnknown_02024C44[gBankTarget] = 0;
        gBattleCommunication[6] = 3;
        RecordAbilityBattle(gBankTarget, gLastUsedAbility);
    }
    if (gBattleMoveFlags & MOVE_NOTAFFECTED)
        gProtectStructs[gBankAttacker].NotEffective = 1;

    END:
        gBattlescriptCurrInstr++;
}

#define RecordAbilitySetField6(ability, fieldValue) \
(gLastUsedAbility = ability, gBattleCommunication[6] = fieldValue, RecordAbilityBattle(gBankTarget, ability)) \

void b_wonderguard_and_levitate(void)
{
    u8 flags = 0;
    int i = 0;
    u8 move_type;
    if (gCurrentMove == MOVE_STRUGGLE || !gBattleMoves[gCurrentMove].power) {return;}

    if (BATTLE_STRUCT->DynamicMoveType)
        move_type = BATTLE_STRUCT->DynamicMoveType & 0x3F;
    else
        move_type = gBattleMoves[gCurrentMove].type;

    if (gBattleMons[gBankTarget].ability == ABILITY_LEVITATE && move_type == TYPE_GROUND)
    {
        RecordAbilitySetField6(ABILITY_LEVITATE, move_type);
        return;
    }

    while (gTypeEffectiveness[i]!= TYPE_ENDTABLE)
    {
        if (gTypeEffectiveness[i] == TYPE_FORESIGHT)
        {
            if (gBattleMons[gBankTarget].status2 & STATUS2_FORESIGHT) {break;}
            else {i += 3; continue;}
        }

        if (gTypeEffectiveness[i] == move_type)
        {
            //check no effect
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type1 && gTypeEffectiveness[i + 2] == 0)
            {
                gBattleMoveFlags |= MOVE_NOTAFFECTED;
                gProtectStructs[gBankAttacker].NotEffective = 1;
            }
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type2 &&
                gBattleMons[gBankTarget].type1 != gBattleMons[gBankTarget].type2 &&
                gTypeEffectiveness[i + 2] == 0)
            {
                gBattleMoveFlags |= MOVE_NOTAFFECTED;
                gProtectStructs[gBankAttacker].NotEffective = 1;
            }

            //check super effective
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type1 && gTypeEffectiveness[i + 2] == 20)
                { flags |= 1;}
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type2 &&
                gBattleMons[gBankTarget].type1 != gBattleMons[gBankTarget].type2 &&
                gTypeEffectiveness[i + 2] == 20)
                    { flags |= 1;}

            //check not very effective
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type1 && gTypeEffectiveness[i + 2] == 5)
                { flags |= 2;}
            if (gTypeEffectiveness[i + 1] == gBattleMons[gBankTarget].type2 &&
                gBattleMons[gBankTarget].type1 != gBattleMons[gBankTarget].type2 &&
                gTypeEffectiveness[i + 2] == 5)
                    { flags |= 2;}
        }
        i += 3;
    }

    if (gBattleMons[gBankTarget].ability == ABILITY_WONDER_GUARD && AttacksThisTurn(gBankAttacker, gCurrentMove) == 2)
    {
        register u8 three asm("r0") = (1 | 2);
        if (!((flags & three) == 1) && gBattleMoves[gCurrentMove].power)
        {
            RecordAbilitySetField6(ABILITY_WONDER_GUARD, 3);
        }
    }
}

void ModulateDmgByType2(u8 multiplier, u16 move, u8* flags) //a literal copy of the ModulateDmgbyType1 with different args...
{
    gBattleMoveDamage = gBattleMoveDamage * multiplier / 10;
    if (gBattleMoveDamage == 0 && multiplier != 0) {gBattleMoveDamage = 1;}

    switch (multiplier)
    {
    case 0: //no effect
        *flags |= MOVE_NOTAFFECTED;
        *flags &= ~MOVE_NOTVERYEFFECTIVE;
        *flags &= ~MOVE_SUPEREFFECTIVE;
        break;
    case 5: //not very effecting
        if (gBattleMoves[move].power && !(*flags & MOVE_NO_EFFECT))
        {
            if (*flags & MOVE_SUPEREFFECTIVE)
                *flags &= ~MOVE_SUPEREFFECTIVE;
            else
                *flags |= MOVE_NOTVERYEFFECTIVE;
        }
        break;
    case 20: //super effective
        if (gBattleMoves[move].power && !(*flags & MOVE_NO_EFFECT))
        {
            if (*flags & MOVE_NOTVERYEFFECTIVE)
                *flags &= ~MOVE_NOTVERYEFFECTIVE;
            else
                *flags |= MOVE_SUPEREFFECTIVE;
        }
        break;
    }
}

#ifdef NONMATCHING
u8 TypeCalc(u16 move, u8 bank_atk, u8 bank_def)
{
    int i = 0;
    u8 flags = 0;
    u8 move_type;
    if (move == MOVE_STRUGGLE) {return 0;}

    move_type = gBattleMoves[move].type;

    //check stab
    if (gBattleMons[bank_atk].type1 == move_type || gBattleMons[bank_atk].type2 == move_type)
    {
        gBattleMoveDamage = gBattleMoveDamage * 15;
        gBattleMoveDamage = gBattleMoveDamage / 10;
    }

    if (gBattleMons[bank_def].ability == ABILITY_LEVITATE && move_type == TYPE_GROUND)
    {
        flags |= (MOVE_MISSED | MOVE_NOTAFFECTED);
    }
    else
    {
        while (gTypeEffectiveness[i]!= TYPE_ENDTABLE)
        {
            if (gTypeEffectiveness[i] == TYPE_FORESIGHT)
            {
                if (gBattleMons[bank_def].status2 & STATUS2_FORESIGHT) {break;}
                else {i += 3; continue;}
            }

            else if (gTypeEffectiveness[i] == move_type)
            {
                //check type1
                if (gTypeEffectiveness[i + 1] == gBattleMons[bank_def].type1)
                    ModulateDmgByType2(gTypeEffectiveness[i + 2], move, &flags);
                //check type2
                if (gTypeEffectiveness[i + 1] == gBattleMons[bank_def].type2 &&
                    gBattleMons[bank_def].type1 != gBattleMons[bank_def].type2)
                    ModulateDmgByType2(gTypeEffectiveness[i + 2], move, &flags);
            }
            i += 3;
        }
    }

    if (gBattleMons[bank_def].ability == ABILITY_WONDER_GUARD && !(flags & MOVE_MISSED) &&
        AttacksThisTurn(bank_atk, move) == 2 &&
        (!(flags & MOVE_SUPEREFFECTIVE) || ((flags & (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE)) == (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE))) &&
        gBattleMoves[move].power)
    {
        flags |= MOVE_MISSED;
    }
    return flags;
}
#else
__attribute__((naked))
u8 TypeCalc(u16 move, u8 bank_atk, u8 bank_def)
{
    asm(".syntax unified\n\
    push {r4-r7,lr}\n\
    mov r7, r10\n\
    mov r6, r9\n\
    mov r5, r8\n\
    push {r5-r7}\n\
    sub sp, 0x14\n\
    lsls r0, 16\n\
    lsrs r0, 16\n\
    mov r10, r0\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    str r1, [sp, 0x4]\n\
    lsls r2, 24\n\
    lsrs r2, 24\n\
    mov r9, r2\n\
    movs r7, 0\n\
    mov r0, sp\n\
    strb r7, [r0]\n\
    mov r0, r10\n\
    cmp r0, 0xA5\n\
    bne _0801D2AE\n\
    movs r0, 0\n\
    b _0801D43A\n\
    _0801D2AE:\n\
    ldr r1, _0801D31C @ =gBattleMoves\n\
    mov r3, r10\n\
    lsls r2, r3, 1\n\
    adds r0, r2, r3\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldrb r0, [r0, 0x2]\n\
    str r0, [sp, 0x8]\n\
    ldr r1, _0801D320 @ =gBattleMons\n\
    movs r0, 0x58\n\
    ldr r3, [sp, 0x4]\n\
    muls r0, r3\n\
    adds r3, r0, r1\n\
    adds r0, r3, 0\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    str r2, [sp, 0xC]\n\
    adds r5, r1, 0\n\
    ldr r1, [sp, 0x8]\n\
    cmp r0, r1\n\
    beq _0801D2E2\n\
    adds r0, r3, 0\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, r1\n\
    bne _0801D2F4\n\
    _0801D2E2:\n\
    ldr r4, _0801D324 @ =gBattleMoveDamage\n\
    ldr r1, [r4]\n\
    lsls r0, r1, 4\n\
    subs r0, r1\n\
    str r0, [r4]\n\
    movs r1, 0xA\n\
    bl __divsi3\n\
    str r0, [r4]\n\
    _0801D2F4:\n\
    movs r0, 0x58\n\
    mov r2, r9\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    adds r0, r5\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x1A\n\
    bne _0801D328\n\
    ldr r3, [sp, 0x8]\n\
    cmp r3, 0x4\n\
    bne _0801D328\n\
    movs r1, 0x9\n\
    mov r0, sp\n\
    ldrb r0, [r0]\n\
    orrs r0, r1\n\
    mov r1, sp\n\
    strb r0, [r1]\n\
    b _0801D3DC\n\
    .align 2, 0\n\
    _0801D31C: .4byte gBattleMoves\n\
    _0801D320: .4byte gBattleMons\n\
    _0801D324: .4byte gBattleMoveDamage\n\
    _0801D328:\n\
    ldr r1, _0801D344 @ =gTypeEffectiveness\n\
    adds r0, r7, r1\n\
    ldrb r0, [r0]\n\
    adds r2, r1, 0\n\
    cmp r0, 0xFF\n\
    beq _0801D3DC\n\
    cmp r0, 0xFE\n\
    bne _0801D34C\n\
    movs r0, 0x58\n\
    mov r1, r9\n\
    muls r1, r0\n\
    adds r0, r1, 0\n\
    b _0801D3CA\n\
    .align 2, 0\n\
    _0801D344: .4byte gTypeEffectiveness\n\
    _0801D348:\n\
    adds r7, 0x3\n\
    b _0801D3B6\n\
    _0801D34C:\n\
    ldr r6, _0801D44C @ =gTypeEffectiveness\n\
    adds r0, r7, r6\n\
    ldrb r0, [r0]\n\
    ldr r2, [sp, 0x8]\n\
    cmp r0, r2\n\
    bne _0801D3B0\n\
    adds r1, r7, 0x1\n\
    adds r1, r6\n\
    ldr r3, _0801D450 @ =gBattleMons\n\
    mov r8, r3\n\
    movs r3, 0x58\n\
    mov r0, r9\n\
    muls r0, r3\n\
    mov r2, r8\n\
    adds r5, r0, r2\n\
    adds r0, r5, 0\n\
    adds r0, 0x21\n\
    ldrb r4, [r1]\n\
    ldrb r0, [r0]\n\
    cmp r4, r0\n\
    bne _0801D388\n\
    adds r0, r7, 0x2\n\
    adds r0, r6\n\
    ldrb r0, [r0]\n\
    mov r1, r10\n\
    mov r2, sp\n\
    str r3, [sp, 0x10]\n\
    bl ModulateDmgByType2\n\
    ldr r3, [sp, 0x10]\n\
    _0801D388:\n\
    adds r0, r5, 0\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r4, r0\n\
    bne _0801D3B0\n\
    ldr r0, _0801D454 @ =gBankTarget\n\
    ldrb r0, [r0]\n\
    muls r0, r3\n\
    add r0, r8\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    cmp r0, r4\n\
    beq _0801D3B0\n\
    adds r0, r7, 0x2\n\
    adds r0, r6\n\
    ldrb r0, [r0]\n\
    mov r1, r10\n\
    mov r2, sp\n\
    bl ModulateDmgByType2\n\
    _0801D3B0:\n\
    adds r7, 0x3\n\
    ldr r5, _0801D450 @ =gBattleMons\n\
    ldr r2, _0801D44C @ =gTypeEffectiveness\n\
    _0801D3B6:\n\
    adds r0, r7, r2\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xFF\n\
    beq _0801D3DC\n\
    cmp r0, 0xFE\n\
    bne _0801D34C\n\
    movs r0, 0x58\n\
    mov r3, r9\n\
    muls r3, r0\n\
    adds r0, r3, 0\n\
    _0801D3CA:\n\
    adds r1, r5, 0\n\
    adds r1, 0x50\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 22\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801D348\n\
    _0801D3DC:\n\
    movs r0, 0x58\n\
    mov r1, r9\n\
    muls r1, r0\n\
    adds r0, r1, 0\n\
    adds r0, r5\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x19\n\
    bne _0801D436\n\
    mov r0, sp\n\
    ldrb r1, [r0]\n\
    movs r0, 0x1\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801D436\n\
    ldr r0, [sp, 0x4]\n\
    mov r1, r10\n\
    bl AttacksThisTurn\n\
    lsls r0, 24\n\
    lsrs r1, r0, 24\n\
    cmp r1, 0x2\n\
    bne _0801D436\n\
    mov r0, sp\n\
    ldrb r3, [r0]\n\
    adds r0, r1, 0\n\
    ands r0, r3\n\
    cmp r0, 0\n\
    beq _0801D41E\n\
    movs r0, 0x6\n\
    ands r0, r3\n\
    cmp r0, 0x6\n\
    bne _0801D436\n\
    _0801D41E:\n\
    ldr r0, _0801D458 @ =gBattleMoves\n\
    ldr r1, [sp, 0xC]\n\
    add r1, r10\n\
    lsls r1, 2\n\
    adds r1, r0\n\
    ldrb r0, [r1, 0x1]\n\
    cmp r0, 0\n\
    beq _0801D436\n\
    mov r0, sp\n\
    movs r1, 0x1\n\
    orrs r1, r3\n\
    strb r1, [r0]\n\
    _0801D436:\n\
    mov r0, sp\n\
    ldrb r0, [r0]\n\
    _0801D43A:\n\
    add sp, 0x14\n\
    pop {r3-r5}\n\
    mov r8, r3\n\
    mov r9, r4\n\
    mov r10, r5\n\
    pop {r4-r7}\n\
    pop {r1}\n\
    bx r1\n\
    .align 2, 0\n\
    _0801D44C: .4byte gTypeEffectiveness\n\
    _0801D450: .4byte gBattleMons\n\
    _0801D454: .4byte gBankTarget\n\
    _0801D458: .4byte gBattleMoves\n\
        .syntax divided\n");
}
#endif // NONMATCHING

u8 AI_TypeCalc(u16 move, u16 species, u8 ability)
{
    int i = 0;
    u8 flags = 0;
    u8 type1 = gBaseStats[species].type1, type2 = gBaseStats[species].type2, move_type;
    if (move == MOVE_STRUGGLE) {return 0;}

    move_type = gBattleMoves[move].type;

    if (ability == ABILITY_LEVITATE && move_type == TYPE_GROUND)
        flags = MOVE_MISSED | MOVE_NOTAFFECTED;
    else
    {
        while (gTypeEffectiveness[i]!= TYPE_ENDTABLE)
        {
            if (gTypeEffectiveness[i] == TYPE_FORESIGHT) {i += 3; continue;}

            if (gTypeEffectiveness[i] == move_type)
            {
                //check type1
                if (gTypeEffectiveness[i + 1] == type1)
                    ModulateDmgByType2(gTypeEffectiveness[i + 2], move, &flags);
                //check type2
                if (gTypeEffectiveness[i + 1] == type2 && gBattleMons[gBankTarget].type1 != type2) //gf you morons, you should check if (type1 != type2)...
                    ModulateDmgByType2(gTypeEffectiveness[i + 2], move, &flags);
            }
            i += 3;
        }
    }
    if (ability == ABILITY_WONDER_GUARD &&
        (!(flags & MOVE_SUPEREFFECTIVE) || ((flags & (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE)) == (MOVE_SUPEREFFECTIVE | MOVE_NOTVERYEFFECTIVE))) &&
        gBattleMoves[move].power)
        flags |= MOVE_NOTAFFECTED;
    return flags;
}

static inline void RandDmgMultiplier(void)
{
    u16 rand = Random();
    u16 multiplier = 100 - (rand & 0xF);
    if (gBattleMoveDamage)
    {
        gBattleMoveDamage *= multiplier;
        gBattleMoveDamage /= 100;
        ATLEAST_ONE_PTR(&gBattleMoveDamage);
    }
}

void Unused_RandDmgMultiplier(void)
{
    RandDmgMultiplier();
}

void atk07_dmg_adjustment(void)
{
    u8 hold_effect, quality;
    RandDmgMultiplier();
    if (gBattleMons[gBankTarget].item == ITEM_ENIGMA_BERRY)
        hold_effect = gEnigmaBerries[gBankTarget].holdEffect, quality = gEnigmaBerries[gBankTarget].holdEffectParam;
    else
    {
        hold_effect = ItemId_GetHoldEffect(gBattleMons[gBankTarget].item);
        quality = ItemId_GetHoldEffectParam(gBattleMons[gBankTarget].item);
    }

    gStringBank = gBankTarget;

    if (hold_effect == HOLD_EFFECT_FOCUS_BAND && (Random() % 100) < quality)
    {
        RecordItemBattle(gBankTarget, hold_effect);
        gSpecialStatuses[gBankTarget].focus_banded = 1;
    }
    if (gBattleMons[gBankTarget].status2 & STATUS2_SUBSTITUTE) {goto END;}
    if (gBattleMoves[gCurrentMove].effect != EFFECT_FALSE_SWIPE && !gProtectStructs[gBankTarget].Endured
        && !gSpecialStatuses[gBankTarget].focus_banded) {goto END;}

    if (gBattleMons[gBankTarget].hp > gBattleMoveDamage) {goto END;}

    gBattleMoveDamage = gBattleMons[gBankTarget].hp - 1;

    if (gProtectStructs[gBankTarget].Endured)
    {
        gBattleMoveFlags |= MOVE_ENDURED;
        goto END;
    }
    if (gSpecialStatuses[gBankTarget].focus_banded)
    {
        gBattleMoveFlags |= MOVE_HANGEDON;
        gLastUsedItem = gBattleMons[gBankTarget].item;
    }

    END:
        gBattlescriptCurrInstr++;
}

void atk08_dmg_adjustment2(void) //literally the same as 0x7 except it doesn't check for false swipe move effect...
{
    u8 hold_effect, quality;
    RandDmgMultiplier();
    if (gBattleMons[gBankTarget].item == ITEM_ENIGMA_BERRY)
        hold_effect = gEnigmaBerries[gBankTarget].holdEffect, quality = gEnigmaBerries[gBankTarget].holdEffectParam;
    else
    {
        hold_effect = ItemId_GetHoldEffect(gBattleMons[gBankTarget].item);
        quality = ItemId_GetHoldEffectParam(gBattleMons[gBankTarget].item);
    }

    gStringBank = gBankTarget;

    if (hold_effect == HOLD_EFFECT_FOCUS_BAND && (Random() % 100) < quality)
    {
        RecordItemBattle(gBankTarget, hold_effect);
        gSpecialStatuses[gBankTarget].focus_banded = 1;
    }
    if (gBattleMons[gBankTarget].status2 & STATUS2_SUBSTITUTE) {goto END;}
    if (!gProtectStructs[gBankTarget].Endured
        && !gSpecialStatuses[gBankTarget].focus_banded) {goto END;}

    if (gBattleMons[gBankTarget].hp > gBattleMoveDamage) {goto END;}

    gBattleMoveDamage = gBattleMons[gBankTarget].hp - 1;

    if (gProtectStructs[gBankTarget].Endured)
    {
        gBattleMoveFlags |= MOVE_ENDURED;
        goto END;
    }
    if (gSpecialStatuses[gBankTarget].focus_banded)
    {
        gBattleMoveFlags |= MOVE_HANGEDON;
        gLastUsedItem = gBattleMons[gBankTarget].item;
    }

    END:
        gBattlescriptCurrInstr++;
}

void atk09_attackanimation(void)
{
    if (gBattleExecBuffer) {return;}

    if ((gHitMarker & HITMARKER_NO_ANIMATIONS) && (gCurrentMove != MOVE_TRANSFORM && gCurrentMove != MOVE_SUBSTITUTE))
    {
        b_movescr_stack_push(gBattlescriptCurrInstr + 1);
        gBattlescriptCurrInstr = BattleScript_Pausex20;
        BATTLE_STRUCT->AnimTurn += 1;
        BATTLE_STRUCT->AnimTargetsHit += 1;
    }
    else
    {
        if ((gBattleMoves[gCurrentMove].target & TARGET_BOTH || gBattleMoves[gCurrentMove].target & TARGET_FOES_AND_ALLY || gBattleMoves[gCurrentMove].target & TARGET_DEPENDS) && BATTLE_STRUCT->AnimTargetsHit)
            {gBattlescriptCurrInstr++; return;}

        if (!(gBattleMoveFlags & MOVE_NO_EFFECT))
        {
            gActiveBank = gBankAttacker;

            EmitMoveAnimation(0, gCurrentMove, BATTLE_STRUCT->AnimTurn, gBattleMovePower, gBattleMoveDamage, gBattleMons[gBankAttacker].friendship, &gDisableStructs[gBankAttacker]);
            BATTLE_STRUCT->AnimTurn += 1;
            BATTLE_STRUCT->AnimTargetsHit += 1;
            MarkBufferBankForExecution(gBankAttacker);
            gBattlescriptCurrInstr++;
        }
        else
        {
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = BattleScript_Pausex20;
        }
    }
}

void atk0A_waitanimation(void)
{
    if (gBattleExecBuffer) {return;}
    gBattlescriptCurrInstr++;
}

void atk0B_healthbarupdate(void)
{
    if (gBattleExecBuffer) {return;}
    if (gBattleMoveFlags & MOVE_NO_EFFECT) {goto END;}

    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));

    if (gBattleMons[gActiveBank].status2 & STATUS2_SUBSTITUTE && gDisableStructs[gActiveBank].SubstituteHP && !(gHitMarker & HITMARKER_IGNORE_SUBSTITUTE))
        {PrepareStringBattle(0x80, gActiveBank); goto END;}

    EmitHealthBarUpdate(0, gBattleMoveDamage);
    MarkBufferBankForExecution(gActiveBank);

    if (!GetBankSide(gActiveBank) && gBattleMoveDamage > 0)
        {gBattleResults.unk5_0 = 1;}

    END:
        gBattlescriptCurrInstr += 2;
}

void atk0C_datahpupdate(void)
{
    register u32 move_type asm("r6"); //no idea how to match it otherwise
    u8 dynamic_move_type;
    if (gBattleExecBuffer) {return;}

    dynamic_move_type = BATTLE_STRUCT->DynamicMoveType;
    if (dynamic_move_type && !(dynamic_move_type & 0x40))
        {move_type = 0x3F; move_type &= dynamic_move_type;}
    else
        {move_type = gBattleMoves[gCurrentMove].type;}

    if (!(gBattleMoveFlags & MOVE_NO_EFFECT))
    {
        gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
        if (gBattleMons[gActiveBank].status2 & STATUS2_SUBSTITUTE && gDisableStructs[gActiveBank].SubstituteHP && !(gHitMarker & HITMARKER_IGNORE_SUBSTITUTE))
        {
            if (gDisableStructs[gActiveBank].SubstituteHP >= gBattleMoveDamage)
            {
                if (gSpecialStatuses[gActiveBank].moveturn_losthp == 0 ) {gSpecialStatuses[gActiveBank].moveturn_losthp = gBattleMoveDamage;}
                gDisableStructs[gActiveBank].SubstituteHP -= gBattleMoveDamage;
                gHP_dealt = gBattleMoveDamage;
            }
            else
            {
                if (gSpecialStatuses[gActiveBank].moveturn_losthp == 0 ) {gSpecialStatuses[gActiveBank].moveturn_losthp = gDisableStructs[gActiveBank].SubstituteHP;}
                gHP_dealt = gDisableStructs[gActiveBank].SubstituteHP;
                gDisableStructs[gActiveBank].SubstituteHP = 0;
            }
            //check substitute fading
            if (gDisableStructs[gActiveBank].SubstituteHP == 0)
            {
                gBattlescriptCurrInstr += 2;
                b_movescr_stack_push_cursor();
                gBattlescriptCurrInstr = BattleScript_SubstituteFade;
                return;
            }
        }
        else
        {
            gHitMarker &= ~(HITMARKER_IGNORE_SUBSTITUTE);
            if (gBattleMoveDamage < 0) //hp goes up
            {
                gBattleMons[gActiveBank].hp -= gBattleMoveDamage;
                if (gBattleMons[gActiveBank].hp > gBattleMons[gActiveBank].maxHP)
                    gBattleMons[gActiveBank].hp = gBattleMons[gActiveBank].maxHP;

            }
            else //hp goes down
            {
                if (gHitMarker & HITMARKER_x20)
                    { gHitMarker &= ~(HITMARKER_x20);}
                else
                {
                    gTakenDmg[gActiveBank] += gBattleMoveDamage;
                    if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 0)
                        gTakenDmgBanks[gActiveBank] = gBankAttacker;
                    else
                        gTakenDmgBanks[gActiveBank] = gBankTarget;
                }

                if (gBattleMons[gActiveBank].hp > gBattleMoveDamage)
                {
                    gBattleMons[gActiveBank].hp -= gBattleMoveDamage;
                    gHP_dealt = gBattleMoveDamage;
                }
                else
                {
                    gHP_dealt = gBattleMons[gActiveBank].hp;
                    gBattleMons[gActiveBank].hp = 0;
                }

                if (!gSpecialStatuses[gActiveBank].moveturn_losthp && !(gHitMarker & HITMARKER_x100000))
                    gSpecialStatuses[gActiveBank].moveturn_losthp = gHP_dealt;

                if (move_type <= 8 && !(gHitMarker & HITMARKER_x100000) && gCurrentMove != MOVE_PAIN_SPLIT)
                {
                    gProtectStructs[gActiveBank].PhysicalDmg = gHP_dealt;
                    gSpecialStatuses[gActiveBank].moveturn_losthp_physical = gHP_dealt;
                    if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 0)
                    {
                        gProtectStructs[gActiveBank].PhysicalBank = gBankAttacker;
                        gSpecialStatuses[gActiveBank].moveturn_physical_bank = gBankAttacker;
                    }
                    else
                    {
                        gProtectStructs[gActiveBank].PhysicalBank = gBankTarget;
                        gSpecialStatuses[gActiveBank].moveturn_physical_bank = gBankTarget;
                    }
                }
                else if (move_type > 8 && !(gHitMarker & HITMARKER_x100000))
                {
                    gProtectStructs[gActiveBank].SpecialDmg = gHP_dealt;
                    gSpecialStatuses[gActiveBank].moveturn_losthp_special = gHP_dealt;
                    if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 0)
                    {
                        gProtectStructs[gActiveBank].SpecialBank = gBankAttacker;
                        gSpecialStatuses[gActiveBank].moveturn_special_bank = gBankAttacker;
                    }
                    else
                    {
                        gProtectStructs[gActiveBank].SpecialBank = gBankTarget;
                        gSpecialStatuses[gActiveBank].moveturn_special_bank = gBankTarget;
                    }
                }
            }
            gHitMarker &= ~(HITMARKER_x100000);
            EmitSetAttributes(0, REQUEST_HP_BATTLE, 0, 2, &gBattleMons[gActiveBank].hp);
            MarkBufferBankForExecution(gActiveBank);
        }
    }
    else
    {
        gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
        if (gSpecialStatuses[gActiveBank].moveturn_losthp == 0)
            gSpecialStatuses[gActiveBank].moveturn_losthp = 0xFFFF;
    }
    gBattlescriptCurrInstr += 2;
}

void atk0D_critmessage(void)
{
    if (gBattleExecBuffer) {return;}
    if (gCritMultiplier == 2 && !(gBattleMoveFlags & MOVE_NO_EFFECT))
        {PrepareStringBattle(0xD9, gBankAttacker); gBattleCommunication[MSG_DISPLAY] = 1;}
    gBattlescriptCurrInstr++;
}

void atk0E_effectiveness_sound(void)
{
    if (gBattleExecBuffer) {return;}
    gActiveBank = gBankTarget;
    if (!(gBattleMoveFlags & MOVE_MISSED))
    {
        u8 flag = ~MOVE_MISSED;
        switch (gBattleMoveFlags & flag)
        {
        case MOVE_SUPEREFFECTIVE:
            EmitEffectivenessSound(0, 14);
            MarkBufferBankForExecution(gActiveBank);
            break;
        case MOVE_NOTVERYEFFECTIVE:
            EmitEffectivenessSound(0, 12);
            MarkBufferBankForExecution(gActiveBank);
            break;
        case MOVE_NOTAFFECTED:
        case MOVE_FAILED:
            break;
        case MOVE_ENDURED:
        case MOVE_ONEHITKO:
        case MOVE_HANGEDON:
        default:
            if (gBattleMoveFlags & MOVE_SUPEREFFECTIVE)
                {EmitEffectivenessSound(0, 14); MarkBufferBankForExecution(gActiveBank);}
            else if (gBattleMoveFlags & MOVE_NOTVERYEFFECTIVE)
                {EmitEffectivenessSound(0, 12); MarkBufferBankForExecution(gActiveBank);}
            else if (!(gBattleMoveFlags & (MOVE_NOTAFFECTED | MOVE_FAILED)))
                {EmitEffectivenessSound(0, 13); MarkBufferBankForExecution(gActiveBank);}
            break;
        }
    }
    gBattlescriptCurrInstr++;
}

void atk0F_resultmessage(void)
{
    u16 stringID = 0;
    if (gBattleExecBuffer) {return;}

    if (gBattleMoveFlags & MOVE_MISSED && (!(gBattleMoveFlags & MOVE_NOTAFFECTED) || gBattleCommunication[6] > 2))
    {
        stringID = gMissStrings[gBattleCommunication[6]];
        gBattleCommunication[MSG_DISPLAY] = 1;
    }
    else
    {
        gBattleCommunication[MSG_DISPLAY] = 1;
        switch (gBattleMoveFlags & 0xFE)
        {
        case MOVE_SUPEREFFECTIVE:
            stringID = 0xDE; break;
        case MOVE_NOTVERYEFFECTIVE:
            stringID = 0xDD; break;
        case MOVE_ONEHITKO:
            stringID = 0xDA; break;
        case MOVE_ENDURED:
            stringID = 0x99; break;
        case MOVE_FAILED:
            goto FAILED;
        case MOVE_NOTAFFECTED:
            goto NOTAFFECTED;
        case MOVE_HANGEDON:
            gLastUsedItem = gBattleMons[gBankTarget].item;
            gStringBank = gBankTarget;
            gBattleMoveFlags &= ~(MOVE_ENDURED | MOVE_HANGEDON);
            b_movescr_stack_push_cursor();
            gBattlescriptCurrInstr = BattleScript_HangedOnMsg; return;
        default:
            if (gBattleMoveFlags & MOVE_NOTAFFECTED)
                NOTAFFECTED:
                    stringID = 0x1B;
            else if (gBattleMoveFlags & MOVE_ONEHITKO)
            {
                gBattleMoveFlags &= ~(MOVE_ONEHITKO);
                gBattleMoveFlags &= ~(MOVE_SUPEREFFECTIVE);
                gBattleMoveFlags &= ~(MOVE_NOTVERYEFFECTIVE);
                b_movescr_stack_push_cursor();
                gBattlescriptCurrInstr = BattleScript_OneHitKOMsg; return;
            }
            else if (gBattleMoveFlags & MOVE_ENDURED)
            {
                gBattleMoveFlags &= ~(MOVE_ENDURED | MOVE_HANGEDON);
                b_movescr_stack_push_cursor();
                gBattlescriptCurrInstr = BattleScript_EnduredMsg; return;
            }
            else if (gBattleMoveFlags & MOVE_HANGEDON)
            {
                gLastUsedItem = gBattleMons[gBankTarget].item;
                gStringBank = gBankTarget;
                gBattleMoveFlags &= ~(MOVE_ENDURED | MOVE_HANGEDON);
                b_movescr_stack_push_cursor();
                gBattlescriptCurrInstr = BattleScript_HangedOnMsg; return;
            }
            else if (gBattleMoveFlags & MOVE_FAILED)
                FAILED:
                    stringID = 0xE5;
            else
                gBattleCommunication[MSG_DISPLAY] = 0;
        }
    }

    if (stringID)
    {
        register u16 dummy asm("r0") = stringID; //Can't match it otherwise
        PrepareStringBattle(dummy, gBankAttacker);
    }
    gBattlescriptCurrInstr++;
}

void atk10_printstring(void)
{
    if (gBattleExecBuffer) {return;}

    PrepareStringBattle(BSScriptRead16(gBattlescriptCurrInstr + 1), gBankAttacker);
    gBattlescriptCurrInstr += 3;
    gBattleCommunication[MSG_DISPLAY] = 1;
}

void atk11_printstring_playeronly(void)
{
    gActiveBank = gBankAttacker;
    EmitPrintStringPlayerOnly(0, BSScriptRead16(gBattlescriptCurrInstr + 1));
    MarkBufferBankForExecution(gActiveBank);
    gBattlescriptCurrInstr += 3;
    gBattleCommunication[MSG_DISPLAY] = 1;
}

void atk12_waitmessage(void)
{
    if (gBattleExecBuffer) {return;}

    if (!gBattleCommunication[MSG_DISPLAY])
        gBattlescriptCurrInstr += 3;
    else
    {
        u16 to_wait = BSScriptRead16(gBattlescriptCurrInstr + 1);
        if (++gPauseCounterBattle >= to_wait)
        {
            gPauseCounterBattle = 0;
            gBattlescriptCurrInstr += 3;
            gBattleCommunication[MSG_DISPLAY] = 0;
        }
    }
}

void atk13_printfromtable(void)
{
    void* Ptr;
    if (gBattleExecBuffer) {return;}

    Ptr = BSScriptReadPtr(gBattlescriptCurrInstr + 1) + 2 * gBattleCommunication[MULTISTRING_CHOOSER];
    PrepareStringBattle(*(u16*)Ptr, gBankAttacker);
    gBattlescriptCurrInstr += 5;
    gBattleCommunication[MSG_DISPLAY] = 1;
}

void atk14_printfromtable_playeronly(void)
{
    void* Ptr;
    if (gBattleExecBuffer) {return;}

    Ptr = BSScriptReadPtr(gBattlescriptCurrInstr + 1) + 2 * gBattleCommunication[MULTISTRING_CHOOSER];
    gActiveBank = gBankAttacker;
    EmitPrintStringPlayerOnly(0, *(u16*)Ptr);
    MarkBufferBankForExecution(gActiveBank);
    gBattlescriptCurrInstr += 5;
    gBattleCommunication[MSG_DISPLAY] = 1;
}

u8 BankGetTurnOrder(u8 bank)
{
    int i;
    for (i = 0; i < gNoOfAllBanks; i++)
    {
        if (gTurnOrder[i] == bank) {break;}
    }
    return i;
}

//Someone please decompile this monstrosity below...
#ifdef NONMATCHING
void SetMoveEffect(bool8 primary, u8 certainArg)
{
    #define EffectAffectsUser 0x40
    register u8 certain asm("r5") = certainArg;
    register bool32 StatusChanged asm("r10") = 0;
    register int AffectsUser asm("r6") = 0; //0x40 otherwise
    bool32 NoSunCanFreeze = 1;

    if (gBattleCommunication[MOVE_EFFECT_BYTE] & EffectAffectsUser)
    {
        gEffectBank = gBankAttacker; //bank that effects get applied on
        gBattleCommunication[MOVE_EFFECT_BYTE] &= ~(EffectAffectsUser);
        AffectsUser = EffectAffectsUser;
        BATTLE_STRUCT->ScriptingActive = gBankTarget; //theoretically the attacker
    }
    else
    {
        gEffectBank = gBankTarget;
        BATTLE_STRUCT->ScriptingActive = gBankAttacker;
    }

    if (gBattleMons[gEffectBank].ability_id == ABILITY_SHIELD_DUST && !(gHitMarker & HITMARKER_IGNORE_SAFEGUARD) &&
        !primary && gBattleCommunication[MOVE_EFFECT_BYTE] <= 9)
        {gBattlescriptCurrInstr++; return;}

    if (gSideAffecting[get_bank_identity(gEffectBank) & 1] & SIDE_SAFEGUARD && !(gHitMarker & HITMARKER_IGNORE_SAFEGUARD) &&
        !primary && gBattleCommunication[MOVE_EFFECT_BYTE] <= 7)
        {gBattlescriptCurrInstr++; return;}

    //make sure at least ONE HP except payday and thief
    if (gBattleMons[gEffectBank].current_hp == 0 && gBattleCommunication[MOVE_EFFECT_BYTE] != 0xB && gBattleCommunication[MOVE_EFFECT_BYTE] != 0x1F)
        {gBattlescriptCurrInstr++; return;}

    if (gBattleMons[gEffectBank].status2 & STATUS2_SUBSTITUTE && AffectsUser != EffectAffectsUser)
        {gBattlescriptCurrInstr++; return;}

    if (gBattleCommunication[MOVE_EFFECT_BYTE] <= 6) //status change
    {
        switch (gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]])
        {
        case STATUS_SLEEP:
            //check active uproar
            if (gBattleMons[gEffectBank].ability_id != ABILITY_SOUNDPROOF)
            {
                for (gActiveBank = 0; gActiveBank < gNoOfAllBanks && !(gBattleMons[gActiveBank].status2 & STATUS2_UPROAR); gActiveBank++) {}
            }
            else
                gActiveBank = gNoOfAllBanks;
            if (gBattleMons[gEffectBank].status) {break;}
            if (gActiveBank != gNoOfAllBanks) {break;} //nice way of checking uproar...
            if (gBattleMons[gEffectBank].ability_id == ABILITY_VITAL_SPIRIT) {break;}
            if (gBattleMons[gEffectBank].ability_id == ABILITY_INSOMNIA) {break;}

            CancelMultiTurnMoves(gEffectBank);
            StatusChanged = 1;
            break;
        case STATUS_POISON:
            if (gBattleMons[gEffectBank].ability_id == ABILITY_IMMUNITY && (primary == 1 || certain == 0x80))
            {
                gLastUsedAbility = ABILITY_IMMUNITY;
                RecordAbility(gEffectBank, ABILITY_IMMUNITY);
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            //_0801E664:
                gBattlescriptCurrInstr = BS_PSN_PREVENTION;
                if (gHitMarker & HITMARKER_IGNORE_SAFEGUARD)
                {
                    gBattleCommunication.multistring_chooser = 1;
                    gHitMarker &= ~(HITMARKER_IGNORE_SAFEGUARD);
                    return;
                }
                else
                    {gBattleCommunication.multistring_chooser = 0; return;}
            }
            if ((gBattleMons[gEffectBank].type1 == TYPE_POISON || gBattleMons[gEffectBank].type2 == TYPE_POISON || gBattleMons[gEffectBank].type1 == TYPE_STEEL || gBattleMons[gEffectBank].type2 == TYPE_STEEL)
                && !(gHitMarker & HITMARKER_IGNORE_SAFEGUARD) && (primary == 1 || certain == 0x80))
            {
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_PSN_PREVENTION;
                gBattleCommunication.multistring_chooser = 2;
                return;
            }
            if (gBattleMons[gEffectBank].type1 == TYPE_POISON) {break;}
            if (gBattleMons[gEffectBank].type2 == TYPE_POISON) {break;}
            if (gBattleMons[gEffectBank].type1 == TYPE_STEEL) {break;}
            if (gBattleMons[gEffectBank].type2 == TYPE_STEEL) {break;}
            if (gBattleMons[gEffectBank].status) {break;}
            if (gBattleMons[gEffectBank].ability_id == ABILITY_IMMUNITY) {break;}
            StatusChanged = 1;
            break;
        case STATUS_BURN:
            if (gBattleMons[gEffectBank].ability_id == ABILITY_WATER_VEIL && (primary == 1 || certain == 0x80))
            {
                gLastUsedAbility = ABILITY_WATER_VEIL;
                RecordAbility(gEffectBank, ABILITY_WATER_VEIL);
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            //_0801E664:
                gBattlescriptCurrInstr = BS_BRN_PREVENTION;
                if (gHitMarker & HITMARKER_IGNORE_SAFEGUARD)
                {
                    gBattleCommunication.multistring_chooser = 1;
                    gHitMarker &= ~(HITMARKER_IGNORE_SAFEGUARD);
                    return;
                }
                else
                    {gBattleCommunication.multistring_chooser = 0; return;}
            }
            if ((gBattleMons[gEffectBank].type1 == TYPE_FIRE || gBattleMons[gEffectBank].type2 == TYPE_FIRE)
                && !(gHitMarker & HITMARKER_IGNORE_SAFEGUARD) && (primary == 1 || certain == 0x80))
            {
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_BRN_PREVENTION;
                gBattleCommunication.multistring_chooser = 2;
                return;
            }
            if (gBattleMons[gEffectBank].type1 == TYPE_FIRE) {break;}
            if (gBattleMons[gEffectBank].type2 == TYPE_FIRE) {break;}
            if (gBattleMons[gEffectBank].ability_id == ABILITY_WATER_VEIL) {break;}
            if (gBattleMons[gEffectBank].status1 == 0) {break;}
            StatusChanged = 1;
            break;
        case STATUS_FREEZE:
            if (WeatherHasEffect && gBattleWeather & WEATHER_SUNNY) {NoSunCanFreeze = 0;}
            if (gBattleMons[gEffectBank].type1 == TYPE_ICE) {break;}
            if (gBattleMons[gEffectBank].type2 == TYPE_ICE) {break;}
            if (gBattleMons[gEffectBank].status) {break;}
            if (NoSunCanFreeze == 0) {break;}
            if (gBattleMons[gEffectBank].ability_id == ABILITY_MAGMA_ARMOR) {break;}

            CancelMultiTurnMoves(gEffectBank);
            StatusChanged = 1;
            break;
        case STATUS_PARALYSIS:
            if (gBattleMons[gEffectBank].ability_id == ABILITY_LIMBER)
            {
                if ((primary == 1 || certain == 0x80))
                {
                    gLastUsedAbility = ABILITY_LIMBER;
                    RecordAbility(gEffectBank, ABILITY_LIMBER);
                    b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                //_0801E664:
                    gBattlescriptCurrInstr = BS_PRLZ_PREVENTION;
                    if (gHitMarker & HITMARKER_IGNORE_SAFEGUARD)
                    {
                        gBattleCommunication.multistring_chooser = 1;
                        gHitMarker &= ~(HITMARKER_IGNORE_SAFEGUARD);
                        return;
                    }
                    else
                        {gBattleCommunication.multistring_chooser = 0; return;}
                }
                else {break;}
            }
            if (gBattleMons[gEffectBank].status) {break;}
            StatusChanged = 1;
            break;
        case STATUS_TOXIC_POISON:
            if (gBattleMons[gEffectBank].ability_id == ABILITY_IMMUNITY && (primary == 1 || certain == 0x80))
            {
                gLastUsedAbility = ABILITY_IMMUNITY;
                RecordAbility(gEffectBank, ABILITY_IMMUNITY);
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            //_0801E664:
                gBattlescriptCurrInstr = BS_PSN_PREVENTION;
                if (gHitMarker & HITMARKER_IGNORE_SAFEGUARD)
                {
                    gBattleCommunication.multistring_chooser = 1;
                    gHitMarker &= ~(HITMARKER_IGNORE_SAFEGUARD);
                    return;
                }
                else
                    {gBattleCommunication.multistring_chooser = 0; return;}
            }
            if ((gBattleMons[gEffectBank].type1 == TYPE_POISON || gBattleMons[gEffectBank].type2 == TYPE_POISON || gBattleMons[gEffectBank].type1 == TYPE_STEEL || gBattleMons[gEffectBank].type2 == TYPE_STEEL)
                && !(gHitMarker & HITMARKER_IGNORE_SAFEGUARD) && (primary == 1 || certain == 0x80))
            {
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_PSN_PREVENTION;
                gBattleCommunication.multistring_chooser = 2;
                return;
            }
            if (gBattleMons[gEffectBank].status) {break;}
            if (gBattleMons[gEffectBank].type1 != TYPE_POISON &&
                gBattleMons[gEffectBank].type2 != TYPE_POISON &&
                gBattleMons[gEffectBank].type1 != TYPE_STEEL &&
                gBattleMons[gEffectBank].type2 != TYPE_STEEL)
            {
                if (gBattleMons[gEffectBank].ability_id == ABILITY_IMMUNITY) {break;}
                gBattleMons[gEffectBank].status1 |= ~(STATUS_POISON); //TODO: fix OR to AND
                StatusChanged = 1;
                break;
            }
            else
                gBattleMoveFlags |= MOVE_NOTAFFECTED;
            break;
        }
        if (StatusChanged == 1)
        {
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            if (gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]] == STATUS_SLEEP)
                gBattleMons[gEffectBank].status1 |= ((Random() & 3) + 2);
            else
                gBattleMons[gEffectBank].status1 |= gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]];
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            gActiveBank = gEffectBank;
            bb2_setattributes_in_battle(0, REQUEST_STATUS_BATTLE, 0, 4, &gBattleMons[gEffectBank].status);
            mark_buffer_bank_for_execution(gActiveBank);
            if (gHitMarker & HITMARKER_IGNORE_SAFEGUARD)
            {
                gBattleCommunication.multistring_chooser = 1;
                gHitMarker &= ~(HITMARKER_IGNORE_SAFEGUARD);
            }
            else
                gBattleCommunication.multistring_chooser = 0;
            if (gBattleCommunication[MOVE_EFFECT_BYTE] == 2 || gBattleCommunication[MOVE_EFFECT_BYTE] == 6 || gBattleCommunication[MOVE_EFFECT_BYTE] == 5 || gBattleCommunication[MOVE_EFFECT_BYTE] == 3)
            {
                BATTLE_STRUCT->SynchroniseEffect = gBattleCommunication[MOVE_EFFECT_BYTE];
                gHitMarker |= HITMARKER_SYNCHRONISE_EFFECT;
            }
            return;
        }
        else if (StatusChanged == 0)
            {gBattlescriptCurrInstr++; return;}
    }
    else
    {
        if (gBattleMons[gEffectBank].status2 & gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]])
            {gBattlescriptCurrInstr++; return;}
        switch (gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]])
        {
        case 7: //confusion
            if (gBattleMons[gEffectBank].ability_id == ABILITY_OWN_TEMPO)
                {gBattlescriptCurrInstr++; return;}
            if (gBattleMons[gEffectBank].status2 & STATUS2_CONFUSION)
                {gBattlescriptCurrInstr++; return;}
            gBattleMons[gEffectBank].status2 |= (((Random()) % 0x4)) + 2;
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            break;
        case 8: //flinch
            if (gBattleMons[gEffectBank].ability_id == ABILITY_INNER_FOCUS)
            {
                if (primary == 1 || certain == 0x80)
                {
                    gLastUsedAbility = ABILITY_INNER_FOCUS;
                    RecordAbility(gEffectBank, ABILITY_INNER_FOCUS);
                    gBattlescriptCurrInstr = BS_FLINCH_PREVENTION;
                    return;
                }
                else
                    {gBattlescriptCurrInstr++; return;}
            }
            else
            {
                if (BankGetTurnOrder(gEffectBank) > gCurrentMoveTurn)
                    gBattleMons[gEffectBank].status2 |= gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]];
                gBattlescriptCurrInstr++; return;
            }
            break;
        case 10: //uproar
            if (gBattleMons[gEffectBank].status2 & STATUS2_UPROAR)
                {gBattlescriptCurrInstr++; return;}
            gBattleMons[gEffectBank].status2 |= STATUS2_MULTIPLETURNS;
            gLockedMove[gEffectBank] = gCurrentMove;
            gBattleMons[gEffectBank].status2 |= ((Random() & 3) + 2) << 4;
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            break;
        case 11: //pay day
            if (!(get_bank_identity(gEffectBank) & 1))
            {
                u16 PayDay = gPaydayMoney;
                gPaydayMoney += (gBattleMons[gEffectBank].level * 5);
                if (PayDay > gPaydayMoney)
                    gPaydayMoney = 0xFFFF;
            }
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            break;
        case 9: //tri attack
            if (gBattleMons[gEffectBank].status)
                {gBattlescriptCurrInstr++; return;}
            gBattleCommunication[MOVE_EFFECT_BYTE] = Random() % 3 + 3;
            SetMoveEffect(0, 0);
            break;
        case 12: //charging move
            gBattleMons[gEffectBank].status2 |= STATUS2_MULTIPLETURNS;
            gLockedMove[gEffectBank] = gCurrentMove;
            gProtectStructs[gEffectBank].flag1_chargingturn = 1;
            gBattlescriptCurrInstr++;
            break;
        case 13: //wrap
            if (gBattleMons[gEffectBank].status2 & STATUS2_WRAPPED)
                {gBattlescriptCurrInstr++; return;}
            gBattleMons[gEffectBank].status2 |= ((Random() & 3) + 2) << 0xD;
            BATTLE_STRUCT->WrappedMove1[gEffectBank] = gCurrentMove;
            BATTLE_STRUCT->WrappedMove2[gEffectBank] = gCurrentMove >> 8;
            BATTLE_STRUCT->WrappedBy[gEffectBank] = gBankAttacker;
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];

            for (gBattleCommunication.multistring_chooser = 0;
            gBattleCommunication.multistring_chooser <= 4 && gCurrentMove != gTrappingMoves[gBattleCommunication.multistring_chooser];
            gBattleCommunication.multistring_chooser++) {}
            break;
        case 14: //recoil
            gBattleMoveDamage = (gHP_dealt) / 4;
            ATLEAST_ONE_PTR(&gBattleMoveDamage);
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            break;
        case 15 ... 21: //stat + 1
            if (ChangeStats(0x10, gBattleCommunication[MOVE_EFFECT_BYTE] + 0xF2, certain, 0)) {gBattlescriptCurrInstr++;}
            else
            {
                BATTLE_STRUCT->AnimArg1 = gBattleCommunication[MOVE_EFFECT_BYTE] & 0x3F; //TODO: the arg ptr is wrong by one
                BATTLE_STRUCT->AnimArg2 = 0;
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_STAT_UP;
            }
            break;
        case 22 ... 28: //stat - 1
            if (ChangeStats(~(0x6f), gBattleCommunication[MOVE_EFFECT_BYTE] + 0xEB, certain, 0)) {gBattlescriptCurrInstr++;} //TODO: negation doesnt work correctly
            else
            {
                BATTLE_STRUCT->AnimArg1 = gBattleCommunication[MOVE_EFFECT_BYTE] & 0x3F;
                BATTLE_STRUCT->AnimArg2 = 0;
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_STAT_DOWN;
            }
            break;
        case 39 ... 45: //stat + 2
            if (ChangeStats(0x20, gBattleCommunication[MOVE_EFFECT_BYTE] + 0xDA, certain, 0)) {gBattlescriptCurrInstr++;}
            else
            {
                BATTLE_STRUCT->AnimArg1 = gBattleCommunication[MOVE_EFFECT_BYTE] & 0x3F;
                BATTLE_STRUCT->AnimArg2 = 0;
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_STAT_UP;
            }
            break;
        case 46 ... 52: //stat - 2
            if (ChangeStats(~(0x5f), gBattleCommunication[MOVE_EFFECT_BYTE] + 0xD3, certain, 0)) {gBattlescriptCurrInstr++;}
            else
            {
                BATTLE_STRUCT->AnimArg1 = gBattleCommunication[MOVE_EFFECT_BYTE] & 0x3F;
                BATTLE_STRUCT->AnimArg2 = 0;
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_STAT_DOWN;
            }
            break;
        case 29: //recharge
            gBattleMons[gEffectBank].status2 |= STATUS2_RECHARGE;
            gDisableStructs[gEffectBank].recharge_counter = 2;
            gLockedMove[gEffectBank] = gCurrentMove;
            gBattlescriptCurrInstr++;
            break;
        case 30: //rage
            gBattleMons[gBankAttacker].status2 |= STATUS2_RAGE;
            gBattlescriptCurrInstr++;
            break;
        case 31: //item steal
            {
                u8 side = GetBankSide(gBankAttacker);
                if (GetBankSide(gBankAttacker) == 1 && !(gBattleTypeFlags & (BATTLE_TYPE_EREADER_TRAINER | BATTLE_TYPE_BATTLE_TOWER | BATTLE_TYPE_LINK)) && gTrainerBattleOpponent != 0x400)
                        {gBattlescriptCurrInstr++; return;}
                if (!(gBattleTypeFlags & (BATTLE_TYPE_EREADER_TRAINER | BATTLE_TYPE_BATTLE_TOWER | BATTLE_TYPE_LINK)) && gTrainerBattleOpponent != 0x400 && (gWishFutureKnock.KnockedOff[side] & gBitTable[gBattlePartyID[gBankAttacker]]))
                        {gBattlescriptCurrInstr++; return;}
                if (gBattleMons[gBankTarget].held_item && gBattleMons[gBankTarget].ability_id == ABILITY_STICKY_HOLD)
                {
                    b_movescr_stack_push_cursor();
                    gBattlescriptCurrInstr = BS_NO_ITEMSTEAL;
                    gLastUsedAbility = gBattleMons[gBankTarget].ability_id;
                    RecordAbility(gBankTarget, gLastUsedAbility);
                    return;
                }
                if (gBattleMons[gBankAttacker].held_item)
                    {gBattlescriptCurrInstr++; return;}
                if (gBattleMons[gBankTarget].held_item == ITEM_ENIGMA_BERRY)
                    {gBattlescriptCurrInstr++; return;}
                if (gBattleMons[gBankTarget].held_item == 0)
                    {gBattlescriptCurrInstr++; return;}

                CHANGED_HELDITEMS[gBankAttacker] = gLastUsedItem = gBattleMons[gBankTarget].held_item;
                gBattleMons[gBankTarget].held_item = 0;

                gActiveBank = gBankAttacker;
                bb2_setattributes_in_battle(0, REQUEST_HELDITEM_BATTLE, 0, 2, &gLastUsedItem);
                mark_buffer_bank_for_execution(gBankAttacker);

                gActiveBank = gBankTarget;
                bb2_setattributes_in_battle(0, REQUEST_HELDITEM_BATTLE, 0, 2, &gBattleMons[gBankTarget].held_item);
                mark_buffer_bank_for_execution(gBankTarget);

                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_ITEMSTEAL;

                STORE_CHOICEMOVE(gBankTarget, 0);
            }
            break;
        case 32: //escape prevention
            gBattleMons[gBankTarget].status2 |= STATUS2_RECHARGE;
            gDisableStructs[gBankTarget].BankPreventingEscape = gBankAttacker;
            gBattlescriptCurrInstr++;
            break;
        case 33: //nightmare
            gBattleMons[gBankTarget].status2 |= STATUS2_NIGHTMARE;
            gBattlescriptCurrInstr++;
            break;
        case 34:
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = gUnknown_081D9224;
            return;
        case 35: //break free rapidspin
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = BS_RAPIDSPINAWAY;
            return;
        case 36: //paralysis removal
            if (gBattleMons[gBankTarget].status1 & STATUS_PARALYSIS)
            {
                gBattleMons[gBankTarget].status1 &= ~(STATUS_PARALYSIS);
                gActiveBank = gBankTarget;
                bb2_setattributes_in_battle(0, REQUEST_STATUS_BATTLE, 0, 4, &gBattleMons[gBankTarget].status);
                mark_buffer_bank_for_execution(gActiveBank);
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_PARALYSISHEALED;
            }
            else
                {gBattlescriptCurrInstr++; return;}
            break;
        case 37: //
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = gUnknown_081D93FA;
            return;
        case 38: //recoil plus paralysis
            gBattleMoveDamage = gHP_dealt / 3;
            ATLEAST_ONE_PTR(&gBattleMoveDamage);
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = MoveEffectBS_ptrs[gBattleCommunication[MOVE_EFFECT_BYTE]];
            break;
        case 53: //thrash
            if (!(gBattleMons[gEffectBank].status2 & STATUS2_LOCK_CONFUSE))
            {
                gBattleMons[gEffectBank].status2 |= STATUS2_MULTIPLETURNS;
                gLockedMove[gEffectBank] = gCurrentMove;
                gBattleMons[gEffectBank].status2 |= (((Random() & 1) + 2) << 0xA);
            }
            else
                {gBattlescriptCurrInstr++; return;}
            break;
        case 54: //knock off
            if (gBattleMons[gEffectBank].ability_id == ABILITY_STICKY_HOLD)
            {
                if (gBattleMons[gEffectBank].held_item == 0)
                    {gBattlescriptCurrInstr++; return;}
                gLastUsedAbility = ABILITY_STICKY_HOLD;
                gBattlescriptCurrInstr = BS_STICKYHOLD_ACTIVATES;
                RecordAbility(gEffectBank, ABILITY_STICKY_HOLD);
                return;
            }
            if (gBattleMons[gEffectBank].held_item == 0)
                    {gBattlescriptCurrInstr++; return;}
            else
            {
                u8 side = GetBankSide(gEffectBank);
                gLastUsedItem = gBattleMons[gEffectBank].held_item;
                gBattleMons[gEffectBank].held_item = 0;
                gWishFutureKnock.KnockedOff[side] |= gBitTable[gBattlePartyID[gEffectBank]];
                b_movescr_stack_push(gBattlescriptCurrInstr + 1);
                gBattlescriptCurrInstr = BS_KNOCKEDOFF;

                STORE_CHOICEMOVE(gEffectBank, 0);
            }
            break;
        case 59: //overheat I guess, dont remember
            b_movescr_stack_push(gBattlescriptCurrInstr + 1);
            gBattlescriptCurrInstr = gUnknown_081D94B0;
            return;
        }
    }
}
#else
__attribute__((naked))
void SetMoveEffect(bool8 primary, u8 certainArg)
{
    asm(".syntax unified\n\
            push {r4-r7,lr}\n\
    mov r7, r10\n\
    mov r6, r9\n\
    mov r5, r8\n\
    push {r5-r7}\n\
    sub sp, 0x8\n\
    lsls r0, 24\n\
    lsrs r4, r0, 24\n\
    lsls r1, 24\n\
    lsrs r5, r1, 24\n\
    movs r0, 0\n\
    mov r10, r0\n\
    movs r6, 0\n\
    movs r1, 0x1\n\
    str r1, [sp, 0x4]\n\
    ldr r1, _0801E430 @ =gBattleCommunication\n\
    ldrb r3, [r1, 0x3]\n\
    movs r0, 0x40\n\
    ands r0, r3\n\
    adds r7, r1, 0\n\
    cmp r0, 0\n\
    beq _0801E444\n\
    ldr r2, _0801E434 @ =gEffectBank\n\
    ldr r0, _0801E438 @ =gBankAttacker\n\
    ldrb r0, [r0]\n\
    strb r0, [r2]\n\
    movs r0, 0xBF\n\
    ands r0, r3\n\
    strb r0, [r7, 0x3]\n\
    movs r6, 0x40\n\
    ldr r0, _0801E43C @ =0x02000000\n\
    ldr r1, _0801E440 @ =gBankTarget\n\
    b _0801E450\n\
    .align 2, 0\n\
_0801E430: .4byte gBattleCommunication\n\
_0801E434: .4byte gEffectBank\n\
_0801E438: .4byte gBankAttacker\n\
_0801E43C: .4byte 0x02000000\n\
_0801E440: .4byte gBankTarget\n\
_0801E444:\n\
    ldr r2, _0801E538 @ =gEffectBank\n\
    ldr r0, _0801E53C @ =gBankTarget\n\
    ldrb r0, [r0]\n\
    strb r0, [r2]\n\
    ldr r0, _0801E540 @ =0x02000000\n\
    ldr r1, _0801E544 @ =gBankAttacker\n\
_0801E450:\n\
    ldrb r1, [r1]\n\
    ldr r3, _0801E548 @ =0x00016003\n\
    adds r0, r3\n\
    strb r1, [r0]\n\
    mov r8, r2\n\
    ldr r2, _0801E54C @ =gBattleMons\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    adds r0, r2\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x13\n\
    bne _0801E48A\n\
    ldr r0, _0801E550 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801E48A\n\
    cmp r4, 0\n\
    bne _0801E48A\n\
    ldrb r0, [r7, 0x3]\n\
    cmp r0, 0x9\n\
    bhi _0801E48A\n\
    bl _0801F5DC\n\
_0801E48A:\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    bl GetBankIdentity\n\
    ldr r2, _0801E554 @ =gSideAffecting\n\
    movs r1, 0x1\n\
    ands r1, r0\n\
    lsls r1, 1\n\
    adds r1, r2\n\
    ldrh r1, [r1]\n\
    movs r0, 0x20\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E4C4\n\
    ldr r0, _0801E550 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801E4C4\n\
    cmp r4, 0\n\
    bne _0801E4C4\n\
    ldr r0, _0801E558 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    cmp r0, 0x7\n\
    bhi _0801E4C4\n\
    bl _0801F5DC\n\
_0801E4C4:\n\
    ldr r3, _0801E54C @ =gBattleMons\n\
    ldr r2, _0801E538 @ =gEffectBank\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    adds r0, r3\n\
    ldrh r0, [r0, 0x28]\n\
    mov r8, r2\n\
    mov r9, r3\n\
    cmp r0, 0\n\
    bne _0801E4EA\n\
    ldr r0, _0801E558 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    cmp r0, 0xB\n\
    beq _0801E4EA\n\
    cmp r0, 0x1F\n\
    beq _0801E4EA\n\
    bl _0801F5DC\n\
_0801E4EA:\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    mov r1, r9\n\
    adds r1, 0x50\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 17\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E50C\n\
    cmp r6, 0x40\n\
    beq _0801E50C\n\
    bl _0801F5DC\n\
_0801E50C:\n\
    ldr r0, _0801E558 @ =gBattleCommunication\n\
    ldrb r1, [r0, 0x3]\n\
    adds r7, r0, 0\n\
    cmp r1, 0x6\n\
    bls _0801E518\n\
    b _0801EB4A\n\
_0801E518:\n\
    ldr r1, _0801E55C @ =gStatusFlagsForMoveEffects\n\
    ldrb r0, [r7, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    cmp r0, 0x10\n\
    bne _0801E528\n\
    b _0801E714\n\
_0801E528:\n\
    cmp r0, 0x10\n\
    bhi _0801E560\n\
    cmp r0, 0x7\n\
    beq _0801E57A\n\
    cmp r0, 0x8\n\
    bne _0801E536\n\
    b _0801E630\n\
_0801E536:\n\
    b _0801EA14\n\
    .align 2, 0\n\
_0801E538: .4byte gEffectBank\n\
_0801E53C: .4byte gBankTarget\n\
_0801E540: .4byte 0x02000000\n\
_0801E544: .4byte gBankAttacker\n\
_0801E548: .4byte 0x00016003\n\
_0801E54C: .4byte gBattleMons\n\
_0801E550: .4byte gHitMarker\n\
_0801E554: .4byte gSideAffecting\n\
_0801E558: .4byte gBattleCommunication\n\
_0801E55C: .4byte gStatusFlagsForMoveEffects\n\
_0801E560:\n\
    cmp r0, 0x40\n\
    bne _0801E566\n\
    b _0801E888\n\
_0801E566:\n\
    cmp r0, 0x40\n\
    bhi _0801E572\n\
    cmp r0, 0x20\n\
    bne _0801E570\n\
    b _0801E7EA\n\
_0801E570:\n\
    b _0801EA14\n\
_0801E572:\n\
    cmp r0, 0x80\n\
    bne _0801E578\n\
    b _0801E8E4\n\
_0801E578:\n\
    b _0801EA14\n\
_0801E57A:\n\
    mov r3, r8\n\
    ldrb r1, [r3]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x2B\n\
    beq _0801E5DC\n\
    ldr r0, _0801E5D4 @ =gActiveBank\n\
    movs r1, 0\n\
    strb r1, [r0]\n\
    ldr r1, _0801E5D8 @ =gNoOfAllBanks\n\
    ldrb r3, [r1]\n\
    adds r7, r0, 0\n\
    mov r12, r1\n\
    cmp r3, 0\n\
    beq _0801E5E8\n\
    mov r4, r9\n\
    ldr r0, [r4, 0x50]\n\
    movs r1, 0x70\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801E5E8\n\
    adds r1, r7, 0\n\
    mov r6, r9\n\
    adds r6, 0x50\n\
    movs r5, 0x58\n\
    movs r4, 0x70\n\
_0801E5B4:\n\
    ldrb r0, [r1]\n\
    adds r0, 0x1\n\
    strb r0, [r1]\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, r3\n\
    bcs _0801E5E8\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r6\n\
    ldr r0, [r0]\n\
    ands r0, r4\n\
    cmp r0, 0\n\
    beq _0801E5B4\n\
    b _0801E5E8\n\
    .align 2, 0\n\
_0801E5D4: .4byte gActiveBank\n\
_0801E5D8: .4byte gNoOfAllBanks\n\
_0801E5DC:\n\
    ldr r0, _0801E628 @ =gActiveBank\n\
    ldr r2, _0801E62C @ =gNoOfAllBanks\n\
    ldrb r1, [r2]\n\
    strb r1, [r0]\n\
    adds r7, r0, 0\n\
    mov r12, r2\n\
_0801E5E8:\n\
    mov r0, r8\n\
    ldrb r2, [r0]\n\
    movs r0, 0x58\n\
    adds r1, r2, 0\n\
    muls r1, r0\n\
    mov r0, r9\n\
    adds r0, 0x4C\n\
    adds r0, r1, r0\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801E600\n\
    b _0801EA14\n\
_0801E600:\n\
    ldrb r0, [r7]\n\
    mov r3, r12\n\
    ldrb r3, [r3]\n\
    cmp r0, r3\n\
    beq _0801E60C\n\
    b _0801EA14\n\
_0801E60C:\n\
    mov r4, r9\n\
    adds r0, r1, r4\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x48\n\
    bne _0801E61A\n\
    b _0801EA14\n\
_0801E61A:\n\
    cmp r0, 0xF\n\
    bne _0801E620\n\
    b _0801EA14\n\
_0801E620:\n\
    adds r0, r2, 0\n\
    bl CancelMultiTurnMoves\n\
    b _0801EA04\n\
    .align 2, 0\n\
_0801E628: .4byte gActiveBank\n\
_0801E62C: .4byte gNoOfAllBanks\n\
_0801E630:\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r1, [r0]\n\
    cmp r1, 0x11\n\
    bne _0801E688\n\
    cmp r4, 0x1\n\
    beq _0801E64A\n\
    cmp r5, 0x80\n\
    bne _0801E688\n\
_0801E64A:\n\
    ldr r0, _0801E678 @ =gLastUsedAbility\n\
    strb r1, [r0]\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r1, 0x11\n\
    bl RecordAbilityBattle\n\
    ldr r4, _0801E67C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E680 @ =BattleScript_PSNPrevention\n\
_0801E664:\n\
    str r0, [r4]\n\
    ldr r2, _0801E684 @ =gHitMarker\n\
    ldr r1, [r2]\n\
    movs r0, 0x80\n\
    lsls r0, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E676\n\
    b _0801E928\n\
_0801E676:\n\
    b _0801E94C\n\
    .align 2, 0\n\
_0801E678: .4byte gLastUsedAbility\n\
_0801E67C: .4byte gBattlescriptCurrInstr\n\
_0801E680: .4byte BattleScript_PSNPrevention\n\
_0801E684: .4byte gHitMarker\n\
_0801E688:\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    movs r1, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r1, r0, 0\n\
    adds r1, 0x21\n\
    ldrb r1, [r1]\n\
    cmp r1, 0x3\n\
    beq _0801E6AC\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x3\n\
    beq _0801E6AC\n\
    cmp r1, 0x8\n\
    beq _0801E6AC\n\
    cmp r0, 0x8\n\
    bne _0801E6C6\n\
_0801E6AC:\n\
    ldr r0, _0801E710 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E6C6\n\
    cmp r4, 0x1\n\
    bne _0801E6C0\n\
    b _0801E98C\n\
_0801E6C0:\n\
    cmp r5, 0x80\n\
    bne _0801E6C6\n\
    b _0801E98C\n\
_0801E6C6:\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    muls r1, r0\n\
    mov r4, r9\n\
    adds r3, r1, r4\n\
    adds r0, r3, 0\n\
    adds r0, 0x21\n\
    ldrb r4, [r0]\n\
    cmp r4, 0x3\n\
    bne _0801E6DE\n\
    b _0801EA14\n\
_0801E6DE:\n\
    adds r0, 0x1\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x3\n\
    bne _0801E6E8\n\
    b _0801EA14\n\
_0801E6E8:\n\
    cmp r4, 0x8\n\
    bne _0801E6EE\n\
    b _0801EA14\n\
_0801E6EE:\n\
    cmp r0, 0x8\n\
    bne _0801E6F4\n\
    b _0801EA14\n\
_0801E6F4:\n\
    mov r0, r9\n\
    adds r0, 0x4C\n\
    adds r0, r1, r0\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801E702\n\
    b _0801EA14\n\
_0801E702:\n\
    adds r0, r3, 0\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x11\n\
    bne _0801E70E\n\
    b _0801EA14\n\
_0801E70E:\n\
    b _0801EA04\n\
    .align 2, 0\n\
_0801E710: .4byte gHitMarker\n\
_0801E714:\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r1, [r0]\n\
    cmp r1, 0x29\n\
    bne _0801E758\n\
    cmp r4, 0x1\n\
    beq _0801E72E\n\
    cmp r5, 0x80\n\
    bne _0801E758\n\
_0801E72E:\n\
    ldr r0, _0801E74C @ =gLastUsedAbility\n\
    strb r1, [r0]\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r1, 0x29\n\
    bl RecordAbilityBattle\n\
    ldr r4, _0801E750 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E754 @ =BattleScript_BRNPrevention\n\
    b _0801E664\n\
    .align 2, 0\n\
_0801E74C: .4byte gLastUsedAbility\n\
_0801E750: .4byte gBattlescriptCurrInstr\n\
_0801E754: .4byte BattleScript_BRNPrevention\n\
_0801E758:\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    mov r2, r9\n\
    adds r1, r0, r2\n\
    adds r0, r1, 0\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xA\n\
    beq _0801E778\n\
    adds r0, r1, 0\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xA\n\
    bne _0801E7A8\n\
_0801E778:\n\
    ldr r0, _0801E79C @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E7A8\n\
    cmp r4, 0x1\n\
    beq _0801E78E\n\
    cmp r5, 0x80\n\
    bne _0801E7A8\n\
_0801E78E:\n\
    ldr r4, _0801E7A0 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E7A4 @ =BattleScript_BRNPrevention\n\
    b _0801E998\n\
    .align 2, 0\n\
_0801E79C: .4byte gHitMarker\n\
_0801E7A0: .4byte gBattlescriptCurrInstr\n\
_0801E7A4: .4byte BattleScript_BRNPrevention\n\
_0801E7A8:\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r1, 0x58\n\
    adds r2, r0, 0\n\
    muls r2, r1\n\
    mov r4, r9\n\
    adds r1, r2, r4\n\
    adds r0, r1, 0\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xA\n\
    bne _0801E7C2\n\
    b _0801EA14\n\
_0801E7C2:\n\
    adds r0, r1, 0\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xA\n\
    bne _0801E7CE\n\
    b _0801EA14\n\
_0801E7CE:\n\
    adds r0, r1, 0\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x29\n\
    bne _0801E7DA\n\
    b _0801EA14\n\
_0801E7DA:\n\
    mov r0, r9\n\
    adds r0, 0x4C\n\
    adds r0, r2, r0\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801E7E8\n\
    b _0801EA14\n\
_0801E7E8:\n\
    b _0801EA04\n\
_0801E7EA:\n\
    movs r0, 0\n\
    str r0, [sp]\n\
    movs r0, 0x13\n\
    movs r1, 0\n\
    movs r2, 0xD\n\
    movs r3, 0\n\
    bl AbilityBattleEffects\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0\n\
    bne _0801E826\n\
    str r0, [sp]\n\
    movs r0, 0x13\n\
    movs r1, 0\n\
    movs r2, 0x4D\n\
    movs r3, 0\n\
    bl AbilityBattleEffects\n\
    lsls r0, 24\n\
    cmp r0, 0\n\
    bne _0801E826\n\
    ldr r0, _0801E87C @ =gBattleWeather\n\
    ldrh r1, [r0]\n\
    movs r0, 0x60\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E826\n\
    movs r1, 0\n\
    str r1, [sp, 0x4]\n\
_0801E826:\n\
    ldr r4, _0801E880 @ =gBattleMons\n\
    ldr r0, _0801E884 @ =gEffectBank\n\
    ldrb r3, [r0]\n\
    movs r0, 0x58\n\
    adds r2, r3, 0\n\
    muls r2, r0\n\
    adds r1, r2, r4\n\
    adds r0, r1, 0\n\
    adds r0, 0x21\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xF\n\
    bne _0801E840\n\
    b _0801EA14\n\
_0801E840:\n\
    adds r0, r1, 0\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xF\n\
    bne _0801E84C\n\
    b _0801EA14\n\
_0801E84C:\n\
    adds r0, r4, 0\n\
    adds r0, 0x4C\n\
    adds r0, r2, r0\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801E85A\n\
    b _0801EA14\n\
_0801E85A:\n\
    ldr r2, [sp, 0x4]\n\
    cmp r2, 0\n\
    bne _0801E862\n\
    b _0801EA14\n\
_0801E862:\n\
    adds r0, r1, 0\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x28\n\
    bne _0801E86E\n\
    b _0801EA14\n\
_0801E86E:\n\
    adds r0, r3, 0\n\
    bl CancelMultiTurnMoves\n\
    movs r3, 0x1\n\
    mov r10, r3\n\
    b _0801EA14\n\
    .align 2, 0\n\
_0801E87C: .4byte gBattleWeather\n\
_0801E880: .4byte gBattleMons\n\
_0801E884: .4byte gEffectBank\n\
_0801E888:\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r1, r0\n\
    mov r2, r9\n\
    adds r0, r1, r2\n\
    adds r0, 0x20\n\
    ldrb r2, [r0]\n\
    cmp r2, 0x7\n\
    bne _0801E8D0\n\
    cmp r4, 0x1\n\
    beq _0801E8A6\n\
    cmp r5, 0x80\n\
    beq _0801E8A6\n\
    b _0801EA14\n\
_0801E8A6:\n\
    ldr r0, _0801E8C4 @ =gLastUsedAbility\n\
    strb r2, [r0]\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r1, 0x7\n\
    bl RecordAbilityBattle\n\
    ldr r4, _0801E8C8 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E8CC @ =BattleScript_PRLZPrevention\n\
    b _0801E664\n\
    .align 2, 0\n\
_0801E8C4: .4byte gLastUsedAbility\n\
_0801E8C8: .4byte gBattlescriptCurrInstr\n\
_0801E8CC: .4byte BattleScript_PRLZPrevention\n\
_0801E8D0:\n\
    mov r0, r9\n\
    adds r0, 0x4C\n\
    adds r0, r1, r0\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801E8DE\n\
    b _0801EA14\n\
_0801E8DE:\n\
    movs r4, 0x1\n\
    mov r10, r4\n\
    b _0801EA14\n\
_0801E8E4:\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r1, [r0]\n\
    cmp r1, 0x11\n\
    bne _0801E952\n\
    cmp r4, 0x1\n\
    beq _0801E8FE\n\
    cmp r5, 0x80\n\
    bne _0801E952\n\
_0801E8FE:\n\
    ldr r0, _0801E938 @ =gLastUsedAbility\n\
    strb r1, [r0]\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    movs r1, 0x11\n\
    bl RecordAbilityBattle\n\
    ldr r4, _0801E93C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E940 @ =BattleScript_PSNPrevention\n\
    str r0, [r4]\n\
    ldr r2, _0801E944 @ =gHitMarker\n\
    ldr r1, [r2]\n\
    movs r0, 0x80\n\
    lsls r0, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E94C\n\
_0801E928:\n\
    movs r0, 0x1\n\
    strb r0, [r7, 0x5]\n\
    ldr r0, _0801E948 @ =0xffffdfff\n\
    ands r1, r0\n\
    str r1, [r2]\n\
    bl _0801F5FA\n\
    .align 2, 0\n\
_0801E938: .4byte gLastUsedAbility\n\
_0801E93C: .4byte gBattlescriptCurrInstr\n\
_0801E940: .4byte BattleScript_PSNPrevention\n\
_0801E944: .4byte gHitMarker\n\
_0801E948: .4byte 0xffffdfff\n\
_0801E94C:\n\
    strb r0, [r7, 0x5]\n\
    bl _0801F5FA\n\
_0801E952:\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    movs r1, 0x58\n\
    muls r0, r1\n\
    add r0, r9\n\
    adds r1, r0, 0\n\
    adds r1, 0x21\n\
    ldrb r1, [r1]\n\
    cmp r1, 0x3\n\
    beq _0801E976\n\
    adds r0, 0x22\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x3\n\
    beq _0801E976\n\
    cmp r1, 0x8\n\
    beq _0801E976\n\
    cmp r0, 0x8\n\
    bne _0801E9B4\n\
_0801E976:\n\
    ldr r0, _0801E9A4 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801E9B4\n\
    cmp r4, 0x1\n\
    beq _0801E98C\n\
    cmp r5, 0x80\n\
    bne _0801E9B4\n\
_0801E98C:\n\
    ldr r4, _0801E9A8 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801E9AC @ =BattleScript_PSNPrevention\n\
_0801E998:\n\
    str r0, [r4]\n\
    ldr r1, _0801E9B0 @ =gBattleCommunication\n\
    movs r0, 0x2\n\
    strb r0, [r1, 0x5]\n\
    bl _0801F5FA\n\
    .align 2, 0\n\
_0801E9A4: .4byte gHitMarker\n\
_0801E9A8: .4byte gBattlescriptCurrInstr\n\
_0801E9AC: .4byte BattleScript_PSNPrevention\n\
_0801E9B0: .4byte gBattleCommunication\n\
_0801E9B4:\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r6, 0x58\n\
    muls r0, r6\n\
    mov r2, r9\n\
    adds r2, 0x4C\n\
    adds r5, r0, r2\n\
    ldr r4, [r5]\n\
    cmp r4, 0\n\
    bne _0801EA14\n\
    mov r3, r9\n\
    adds r1, r0, r3\n\
    adds r0, r1, 0\n\
    adds r0, 0x21\n\
    ldrb r3, [r0]\n\
    cmp r3, 0x3\n\
    beq _0801EA0A\n\
    adds r0, 0x1\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x3\n\
    beq _0801EA0A\n\
    cmp r3, 0x8\n\
    beq _0801EA0A\n\
    cmp r0, 0x8\n\
    beq _0801EA0A\n\
    adds r0, r1, 0\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x11\n\
    beq _0801EA14\n\
    mov r4, r8\n\
    ldrb r0, [r4]\n\
    adds r1, r0, 0\n\
    muls r1, r6\n\
    adds r1, r2\n\
    ldr r0, [r1]\n\
    movs r2, 0x9\n\
    negs r2, r2\n\
    ands r0, r2\n\
    str r0, [r1]\n\
_0801EA04:\n\
    movs r0, 0x1\n\
    mov r10, r0\n\
    b _0801EA14\n\
_0801EA0A:\n\
    ldr r0, _0801EA58 @ =gBattleMoveFlags\n\
    ldrb r1, [r0]\n\
    movs r2, 0x8\n\
    orrs r1, r2\n\
    strb r1, [r0]\n\
_0801EA14:\n\
    mov r1, r10\n\
    cmp r1, 0x1\n\
    beq _0801EA1C\n\
    b _0801EB3C\n\
_0801EA1C:\n\
    ldr r0, _0801EA5C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r0]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801EA60 @ =gStatusFlagsForMoveEffects\n\
    ldr r0, _0801EA64 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r3, [r0]\n\
    cmp r3, 0x7\n\
    bne _0801EA70\n\
    bl Random\n\
    ldr r2, _0801EA68 @ =gBattleMons\n\
    ldr r1, _0801EA6C @ =gEffectBank\n\
    ldrb r3, [r1]\n\
    movs r1, 0x58\n\
    muls r3, r1\n\
    adds r2, 0x4C\n\
    adds r3, r2\n\
    movs r1, 0x3\n\
    ands r1, r0\n\
    adds r1, 0x2\n\
    ldr r0, [r3]\n\
    orrs r0, r1\n\
    str r0, [r3]\n\
    b _0801EA84\n\
    .align 2, 0\n\
_0801EA58: .4byte gBattleMoveFlags\n\
_0801EA5C: .4byte gBattlescriptCurrInstr\n\
_0801EA60: .4byte gStatusFlagsForMoveEffects\n\
_0801EA64: .4byte gBattleCommunication\n\
_0801EA68: .4byte gBattleMons\n\
_0801EA6C: .4byte gEffectBank\n\
_0801EA70:\n\
    ldr r2, _0801EAD4 @ =gBattleMons\n\
    ldr r0, _0801EAD8 @ =gEffectBank\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r1, r0\n\
    adds r2, 0x4C\n\
    adds r1, r2\n\
    ldr r0, [r1]\n\
    orrs r0, r3\n\
    str r0, [r1]\n\
_0801EA84:\n\
    ldr r2, _0801EADC @ =gBattlescriptCurrInstr\n\
    ldr r1, _0801EAE0 @ =gMoveEffectBS_Ptrs\n\
    ldr r5, _0801EAE4 @ =gBattleCommunication\n\
    ldrb r0, [r5, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    str r0, [r2]\n\
    ldr r4, _0801EAE8 @ =gActiveBank\n\
    ldr r1, _0801EAD8 @ =gEffectBank\n\
    ldrb r0, [r1]\n\
    strb r0, [r4]\n\
    ldrb r1, [r1]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    ldr r1, _0801EAEC @ =gUnknown_02024ACC\n\
    adds r0, r1\n\
    str r0, [sp]\n\
    movs r0, 0\n\
    movs r1, 0x28\n\
    movs r2, 0\n\
    movs r3, 0x4\n\
    bl EmitSetAttributes\n\
    ldrb r0, [r4]\n\
    bl MarkBufferBankForExecution\n\
    ldr r2, _0801EAF0 @ =gHitMarker\n\
    ldr r1, [r2]\n\
    movs r0, 0x80\n\
    lsls r0, 6\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801EAF8\n\
    movs r0, 0x1\n\
    strb r0, [r5, 0x5]\n\
    ldr r0, _0801EAF4 @ =0xffffdfff\n\
    ands r1, r0\n\
    str r1, [r2]\n\
    b _0801EAFA\n\
    .align 2, 0\n\
_0801EAD4: .4byte gBattleMons\n\
_0801EAD8: .4byte gEffectBank\n\
_0801EADC: .4byte gBattlescriptCurrInstr\n\
_0801EAE0: .4byte gMoveEffectBS_Ptrs\n\
_0801EAE4: .4byte gBattleCommunication\n\
_0801EAE8: .4byte gActiveBank\n\
_0801EAEC: .4byte gUnknown_02024ACC\n\
_0801EAF0: .4byte gHitMarker\n\
_0801EAF4: .4byte 0xffffdfff\n\
_0801EAF8:\n\
    strb r0, [r5, 0x5]\n\
_0801EAFA:\n\
    ldr r0, _0801EB2C @ =gBattleCommunication\n\
    ldrb r2, [r0, 0x3]\n\
    adds r7, r0, 0\n\
    cmp r2, 0x2\n\
    beq _0801EB14\n\
    cmp r2, 0x6\n\
    beq _0801EB14\n\
    cmp r2, 0x5\n\
    beq _0801EB14\n\
    cmp r2, 0x3\n\
    beq _0801EB14\n\
    bl _0801F5FA\n\
_0801EB14:\n\
    ldr r0, _0801EB30 @ =0x02000000\n\
    ldrb r1, [r7, 0x3]\n\
    ldr r2, _0801EB34 @ =0x000160ca\n\
    adds r0, r2\n\
    strb r1, [r0]\n\
    ldr r2, _0801EB38 @ =gHitMarker\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 7\n\
    bl _0801F4F2\n\
    .align 2, 0\n\
_0801EB2C: .4byte gBattleCommunication\n\
_0801EB30: .4byte 0x02000000\n\
_0801EB34: .4byte 0x000160ca\n\
_0801EB38: .4byte gHitMarker\n\
_0801EB3C:\n\
    mov r3, r10\n\
    cmp r3, 0\n\
    beq _0801EB46\n\
    bl _0801F5FA\n\
_0801EB46:\n\
    bl _0801F5DC\n\
_0801EB4A:\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r1, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r1, r0\n\
    ldr r2, _0801EB84 @ =gStatusFlagsForMoveEffects\n\
    ldrb r3, [r7, 0x3]\n\
    lsls r0, r3, 2\n\
    adds r0, r2\n\
    ldr r1, [r1]\n\
    ldr r0, [r0]\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    beq _0801EB6E\n\
    bl _0801F5DC\n\
_0801EB6E:\n\
    subs r0, r3, 0x7\n\
    cmp r0, 0x34\n\
    bls _0801EB78\n\
    bl _0801F5FA\n\
_0801EB78:\n\
    lsls r0, 2\n\
    ldr r1, _0801EB88 @ =_0801EB8C\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_0801EB84: .4byte gStatusFlagsForMoveEffects\n\
_0801EB88: .4byte _0801EB8C\n\
    .align 2, 0\n\
_0801EB8C:\n\
    .4byte _0801EC60\n\
    .4byte _0801ECD4\n\
    .4byte _0801EE4C\n\
    .4byte _0801ED60\n\
    .4byte _0801EDDC\n\
    .4byte _0801EE84\n\
    .4byte _0801EECC\n\
    .4byte _0801EFA8\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801EFEC\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F040\n\
    .4byte _0801F13C\n\
    .4byte _0801F184\n\
    .4byte _0801F1A4\n\
    .4byte _0801F364\n\
    .4byte _0801F3A0\n\
    .4byte _0801F3BC\n\
    .4byte _0801F3D4\n\
    .4byte _0801F3EC\n\
    .4byte _0801F44C\n\
    .4byte _0801F464\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F094\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F0E8\n\
    .4byte _0801F4A8\n\
    .4byte _0801F500\n\
    .4byte _0801F5FA\n\
    .4byte _0801F5FA\n\
    .4byte _0801F5FA\n\
    .4byte _0801F5FA\n\
    .4byte _0801F5EC\n\
_0801EC60:\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    movs r5, 0x58\n\
    adds r1, r0, 0\n\
    muls r1, r5\n\
    mov r2, r9\n\
    adds r0, r1, r2\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x14\n\
    bne _0801EC7A\n\
    bl _0801F5DC\n\
_0801EC7A:\n\
    mov r4, r9\n\
    adds r4, 0x50\n\
    adds r0, r1, r4\n\
    ldr r0, [r0]\n\
    movs r1, 0x7\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801EC8E\n\
    bl _0801F5DC\n\
_0801EC8E:\n\
    bl Random\n\
    mov r3, r8\n\
    ldrb r1, [r3]\n\
    adds r2, r1, 0\n\
    muls r2, r5\n\
    adds r2, r4\n\
    lsls r0, 16\n\
    movs r1, 0xC0\n\
    lsls r1, 10\n\
    ands r1, r0\n\
    lsrs r1, 16\n\
    adds r1, 0x2\n\
    ldr r0, [r2]\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r4, _0801ECC8 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801ECCC @ =gMoveEffectBS_Ptrs\n\
    ldr r0, _0801ECD0 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    bl _0801F5F8\n\
    .align 2, 0\n\
_0801ECC8: .4byte gBattlescriptCurrInstr\n\
_0801ECCC: .4byte gMoveEffectBS_Ptrs\n\
_0801ECD0: .4byte gBattleCommunication\n\
_0801ECD4:\n\
    mov r0, r8\n\
    ldrb r2, [r0]\n\
    movs r6, 0x58\n\
    adds r0, r2, 0\n\
    muls r0, r6\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r1, [r0]\n\
    cmp r1, 0x27\n\
    bne _0801ED18\n\
    cmp r4, 0x1\n\
    beq _0801ECF4\n\
    cmp r5, 0x80\n\
    beq _0801ECF4\n\
    bl _0801F5DC\n\
_0801ECF4:\n\
    ldr r0, _0801ED0C @ =gLastUsedAbility\n\
    strb r1, [r0]\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    movs r1, 0x27\n\
    bl RecordAbilityBattle\n\
    ldr r1, _0801ED10 @ =gBattlescriptCurrInstr\n\
    ldr r0, _0801ED14 @ =BattleScript_FlinchPrevention\n\
    str r0, [r1]\n\
    bl _0801F5FA\n\
    .align 2, 0\n\
_0801ED0C: .4byte gLastUsedAbility\n\
_0801ED10: .4byte gBattlescriptCurrInstr\n\
_0801ED14: .4byte BattleScript_FlinchPrevention\n\
_0801ED18:\n\
    adds r0, r2, 0\n\
    bl BankGetTurnOrder\n\
    ldr r1, _0801ED54 @ =gCurrentMoveTurn\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    ldrb r1, [r1]\n\
    cmp r0, r1\n\
    bhi _0801ED2E\n\
    bl _0801F5DC\n\
_0801ED2E:\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    adds r2, r0, 0\n\
    muls r2, r6\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r1, _0801ED58 @ =gStatusFlagsForMoveEffects\n\
    ldr r0, _0801ED5C @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r1, [r2]\n\
    ldr r0, [r0]\n\
    orrs r1, r0\n\
    str r1, [r2]\n\
    bl _0801F5DC\n\
    .align 2, 0\n\
_0801ED54: .4byte gCurrentMoveTurn\n\
_0801ED58: .4byte gStatusFlagsForMoveEffects\n\
_0801ED5C: .4byte gBattleCommunication\n\
_0801ED60:\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r5, 0x58\n\
    muls r0, r5\n\
    mov r4, r9\n\
    adds r4, 0x50\n\
    adds r2, r0, r4\n\
    ldr r1, [r2]\n\
    movs r0, 0x70\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801ED7C\n\
    bl _0801F5DC\n\
_0801ED7C:\n\
    movs r0, 0x80\n\
    lsls r0, 5\n\
    orrs r1, r0\n\
    str r1, [r2]\n\
    ldr r1, _0801EDC8 @ =gLockedMove\n\
    ldrb r0, [r3]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldr r1, _0801EDCC @ =gCurrentMove\n\
    ldrh r1, [r1]\n\
    strh r1, [r0]\n\
    bl Random\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    adds r2, r1, 0\n\
    muls r2, r5\n\
    adds r2, r4\n\
    movs r1, 0x3\n\
    ands r1, r0\n\
    adds r1, 0x2\n\
    lsls r1, 4\n\
    ldr r0, [r2]\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r4, _0801EDD0 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801EDD4 @ =gMoveEffectBS_Ptrs\n\
    ldr r0, _0801EDD8 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    bl _0801F5F8\n\
    .align 2, 0\n\
_0801EDC8: .4byte gLockedMove\n\
_0801EDCC: .4byte gCurrentMove\n\
_0801EDD0: .4byte gBattlescriptCurrInstr\n\
_0801EDD4: .4byte gMoveEffectBS_Ptrs\n\
_0801EDD8: .4byte gBattleCommunication\n\
_0801EDDC:\n\
    ldr r5, _0801EE30 @ =gBankAttacker\n\
    ldrb r0, [r5]\n\
    bl GetBankIdentity\n\
    movs r1, 0x1\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    bne _0801EE14\n\
    ldr r4, _0801EE34 @ =gPaydayMoney\n\
    ldrh r3, [r4]\n\
    ldr r2, _0801EE38 @ =gBattleMons\n\
    ldrb r1, [r5]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    adds r0, r2\n\
    adds r0, 0x2A\n\
    ldrb r1, [r0]\n\
    lsls r0, r1, 2\n\
    adds r0, r1\n\
    adds r0, r3, r0\n\
    strh r0, [r4]\n\
    lsls r0, 16\n\
    lsrs r0, 16\n\
    cmp r3, r0\n\
    bls _0801EE14\n\
    ldr r3, _0801EE3C @ =0x0000ffff\n\
    adds r0, r3, 0\n\
    strh r0, [r4]\n\
_0801EE14:\n\
    ldr r4, _0801EE40 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801EE44 @ =gMoveEffectBS_Ptrs\n\
    ldr r0, _0801EE48 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    bl _0801F5F8\n\
    .align 2, 0\n\
_0801EE30: .4byte gBankAttacker\n\
_0801EE34: .4byte gPaydayMoney\n\
_0801EE38: .4byte gBattleMons\n\
_0801EE3C: .4byte 0x0000ffff\n\
_0801EE40: .4byte gBattlescriptCurrInstr\n\
_0801EE44: .4byte gMoveEffectBS_Ptrs\n\
_0801EE48: .4byte gBattleCommunication\n\
_0801EE4C:\n\
    mov r4, r8\n\
    ldrb r1, [r4]\n\
    movs r0, 0x58\n\
    muls r0, r1\n\
    mov r1, r9\n\
    adds r1, 0x4C\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _0801EE62\n\
    b _0801F5DC\n\
_0801EE62:\n\
    bl Random\n\
    ldr r4, _0801EE80 @ =gBattleCommunication\n\
    lsls r0, 16\n\
    lsrs r0, 16\n\
    movs r1, 0x3\n\
    bl __umodsi3\n\
    adds r0, 0x3\n\
    strb r0, [r4, 0x3]\n\
    movs r0, 0\n\
    movs r1, 0\n\
    bl SetMoveEffect\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801EE80: .4byte gBattleCommunication\n\
_0801EE84:\n\
    mov r0, r8\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    adds r2, r1, 0\n\
    muls r2, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 5\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r1, _0801EEC0 @ =gLockedMove\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldr r1, _0801EEC4 @ =gCurrentMove\n\
    ldrh r1, [r1]\n\
    strh r1, [r0]\n\
    ldr r0, _0801EEC8 @ =gProtectStructs\n\
    ldrb r1, [r2]\n\
    lsls r1, 4\n\
    adds r1, r0\n\
    ldrb r0, [r1, 0x1]\n\
    movs r2, 0x4\n\
    orrs r0, r2\n\
    strb r0, [r1, 0x1]\n\
    b _0801F5DC\n\
    .align 2, 0\n\
_0801EEC0: .4byte gLockedMove\n\
_0801EEC4: .4byte gCurrentMove\n\
_0801EEC8: .4byte gProtectStructs\n\
_0801EECC:\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r6, 0x58\n\
    muls r0, r6\n\
    mov r4, r9\n\
    adds r4, 0x50\n\
    adds r0, r4\n\
    ldr r5, [r0]\n\
    movs r0, 0xE0\n\
    lsls r0, 8\n\
    ands r5, r0\n\
    cmp r5, 0\n\
    beq _0801EEE8\n\
    b _0801F5DC\n\
_0801EEE8:\n\
    bl Random\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    adds r2, r1, 0\n\
    muls r2, r6\n\
    adds r2, r4\n\
    movs r1, 0x3\n\
    ands r1, r0\n\
    adds r1, 0x3\n\
    lsls r1, 13\n\
    ldr r0, [r2]\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r2, _0801EF80 @ =0x02000000\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    lsls r0, 1\n\
    ldr r4, _0801EF84 @ =0x00016004\n\
    adds r0, r4\n\
    adds r0, r2\n\
    ldr r6, _0801EF88 @ =gCurrentMove\n\
    ldrh r1, [r6]\n\
    strb r1, [r0]\n\
    ldrb r0, [r3]\n\
    lsls r0, 1\n\
    ldr r1, _0801EF8C @ =0x00016005\n\
    adds r0, r1\n\
    adds r0, r2\n\
    ldrh r1, [r6]\n\
    lsrs r1, 8\n\
    strb r1, [r0]\n\
    ldrb r0, [r3]\n\
    ldr r3, _0801EF90 @ =0x00016020\n\
    adds r0, r3\n\
    adds r0, r2\n\
    ldr r1, _0801EF94 @ =gBankAttacker\n\
    ldrb r1, [r1]\n\
    strb r1, [r0]\n\
    ldr r4, _0801EF98 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801EF9C @ =gMoveEffectBS_Ptrs\n\
    ldr r2, _0801EFA0 @ =gBattleCommunication\n\
    ldrb r0, [r2, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    str r0, [r4]\n\
    strb r5, [r2, 0x5]\n\
    ldr r1, _0801EFA4 @ =gTrappingMoves\n\
    ldrh r0, [r1]\n\
    ldrh r4, [r6]\n\
    cmp r0, r4\n\
    bne _0801EF5C\n\
    b _0801F5FA\n\
_0801EF5C:\n\
    adds r3, r1, 0\n\
    adds r1, r6, 0\n\
_0801EF60:\n\
    ldrb r0, [r2, 0x5]\n\
    adds r0, 0x1\n\
    strb r0, [r2, 0x5]\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x4\n\
    bls _0801EF70\n\
    b _0801F5FA\n\
_0801EF70:\n\
    ldrb r0, [r2, 0x5]\n\
    lsls r0, 1\n\
    adds r0, r3\n\
    ldrh r0, [r0]\n\
    ldrh r4, [r1]\n\
    cmp r0, r4\n\
    bne _0801EF60\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801EF80: .4byte 0x02000000\n\
_0801EF84: .4byte 0x00016004\n\
_0801EF88: .4byte gCurrentMove\n\
_0801EF8C: .4byte 0x00016005\n\
_0801EF90: .4byte 0x00016020\n\
_0801EF94: .4byte gBankAttacker\n\
_0801EF98: .4byte gBattlescriptCurrInstr\n\
_0801EF9C: .4byte gMoveEffectBS_Ptrs\n\
_0801EFA0: .4byte gBattleCommunication\n\
_0801EFA4: .4byte gTrappingMoves\n\
_0801EFA8:\n\
    ldr r1, _0801EFD8 @ =gBattleMoveDamage\n\
    ldr r0, _0801EFDC @ =gHP_dealt\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    bge _0801EFB4\n\
    adds r0, 0x3\n\
_0801EFB4:\n\
    asrs r0, 2\n\
    str r0, [r1]\n\
    cmp r0, 0\n\
    bne _0801EFC0\n\
    movs r0, 0x1\n\
    str r0, [r1]\n\
_0801EFC0:\n\
    ldr r4, _0801EFE0 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801EFE4 @ =gMoveEffectBS_Ptrs\n\
    ldr r0, _0801EFE8 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801EFD8: .4byte gBattleMoveDamage\n\
_0801EFDC: .4byte gHP_dealt\n\
_0801EFE0: .4byte gBattlescriptCurrInstr\n\
_0801EFE4: .4byte gMoveEffectBS_Ptrs\n\
_0801EFE8: .4byte gBattleCommunication\n\
_0801EFEC:\n\
    ldrb r1, [r7, 0x3]\n\
    adds r1, 0xF2\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    movs r0, 0x10\n\
    adds r2, r6, 0\n\
    movs r3, 0\n\
    bl ChangeStatBuffs\n\
    lsls r0, 24\n\
    lsrs r3, r0, 24\n\
    cmp r3, 0\n\
    beq _0801F008\n\
    b _0801F5DC\n\
_0801F008:\n\
    ldr r2, _0801F02C @ =0x02000000\n\
    ldrb r1, [r7, 0x3]\n\
    movs r0, 0x3F\n\
    ands r0, r1\n\
    ldr r4, _0801F030 @ =0x000160a4\n\
    adds r1, r2, r4\n\
    strb r0, [r1]\n\
    ldr r0, _0801F034 @ =0x000160a5\n\
    adds r2, r0\n\
    strb r3, [r2]\n\
    ldr r4, _0801F038 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F03C @ =BattleScript_StatUp\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F02C: .4byte 0x02000000\n\
_0801F030: .4byte 0x000160a4\n\
_0801F034: .4byte 0x000160a5\n\
_0801F038: .4byte gBattlescriptCurrInstr\n\
_0801F03C: .4byte BattleScript_StatUp\n\
_0801F040:\n\
    movs r0, 0x70\n\
    negs r0, r0\n\
    ldrb r1, [r7, 0x3]\n\
    adds r1, 0xEB\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    adds r2, r6, 0\n\
    movs r3, 0\n\
    bl ChangeStatBuffs\n\
    lsls r0, 24\n\
    lsrs r3, r0, 24\n\
    cmp r3, 0\n\
    beq _0801F05E\n\
    b _0801F5DC\n\
_0801F05E:\n\
    ldr r2, _0801F080 @ =0x02000000\n\
    ldrb r1, [r7, 0x3]\n\
    movs r0, 0x3F\n\
    ands r0, r1\n\
    ldr r4, _0801F084 @ =0x000160a4\n\
    adds r1, r2, r4\n\
    strb r0, [r1]\n\
    ldr r0, _0801F088 @ =0x000160a5\n\
    adds r2, r0\n\
    strb r3, [r2]\n\
    ldr r4, _0801F08C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F090 @ =BattleScript_StatDown\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F080: .4byte 0x02000000\n\
_0801F084: .4byte 0x000160a4\n\
_0801F088: .4byte 0x000160a5\n\
_0801F08C: .4byte gBattlescriptCurrInstr\n\
_0801F090: .4byte BattleScript_StatDown\n\
_0801F094:\n\
    ldrb r1, [r7, 0x3]\n\
    adds r1, 0xDA\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    movs r0, 0x20\n\
    adds r2, r6, 0\n\
    movs r3, 0\n\
    bl ChangeStatBuffs\n\
    lsls r0, 24\n\
    lsrs r3, r0, 24\n\
    cmp r3, 0\n\
    beq _0801F0B0\n\
    b _0801F5DC\n\
_0801F0B0:\n\
    ldr r2, _0801F0D4 @ =0x02000000\n\
    ldrb r1, [r7, 0x3]\n\
    movs r0, 0x3F\n\
    ands r0, r1\n\
    ldr r4, _0801F0D8 @ =0x000160a4\n\
    adds r1, r2, r4\n\
    strb r0, [r1]\n\
    ldr r0, _0801F0DC @ =0x000160a5\n\
    adds r2, r0\n\
    strb r3, [r2]\n\
    ldr r4, _0801F0E0 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F0E4 @ =BattleScript_StatUp\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F0D4: .4byte 0x02000000\n\
_0801F0D8: .4byte 0x000160a4\n\
_0801F0DC: .4byte 0x000160a5\n\
_0801F0E0: .4byte gBattlescriptCurrInstr\n\
_0801F0E4: .4byte BattleScript_StatUp\n\
_0801F0E8:\n\
    movs r0, 0x60\n\
    negs r0, r0\n\
    ldrb r1, [r7, 0x3]\n\
    adds r1, 0xD3\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    adds r2, r6, 0\n\
    movs r3, 0\n\
    bl ChangeStatBuffs\n\
    lsls r0, 24\n\
    lsrs r3, r0, 24\n\
    cmp r3, 0\n\
    beq _0801F106\n\
    b _0801F5DC\n\
_0801F106:\n\
    ldr r2, _0801F128 @ =0x02000000\n\
    ldrb r1, [r7, 0x3]\n\
    movs r0, 0x3F\n\
    ands r0, r1\n\
    ldr r4, _0801F12C @ =0x000160a4\n\
    adds r1, r2, r4\n\
    strb r0, [r1]\n\
    ldr r0, _0801F130 @ =0x000160a5\n\
    adds r2, r0\n\
    strb r3, [r2]\n\
    ldr r4, _0801F134 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F138 @ =BattleScript_StatDown\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F128: .4byte 0x02000000\n\
_0801F12C: .4byte 0x000160a4\n\
_0801F130: .4byte 0x000160a5\n\
_0801F134: .4byte gBattlescriptCurrInstr\n\
_0801F138: .4byte BattleScript_StatDown\n\
_0801F13C:\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    movs r0, 0x58\n\
    adds r2, r1, 0\n\
    muls r2, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 15\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r2, _0801F178 @ =gDisableStructs\n\
    mov r3, r8\n\
    ldrb r1, [r3]\n\
    lsls r0, r1, 3\n\
    subs r0, r1\n\
    lsls r0, 2\n\
    adds r0, r2\n\
    movs r1, 0x2\n\
    strb r1, [r0, 0x19]\n\
    ldr r1, _0801F17C @ =gLockedMove\n\
    ldrb r0, [r3]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldr r1, _0801F180 @ =gCurrentMove\n\
    ldrh r1, [r1]\n\
    strh r1, [r0]\n\
    b _0801F5DC\n\
    .align 2, 0\n\
_0801F178: .4byte gDisableStructs\n\
_0801F17C: .4byte gLockedMove\n\
_0801F180: .4byte gCurrentMove\n\
_0801F184:\n\
    ldr r0, _0801F1A0 @ =gBankAttacker\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    adds r2, r1, 0\n\
    muls r2, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 16\n\
_0801F19A:\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    b _0801F5DC\n\
    .align 2, 0\n\
_0801F1A0: .4byte gBankAttacker\n\
_0801F1A4:\n\
    ldr r4, _0801F254 @ =gBankAttacker\n\
    ldrb r0, [r4]\n\
    bl GetBankSide\n\
    lsls r0, 24\n\
    lsrs r6, r0, 24\n\
    ldrb r0, [r4]\n\
    bl GetBankSide\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x1\n\
    bne _0801F1D8\n\
    ldr r0, _0801F258 @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    ldr r0, _0801F25C @ =0x00000902\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801F214\n\
    ldr r0, _0801F260 @ =gTrainerBattleOpponent\n\
    ldrh r1, [r0]\n\
    movs r0, 0x80\n\
    lsls r0, 3\n\
    cmp r1, r0\n\
    beq _0801F1D8\n\
    b _0801F5DC\n\
_0801F1D8:\n\
    ldr r0, _0801F258 @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    ldr r0, _0801F25C @ =0x00000902\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801F214\n\
    ldr r0, _0801F260 @ =gTrainerBattleOpponent\n\
    ldrh r1, [r0]\n\
    movs r0, 0x80\n\
    lsls r0, 3\n\
    cmp r1, r0\n\
    beq _0801F214\n\
    ldr r0, _0801F264 @ =gWishFutureKnock\n\
    adds r0, 0x29\n\
    adds r0, r6, r0\n\
    ldrb r1, [r0]\n\
    ldr r3, _0801F268 @ =gBitTable\n\
    ldr r2, _0801F26C @ =gBattlePartyID\n\
    ldr r0, _0801F254 @ =gBankAttacker\n\
    ldrb r0, [r0]\n\
    lsls r0, 1\n\
    adds r0, r2\n\
    ldrh r0, [r0]\n\
    lsls r0, 2\n\
    adds r0, r3\n\
    ldr r0, [r0]\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    beq _0801F214\n\
    b _0801F5DC\n\
_0801F214:\n\
    ldr r2, _0801F270 @ =gBattleMons\n\
    ldr r1, _0801F274 @ =gBankTarget\n\
    ldrb r0, [r1]\n\
    movs r3, 0x58\n\
    muls r0, r3\n\
    adds r4, r0, r2\n\
    ldrh r0, [r4, 0x2E]\n\
    adds r7, r1, 0\n\
    mov r9, r2\n\
    cmp r0, 0\n\
    beq _0801F284\n\
    adds r0, r4, 0\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x3C\n\
    bne _0801F284\n\
    ldr r1, _0801F278 @ =gBattlescriptCurrInstr\n\
    ldr r0, _0801F27C @ =BattleScript_NoItemSteal\n\
    str r0, [r1]\n\
    ldr r1, _0801F280 @ =gLastUsedAbility\n\
    ldrb r0, [r7]\n\
    muls r0, r3\n\
    add r0, r9\n\
    adds r0, 0x20\n\
    ldrb r0, [r0]\n\
    strb r0, [r1]\n\
    ldrb r0, [r7]\n\
    ldrb r1, [r1]\n\
    bl RecordAbilityBattle\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F254: .4byte gBankAttacker\n\
_0801F258: .4byte gBattleTypeFlags\n\
_0801F25C: .4byte 0x00000902\n\
_0801F260: .4byte gTrainerBattleOpponent\n\
_0801F264: .4byte gWishFutureKnock\n\
_0801F268: .4byte gBitTable\n\
_0801F26C: .4byte gBattlePartyID\n\
_0801F270: .4byte gBattleMons\n\
_0801F274: .4byte gBankTarget\n\
_0801F278: .4byte gBattlescriptCurrInstr\n\
_0801F27C: .4byte BattleScript_NoItemSteal\n\
_0801F280: .4byte gLastUsedAbility\n\
_0801F284:\n\
    ldr r4, _0801F340 @ =gBankAttacker\n\
    mov r10, r4\n\
    ldrb r1, [r4]\n\
    movs r0, 0x58\n\
    mov r8, r0\n\
    mov r0, r8\n\
    muls r0, r1\n\
    add r0, r9\n\
    ldrh r3, [r0, 0x2E]\n\
    cmp r3, 0\n\
    beq _0801F29C\n\
    b _0801F5DC\n\
_0801F29C:\n\
    ldrb r0, [r7]\n\
    mov r2, r8\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    add r0, r9\n\
    ldrh r2, [r0, 0x2E]\n\
    adds r0, r2, 0\n\
    cmp r0, 0xAF\n\
    bne _0801F2B0\n\
    b _0801F5DC\n\
_0801F2B0:\n\
    cmp r0, 0\n\
    bne _0801F2B6\n\
    b _0801F5DC\n\
_0801F2B6:\n\
    lsls r0, r1, 1\n\
    ldr r5, _0801F344 @ =0x020160f0\n\
    adds r0, r5\n\
    ldr r1, _0801F348 @ =gLastUsedItem\n\
    strh r2, [r0]\n\
    strh r2, [r1]\n\
    ldrb r0, [r7]\n\
    mov r4, r8\n\
    muls r4, r0\n\
    adds r0, r4, 0\n\
    add r0, r9\n\
    movs r6, 0\n\
    strh r3, [r0, 0x2E]\n\
    ldr r4, _0801F34C @ =gActiveBank\n\
    mov r2, r10\n\
    ldrb r0, [r2]\n\
    strb r0, [r4]\n\
    str r1, [sp]\n\
    movs r0, 0\n\
    movs r1, 0x2\n\
    movs r2, 0\n\
    movs r3, 0x2\n\
    bl EmitSetAttributes\n\
    mov r3, r10\n\
    ldrb r0, [r3]\n\
    bl MarkBufferBankForExecution\n\
    ldrb r0, [r7]\n\
    strb r0, [r4]\n\
    ldrb r0, [r7]\n\
    mov r4, r8\n\
    muls r4, r0\n\
    adds r0, r4, 0\n\
    mov r1, r9\n\
    adds r1, 0x2E\n\
    adds r0, r1\n\
    str r0, [sp]\n\
    movs r0, 0\n\
    movs r1, 0x2\n\
    movs r2, 0\n\
    movs r3, 0x2\n\
    bl EmitSetAttributes\n\
    ldrb r0, [r7]\n\
    bl MarkBufferBankForExecution\n\
    ldr r4, _0801F350 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F354 @ =BattleScript_ItemSteal\n\
    str r0, [r4]\n\
    ldr r0, _0801F358 @ =0xfffe9f10\n\
    adds r5, r0\n\
    ldrb r0, [r7]\n\
    lsls r0, 1\n\
    ldr r1, _0801F35C @ =0x000160e8\n\
    adds r0, r1\n\
    adds r0, r5\n\
    strb r6, [r0]\n\
    ldrb r0, [r7]\n\
    lsls r0, 1\n\
    ldr r2, _0801F360 @ =0x000160e9\n\
    adds r0, r2\n\
    adds r0, r5\n\
    strb r6, [r0]\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F340: .4byte gBankAttacker\n\
_0801F344: .4byte 0x020160f0\n\
_0801F348: .4byte gLastUsedItem\n\
_0801F34C: .4byte gActiveBank\n\
_0801F350: .4byte gBattlescriptCurrInstr\n\
_0801F354: .4byte BattleScript_ItemSteal\n\
_0801F358: .4byte 0xfffe9f10\n\
_0801F35C: .4byte 0x000160e8\n\
_0801F360: .4byte 0x000160e9\n\
_0801F364:\n\
    ldr r3, _0801F394 @ =gBankTarget\n\
    ldrb r1, [r3]\n\
    movs r0, 0x58\n\
    adds r2, r1, 0\n\
    muls r2, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 19\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    ldr r2, _0801F398 @ =gDisableStructs\n\
    ldrb r1, [r3]\n\
    lsls r0, r1, 3\n\
    subs r0, r1\n\
    lsls r0, 2\n\
    adds r0, r2\n\
    ldr r1, _0801F39C @ =gBankAttacker\n\
    ldrb r1, [r1]\n\
    strb r1, [r0, 0x14]\n\
    b _0801F5DC\n\
    .align 2, 0\n\
_0801F394: .4byte gBankTarget\n\
_0801F398: .4byte gDisableStructs\n\
_0801F39C: .4byte gBankAttacker\n\
_0801F3A0:\n\
    ldr r0, _0801F3B8 @ =gBankTarget\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    adds r2, r1, 0\n\
    muls r2, r0\n\
    mov r0, r9\n\
    adds r0, 0x50\n\
    adds r2, r0\n\
    ldr r0, [r2]\n\
    movs r1, 0x80\n\
    lsls r1, 20\n\
    b _0801F19A\n\
    .align 2, 0\n\
_0801F3B8: .4byte gBankTarget\n\
_0801F3BC:\n\
    ldr r4, _0801F3CC @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F3D0 @ =gUnknown_081D9224\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F3CC: .4byte gBattlescriptCurrInstr\n\
_0801F3D0: .4byte gUnknown_081D9224\n\
_0801F3D4:\n\
    ldr r4, _0801F3E4 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F3E8 @ =BattleScript_RapidSpinAway\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F3E4: .4byte gBattlescriptCurrInstr\n\
_0801F3E8: .4byte BattleScript_RapidSpinAway\n\
_0801F3EC:\n\
    ldr r6, _0801F43C @ =gBankTarget\n\
    ldrb r0, [r6]\n\
    movs r2, 0x58\n\
    muls r0, r2\n\
    mov r1, r9\n\
    adds r1, 0x4C\n\
    adds r5, r0, r1\n\
    ldr r4, [r5]\n\
    movs r0, 0x40\n\
    ands r0, r4\n\
    cmp r0, 0\n\
    bne _0801F406\n\
    b _0801F5DC\n\
_0801F406:\n\
    movs r0, 0x41\n\
    negs r0, r0\n\
    ands r4, r0\n\
    str r4, [r5]\n\
    ldr r4, _0801F440 @ =gActiveBank\n\
    ldrb r0, [r6]\n\
    strb r0, [r4]\n\
    ldrb r0, [r4]\n\
    muls r0, r2\n\
    adds r0, r1\n\
    str r0, [sp]\n\
    movs r0, 0\n\
    movs r1, 0x28\n\
    movs r2, 0\n\
    movs r3, 0x4\n\
    bl EmitSetAttributes\n\
    ldrb r0, [r4]\n\
    bl MarkBufferBankForExecution\n\
    ldr r4, _0801F444 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F448 @ =BattleScript_TargetPRLZHeal\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F43C: .4byte gBankTarget\n\
_0801F440: .4byte gActiveBank\n\
_0801F444: .4byte gBattlescriptCurrInstr\n\
_0801F448: .4byte BattleScript_TargetPRLZHeal\n\
_0801F44C:\n\
    ldr r4, _0801F45C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F460 @ =gUnknown_081D93FA\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F45C: .4byte gBattlescriptCurrInstr\n\
_0801F460: .4byte gUnknown_081D93FA\n\
_0801F464:\n\
    ldr r4, _0801F494 @ =gBattleMoveDamage\n\
    ldr r0, _0801F498 @ =gHP_dealt\n\
    ldr r0, [r0]\n\
    movs r1, 0x3\n\
    bl __divsi3\n\
    str r0, [r4]\n\
    cmp r0, 0\n\
    bne _0801F47A\n\
    movs r0, 0x1\n\
    str r0, [r4]\n\
_0801F47A:\n\
    ldr r4, _0801F49C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801F4A0 @ =gMoveEffectBS_Ptrs\n\
    ldr r0, _0801F4A4 @ =gBattleCommunication\n\
    ldrb r0, [r0, 0x3]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    b _0801F5F8\n\
    .align 2, 0\n\
_0801F494: .4byte gBattleMoveDamage\n\
_0801F498: .4byte gHP_dealt\n\
_0801F49C: .4byte gBattlescriptCurrInstr\n\
_0801F4A0: .4byte gMoveEffectBS_Ptrs\n\
_0801F4A4: .4byte gBattleCommunication\n\
_0801F4A8:\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    movs r5, 0x58\n\
    muls r0, r5\n\
    mov r4, r9\n\
    adds r4, 0x50\n\
    adds r2, r0, r4\n\
    ldr r1, [r2]\n\
    movs r0, 0xC0\n\
    lsls r0, 4\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801F4C4\n\
    b _0801F5DC\n\
_0801F4C4:\n\
    movs r0, 0x80\n\
    lsls r0, 5\n\
    orrs r1, r0\n\
    str r1, [r2]\n\
    ldr r1, _0801F4F8 @ =gLockedMove\n\
    ldrb r0, [r3]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldr r1, _0801F4FC @ =gCurrentMove\n\
    ldrh r1, [r1]\n\
    strh r1, [r0]\n\
    bl Random\n\
    mov r2, r8\n\
    ldrb r1, [r2]\n\
    adds r2, r1, 0\n\
    muls r2, r5\n\
    adds r2, r4\n\
    movs r1, 0x1\n\
    ands r1, r0\n\
    adds r1, 0x2\n\
    lsls r1, 10\n\
    ldr r0, [r2]\n\
_0801F4F2:\n\
    orrs r0, r1\n\
    str r0, [r2]\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F4F8: .4byte gLockedMove\n\
_0801F4FC: .4byte gCurrentMove\n\
_0801F500:\n\
    mov r5, r8\n\
    ldrb r3, [r5]\n\
    movs r4, 0x58\n\
    adds r0, r3, 0\n\
    muls r0, r4\n\
    mov r2, r9\n\
    adds r1, r0, r2\n\
    adds r0, r1, 0\n\
    adds r0, 0x20\n\
    ldrb r2, [r0]\n\
    cmp r2, 0x3C\n\
    bne _0801F540\n\
    ldrh r0, [r1, 0x2E]\n\
    cmp r0, 0\n\
    beq _0801F5DC\n\
    ldr r0, _0801F534 @ =gLastUsedAbility\n\
    strb r2, [r0]\n\
    ldr r1, _0801F538 @ =gBattlescriptCurrInstr\n\
    ldr r0, _0801F53C @ =BattleScript_NoItemSteal\n\
    str r0, [r1]\n\
    ldrb r0, [r5]\n\
    movs r1, 0x3C\n\
    bl RecordAbilityBattle\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F534: .4byte gLastUsedAbility\n\
_0801F538: .4byte gBattlescriptCurrInstr\n\
_0801F53C: .4byte BattleScript_NoItemSteal\n\
_0801F540:\n\
    ldrh r0, [r1, 0x2E]\n\
    cmp r0, 0\n\
    beq _0801F5DC\n\
    adds r0, r3, 0\n\
    bl GetBankSide\n\
    lsls r0, 24\n\
    lsrs r6, r0, 24\n\
    ldr r1, _0801F5B8 @ =gLastUsedItem\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    muls r0, r4\n\
    add r0, r9\n\
    ldrh r0, [r0, 0x2E]\n\
    strh r0, [r1]\n\
    ldrb r0, [r3]\n\
    muls r0, r4\n\
    add r0, r9\n\
    movs r5, 0\n\
    movs r1, 0\n\
    strh r1, [r0, 0x2E]\n\
    ldr r2, _0801F5BC @ =gWishFutureKnock\n\
    adds r2, 0x29\n\
    adds r2, r6, r2\n\
    ldr r3, _0801F5C0 @ =gBitTable\n\
    ldr r1, _0801F5C4 @ =gBattlePartyID\n\
    mov r4, r8\n\
    ldrb r0, [r4]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldrh r0, [r0]\n\
    lsls r0, 2\n\
    adds r0, r3\n\
    ldr r0, [r0]\n\
    ldrb r1, [r2]\n\
    orrs r0, r1\n\
    strb r0, [r2]\n\
    ldr r4, _0801F5C8 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F5CC @ =BattleScript_KnockedOff\n\
    str r0, [r4]\n\
    ldr r1, _0801F5D0 @ =0x02000000\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    lsls r0, 1\n\
    ldr r3, _0801F5D4 @ =0x000160e8\n\
    adds r0, r3\n\
    adds r0, r1\n\
    strb r5, [r0]\n\
    ldrb r0, [r2]\n\
    lsls r0, 1\n\
    ldr r4, _0801F5D8 @ =0x000160e9\n\
    adds r0, r4\n\
    adds r0, r1\n\
    strb r5, [r0]\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F5B8: .4byte gLastUsedItem\n\
_0801F5BC: .4byte gWishFutureKnock\n\
_0801F5C0: .4byte gBitTable\n\
_0801F5C4: .4byte gBattlePartyID\n\
_0801F5C8: .4byte gBattlescriptCurrInstr\n\
_0801F5CC: .4byte BattleScript_KnockedOff\n\
_0801F5D0: .4byte 0x02000000\n\
_0801F5D4: .4byte 0x000160e8\n\
_0801F5D8: .4byte 0x000160e9\n\
_0801F5DC:\n\
    ldr r1, _0801F5E8 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r1]\n\
    adds r0, 0x1\n\
    str r0, [r1]\n\
    b _0801F5FA\n\
    .align 2, 0\n\
_0801F5E8: .4byte gBattlescriptCurrInstr\n\
_0801F5EC:\n\
    ldr r4, _0801F60C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    adds r0, 0x1\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801F610 @ =gUnknown_081D94B0\n\
_0801F5F8:\n\
    str r0, [r4]\n\
_0801F5FA:\n\
    add sp, 0x8\n\
    pop {r3-r5}\n\
    mov r8, r3\n\
    mov r9, r4\n\
    mov r10, r5\n\
    pop {r4-r7}\n\
    pop {r0}\n\
    bx r0\n\
    .align 2, 0\n\
_0801F60C: .4byte gBattlescriptCurrInstr\n\
_0801F610: .4byte gUnknown_081D94B0\n\
        .syntax divided\n");
}
#endif // NONMATCHING

void atk15_seteffectwithchancetarget(void)
{
    u32 PercentChance;
    if (gBattleMons[gBankAttacker].ability == ABILITY_SERENE_GRACE)
        PercentChance = gBattleMoves[gCurrentMove].secondaryEffectChance * 2;
    else
        PercentChance = gBattleMoves[gCurrentMove].secondaryEffectChance;
    if (gBattleCommunication[MOVE_EFFECT_BYTE] & 0x80 && !(gBattleMoveFlags & MOVE_NO_EFFECT))
    {
        gBattleCommunication[MOVE_EFFECT_BYTE] &= 0x7F;
        SetMoveEffect(0, 0x80);
    }
    else if (Random() % 100 <= PercentChance && gBattleCommunication[MOVE_EFFECT_BYTE] && !(gBattleMoveFlags & MOVE_NO_EFFECT))
    {
        if (PercentChance >= 100)
            SetMoveEffect(0, 0x80);
        else
            SetMoveEffect(0, 0);
    }
    else
        gBattlescriptCurrInstr++;
    gBattleCommunication[MOVE_EFFECT_BYTE] = 0;
    BATTLE_STRUCT->filler2[0x3E] = 0; //TODO: to fix this later
}

void atk16_seteffectprimary(void)
{
    SetMoveEffect(1, 0);
}

void atk17_seteffectsecondary(void)
{
    SetMoveEffect(0, 0);
}

void atk18_status_effect_clear(void)
{
    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    if (gBattleCommunication[MOVE_EFFECT_BYTE] <= 6)
        gBattleMons[gActiveBank].status1 &= (~gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]]);
    else
        gBattleMons[gActiveBank].status2 &= (~gStatusFlagsForMoveEffects[gBattleCommunication[MOVE_EFFECT_BYTE]]);

    gBattleCommunication[MOVE_EFFECT_BYTE] = 0;
    gBattlescriptCurrInstr += 2;
    BATTLE_STRUCT->filler2[0x3E] = 0; //TODO: to fix this later
}

//Fuck this, Maybe later
__attribute__((naked))
void atk19_faint_pokemon(void)
{
    asm(".syntax unified\n\
push {r4-r7,lr}\n\
    mov r7, r10\n\
    mov r6, r9\n\
    mov r5, r8\n\
    push {r5-r7}\n\
    sub sp, 0x4\n\
    ldr r0, _0801F81C @ =gBattlescriptCurrInstr\n\
    ldr r2, [r0]\n\
    ldrb r1, [r2, 0x2]\n\
    adds r6, r0, 0\n\
    cmp r1, 0\n\
    beq _0801F834\n\
    ldrb r0, [r2, 0x1]\n\
    bl GetBattleBank\n\
    ldr r5, _0801F820 @ =gActiveBank\n\
    strb r0, [r5]\n\
    ldr r2, _0801F824 @ =gHitMarker\n\
    ldr r1, _0801F828 @ =gBitTable\n\
    ldrb r0, [r5]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r1, [r0]\n\
    lsls r1, 28\n\
    ldr r0, [r2]\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801F7E6\n\
    b _0801FB1C\n\
_0801F7E6:\n\
    ldr r1, [r6]\n\
    ldrb r4, [r1, 0x3]\n\
    ldrb r0, [r1, 0x4]\n\
    lsls r0, 8\n\
    orrs r4, r0\n\
    ldrb r0, [r1, 0x5]\n\
    lsls r0, 16\n\
    orrs r4, r0\n\
    ldrb r0, [r1, 0x6]\n\
    lsls r0, 24\n\
    orrs r4, r0\n\
    bl b_movescr_stack_pop_cursor\n\
    str r4, [r6]\n\
    ldrb r0, [r5]\n\
    bl GetBankSide\n\
    ldr r1, _0801F82C @ =gSideAffecting\n\
    lsls r0, 24\n\
    lsrs r0, 23\n\
    adds r0, r1\n\
    ldrh r2, [r0]\n\
    ldr r1, _0801F830 @ =0x0000fdff\n\
    ands r1, r2\n\
    strh r1, [r0]\n\
    b _0801FB22\n\
    .align 2, 0\n\
_0801F81C: .4byte gBattlescriptCurrInstr\n\
_0801F820: .4byte gActiveBank\n\
_0801F824: .4byte gHitMarker\n\
_0801F828: .4byte gBitTable\n\
_0801F82C: .4byte gSideAffecting\n\
_0801F830: .4byte 0x0000fdff\n\
_0801F834:\n\
    ldrb r0, [r2, 0x1]\n\
    cmp r0, 0x1\n\
    bne _0801F85C\n\
    ldr r1, _0801F84C @ =gActiveBank\n\
    ldr r0, _0801F850 @ =gBankAttacker\n\
    ldrb r0, [r0]\n\
    strb r0, [r1]\n\
    ldr r0, _0801F854 @ =gBankTarget\n\
    ldrb r7, [r0]\n\
    ldr r4, _0801F858 @ =gUnknown_081D8C58\n\
    b _0801F86A\n\
    .align 2, 0\n\
_0801F84C: .4byte gActiveBank\n\
_0801F850: .4byte gBankAttacker\n\
_0801F854: .4byte gBankTarget\n\
_0801F858: .4byte gUnknown_081D8C58\n\
_0801F85C:\n\
    ldr r1, _0801F954 @ =gActiveBank\n\
    ldr r0, _0801F958 @ =gBankTarget\n\
    ldrb r0, [r0]\n\
    strb r0, [r1]\n\
    ldr r0, _0801F95C @ =gBankAttacker\n\
    ldrb r7, [r0]\n\
    ldr r4, _0801F960 @ =gUnknown_081D8C65\n\
_0801F86A:\n\
    ldr r0, _0801F964 @ =gAbsentBankFlags\n\
    ldrb r1, [r0]\n\
    ldr r0, _0801F968 @ =gBitTable\n\
    mov r12, r0\n\
    ldr r2, _0801F954 @ =gActiveBank\n\
    mov r8, r2\n\
    ldrb r2, [r2]\n\
    lsls r0, r2, 2\n\
    add r0, r12\n\
    ldr r0, [r0]\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    beq _0801F886\n\
    b _0801FB1C\n\
_0801F886:\n\
    ldr r3, _0801F96C @ =gBattleMons\n\
    mov r10, r3\n\
    movs r5, 0x58\n\
    mov r9, r5\n\
    mov r0, r9\n\
    muls r0, r2\n\
    add r0, r10\n\
    ldrh r3, [r0, 0x28]\n\
    cmp r3, 0\n\
    beq _0801F89C\n\
    b _0801FB1C\n\
_0801F89C:\n\
    ldr r2, _0801F970 @ =0x02000000\n\
    lsls r1, r7, 1\n\
    ldr r5, _0801F974 @ =0x000160ac\n\
    adds r0, r1, r5\n\
    adds r0, r2\n\
    strb r3, [r0]\n\
    ldr r0, _0801F978 @ =0x000160ad\n\
    adds r1, r0\n\
    adds r1, r2\n\
    strb r3, [r1]\n\
    lsls r1, r7, 2\n\
    adds r5, 0x54\n\
    adds r0, r1, r5\n\
    adds r0, r2\n\
    strb r3, [r0]\n\
    adds r5, 0x1\n\
    adds r0, r1, r5\n\
    adds r0, r2\n\
    strb r3, [r0]\n\
    adds r5, 0x1\n\
    adds r0, r1, r5\n\
    adds r0, r2\n\
    strb r3, [r0]\n\
    ldr r0, _0801F97C @ =0x00016103\n\
    adds r1, r0\n\
    adds r1, r2\n\
    strb r3, [r1]\n\
    ldr r5, _0801F980 @ =gHitMarker\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    lsls r0, 2\n\
    add r0, r12\n\
    ldr r1, [r0]\n\
    lsls r1, 28\n\
    ldr r0, [r5]\n\
    orrs r0, r1\n\
    str r0, [r5]\n\
    ldr r0, [r6]\n\
    adds r0, 0x7\n\
    bl b_movescr_stack_push\n\
    str r4, [r6]\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    bl GetBankSide\n\
    lsls r0, 24\n\
    cmp r0, 0\n\
    bne _0801F9B0\n\
    ldr r0, [r5]\n\
    movs r1, 0x80\n\
    lsls r1, 15\n\
    orrs r0, r1\n\
    str r0, [r5]\n\
    ldr r1, _0801F984 @ =gBattleResults\n\
    ldrb r0, [r1]\n\
    cmp r0, 0xFE\n\
    bhi _0801F914\n\
    adds r0, 0x1\n\
    strb r0, [r1]\n\
_0801F914:\n\
    mov r0, r9\n\
    muls r0, r7\n\
    add r0, r10\n\
    adds r3, r0, 0\n\
    adds r3, 0x2A\n\
    mov r4, r8\n\
    ldrb r2, [r4]\n\
    mov r0, r9\n\
    muls r0, r2\n\
    add r0, r10\n\
    adds r1, r0, 0\n\
    adds r1, 0x2A\n\
    ldrb r0, [r3]\n\
    ldrb r5, [r1]\n\
    cmp r0, r5\n\
    bls _0801F9CC\n\
    ldrb r1, [r1]\n\
    subs r0, r1\n\
    cmp r0, 0x1D\n\
    ble _0801F990\n\
    ldr r1, _0801F988 @ =gBattlePartyID\n\
    lsls r0, r2, 1\n\
    adds r0, r1\n\
    ldrh r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _0801F98C @ =gPlayerParty\n\
    adds r0, r1\n\
    movs r1, 0x8\n\
    bl AdjustFriendship\n\
    b _0801F9CC\n\
    .align 2, 0\n\
_0801F954: .4byte gActiveBank\n\
_0801F958: .4byte gBankTarget\n\
_0801F95C: .4byte gBankAttacker\n\
_0801F960: .4byte gUnknown_081D8C65\n\
_0801F964: .4byte gAbsentBankFlags\n\
_0801F968: .4byte gBitTable\n\
_0801F96C: .4byte gBattleMons\n\
_0801F970: .4byte 0x02000000\n\
_0801F974: .4byte 0x000160ac\n\
_0801F978: .4byte 0x000160ad\n\
_0801F97C: .4byte 0x00016103\n\
_0801F980: .4byte gHitMarker\n\
_0801F984: .4byte gBattleResults\n\
_0801F988: .4byte gBattlePartyID\n\
_0801F98C: .4byte gPlayerParty\n\
_0801F990:\n\
    ldr r1, _0801F9A8 @ =gBattlePartyID\n\
    lsls r0, r2, 1\n\
    adds r0, r1\n\
    ldrh r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _0801F9AC @ =gPlayerParty\n\
    adds r0, r1\n\
    movs r1, 0x6\n\
    bl AdjustFriendship\n\
    b _0801F9CC\n\
    .align 2, 0\n\
_0801F9A8: .4byte gBattlePartyID\n\
_0801F9AC: .4byte gPlayerParty\n\
_0801F9B0:\n\
    ldr r1, _0801FAE0 @ =gBattleResults\n\
    ldrb r0, [r1, 0x1]\n\
    cmp r0, 0xFE\n\
    bhi _0801F9BC\n\
    adds r0, 0x1\n\
    strb r0, [r1, 0x1]\n\
_0801F9BC:\n\
    ldr r2, _0801FAE4 @ =gActiveBank\n\
    ldrb r0, [r2]\n\
    mov r3, r9\n\
    muls r3, r0\n\
    adds r0, r3, 0\n\
    add r0, r10\n\
    ldrh r0, [r0]\n\
    strh r0, [r1, 0x20]\n\
_0801F9CC:\n\
    ldr r0, _0801FAE8 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x40\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0801FA02\n\
    ldr r6, _0801FAEC @ =gBattleMons\n\
    ldr r0, _0801FAF0 @ =gBankAttacker\n\
    ldrb r0, [r0]\n\
    movs r5, 0x58\n\
    muls r0, r5\n\
    adds r0, r6\n\
    ldrh r0, [r0, 0x28]\n\
    cmp r0, 0\n\
    beq _0801FA02\n\
    ldr r4, _0801FAF4 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    bl b_movescr_stack_push\n\
    ldr r1, _0801FAF8 @ =gBattleMoveDamage\n\
    adds r0, r7, 0\n\
    muls r0, r5\n\
    adds r0, r6\n\
    ldrh r0, [r0, 0x28]\n\
    str r0, [r1]\n\
    ldr r0, _0801FAFC @ =gUnknown_081D9156\n\
    str r0, [r4]\n\
_0801FA02:\n\
    ldr r1, _0801FB00 @ =gStatuses3\n\
    ldr r6, _0801FB04 @ =gBankTarget\n\
    ldrb r0, [r6]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    lsls r1, 7\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _0801FA1A\n\
    b _0801FB22\n\
_0801FA1A:\n\
    ldr r0, _0801FAE8 @ =gHitMarker\n\
    ldr r5, [r0]\n\
    movs r0, 0x80\n\
    lsls r0, 17\n\
    ands r5, r0\n\
    cmp r5, 0\n\
    bne _0801FB22\n\
    ldr r4, _0801FAF0 @ =gBankAttacker\n\
    mov r8, r4\n\
    ldrb r0, [r4]\n\
    bl GetBankSide\n\
    adds r4, r0, 0\n\
    ldrb r0, [r6]\n\
    bl GetBankSide\n\
    lsls r4, 24\n\
    lsls r0, 24\n\
    cmp r4, r0\n\
    beq _0801FB22\n\
    ldr r0, _0801FAEC @ =gBattleMons\n\
    mov r9, r0\n\
    mov r1, r8\n\
    ldrb r2, [r1]\n\
    movs r7, 0x58\n\
    adds r3, r2, 0\n\
    muls r3, r7\n\
    adds r0, r3, r0\n\
    ldrh r0, [r0, 0x28]\n\
    cmp r0, 0\n\
    beq _0801FB22\n\
    ldr r0, _0801FB08 @ =gCurrentMove\n\
    ldrh r0, [r0]\n\
    cmp r0, 0xA5\n\
    beq _0801FB22\n\
    ldr r1, _0801FB0C @ =0x02000000\n\
    ldr r4, _0801FB10 @ =0x0001608c\n\
    adds r0, r2, r4\n\
    adds r0, r1\n\
    ldrb r4, [r0]\n\
    adds r0, r4, r3\n\
    mov r6, r9\n\
    adds r6, 0x24\n\
    adds r0, r6\n\
    strb r5, [r0]\n\
    ldr r5, _0801FAF4 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r5]\n\
    bl b_movescr_stack_push\n\
    ldr r0, _0801FB14 @ =gUnknown_081D9468\n\
    str r0, [r5]\n\
    ldr r5, _0801FAE4 @ =gActiveBank\n\
    mov r1, r8\n\
    ldrb r0, [r1]\n\
    strb r0, [r5]\n\
    adds r1, r4, 0\n\
    adds r1, 0x9\n\
    lsls r1, 24\n\
    lsrs r1, 24\n\
    ldrb r0, [r5]\n\
    muls r0, r7\n\
    adds r0, r6\n\
    adds r0, r4\n\
    str r0, [sp]\n\
    movs r0, 0\n\
    movs r2, 0\n\
    movs r3, 0x1\n\
    bl EmitSetAttributes\n\
    ldrb r0, [r5]\n\
    bl MarkBufferBankForExecution\n\
    ldr r1, _0801FB18 @ =gBattleTextBuff1\n\
    movs r0, 0xFD\n\
    strb r0, [r1]\n\
    movs r0, 0x2\n\
    strb r0, [r1, 0x1]\n\
    lsls r4, 1\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    muls r0, r7\n\
    adds r0, r4, r0\n\
    mov r2, r9\n\
    adds r2, 0xC\n\
    adds r0, r2\n\
    ldrh r0, [r0]\n\
    strb r0, [r1, 0x2]\n\
    mov r3, r8\n\
    ldrb r0, [r3]\n\
    muls r0, r7\n\
    adds r4, r0\n\
    adds r4, r2\n\
    ldrh r0, [r4]\n\
    lsrs r0, 8\n\
    strb r0, [r1, 0x3]\n\
    movs r0, 0xFF\n\
    strb r0, [r1, 0x4]\n\
    b _0801FB22\n\
    .align 2, 0\n\
_0801FAE0: .4byte gBattleResults\n\
_0801FAE4: .4byte gActiveBank\n\
_0801FAE8: .4byte gHitMarker\n\
_0801FAEC: .4byte gBattleMons\n\
_0801FAF0: .4byte gBankAttacker\n\
_0801FAF4: .4byte gBattlescriptCurrInstr\n\
_0801FAF8: .4byte gBattleMoveDamage\n\
_0801FAFC: .4byte gUnknown_081D9156\n\
_0801FB00: .4byte gStatuses3\n\
_0801FB04: .4byte gBankTarget\n\
_0801FB08: .4byte gCurrentMove\n\
_0801FB0C: .4byte 0x02000000\n\
_0801FB10: .4byte 0x0001608c\n\
_0801FB14: .4byte gUnknown_081D9468\n\
_0801FB18: .4byte gBattleTextBuff1\n\
_0801FB1C:\n\
    ldr r0, [r6]\n\
    adds r0, 0x7\n\
    str r0, [r6]\n\
_0801FB22:\n\
    add sp, 0x4\n\
    pop {r3-r5}\n\
    mov r8, r3\n\
    mov r9, r4\n\
    mov r10, r5\n\
    pop {r4-r7}\n\
    pop {r0}\n\
    bx r0\n\
    .syntax divided\n");
}

void atk1A_faint_animation(void)
{
    if (gBattleExecBuffer) {return;}

    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    EmitFaintAnimation(0);
    MarkBufferBankForExecution(gActiveBank);
    gBattlescriptCurrInstr += 2;
}

void atk1B_faint_effects_clear(void)
{
    //Clears things like attraction or trapping to other banks
    if (gBattleExecBuffer) {return;}

    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    gBattleMons[gActiveBank].status1 = 0;
    EmitSetAttributes(0, REQUEST_STATUS_BATTLE, 0, 0x4, &gBattleMons[gActiveBank].status1);
    MarkBufferBankForExecution(gActiveBank);
    UndoEffectsAfterFainting();
    gBattlescriptCurrInstr += 2;
}

void atk1C_jumpifstatus(void)
{
    u8 bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    u32 flags = BS2ScriptRead32(gBattlescriptCurrInstr + 2);
    void* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 6);
    if (gBattleMons[bank].status1 & flags && gBattleMons[bank].hp)
        gBattlescriptCurrInstr = jump_loc;
    else
        gBattlescriptCurrInstr += 10;
}

void atk1D_jumpifstatus2(void)
{
    u8 bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    u32 flags = BS2ScriptRead32(gBattlescriptCurrInstr + 2);
    void* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 6);
    if (gBattleMons[bank].status2 & flags && gBattleMons[bank].hp)
        gBattlescriptCurrInstr = jump_loc;
    else
        gBattlescriptCurrInstr += 10;
}

void atk1E_jumpifability(void)
{
    u8 bank;
    u8 ability = BSScriptRead8(gBattlescriptCurrInstr + 2);
    void* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 3);
    if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 8)
    {
        bank = AbilityBattleEffects(ABILITY_CHECK_BANK_SIDE, gBankAttacker, ability, 0, 0);
        if (bank)
        {
            gLastUsedAbility = ability;
            gBattlescriptCurrInstr = jump_loc;
            RecordAbilityBattle(bank -1, gLastUsedAbility);
            unk_2000000[0x160f8] = bank - 1;
        }
        else
            gBattlescriptCurrInstr += 7;
    }
    else if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 9)
    {
        bank = AbilityBattleEffects(ABILITY_CHECK_OTHER_SIDE, gBankAttacker, ability, 0, 0);
        if (bank)
        {
            gLastUsedAbility = ability;
            gBattlescriptCurrInstr = jump_loc;
            RecordAbilityBattle(bank - 1, gLastUsedAbility);
            unk_2000000[0x160f8] = bank - 1;
        }
        else
            gBattlescriptCurrInstr += 7;
    }
    else
    {
        bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
        if (gBattleMons[bank].ability == ability)
        {
            gLastUsedAbility = ability;
            gBattlescriptCurrInstr = jump_loc;
            RecordAbilityBattle(bank, gLastUsedAbility);
            unk_2000000[0x160f8] = bank;
        }
        else
            gBattlescriptCurrInstr += 7;
    }
}

void atk1F_jumpifsideaffecting(void)
{
    u8 side;
    u16 flags;
    void* jump_loc;
    if (BSScriptRead8(gBattlescriptCurrInstr + 1) == 1)
        side = GetBankIdentity(gBankAttacker) & 1;
    else
        side = GetBankIdentity(gBankTarget) & 1;

    flags = BS2ScriptRead16(gBattlescriptCurrInstr + 2);
    jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 4);

    if (gSideAffecting[side] & flags)
        gBattlescriptCurrInstr = jump_loc;
    else
        gBattlescriptCurrInstr += 8;
}

void atk20_jumpifstat(void)
{
    u8 ret = 0;
    u8 bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    u8 value = gBattleMons[bank].statStages[BSScriptRead8(gBattlescriptCurrInstr + 3)];
    switch (BSScriptRead8(gBattlescriptCurrInstr + 2))
    {
    case CMP_EQUAL:
        if (value == BSScriptRead8(gBattlescriptCurrInstr + 4))
            ret++;
        break;
    case CMP_NOT_EQUAL:
        if (value != BSScriptRead8(gBattlescriptCurrInstr + 4))
            ret++;
        break;
    case CMP_GREATER_THAN:
        if (value > BSScriptRead8(gBattlescriptCurrInstr + 4))
            ret++;
        break;
    case CMP_LESS_THAN:
        if (value < BSScriptRead8(gBattlescriptCurrInstr + 4))
            ret++;
        break;
    case CMP_COMMON_BITS:
        if (value & BSScriptRead8(gBattlescriptCurrInstr + 4))
            ret++;
        break;
    case CMP_NO_COMMON_BITS:
        if (!(value & BSScriptRead8(gBattlescriptCurrInstr + 4)))
            ret++;
        break;
    }
    if (ret)
        gBattlescriptCurrInstr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 5);
    else
        gBattlescriptCurrInstr += 9;
}

void atk21_jumpifstatus3(void)
{
    u32 flags;
    void* jump_loc;

    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    flags = BS2ScriptRead32(gBattlescriptCurrInstr + 2);
    jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 7);
    if (BSScriptRead8(gBattlescriptCurrInstr + 6))
    {
        if ((gStatuses3[gActiveBank] & flags) != 0)
            gBattlescriptCurrInstr += 11;
        else
            gBattlescriptCurrInstr = jump_loc;
    }
    else
    {
        if ((gStatuses3[gActiveBank] & flags) != 0)
            gBattlescriptCurrInstr = jump_loc;
        else
            gBattlescriptCurrInstr += 11;
    }
}

void atk22_jumpiftype(void) //u8 bank, u8 type, *ptr
{
    u8 bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    u8 type = BSScriptRead8(gBattlescriptCurrInstr + 2);
    void* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 3);

    if (gBattleMons[bank].type1 == type || gBattleMons[bank].type2 == type)
        gBattlescriptCurrInstr = jump_loc;
    else
        gBattlescriptCurrInstr += 7;
}

//here we go again...
//#ifdef NONMATCHING
void atk23_getexp(void)
{
    u8 hold_effect;
    int via_expshare = 0, sent_in;
	int via_sent_in;
    u16* exp = &BATTLE_STRUCT->exp;
    gBank1 = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    sent_in = gSentPokesToOpponent[(gBank1 & 2) >> 1];
    switch (BATTLE_STRUCT->atk23StateTracker)
    {
    case 0: //check if should receive exp at all
        if (GetBankSide(gBank1) != 1 || (gBattleTypeFlags & (BATTLE_TYPE_LINK | BATTLE_TYPE_SAFARI | BATTLE_TYPE_BATTLE_TOWER | BATTLE_TYPE_EREADER_TRAINER)))
            BATTLE_STRUCT->atk23StateTracker = 6; //goto last case
        else
        {
            BATTLE_STRUCT->atk23StateTracker++;
            unk_2000000[0x16113] |= gBitTable[gBattlePartyID[gBank1]];
        }
        break;
    case 1: //calculate experience points to redistribute
        {
			int i;
			u16 calculatedExp;
            via_sent_in = 0;
            for (i = 0; i < 6; i++)
            {
                u16 item;
                if (GetMonData(&gPlayerParty[i], MON_DATA_SPECIES) == 0 || GetMonData(&gPlayerParty[i], MON_DATA_HP) == 0)
                    continue;
                if (gBitTable[i] & sent_in)
                    via_sent_in++;

                item = GetMonData(&gPlayerParty[i], MON_DATA_HELD_ITEM);
                if (item == ITEM_ENIGMA_BERRY)
                    hold_effect = gSaveBlock1.enigmaBerry.holdEffect;
                else
                    hold_effect = ItemId_GetHoldEffect(item);

                if (hold_effect == HOLD_EFFECT_EXP_SHARE)
                    via_expshare++;
            }
            calculatedExp = gBaseStats[gBattleMons[gBank1].species].expYield * gBattleMons[gBank1].level / 7;
            if (via_expshare) //at least one poke is getting exp via exp share
            {
                calculatedExp /= 2;
                *exp = calculatedExp / via_sent_in;
                ATLEAST_ONE_PTR(exp);

                gExpShareExp = calculatedExp / via_expshare;
                ATLEAST_ONE_PTR(&gExpShareExp);
            }
            else
            {
                *exp = calculatedExp / via_sent_in;
                ATLEAST_ONE_PTR(exp);
                gExpShareExp = 0;
            }
            BATTLE_STRUCT->atk23StateTracker++;
            BATTLE_STRUCT->expGetterID = 0;
            BATTLE_STRUCT->sentInPokes = sent_in;
        } //no break statement
    case 2: //loop; set exp value to the poke in expgetter_id and print message
        if (gBattleExecBuffer == 0)
        {
            u16 item = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_HELD_ITEM);
            u8* tracker; u32 zero;
            if (item == ITEM_ENIGMA_BERRY)
                hold_effect = gSaveBlock1.enigmaBerry.holdEffect;
            else
                hold_effect = ItemId_GetHoldEffect(item);

            if ((hold_effect != HOLD_EFFECT_EXP_SHARE && !(BATTLE_STRUCT->sentInPokes & 1)))
            {
                BATTLE_STRUCT->sentInPokes >>= 1;
                tracker = &BATTLE_STRUCT->atk23StateTracker;
                zero = 0;
                goto LABEL;
            }
            else if (GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_LEVEL) == 100)
            {
                BATTLE_STRUCT->sentInPokes >>= 1;
                tracker = &BATTLE_STRUCT->atk23StateTracker;
                zero = 0;
                LABEL:
                *tracker = 5; //increment looper
                gBattleMoveDamage = zero; //used for exp
            }
            else
            {
                //music change in wild battle after fainting a poke
                if (!(gBattleTypeFlags & BATTLE_TYPE_TRAINER) && gBattleMons[0].hp && !BATTLE_STRUCT->wildVictorySong)
                {
                    BattleMusicStop();
                    PlayBGM(0x161);
                    BATTLE_STRUCT->wildVictorySong++;
                }

                if (GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_HP))
                {
                    s32 stringID;
                    if (BATTLE_STRUCT->sentInPokes & 1)
                        gBattleMoveDamage = *exp;
                    else
                        gBattleMoveDamage = 0;

                    if (hold_effect == HOLD_EFFECT_EXP_SHARE)
                        gBattleMoveDamage += gExpShareExp;
                    if (hold_effect == HOLD_EFFECT_LUCKY_EGG)
                        gBattleMoveDamage = (gBattleMoveDamage * 150) / 100;
                    if (gBattleTypeFlags & BATTLE_TYPE_TRAINER)
                        gBattleMoveDamage = (gBattleMoveDamage * 150) / 100;

                    if (IsTradedMon(&gPlayerParty[BATTLE_STRUCT->expGetterID]))
                    {
                        gBattleMoveDamage = (gBattleMoveDamage * 150) / 100;
                        stringID = 0x14A;
                    }
                    else
                        stringID = 0x149;

                    //get exp getter bank
                    if (gBattleTypeFlags & BATTLE_TYPE_DOUBLE)
                    {
                        if (!(gBattlePartyID[2] != BATTLE_STRUCT->expGetterID) && !(gAbsentBankFlags & gBitTable[2]))
                            BATTLE_STRUCT->expGetterBank = 2;
                        else
                        {
                            if (!(gAbsentBankFlags & gBitTable[0]))
                                BATTLE_STRUCT->expGetterBank = 0;
                            else
                                BATTLE_STRUCT->expGetterBank = 2;
                        }
                    }
                    else
                        BATTLE_STRUCT->expGetterBank = 0;

    // redo how the experience is entirely calculated.
    if(CheckSpeedchoiceOption(BWEXP, ON) == TRUE)
    {
        #define EXP_CONSTANT_GENV 7
		s16 newCalculatedExp;
        u32 upperRatio;
        u32 lowerRatio;

        // step 1
        newCalculatedExp = gBaseStats[gBattleMons[gBank1].species].expYield * gBattleMons[gBank1].level / EXP_CONSTANT_GENV;
		if (via_expshare) // i literally copy pasted this.
        {
            newCalculatedExp /= 2;
            *exp = newCalculatedExp / via_sent_in;
            ATLEAST_ONE_PTR(exp);

            gExpShareExp = newCalculatedExp / via_expshare;
            ATLEAST_ONE_PTR(&gExpShareExp);
        }
        else
        {
            *exp = newCalculatedExp / via_sent_in;
            ATLEAST_ONE_PTR(exp);
            gExpShareExp = 0;
        }
		if (BATTLE_STRUCT->sentInPokes & 1)
            newCalculatedExp = *exp;
        else
            newCalculatedExp = 0;
        if (gBattleTypeFlags & BATTLE_TYPE_TRAINER)
            newCalculatedExp = (newCalculatedExp * 150) / 100; // x 1.5

        // step 2, calculate ratio
        upperRatio = ((gBattleMons[gBank1].level * 2) + 10);
        upperRatio *= upperRatio * Sqrt(upperRatio);
        lowerRatio = (gBattleMons[gBank1].level + gBattleMons[BATTLE_STRUCT->expGetterBank].level + 10);
        lowerRatio *= lowerRatio * Sqrt(lowerRatio);

        // step 3, calculate ratio product and multiply rest.
        newCalculatedExp = max(newCalculatedExp, newCalculatedExp * upperRatio / lowerRatio) + 1;
        if (IsTradedMon(&gPlayerParty[BATTLE_STRUCT->expGetterID]))
            newCalculatedExp = (newCalculatedExp * 150) / 100; // x 1.5
        if (hold_effect == HOLD_EFFECT_LUCKY_EGG)
            newCalculatedExp = (newCalculatedExp * 150) / 100; // x 1.5
        if (hold_effect == HOLD_EFFECT_EXP_SHARE)
            newCalculatedExp += gExpShareExp;
		gBattleMoveDamage = newCalculatedExp;
    }

                    //buffer poke name
                    gBattleTextBuff1[0] = 0xFD;
                    gBattleTextBuff1[1] = 4;
                    gBattleTextBuff1[2] = BATTLE_STRUCT->expGetterBank;
                    gBattleTextBuff1[3] = BATTLE_STRUCT->expGetterID;
                    gBattleTextBuff1[4] = 0xFF;

                    //buffer 'gained' or 'gained a boosted'
                    gBattleTextBuff2[0] = 0xFD;
                    gBattleTextBuff2[1] = 0;
                    gBattleTextBuff2[2] = stringID;
                    gBattleTextBuff2[3] = (stringID & (0xFF00)) >> 8;
                    gBattleTextBuff2[4] = 0xFF;

                    //buffer exp number
                    gBattleTextBuff3[0] = 0xFD;
                    gBattleTextBuff3[1] = 1;
                    gBattleTextBuff3[2] = 4; //word
                    gBattleTextBuff3[3] = 5; //max digits
                    gBattleTextBuff3[4] = gBattleMoveDamage;
                    gBattleTextBuff3[5] = (gBattleMoveDamage & 0x00FF00) >> 8;
                    gBattleTextBuff3[6] = (gBattleMoveDamage & 0xFF0000) >> 0x10;
                    gBattleTextBuff3[7] = gBattleMoveDamage >> 0x18;
                    gBattleTextBuff3[8] = 0xFF;

                    PrepareStringBattle(0xD, BATTLE_STRUCT->expGetterBank);
                    MonGainEVs(&gPlayerParty[BATTLE_STRUCT->expGetterID], gBattleMons[gBank1].species);
                }
                BATTLE_STRUCT->sentInPokes >>= 1;
                BATTLE_STRUCT->atk23StateTracker++;
            }
        }
        break;
    case 3: //Set Stats and give exp
        if (gBattleExecBuffer == 0)
        {
            BattleBufferB[BATTLE_STRUCT->expGetterBank][0] = 0;
            if (GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_HP) && GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_LEVEL) != 100)
            {
                BATTLE_STRUCT->beforeLvlUp[0] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_MAX_HP); //doesnt match
                BATTLE_STRUCT->beforeLvlUp[1] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_ATK);
                BATTLE_STRUCT->beforeLvlUp[2] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_DEF);
                BATTLE_STRUCT->beforeLvlUp[3] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPD);
                BATTLE_STRUCT->beforeLvlUp[4] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPATK);
                BATTLE_STRUCT->beforeLvlUp[5] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPDEF);

                gActiveBank = BATTLE_STRUCT->expGetterBank;
                EmitExpBarUpdate(0, BATTLE_STRUCT->expGetterID, gBattleMoveDamage);
                MarkBufferBankForExecution(gActiveBank);
            }
            BATTLE_STRUCT->atk23StateTracker++;
        }
        break;
    case 4: //lvl up if necessary
        if (gBattleExecBuffer == 0)
        {
            gActiveBank = BATTLE_STRUCT->expGetterBank;
            if (BattleBufferB[gActiveBank][0] == 0x21 && BattleBufferB[gActiveBank][1] == 0xB)
            {
                if (gBattleTypeFlags & BATTLE_TYPE_TRAINER && gBattlePartyID[gActiveBank] == BATTLE_STRUCT->expGetterID)
                    sub_80324F8(&gPlayerParty[gActiveBank], gActiveBank);

                //buff poke name
                gBattleTextBuff1[0] = 0xFD;
                gBattleTextBuff1[1] = 4;
                gBattleTextBuff1[2] = gActiveBank;
                gBattleTextBuff1[3] = BATTLE_STRUCT->expGetterID;
                gBattleTextBuff1[4] = 0xFF;

                //buff level
                gBattleTextBuff2[0] = 0xFD;
                gBattleTextBuff2[1] = 1;
                gBattleTextBuff2[2] = 1;
                gBattleTextBuff2[3] = 3;
                gBattleTextBuff2[4] = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_LEVEL);
                gBattleTextBuff2[5] = 0xFF;

                b_movescr_stack_push_cursor();
                gLeveledUpInBattle |= gBitTable[BATTLE_STRUCT->expGetterID];
                gBattlescriptCurrInstr = BattleScript_LevelUp;
                gBattleMoveDamage = (BattleBufferB[gActiveBank][2] | (BattleBufferB[gActiveBank][3] << 8));
                AdjustFriendship(&gPlayerParty[BATTLE_STRUCT->expGetterID], 0);

                //update battle mon structure after level up
                if (gBattlePartyID[0] == BATTLE_STRUCT->expGetterID && gBattleMons[0].hp)
                {
                    gBattleMons[0].level = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_LEVEL);
                    gBattleMons[0].hp = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_HP);
                    gBattleMons[0].maxHP = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_MAX_HP);
                    gBattleMons[0].attack = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_ATK);
                    gBattleMons[0].defense = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_DEF);
                    gBattleMons[0].speed = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPD);
                    gBattleMons[0].spAttack = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPATK);
                    gBattleMons[0].spDefense = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPDEF);
                }
                //What is else if? Guess it's too advanced for GameFreak
                if (gBattlePartyID[2] == BATTLE_STRUCT->expGetterID && gBattleMons[2].hp && (gBattleTypeFlags & BATTLE_TYPE_DOUBLE))
                {
                    gBattleMons[2].level = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_LEVEL);
                    gBattleMons[2].hp = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_HP);
                    gBattleMons[2].maxHP = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_MAX_HP);
                    gBattleMons[2].attack = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_ATK);
                    gBattleMons[2].defense = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_DEF);
                    //There are no words...GF can't even copy&paste code properly
                    gBattleMons[2].speed = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPD);
                    gBattleMons[2].spAttack = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPD /*RIP*/);
                    gBattleMons[2].spDefense = GetMonData(&gPlayerParty[BATTLE_STRUCT->expGetterID], MON_DATA_SPATK);
                }
                BATTLE_STRUCT->atk23StateTracker = 5;
            }
            else
            {
                gBattleMoveDamage = 0;
                BATTLE_STRUCT->atk23StateTracker = 5;
            }
        }
        break;
    case 5: //looper increment
        if (gBattleMoveDamage) //there is exp to give, goto case 3 that gives exp
            BATTLE_STRUCT->atk23StateTracker = 3;
        else
        {
            if (++BATTLE_STRUCT->expGetterID <= 5)
                BATTLE_STRUCT->atk23StateTracker = 2; //loop again
            else
                BATTLE_STRUCT->atk23StateTracker = 6; //we're done
        }
        break;
    case 6: //increment instruction
        if (gBattleExecBuffer == 0)
        {
            //not even sure why gamefreak clears that data in this place
            gBattleMons[gBank1].item = 0;
            gBattleMons[gBank1].ability = 0;
            gBattlescriptCurrInstr += 2;
        }
        break;
    }
}
/*#else
__attribute__((naked))
void atk23_getexp(void)
{
    asm(".syntax unified\n\
            push {r4-r7,lr}\n\
    mov r7, r10\n\
    mov r6, r9\n\
    mov r5, r8\n\
    push {r5-r7}\n\
    movs r6, 0\n\
    ldr r0, _0802004C @ =0x0201605c\n\
    mov r10, r0\n\
    ldr r0, _08020050 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r0]\n\
    ldrb r0, [r0, 0x1]\n\
    bl GetBattleBank\n\
    ldr r1, _08020054 @ =gBank1\n\
    strb r0, [r1]\n\
    ldr r2, _08020058 @ =gSentPokesToOpponent\n\
    movs r1, 0x2\n\
    ands r1, r0\n\
    lsls r1, 24\n\
    lsrs r1, 25\n\
    adds r1, r2\n\
    ldrb r1, [r1]\n\
    mov r8, r1\n\
    mov r0, r10\n\
    subs r0, 0x4D\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x6\n\
    bls _08020040\n\
    bl _08020996\n\
_08020040:\n\
    lsls r0, 2\n\
    ldr r1, _0802005C @ =_08020060\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    mov pc, r0\n\
    .align 2, 0\n\
_0802004C: .4byte 0x0201605c\n\
_08020050: .4byte gBattlescriptCurrInstr\n\
_08020054: .4byte gBank1\n\
_08020058: .4byte gSentPokesToOpponent\n\
_0802005C: .4byte _08020060\n\
    .align 2, 0\n\
_08020060:\n\
    .4byte _0802007C\n\
    .4byte _080200FC\n\
    .4byte _08020216\n\
    .4byte _0802055C\n\
    .4byte _08020648\n\
    .4byte _08020910\n\
    .4byte _0802096C\n\
_0802007C:\n\
    ldr r4, _080200A8 @ =gBank1\n\
    ldrb r0, [r4]\n\
    bl GetBankSide\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x1\n\
    bne _08020098\n\
    ldr r0, _080200AC @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    ldr r0, _080200B0 @ =0x00000982\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080200BC\n\
_08020098:\n\
    ldr r0, _080200B4 @ =0x02000000\n\
    ldr r1, _080200B8 @ =0x0001600f\n\
    adds r0, r1\n\
    movs r1, 0x6\n\
    strb r1, [r0]\n\
    bl _08020996\n\
    .align 2, 0\n\
_080200A8: .4byte gBank1\n\
_080200AC: .4byte gBattleTypeFlags\n\
_080200B0: .4byte 0x00000982\n\
_080200B4: .4byte 0x02000000\n\
_080200B8: .4byte 0x0001600f\n\
_080200BC:\n\
    ldr r2, _080200E8 @ =0x02000000\n\
    ldr r3, _080200EC @ =0x0001600f\n\
    adds r1, r2, r3\n\
    ldrb r0, [r1]\n\
    adds r0, 0x1\n\
    strb r0, [r1]\n\
    ldr r0, _080200F0 @ =0x00016113\n\
    adds r2, r0\n\
    ldr r3, _080200F4 @ =gBitTable\n\
    ldr r1, _080200F8 @ =gBattlePartyID\n\
    ldrb r0, [r4]\n\
    lsls r0, 1\n\
    adds r0, r1\n\
    ldrh r0, [r0]\n\
    lsls r0, 2\n\
    adds r0, r3\n\
    ldr r0, [r0]\n\
    ldrb r1, [r2]\n\
    orrs r0, r1\n\
    strb r0, [r2]\n\
    bl _08020996\n\
    .align 2, 0\n\
_080200E8: .4byte 0x02000000\n\
_080200EC: .4byte 0x0001600f\n\
_080200F0: .4byte 0x00016113\n\
_080200F4: .4byte gBitTable\n\
_080200F8: .4byte gBattlePartyID\n\
_080200FC:\n\
    movs r5, 0\n\
    movs r7, 0\n\
    ldr r1, _08020150 @ =gSaveBlock1 + 0x3688\n\
    mov r9, r1\n\
_08020104:\n\
    movs r0, 0x64\n\
    adds r1, r7, 0\n\
    muls r1, r0\n\
    ldr r0, _08020154 @ =gPlayerParty\n\
    adds r4, r1, r0\n\
    adds r0, r4, 0\n\
    movs r1, 0xB\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    beq _0802016A\n\
    adds r0, r4, 0\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    beq _0802016A\n\
    ldr r0, _08020158 @ =gBitTable\n\
    lsls r1, r7, 2\n\
    adds r1, r0\n\
    ldr r0, [r1]\n\
    mov r2, r8\n\
    ands r0, r2\n\
    cmp r0, 0\n\
    beq _08020138\n\
    adds r5, 0x1\n\
_08020138:\n\
    adds r0, r4, 0\n\
    movs r1, 0xC\n\
    bl GetMonData\n\
    lsls r0, 16\n\
    lsrs r0, 16\n\
    cmp r0, 0xAF\n\
    bne _0802015C\n\
    mov r3, r9\n\
    ldrb r4, [r3]\n\
    b _08020164\n\
    .align 2, 0\n\
_08020150: .4byte gSaveBlock1 + 0x3688\n\
_08020154: .4byte gPlayerParty\n\
_08020158: .4byte gBitTable\n\
_0802015C:\n\
    bl ItemId_GetHoldEffect\n\
    lsls r0, 24\n\
    lsrs r4, r0, 24\n\
_08020164:\n\
    cmp r4, 0x19\n\
    bne _0802016A\n\
    adds r6, 0x1\n\
_0802016A:\n\
    adds r7, 0x1\n\
    cmp r7, 0x5\n\
    ble _08020104\n\
    ldr r3, _080201D0 @ =gBaseStats\n\
    ldr r2, _080201D4 @ =gBattleMons\n\
    ldr r0, _080201D8 @ =gBank1\n\
    ldrb r1, [r0]\n\
    movs r0, 0x58\n\
    muls r1, r0\n\
    adds r1, r2\n\
    ldrh r2, [r1]\n\
    lsls r0, r2, 3\n\
    subs r0, r2\n\
    lsls r0, 2\n\
    adds r0, r3\n\
    ldrb r2, [r0, 0x9]\n\
    adds r1, 0x2A\n\
    ldrb r0, [r1]\n\
    muls r0, r2\n\
    movs r1, 0x7\n\
    bl __divsi3\n\
    lsls r0, 16\n\
    lsrs r1, r0, 16\n\
    cmp r6, 0\n\
    beq _080201E0\n\
    lsrs r4, r0, 17\n\
    adds r0, r4, 0\n\
    adds r1, r5, 0\n\
    bl __divsi3\n\
    mov r1, r10\n\
    strh r0, [r1]\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _080201B6\n\
    movs r0, 0x1\n\
    strh r0, [r1]\n\
_080201B6:\n\
    ldr r5, _080201DC @ =gExpShareExp\n\
    adds r0, r4, 0\n\
    adds r1, r6, 0\n\
    bl __divsi3\n\
    strh r0, [r5]\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _080201FA\n\
    movs r0, 0x1\n\
    strh r0, [r5]\n\
    b _080201FA\n\
    .align 2, 0\n\
_080201D0: .4byte gBaseStats\n\
_080201D4: .4byte gBattleMons\n\
_080201D8: .4byte gBank1\n\
_080201DC: .4byte gExpShareExp\n\
_080201E0:\n\
    adds r0, r1, 0\n\
    adds r1, r5, 0\n\
    bl __divsi3\n\
    mov r2, r10\n\
    strh r0, [r2]\n\
    lsls r0, 16\n\
    cmp r0, 0\n\
    bne _080201F6\n\
    movs r0, 0x1\n\
    strh r0, [r2]\n\
_080201F6:\n\
    ldr r0, _08020248 @ =gExpShareExp\n\
    strh r6, [r0]\n\
_080201FA:\n\
    ldr r1, _0802024C @ =0x02000000\n\
    ldr r3, _08020250 @ =0x0001600f\n\
    adds r2, r1, r3\n\
    ldrb r0, [r2]\n\
    adds r0, 0x1\n\
    movs r3, 0\n\
    strb r0, [r2]\n\
    ldr r2, _08020254 @ =0x00016018\n\
    adds r0, r1, r2\n\
    strb r3, [r0]\n\
    ldr r3, _08020258 @ =0x0001605f\n\
    adds r1, r3\n\
    mov r0, r8\n\
    strb r0, [r1]\n\
_08020216:\n\
    ldr r0, _0802025C @ =gBattleExecBuffer\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _08020220\n\
    b _08020996\n\
_08020220:\n\
    ldr r0, _0802024C @ =0x02000000\n\
    ldr r1, _08020254 @ =0x00016018\n\
    adds r0, r1\n\
    ldrb r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _08020260 @ =gPlayerParty\n\
    adds r0, r1\n\
    movs r1, 0xC\n\
    bl GetMonData\n\
    lsls r0, 16\n\
    lsrs r0, 16\n\
    cmp r0, 0xAF\n\
    bne _0802026C\n\
    ldr r0, _08020264 @ =gSaveBlock1\n\
    ldr r2, _08020268 @ =0x00003688\n\
    adds r0, r2\n\
    ldrb r4, [r0]\n\
    b _08020274\n\
    .align 2, 0\n\
_08020248: .4byte gExpShareExp\n\
_0802024C: .4byte 0x02000000\n\
_08020250: .4byte 0x0001600f\n\
_08020254: .4byte 0x00016018\n\
_08020258: .4byte 0x0001605f\n\
_0802025C: .4byte gBattleExecBuffer\n\
_08020260: .4byte gPlayerParty\n\
_08020264: .4byte gSaveBlock1\n\
_08020268: .4byte 0x00003688\n\
_0802026C:\n\
    bl ItemId_GetHoldEffect\n\
    lsls r0, 24\n\
    lsrs r4, r0, 24\n\
_08020274:\n\
    ldr r5, _08020294 @ =0x02000000\n\
    cmp r4, 0x19\n\
    beq _080202A0\n\
    ldr r3, _08020298 @ =0x0001605f\n\
    adds r1, r5, r3\n\
    ldrb r0, [r1]\n\
    movs r2, 0x1\n\
    ands r2, r0\n\
    cmp r2, 0\n\
    bne _080202A0\n\
    lsrs r0, 1\n\
    strb r0, [r1]\n\
    ldr r0, _0802029C @ =0x0001600f\n\
    adds r1, r5, r0\n\
    b _080202C8\n\
    .align 2, 0\n\
_08020294: .4byte 0x02000000\n\
_08020298: .4byte 0x0001605f\n\
_0802029C: .4byte 0x0001600f\n\
_080202A0:\n\
    ldr r1, _080202D4 @ =0x00016018\n\
    adds r0, r5, r1\n\
    ldrb r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _080202D8 @ =gPlayerParty\n\
    adds r0, r1\n\
    movs r1, 0x38\n\
    bl GetMonData\n\
    cmp r0, 0x64\n\
    bne _080202E8\n\
    ldr r2, _080202DC @ =0x0001605f\n\
    adds r1, r5, r2\n\
    ldrb r0, [r1]\n\
    lsrs r0, 1\n\
    movs r2, 0\n\
    strb r0, [r1]\n\
    ldr r3, _080202E0 @ =0x0001600f\n\
    adds r1, r5, r3\n\
_080202C8:\n\
    movs r0, 0x5\n\
    strb r0, [r1]\n\
    ldr r0, _080202E4 @ =gBattleMoveDamage\n\
    str r2, [r0]\n\
    b _08020996\n\
    .align 2, 0\n\
_080202D4: .4byte 0x00016018\n\
_080202D8: .4byte gPlayerParty\n\
_080202DC: .4byte 0x0001605f\n\
_080202E0: .4byte 0x0001600f\n\
_080202E4: .4byte gBattleMoveDamage\n\
_080202E8:\n\
    ldr r0, _0802034C @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    movs r0, 0x8\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    bne _08020316\n\
    ldr r0, _08020350 @ =gBattleMons\n\
    ldrh r0, [r0, 0x28]\n\
    cmp r0, 0\n\
    beq _08020316\n\
    ldr r0, _08020354 @ =0x0001601b\n\
    adds r5, r0\n\
    ldrb r0, [r5]\n\
    cmp r0, 0\n\
    bne _08020316\n\
    bl BattleMusicStop\n\
    ldr r0, _08020358 @ =0x00000161\n\
    bl PlayBGM\n\
    ldrb r0, [r5]\n\
    adds r0, 0x1\n\
    strb r0, [r5]\n\
_08020316:\n\
    ldr r5, _0802035C @ =0x02000000\n\
    ldr r1, _08020360 @ =0x00016018\n\
    adds r0, r5, r1\n\
    ldrb r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _08020364 @ =gPlayerParty\n\
    adds r0, r1\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    bne _08020332\n\
    b _0802051E\n\
_08020332:\n\
    ldr r2, _08020368 @ =0x0001605f\n\
    adds r0, r5, r2\n\
    ldrb r0, [r0]\n\
    movs r3, 0x1\n\
    ands r3, r0\n\
    cmp r3, 0\n\
    beq _08020370\n\
    ldr r1, _0802036C @ =gBattleMoveDamage\n\
    mov r3, r10\n\
    ldrh r0, [r3]\n\
    str r0, [r1]\n\
    mov r8, r1\n\
    b _08020376\n\
    .align 2, 0\n\
_0802034C: .4byte gBattleTypeFlags\n\
_08020350: .4byte gBattleMons\n\
_08020354: .4byte 0x0001601b\n\
_08020358: .4byte 0x00000161\n\
_0802035C: .4byte 0x02000000\n\
_08020360: .4byte 0x00016018\n\
_08020364: .4byte gPlayerParty\n\
_08020368: .4byte 0x0001605f\n\
_0802036C: .4byte gBattleMoveDamage\n\
_08020370:\n\
    ldr r0, _080203EC @ =gBattleMoveDamage\n\
    str r3, [r0]\n\
    mov r8, r0\n\
_08020376:\n\
    cmp r4, 0x19\n\
    bne _08020386\n\
    ldr r0, _080203F0 @ =gExpShareExp\n\
    ldrh r1, [r0]\n\
    mov r2, r8\n\
    ldr r0, [r2]\n\
    adds r0, r1\n\
    str r0, [r2]\n\
_08020386:\n\
    cmp r4, 0x28\n\
    bne _0802039C\n\
    mov r3, r8\n\
    ldr r1, [r3]\n\
    movs r0, 0x96\n\
    muls r0, r1\n\
    movs r1, 0x64\n\
    bl __divsi3\n\
    mov r1, r8\n\
    str r0, [r1]\n\
_0802039C:\n\
    ldr r0, _080203F4 @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    movs r0, 0x8\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080203B8\n\
    ldr r4, _080203EC @ =gBattleMoveDamage\n\
    ldr r1, [r4]\n\
    movs r0, 0x96\n\
    muls r0, r1\n\
    movs r1, 0x64\n\
    bl __divsi3\n\
    str r0, [r4]\n\
_080203B8:\n\
    ldr r0, _080203F8 @ =0x02000000\n\
    ldr r2, _080203FC @ =0x00016018\n\
    adds r0, r2\n\
    ldrb r1, [r0]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _08020400 @ =gPlayerParty\n\
    adds r0, r1\n\
    bl IsTradedMon\n\
    lsls r0, 24\n\
    cmp r0, 0\n\
    beq _08020404\n\
    ldr r4, _080203EC @ =gBattleMoveDamage\n\
    ldr r1, [r4]\n\
    movs r0, 0x96\n\
    muls r0, r1\n\
    movs r1, 0x64\n\
    bl __divsi3\n\
    str r0, [r4]\n\
    movs r7, 0xA5\n\
    lsls r7, 1\n\
    mov r8, r4\n\
    b _0802040A\n\
    .align 2, 0\n\
_080203EC: .4byte gBattleMoveDamage\n\
_080203F0: .4byte gExpShareExp\n\
_080203F4: .4byte gBattleTypeFlags\n\
_080203F8: .4byte 0x02000000\n\
_080203FC: .4byte 0x00016018\n\
_08020400: .4byte gPlayerParty\n\
_08020404:\n\
    ldr r7, _0802043C @ =0x00000149\n\
    ldr r3, _08020440 @ =gBattleMoveDamage\n\
    mov r8, r3\n\
_0802040A:\n\
    ldr r0, _08020444 @ =gBattleTypeFlags\n\
    ldrh r0, [r0]\n\
    movs r1, 0x1\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    beq _08020488\n\
    ldr r1, _08020448 @ =gBattlePartyID\n\
    ldr r0, _0802044C @ =0x02000000\n\
    ldr r3, _08020450 @ =0x00016018\n\
    adds r2, r0, r3\n\
    ldrh r1, [r1, 0x4]\n\
    adds r5, r0, 0\n\
    ldr r4, _08020454 @ =gBitTable\n\
    ldr r3, _08020458 @ =gAbsentBankFlags\n\
    ldrb r2, [r2]\n\
    cmp r1, r2\n\
    bne _08020460\n\
    ldrb r1, [r3]\n\
    ldr r0, [r4, 0x8]\n\
    ands r1, r0\n\
    cmp r1, 0\n\
    bne _08020460\n\
    ldr r0, _0802045C @ =0x000160a2\n\
    adds r1, r5, r0\n\
    b _0802047C\n\
    .align 2, 0\n\
_0802043C: .4byte 0x00000149\n\
_08020440: .4byte gBattleMoveDamage\n\
_08020444: .4byte gBattleTypeFlags\n\
_08020448: .4byte gBattlePartyID\n\
_0802044C: .4byte 0x02000000\n\
_08020450: .4byte 0x00016018\n\
_08020454: .4byte gBitTable\n\
_08020458: .4byte gAbsentBankFlags\n\
_0802045C: .4byte 0x000160a2\n\
_08020460:\n\
    ldrb r2, [r3]\n\
    ldr r0, [r4]\n\
    ands r2, r0\n\
    cmp r2, 0\n\
    bne _08020478\n\
    ldr r1, _08020474 @ =0x000160a2\n\
    adds r0, r5, r1\n\
    strb r2, [r0]\n\
    b _08020490\n\
    .align 2, 0\n\
_08020474: .4byte 0x000160a2\n\
_08020478:\n\
    ldr r2, _08020484 @ =0x000160a2\n\
    adds r1, r5, r2\n\
_0802047C:\n\
    movs r0, 0x2\n\
    strb r0, [r1]\n\
    b _08020490\n\
    .align 2, 0\n\
_08020484: .4byte 0x000160a2\n\
_08020488:\n\
    ldr r0, _08020530 @ =0x02000000\n\
    ldr r3, _08020534 @ =0x000160a2\n\
    adds r0, r3\n\
    strb r1, [r0]\n\
_08020490:\n\
    ldr r1, _08020538 @ =gBattleTextBuff1\n\
    movs r3, 0\n\
    movs r2, 0xFD\n\
    strb r2, [r1]\n\
    movs r5, 0x4\n\
    strb r5, [r1, 0x1]\n\
    ldr r4, _08020530 @ =0x02000000\n\
    ldr r0, _08020534 @ =0x000160a2\n\
    adds r6, r4, r0\n\
    ldrb r0, [r6]\n\
    strb r0, [r1, 0x2]\n\
    ldr r0, _0802053C @ =0x00016018\n\
    adds r4, r0\n\
    ldrb r0, [r4]\n\
    strb r0, [r1, 0x3]\n\
    movs r0, 0xFF\n\
    strb r0, [r1, 0x4]\n\
    ldr r1, _08020540 @ =gBattleTextBuff2\n\
    strb r2, [r1]\n\
    strb r3, [r1, 0x1]\n\
    strb r7, [r1, 0x2]\n\
    movs r3, 0xFF\n\
    lsls r3, 8\n\
    ands r7, r3\n\
    asrs r0, r7, 8\n\
    strb r0, [r1, 0x3]\n\
    movs r0, 0x1\n\
    negs r0, r0\n\
    strb r0, [r1, 0x4]\n\
    ldr r1, _08020544 @ =gBattleTextBuff3\n\
    strb r2, [r1]\n\
    movs r0, 0x1\n\
    strb r0, [r1, 0x1]\n\
    strb r5, [r1, 0x2]\n\
    movs r0, 0x5\n\
    strb r0, [r1, 0x3]\n\
    mov r0, r8\n\
    ldr r2, [r0]\n\
    strb r2, [r1, 0x4]\n\
    adds r0, r2, 0\n\
    ands r0, r3\n\
    asrs r0, 8\n\
    strb r0, [r1, 0x5]\n\
    movs r0, 0xFF\n\
    lsls r0, 16\n\
    ands r0, r2\n\
    asrs r0, 16\n\
    strb r0, [r1, 0x6]\n\
    lsrs r2, 24\n\
    strb r2, [r1, 0x7]\n\
    movs r0, 0x1\n\
    negs r0, r0\n\
    strb r0, [r1, 0x8]\n\
    ldrb r1, [r6]\n\
    movs r0, 0xD\n\
    bl PrepareStringBattle\n\
    ldrb r1, [r4]\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _08020548 @ =gPlayerParty\n\
    adds r0, r1\n\
    ldr r3, _0802054C @ =gBattleMons\n\
    ldr r1, _08020550 @ =gBank1\n\
    ldrb r2, [r1]\n\
    movs r1, 0x58\n\
    muls r1, r2\n\
    adds r1, r3\n\
    ldrh r1, [r1]\n\
    bl MonGainEVs\n\
_0802051E:\n\
    ldr r1, _08020530 @ =0x02000000\n\
    ldr r3, _08020554 @ =0x0001605f\n\
    adds r2, r1, r3\n\
    ldrb r0, [r2]\n\
    lsrs r0, 1\n\
    strb r0, [r2]\n\
    ldr r0, _08020558 @ =0x0001600f\n\
    adds r1, r0\n\
    b _08020618\n\
    .align 2, 0\n\
_08020530: .4byte 0x02000000\n\
_08020534: .4byte 0x000160a2\n\
_08020538: .4byte gBattleTextBuff1\n\
_0802053C: .4byte 0x00016018\n\
_08020540: .4byte gBattleTextBuff2\n\
_08020544: .4byte gBattleTextBuff3\n\
_08020548: .4byte gPlayerParty\n\
_0802054C: .4byte gBattleMons\n\
_08020550: .4byte gBank1\n\
_08020554: .4byte 0x0001605f\n\
_08020558: .4byte 0x0001600f\n\
_0802055C:\n\
    ldr r0, _08020620 @ =gBattleExecBuffer\n\
    ldr r2, [r0]\n\
    cmp r2, 0\n\
    beq _08020566\n\
    b _08020996\n\
_08020566:\n\
    ldr r1, _08020624 @ =BattleBufferB\n\
    ldr r4, _08020628 @ =0x02000000\n\
    ldr r3, _0802062C @ =0x000160a2\n\
    adds r3, r4\n\
    mov r8, r3\n\
    ldrb r0, [r3]\n\
    lsls r0, 9\n\
    adds r0, r1\n\
    strb r2, [r0]\n\
    ldr r0, _08020630 @ =0x00016018\n\
    adds r7, r4, r0\n\
    ldrb r0, [r7]\n\
    movs r6, 0x64\n\
    muls r0, r6\n\
    ldr r5, _08020634 @ =gPlayerParty\n\
    adds r0, r5\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    beq _08020612\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x38\n\
    bl GetMonData\n\
    cmp r0, 0x64\n\
    beq _08020612\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3A\n\
    bl GetMonData\n\
    ldr r1, _08020638 @ =0x00017180\n\
    adds r4, r1\n\
    strh r0, [r4]\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3B\n\
    bl GetMonData\n\
    strh r0, [r4, 0x2]\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3C\n\
    bl GetMonData\n\
    strh r0, [r4, 0x4]\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3D\n\
    bl GetMonData\n\
    strh r0, [r4, 0x6]\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3E\n\
    bl GetMonData\n\
    strh r0, [r4, 0x8]\n\
    ldrb r0, [r7]\n\
    muls r0, r6\n\
    adds r0, r5\n\
    movs r1, 0x3F\n\
    bl GetMonData\n\
    strh r0, [r4, 0xA]\n\
    ldr r4, _0802063C @ =gActiveBank\n\
    mov r2, r8\n\
    ldrb r0, [r2]\n\
    strb r0, [r4]\n\
    ldrb r1, [r7]\n\
    ldr r0, _08020640 @ =gBattleMoveDamage\n\
    ldrh r2, [r0]\n\
    movs r0, 0\n\
    bl EmitExpBarUpdate\n\
    ldrb r0, [r4]\n\
    bl MarkBufferBankForExecution\n\
_08020612:\n\
    ldr r1, _08020628 @ =0x02000000\n\
    ldr r3, _08020644 @ =0x0001600f\n\
    adds r1, r3\n\
_08020618:\n\
    ldrb r0, [r1]\n\
    adds r0, 0x1\n\
    strb r0, [r1]\n\
    b _08020996\n\
    .align 2, 0\n\
_08020620: .4byte gBattleExecBuffer\n\
_08020624: .4byte BattleBufferB\n\
_08020628: .4byte 0x02000000\n\
_0802062C: .4byte 0x000160a2\n\
_08020630: .4byte 0x00016018\n\
_08020634: .4byte gPlayerParty\n\
_08020638: .4byte 0x00017180\n\
_0802063C: .4byte gActiveBank\n\
_08020640: .4byte gBattleMoveDamage\n\
_08020644: .4byte 0x0001600f\n\
_08020648:\n\
    ldr r0, _080208AC @ =gBattleExecBuffer\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _08020652\n\
    b _08020996\n\
_08020652:\n\
    ldr r1, _080208B0 @ =gActiveBank\n\
    ldr r4, _080208B4 @ =0x02000000\n\
    ldr r2, _080208B8 @ =0x000160a2\n\
    adds r0, r4, r2\n\
    ldrb r0, [r0]\n\
    strb r0, [r1]\n\
    ldr r2, _080208BC @ =BattleBufferB\n\
    ldrb r3, [r1]\n\
    lsls r1, r3, 9\n\
    adds r0, r1, r2\n\
    ldrb r0, [r0]\n\
    cmp r0, 0x21\n\
    beq _0802066E\n\
    b _080208F0\n\
_0802066E:\n\
    adds r0, r2, 0x1\n\
    adds r0, r1, r0\n\
    ldrb r0, [r0]\n\
    cmp r0, 0xB\n\
    beq _0802067A\n\
    b _080208F0\n\
_0802067A:\n\
    ldr r0, _080208C0 @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    movs r0, 0x8\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080206A8\n\
    ldr r1, _080208C4 @ =gBattlePartyID\n\
    lsls r0, r3, 1\n\
    adds r2, r0, r1\n\
    ldr r0, _080208C8 @ =0x00016018\n\
    adds r1, r4, r0\n\
    ldrh r0, [r2]\n\
    ldrb r1, [r1]\n\
    cmp r0, r1\n\
    bne _080206A8\n\
    adds r1, r0, 0\n\
    movs r0, 0x64\n\
    muls r0, r1\n\
    ldr r1, _080208CC @ =gPlayerParty\n\
    adds r0, r1\n\
    adds r1, r3, 0\n\
    bl sub_80324F8\n\
_080206A8:\n\
    ldr r1, _080208D0 @ =gBattleTextBuff1\n\
    movs r2, 0xFD\n\
    strb r2, [r1]\n\
    movs r0, 0x4\n\
    strb r0, [r1, 0x1]\n\
    ldr r5, _080208B0 @ =gActiveBank\n\
    ldrb r0, [r5]\n\
    strb r0, [r1, 0x2]\n\
    ldr r0, _080208B4 @ =0x02000000\n\
    ldr r3, _080208C8 @ =0x00016018\n\
    adds r6, r0, r3\n\
    ldrb r0, [r6]\n\
    strb r0, [r1, 0x3]\n\
    movs r0, 0xFF\n\
    strb r0, [r1, 0x4]\n\
    ldr r4, _080208D4 @ =gBattleTextBuff2\n\
    strb r2, [r4]\n\
    movs r0, 0x1\n\
    strb r0, [r4, 0x1]\n\
    strb r0, [r4, 0x2]\n\
    movs r0, 0x3\n\
    strb r0, [r4, 0x3]\n\
    ldrb r0, [r6]\n\
    movs r1, 0x64\n\
    mov r8, r1\n\
    mov r2, r8\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    ldr r7, _080208CC @ =gPlayerParty\n\
    adds r0, r7\n\
    movs r1, 0x38\n\
    bl GetMonData\n\
    strb r0, [r4, 0x4]\n\
    movs r0, 0x1\n\
    negs r0, r0\n\
    strb r0, [r4, 0x5]\n\
    bl b_movescr_stack_push_cursor\n\
    ldr r2, _080208D8 @ =gLeveledUpInBattle\n\
    ldr r1, _080208DC @ =gBitTable\n\
    ldrb r0, [r6]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    ldrb r1, [r2]\n\
    orrs r0, r1\n\
    strb r0, [r2]\n\
    ldr r1, _080208E0 @ =gBattlescriptCurrInstr\n\
    ldr r0, _080208E4 @ =BattleScript_LevelUp\n\
    str r0, [r1]\n\
    ldr r4, _080208E8 @ =gBattleMoveDamage\n\
    ldr r2, _080208BC @ =BattleBufferB\n\
    ldrb r1, [r5]\n\
    lsls r1, 9\n\
    adds r0, r2, 0x2\n\
    adds r0, r1, r0\n\
    ldrb r3, [r0]\n\
    adds r2, 0x3\n\
    adds r1, r2\n\
    ldrb r0, [r1]\n\
    lsls r0, 8\n\
    orrs r3, r0\n\
    str r3, [r4]\n\
    ldrb r0, [r6]\n\
    mov r3, r8\n\
    muls r3, r0\n\
    adds r0, r3, 0\n\
    adds r0, r7\n\
    movs r1, 0\n\
    bl AdjustFriendship\n\
    ldr r0, _080208C4 @ =gBattlePartyID\n\
    ldrb r1, [r6]\n\
    ldrh r0, [r0]\n\
    cmp r0, r1\n\
    bne _080207EC\n\
    ldr r4, _080208EC @ =gBattleMons\n\
    ldrh r0, [r4, 0x28]\n\
    cmp r0, 0\n\
    beq _080207EC\n\
    mov r0, r8\n\
    muls r0, r1\n\
    adds r0, r7\n\
    movs r1, 0x38\n\
    bl GetMonData\n\
    adds r1, r4, 0\n\
    adds r1, 0x2A\n\
    strb r0, [r1]\n\
    ldrb r0, [r6]\n\
    mov r1, r8\n\
    muls r1, r0\n\
    adds r0, r1, 0\n\
    adds r0, r7\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    strh r0, [r4, 0x28]\n\
    ldrb r0, [r6]\n\
    mov r2, r8\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    adds r0, r7\n\
    movs r1, 0x3A\n\
    bl GetMonData\n\
    strh r0, [r4, 0x2C]\n\
    ldrb r0, [r6]\n\
    mov r3, r8\n\
    muls r3, r0\n\
    adds r0, r3, 0\n\
    adds r0, r7\n\
    movs r1, 0x3B\n\
    bl GetMonData\n\
    strh r0, [r4, 0x2]\n\
    ldrb r0, [r6]\n\
    mov r1, r8\n\
    muls r1, r0\n\
    adds r0, r1, 0\n\
    adds r0, r7\n\
    movs r1, 0x3C\n\
    bl GetMonData\n\
    strh r0, [r4, 0x4]\n\
    ldrb r0, [r6]\n\
    mov r2, r8\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    adds r0, r7\n\
    movs r1, 0x3D\n\
    bl GetMonData\n\
    strh r0, [r4, 0x6]\n\
    ldrb r0, [r6]\n\
    mov r3, r8\n\
    muls r3, r0\n\
    adds r0, r3, 0\n\
    adds r0, r7\n\
    movs r1, 0x3D\n\
    bl GetMonData\n\
    strh r0, [r4, 0x6]\n\
    ldrb r0, [r6]\n\
    mov r1, r8\n\
    muls r1, r0\n\
    adds r0, r1, 0\n\
    adds r0, r7\n\
    movs r1, 0x3E\n\
    bl GetMonData\n\
    strh r0, [r4, 0x8]\n\
    ldrb r0, [r6]\n\
    mov r2, r8\n\
    muls r2, r0\n\
    adds r0, r2, 0\n\
    adds r0, r7\n\
    movs r1, 0x3F\n\
    bl GetMonData\n\
    strh r0, [r4, 0xA]\n\
_080207EC:\n\
    ldr r0, _080208C4 @ =gBattlePartyID\n\
    ldr r1, _080208B4 @ =0x02000000\n\
    ldr r3, _080208C8 @ =0x00016018\n\
    adds r7, r1, r3\n\
    ldrb r2, [r7]\n\
    ldrh r0, [r0, 0x4]\n\
    cmp r0, r2\n\
    bne _080208F6\n\
    ldr r6, _080208EC @ =gBattleMons\n\
    movs r0, 0xD8\n\
    adds r0, r6\n\
    mov r8, r0\n\
    ldrh r0, [r0]\n\
    cmp r0, 0\n\
    beq _080208F6\n\
    ldr r0, _080208C0 @ =gBattleTypeFlags\n\
    ldrh r1, [r0]\n\
    movs r0, 0x1\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _080208F6\n\
    movs r5, 0x64\n\
    adds r0, r2, 0\n\
    muls r0, r5\n\
    ldr r4, _080208CC @ =gPlayerParty\n\
    adds r0, r4\n\
    movs r1, 0x38\n\
    bl GetMonData\n\
    adds r1, r6, 0\n\
    adds r1, 0xDA\n\
    strb r0, [r1]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    mov r1, r8\n\
    strh r0, [r1]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3A\n\
    bl GetMonData\n\
    adds r1, r6, 0\n\
    adds r1, 0xDC\n\
    strh r0, [r1]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3B\n\
    bl GetMonData\n\
    adds r1, r6, 0\n\
    adds r1, 0xB2\n\
    strh r0, [r1]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3C\n\
    bl GetMonData\n\
    adds r1, r6, 0\n\
    adds r1, 0xB4\n\
    strh r0, [r1]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3D\n\
    bl GetMonData\n\
    movs r2, 0xB6\n\
    adds r2, r6\n\
    mov r8, r2\n\
    strh r0, [r2]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3D\n\
    bl GetMonData\n\
    mov r3, r8\n\
    strh r0, [r3]\n\
    ldrb r0, [r7]\n\
    muls r0, r5\n\
    adds r0, r4\n\
    movs r1, 0x3E\n\
    bl GetMonData\n\
    adds r1, r6, 0\n\
    adds r1, 0xB8\n\
    strh r0, [r1]\n\
    b _080208F6\n\
    .align 2, 0\n\
_080208AC: .4byte gBattleExecBuffer\n\
_080208B0: .4byte gActiveBank\n\
_080208B4: .4byte 0x02000000\n\
_080208B8: .4byte 0x000160a2\n\
_080208BC: .4byte BattleBufferB\n\
_080208C0: .4byte gBattleTypeFlags\n\
_080208C4: .4byte gBattlePartyID\n\
_080208C8: .4byte 0x00016018\n\
_080208CC: .4byte gPlayerParty\n\
_080208D0: .4byte gBattleTextBuff1\n\
_080208D4: .4byte gBattleTextBuff2\n\
_080208D8: .4byte gLeveledUpInBattle\n\
_080208DC: .4byte gBitTable\n\
_080208E0: .4byte gBattlescriptCurrInstr\n\
_080208E4: .4byte BattleScript_LevelUp\n\
_080208E8: .4byte gBattleMoveDamage\n\
_080208EC: .4byte gBattleMons\n\
_080208F0:\n\
    ldr r1, _08020904 @ =gBattleMoveDamage\n\
    movs r0, 0\n\
    str r0, [r1]\n\
_080208F6:\n\
    ldr r0, _08020908 @ =0x02000000\n\
    ldr r1, _0802090C @ =0x0001600f\n\
    adds r0, r1\n\
    movs r1, 0x5\n\
    strb r1, [r0]\n\
    b _08020996\n\
    .align 2, 0\n\
_08020904: .4byte gBattleMoveDamage\n\
_08020908: .4byte 0x02000000\n\
_0802090C: .4byte 0x0001600f\n\
_08020910:\n\
    ldr r0, _08020924 @ =gBattleMoveDamage\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _08020930\n\
    ldr r0, _08020928 @ =0x02000000\n\
    ldr r2, _0802092C @ =0x0001600f\n\
    adds r0, r2\n\
    movs r1, 0x3\n\
    strb r1, [r0]\n\
    b _08020996\n\
    .align 2, 0\n\
_08020924: .4byte gBattleMoveDamage\n\
_08020928: .4byte 0x02000000\n\
_0802092C: .4byte 0x0001600f\n\
_08020930:\n\
    ldr r2, _08020950 @ =0x02000000\n\
    ldr r3, _08020954 @ =0x00016018\n\
    adds r1, r2, r3\n\
    ldrb r0, [r1]\n\
    adds r0, 0x1\n\
    strb r0, [r1]\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x5\n\
    bhi _0802095C\n\
    ldr r0, _08020958 @ =0x0001600f\n\
    adds r1, r2, r0\n\
    movs r0, 0x2\n\
    strb r0, [r1]\n\
    b _08020996\n\
    .align 2, 0\n\
_08020950: .4byte 0x02000000\n\
_08020954: .4byte 0x00016018\n\
_08020958: .4byte 0x0001600f\n\
_0802095C:\n\
    ldr r3, _08020968 @ =0x0001600f\n\
    adds r1, r2, r3\n\
    movs r0, 0x6\n\
    strb r0, [r1]\n\
    b _08020996\n\
    .align 2, 0\n\
_08020968: .4byte 0x0001600f\n\
_0802096C:\n\
    ldr r0, _080209A4 @ =gBattleExecBuffer\n\
    ldr r5, [r0]\n\
    cmp r5, 0\n\
    bne _08020996\n\
    ldr r4, _080209A8 @ =gBattleMons\n\
    ldr r2, _080209AC @ =gBank1\n\
    ldrb r0, [r2]\n\
    movs r1, 0x58\n\
    muls r0, r1\n\
    adds r0, r4\n\
    movs r3, 0\n\
    strh r5, [r0, 0x2E]\n\
    ldrb r0, [r2]\n\
    muls r0, r1\n\
    adds r0, r4\n\
    adds r0, 0x20\n\
    strb r3, [r0]\n\
    ldr r1, _080209B0 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r1]\n\
    adds r0, 0x2\n\
    str r0, [r1]\n\
_08020996:\n\
    pop {r3-r5}\n\
    mov r8, r3\n\
    mov r9, r4\n\
    mov r10, r5\n\
    pop {r4-r7}\n\
    pop {r0}\n\
    bx r0\n\
    .align 2, 0\n\
_080209A4: .4byte gBattleExecBuffer\n\
_080209A8: .4byte gBattleMons\n\
_080209AC: .4byte gBank1\n\
_080209B0: .4byte gBattlescriptCurrInstr\n\
        .syntax divided\n");
}

#endif // NONMATCHING*/

#ifdef NONMATCHING
void atk24(void)
{
    u16 HP_count = 0;
    int i;
    if (gBattleExecBuffer) {return;}

    for (i = 0; i < 6; i++)
    {
        if (GetMonData(&gPlayerParty[i], MON_DATA_SPECIES) && !GetMonData(&gPlayerParty[i], MON_DATA_IS_EGG))
            HP_count += GetMonData(&gPlayerParty[i], MON_DATA_HP);
    }

    if (HP_count == 0)
        gBattleOutcome |= BATTLE_LOST;

    for (HP_count = 0, i = 0; i < 6; i++)
    {
        if (GetMonData(&gEnemyParty[i], MON_DATA_SPECIES) && !GetMonData(&gEnemyParty[i], MON_DATA_IS_EGG))
            HP_count += GetMonData(&gEnemyParty[i], MON_DATA_HP);
    }

    if (!HP_count)
        gBattleOutcome |= BATTLE_WON;

    if (!gBattleOutcome && (gBattleTypeFlags & BATTLE_TYPE_LINK))
    {
        register int found1 asm("r2");
        register int found2 asm("r4");

        //I can't for the love of god decompile that part

        for (found1 = 0, i = 0; i < gNoOfAllBanks; i += 2)
        {
            if ((gHitMarker & HITMARKER_UNK(i)) && !gSpecialStatuses[i].flag40)
                found1++;
        }

        for (found2 = 0, i = 1; i < gNoOfAllBanks; i += 2)
        {
            if ((gHitMarker & HITMARKER_UNK(i)) && !gSpecialStatuses[i].flag40)
                found2++;
        }

        if (gBattleTypeFlags & BATTLE_TYPE_MULTI)
        {
            if (found2 + found1 > 1)
                gBattlescriptCurrInstr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
            else
                gBattlescriptCurrInstr += 5;
        }
        else
        {
            if (found2 != 0 && found1 != 0)
                gBattlescriptCurrInstr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
            else
                gBattlescriptCurrInstr += 5;
        }
    }
    else
        gBattlescriptCurrInstr += 5;

}
#else
__attribute__((naked))
void atk24(void)
{
    asm(".syntax unified\n\
    push {r4-r7,lr}\n\
    mov r7, r8\n\
    push {r7}\n\
    movs r6, 0\n\
    ldr r0, _08020AF0 @ =gBattleExecBuffer\n\
    ldr r0, [r0]\n\
    cmp r0, 0\n\
    beq _080209C6\n\
    b _08020B46\n\
_080209C6:\n\
    movs r5, 0\n\
_080209C8:\n\
    movs r0, 0x64\n\
    adds r1, r5, 0\n\
    muls r1, r0\n\
    ldr r0, _08020AF4 @ =gPlayerParty\n\
    adds r4, r1, r0\n\
    adds r0, r4, 0\n\
    movs r1, 0xB\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    beq _080209F8\n\
    adds r0, r4, 0\n\
    movs r1, 0x2D\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    bne _080209F8\n\
    adds r0, r4, 0\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    adds r0, r6, r0\n\
    lsls r0, 16\n\
    lsrs r6, r0, 16\n\
_080209F8:\n\
    adds r5, 0x1\n\
    cmp r5, 0x5\n\
    ble _080209C8\n\
    cmp r6, 0\n\
    bne _08020A0C\n\
    ldr r0, _08020AF8 @ =gBattleOutcome\n\
    ldrb r1, [r0]\n\
    movs r2, 0x2\n\
    orrs r1, r2\n\
    strb r1, [r0]\n\
_08020A0C:\n\
    movs r6, 0\n\
    movs r5, 0\n\
_08020A10:\n\
    movs r0, 0x64\n\
    adds r1, r5, 0\n\
    muls r1, r0\n\
    ldr r0, _08020AFC @ =gEnemyParty\n\
    adds r4, r1, r0\n\
    adds r0, r4, 0\n\
    movs r1, 0xB\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    beq _08020A40\n\
    adds r0, r4, 0\n\
    movs r1, 0x2D\n\
    bl GetMonData\n\
    cmp r0, 0\n\
    bne _08020A40\n\
    adds r0, r4, 0\n\
    movs r1, 0x39\n\
    bl GetMonData\n\
    adds r0, r6, r0\n\
    lsls r0, 16\n\
    lsrs r6, r0, 16\n\
_08020A40:\n\
    adds r5, 0x1\n\
    cmp r5, 0x5\n\
    ble _08020A10\n\
    ldr r2, _08020AF8 @ =gBattleOutcome\n\
    cmp r6, 0\n\
    bne _08020A54\n\
    ldrb r0, [r2]\n\
    movs r1, 0x1\n\
    orrs r0, r1\n\
    strb r0, [r2]\n\
_08020A54:\n\
    ldrb r0, [r2]\n\
    cmp r0, 0\n\
    bne _08020B3E\n\
    ldr r2, _08020B00 @ =gBattleTypeFlags\n\
    ldrh r1, [r2]\n\
    movs r0, 0x2\n\
    ands r0, r1\n\
    mov r8, r2\n\
    cmp r0, 0\n\
    beq _08020B3E\n\
    movs r2, 0\n\
    movs r5, 0\n\
    ldr r0, _08020B04 @ =gNoOfAllBanks\n\
    ldrb r3, [r0]\n\
    mov r12, r0\n\
    ldr r7, _08020B08 @ =gBattlescriptCurrInstr\n\
    cmp r2, r3\n\
    bge _08020AA0\n\
    ldr r0, _08020B0C @ =gHitMarker\n\
    movs r1, 0x80\n\
    lsls r1, 21\n\
    ldr r6, [r0]\n\
    adds r4, r3, 0\n\
    ldr r3, _08020B10 @ =gSpecialStatuses\n\
_08020A84:\n\
    adds r0, r1, 0\n\
    lsls r0, r5\n\
    ands r0, r6\n\
    cmp r0, 0\n\
    beq _08020A98\n\
    ldrb r0, [r3]\n\
    lsls r0, 25\n\
    cmp r0, 0\n\
    blt _08020A98\n\
    adds r2, 0x1\n\
_08020A98:\n\
    adds r3, 0x28\n\
    adds r5, 0x2\n\
    cmp r5, r4\n\
    blt _08020A84\n\
_08020AA0:\n\
    movs r4, 0\n\
    movs r5, 0x1\n\
    mov r0, r12\n\
    ldrb r3, [r0]\n\
    cmp r5, r3\n\
    bge _08020ADA\n\
    ldr r0, _08020B0C @ =gHitMarker\n\
    movs r1, 0x80\n\
    lsls r1, 21\n\
    mov r12, r1\n\
    ldr r1, [r0]\n\
    ldr r0, _08020B10 @ =gSpecialStatuses\n\
    adds r6, r3, 0\n\
    adds r3, r0, 0\n\
    adds r3, 0x14\n\
_08020ABE:\n\
    mov r0, r12\n\
    lsls r0, r5\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _08020AD2\n\
    ldrb r0, [r3]\n\
    lsls r0, 25\n\
    cmp r0, 0\n\
    blt _08020AD2\n\
    adds r4, 0x1\n\
_08020AD2:\n\
    adds r3, 0x28\n\
    adds r5, 0x2\n\
    cmp r5, r6\n\
    blt _08020ABE\n\
_08020ADA:\n\
    mov r0, r8\n\
    ldrh r1, [r0]\n\
    movs r0, 0x40\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _08020B14\n\
    adds r0, r4, r2\n\
    cmp r0, 0x1\n\
    bgt _08020B1C\n\
    b _08020B36\n\
    .align 2, 0\n\
_08020AF0: .4byte gBattleExecBuffer\n\
_08020AF4: .4byte gPlayerParty\n\
_08020AF8: .4byte gBattleOutcome\n\
_08020AFC: .4byte gEnemyParty\n\
_08020B00: .4byte gBattleTypeFlags\n\
_08020B04: .4byte gNoOfAllBanks\n\
_08020B08: .4byte gBattlescriptCurrInstr\n\
_08020B0C: .4byte gHitMarker\n\
_08020B10: .4byte gSpecialStatuses\n\
_08020B14:\n\
    cmp r4, 0\n\
    beq _08020B36\n\
    cmp r2, 0\n\
    beq _08020B36\n\
_08020B1C:\n\
    ldr r2, [r7]\n\
    ldrb r1, [r2, 0x1]\n\
    ldrb r0, [r2, 0x2]\n\
    lsls r0, 8\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x3]\n\
    lsls r0, 16\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x4]\n\
    lsls r0, 24\n\
    adds r1, r0\n\
    str r1, [r7]\n\
    b _08020B46\n\
_08020B36:\n\
    ldr r0, [r7]\n\
    adds r0, 0x5\n\
    str r0, [r7]\n\
    b _08020B46\n\
_08020B3E:\n\
    ldr r1, _08020B50 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r1]\n\
    adds r0, 0x5\n\
    str r0, [r1]\n\
_08020B46:\n\
    pop {r3}\n\
    mov r8, r3\n\
    pop {r4-r7}\n\
    pop {r0}\n\
    bx r0\n\
    .align 2, 0\n\
_08020B50: .4byte gBattlescriptCurrInstr\n\
        .syntax divided\n");
}
#endif

void MoveValuesCleanUp(void)
{
    gBattleMoveFlags = 0;
    BATTLE_STRUCT->DmgMultiplier = 1;
    gCritMultiplier = 1;
    gBattleCommunication[MOVE_EFFECT_BYTE] = 0;
    gBattleCommunication[6] = 0;
    gHitMarker &= ~(HITMARKER_DESTINYBOND);
    gHitMarker &= ~(HITMARKER_SYNCHRONISE_EFFECT);
}

void atk25_move_values_cleanup(void)
{
    MoveValuesCleanUp();
    gBattlescriptCurrInstr += 1;
}

void atk26_set_multihit(void)
{
    gMultiHitCounter = BSScriptRead8(gBattlescriptCurrInstr + 1);
    gBattlescriptCurrInstr += 2;
}

void atk27_decrement_multihit(void)
{
    if (--gMultiHitCounter == 0)
        gBattlescriptCurrInstr += 5;
    else
        gBattlescriptCurrInstr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
}

void atk28_goto(void)
{
    gBattlescriptCurrInstr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
}

void atk29_jumpifbyte(void)
{
    u8 caseID = BSScriptRead8(gBattlescriptCurrInstr + 1);
    u8* ptr = BS2ScriptReadPtr(gBattlescriptCurrInstr + 2);
    u8 value = BSScriptRead8(gBattlescriptCurrInstr + 6);
    u8* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 7);
    gBattlescriptCurrInstr += 11;
    switch (caseID)
    {
    case CMP_EQUAL:
        if (*ptr == value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NOT_EQUAL:
        if (*ptr != value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_GREATER_THAN:
        if (*ptr > value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_LESS_THAN:
        if (*ptr < value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_COMMON_BITS:
        if (*ptr & value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NO_COMMON_BITS:
        if (!(*ptr & value))
            gBattlescriptCurrInstr = jump_loc;
        break;
    }
}

void atk2A_jumpifhalfword(void)
{
    u8 caseID = BSScriptRead8(gBattlescriptCurrInstr + 1);
    u16* ptr = (u16*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 2);
    u16 value = BSScriptRead16(gBattlescriptCurrInstr + 6);
    u8* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 8);
    gBattlescriptCurrInstr += 12;
    switch (caseID)
    {
    case CMP_EQUAL:
        if (*ptr == value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NOT_EQUAL:
        if (*ptr != value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_GREATER_THAN:
        if (*ptr > value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_LESS_THAN:
        if (*ptr < value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_COMMON_BITS:
        if (*ptr & value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NO_COMMON_BITS:
        if (!(*ptr & value))
            gBattlescriptCurrInstr = jump_loc;
        break;
    }
}

void atk2B_jumpifword(void)
{
    u8 caseID = BSScriptRead8(gBattlescriptCurrInstr + 1);
    u32* ptr = (u32*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 2);
    u32 value = BSScriptRead32(gBattlescriptCurrInstr + 6);
    u8* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 10);
    gBattlescriptCurrInstr += 14;
    switch (caseID)
    {
    case CMP_EQUAL:
        if (*ptr == value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NOT_EQUAL:
        if (*ptr != value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_GREATER_THAN:
        if (*ptr > value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_LESS_THAN:
        if (*ptr < value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_COMMON_BITS:
        if (*ptr & value)
            gBattlescriptCurrInstr = jump_loc;
        break;
    case CMP_NO_COMMON_BITS:
        if (!(*ptr & value))
            gBattlescriptCurrInstr = jump_loc;
        break;
    }
}

void atk2C_jumpifarrayequal(void)
{
    //Mem1, Mem2, Size, Jump Loc
    u8* mem1 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    u8* mem2 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 5);
    u32 size = BSScriptRead8(gBattlescriptCurrInstr + 9);
    u8* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 10);

    u8 i;
    for (i = 0; i < size; i++)
    {
        if (*mem1 != *mem2)
        {
            gBattlescriptCurrInstr += 14;
            break;
        }
        mem1++, mem2++;
    }

    if (i == size)
        gBattlescriptCurrInstr = jump_loc;
}

void atk2D_jumpifarraynotequal(void)
{
    //Mem1, Mem2, Size, Jump Loc
    u8 equal_bytes = 0;
    u8* mem1 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    u8* mem2 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 5);
    u32 size = BSScriptRead8(gBattlescriptCurrInstr + 9);
    u8* jump_loc = BS2ScriptReadPtr(gBattlescriptCurrInstr + 10);

    u8 i;
    for (i = 0; i < size; i++)
    {
        if (*mem1 == *mem2)
        {
            equal_bytes++;
        }
        mem1++, mem2++;
    }

    if (equal_bytes != size)
        gBattlescriptCurrInstr = jump_loc;
    else
        gBattlescriptCurrInstr += 14;
}

void atk2E_setbyte(void)
{
    u8* mem = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem = BSScriptRead8(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr += 6;
}

void atk2F_addbyte(void)
{
    u8* mem = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem += BSScriptRead8(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr += 6;
}

void atk30_subbyte(void)
{
    u8* mem = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem -= BSScriptRead8(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr += 6;
}

void atk31_copyarray(void)
{
    u8* mem1 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    u8* mem2 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 5);
    s32 size = BSScriptRead8(gBattlescriptCurrInstr + 9);

    s32 i;
    for (i = 0; i < size; i++)
    {
        mem1[i] = mem2[i];
    }

    gBattlescriptCurrInstr += 10;
}

void atk32_copyarray_withindex(void)
{
    u8* mem1 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    u8* mem2 = BS2ScriptReadPtr(gBattlescriptCurrInstr + 5);
    u8* index = BS2ScriptReadPtr(gBattlescriptCurrInstr + 9);
    s32 size = BSScriptRead8(gBattlescriptCurrInstr + 13);

    s32 i;
    for (i = 0; i < size; i++)
    {
        mem1[i] = mem2[i + *index];
    }

    gBattlescriptCurrInstr += 14;
}

void atk33_orbyte(void)
{
    u8* mem = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem |= BSScriptRead8(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr += 6;
}

void atk34_orhalfword(void)
{
    u16* mem = (u16*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem |= BSScriptRead16(gBattlescriptCurrInstr + 5); //lmao gamefreak, decide on your macro...
    gBattlescriptCurrInstr += 7;
}

void atk35_orword(void)
{
    u32* mem = (u32*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem |= BS2ScriptRead32(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr += 9;
}

void atk36_bicbyte(void)
{
    u8* mem = BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem &= ~(BSScriptRead8(gBattlescriptCurrInstr + 5));
    gBattlescriptCurrInstr += 6;
}

void atk37_bichalfword(void)
{
    u16* mem = (u16*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem &= ~(BSScriptRead16(gBattlescriptCurrInstr + 5));
    gBattlescriptCurrInstr += 7;
}

void atk38_bicword(void)
{
    u32* mem = (u32*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 1);
    *mem &= ~(BS2ScriptRead32(gBattlescriptCurrInstr + 5));
    gBattlescriptCurrInstr += 9;
}

void atk39_pause(void)
{
    if (gBattleExecBuffer == 0)
    {
        u16 value = BSScriptRead16(gBattlescriptCurrInstr + 1) / BATTLE_SPEED_FRACTION;

        if (++gPauseCounterBattle >= value)
        {
            gPauseCounterBattle = 0;
            gBattlescriptCurrInstr += 3;
        }
    }
}

void atk3A_waitstate(void)
{
    if (gBattleExecBuffer == 0)
        gBattlescriptCurrInstr++;
}

void atk3B_healthbar_update(void)
{
    if (!BSScriptRead8(gBattlescriptCurrInstr + 1))
        gActiveBank = gBankTarget;
    else
        gActiveBank = gBankAttacker;

    EmitHealthBarUpdate(0, gBattleMoveDamage);
    MarkBufferBankForExecution(gActiveBank);
    gBattlescriptCurrInstr += 2;
}

void atk3C_return(void)
{
    b_movescr_stack_pop_cursor();
}

void atk3D_end(void)
{
    gBattleMoveFlags = 0;
    gActiveBank = 0;
    gFightStateTracker = 0xB;
}

void atk3E_end2(void)
{
    //not much difference between this and 3D. It's more apparent in Emerald
    gActiveBank = 0;
    gFightStateTracker = 0xB;
}

void atk3F_end3(void) //pops the main function stack
{
    b_movescr_stack_pop_cursor();
    if (B_FUNCTION_STACK->size)
        B_FUNCTION_STACK->size--;
    gBattleMainFunc = B_FUNCTION_STACK->ptr[B_FUNCTION_STACK->size];
}

void atk41_call(void)
{
    b_movescr_stack_push(gBattlescriptCurrInstr + 5);
    gBattlescriptCurrInstr = BSScriptReadPtr(gBattlescriptCurrInstr + 1);
}

void atk42_jumpiftype2(void) //u8 bank, u8 type, *ptr
{
    u8 bank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));

    if (BSScriptRead8(gBattlescriptCurrInstr + 2) == gBattleMons[bank].type1 || BSScriptRead8(gBattlescriptCurrInstr + 2) == gBattleMons[bank].type2)
        gBattlescriptCurrInstr = BSScriptReadPtr(gBattlescriptCurrInstr + 3);
    else
        gBattlescriptCurrInstr += 7;
}

void atk43_jumpifabilitypresent(void)
{
    if (AbilityBattleEffects(ABILITY_CHECK_ON_FIELD, 0, BSScriptRead8(gBattlescriptCurrInstr + 1), 0, 0))
        gBattlescriptCurrInstr = BSScriptReadPtr(gBattlescriptCurrInstr + 2);
    else
        gBattlescriptCurrInstr += 6;
}
#ifdef NONMATCHING
void atk44(void)
{
    BATTLE_STRUCT->unk16060[gBankAttacker] = 1;
}
#else
__attribute__((naked))
void atk44(void)
{
    asm("\n\
    ldr r1, _080213E4 @ =0x02000000\n\
    ldr r0, _080213E8 @ =gBankAttacker\n\
    ldrb r0, [r0]\n\
    ldr r2, _080213EC @ =0x00016060\n\
    add r0, r2\n\
    add r0, r1\n\
    mov r1, #0x1\n\
    strb r1, [r0]\n\
    bx lr\n\
    .align 2, 0\n\
_080213E4: .4byte 0x02000000\n\
_080213E8: .4byte gBankAttacker\n\
_080213EC: .4byte 0x00016060\n\
        ");
}
#endif // NONMATCHING

#ifdef NONMATCHING

void atk45_playanimation(void)
{
    u16* argument;

    gActiveBank = GetBattleBank(BSScriptRead8(gBattlescriptCurrInstr + 1));
    argument = (u16*) BS2ScriptReadPtr(gBattlescriptCurrInstr + 3);

    if (BSScriptRead8(gBattlescriptCurrInstr + 2) == 1 || BSScriptRead8(gBattlescriptCurrInstr + 2) == 0x11 || BSScriptRead8(gBattlescriptCurrInstr + 2) == 2)
    {
        asm("");
        EmitBattleAnimation(0, BSScriptRead8(gBattlescriptCurrInstr + 2), *argument);
        MarkBufferBankForExecution(gActiveBank);
        gBattlescriptCurrInstr += 7;
        asm("");
    }
    else if (gHitMarker & HITMARKER_NO_ANIMATIONS)
    {
        b_movescr_stack_push(gBattlescriptCurrInstr + 7);
        gBattlescriptCurrInstr = BattleScript_Pausex20;
    }
    else if ((u8) (BSScriptRead8(gBattlescriptCurrInstr + 2) - 10) > 3 && gStatuses3[gActiveBank] & (STATUS3_ON_AIR | STATUS3_UNDERGROUND | STATUS3_UNDERWATER))
    {
        gBattlescriptCurrInstr += 7;
    }
    else
    {
        EmitBattleAnimation(0, BSScriptRead8(gBattlescriptCurrInstr + 2), *argument);
        /*asm("ldrb r1, [r2, #2]\n\
            ldrh r2, [r3]\n\
            mov r0, #0x0\n\
            bl EmitBattleAnimation");*/
        MarkBufferBankForExecution(gActiveBank);
        gBattlescriptCurrInstr += 7;
    }
}

#else
__attribute__((naked))
void atk45_playanimation(void)
{
    asm(".syntax unified\n\
        push {r4-r6,lr}\n\
    ldr r5, _08021444 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r5]\n\
    ldrb r0, [r0, 0x1]\n\
    bl GetBattleBank\n\
    ldr r6, _08021448 @ =gActiveBank\n\
    strb r0, [r6]\n\
    ldr r2, [r5]\n\
    ldrb r1, [r2, 0x3]\n\
    ldrb r0, [r2, 0x4]\n\
    lsls r0, 8\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x5]\n\
    lsls r0, 16\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x6]\n\
    lsls r0, 24\n\
    adds r3, r1, r0\n\
    ldrb r4, [r2, 0x2]\n\
    adds r0, r4, 0\n\
    cmp r0, 0x1\n\
    beq _08021426\n\
    cmp r0, 0x11\n\
    beq _08021426\n\
    cmp r0, 0x2\n\
    bne _0802144C\n\
_08021426:\n\
    ldr r4, _08021444 @ =gBattlescriptCurrInstr\n\
    ldr r0, [r4]\n\
    ldrb r1, [r0, 0x2]\n\
    ldrh r2, [r3]\n\
    movs r0, 0\n\
    bl EmitBattleAnimation\n\
    ldr r0, _08021448 @ =gActiveBank\n\
    ldrb r0, [r0]\n\
    bl MarkBufferBankForExecution\n\
    ldr r0, [r4]\n\
    adds r0, 0x7\n\
    str r0, [r4]\n\
    b _080214AE\n\
    .align 2, 0\n\
_08021444: .4byte gBattlescriptCurrInstr\n\
_08021448: .4byte gActiveBank\n\
_0802144C:\n\
    ldr r0, _08021464 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _0802146C\n\
    adds r0, r2, 0x7\n\
    bl b_movescr_stack_push\n\
    ldr r0, _08021468 @ =BattleScript_Pausex20\n\
    b _080214AC\n\
    .align 2, 0\n\
_08021464: .4byte gHitMarker\n\
_08021468: .4byte BattleScript_Pausex20\n\
_0802146C:\n\
    adds r0, r4, 0\n\
    subs r0, 0xA\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x3\n\
    bls _08021498\n\
    ldr r1, _08021490 @ =gStatuses3\n\
    ldrb r0, [r6]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    ldr r1, _08021494 @ =0x000400c0\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _08021498\n\
    adds r0, r2, 0x7\n\
    b _080214AC\n\
    .align 2, 0\n\
_08021490: .4byte gStatuses3\n\
_08021494: .4byte 0x000400c0\n\
_08021498:\n\
    ldrb r1, [r2, 0x2]\n\
    ldrh r2, [r3]\n\
    movs r0, 0\n\
    bl EmitBattleAnimation\n\
    ldrb r0, [r6]\n\
    bl MarkBufferBankForExecution\n\
    ldr r0, [r5]\n\
    adds r0, 0x7\n\
_080214AC:\n\
    str r0, [r5]\n\
_080214AE:\n\
    pop {r4-r6}\n\
    pop {r0}\n\
    bx r0\n\
    .syntax divided");
}
#endif // NONMATCHING

#ifdef NONMATCHING
void atk46_playanimation2(void)
{

}

#else
__attribute__((naked))
void atk46_playanimation2(void)
{
    asm(".syntax unified\n\
        push {r4-r7,lr}\n\
    ldr r6, _0802151C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r6]\n\
    ldrb r0, [r0, 0x1]\n\
    bl GetBattleBank\n\
    ldr r7, _08021520 @ =gActiveBank\n\
    strb r0, [r7]\n\
    ldr r2, [r6]\n\
    ldrb r1, [r2, 0x2]\n\
    ldrb r0, [r2, 0x3]\n\
    lsls r0, 8\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x4]\n\
    lsls r0, 16\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x5]\n\
    lsls r0, 24\n\
    adds r3, r1, r0\n\
    ldrb r1, [r2, 0x6]\n\
    ldrb r0, [r2, 0x7]\n\
    lsls r0, 8\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x8]\n\
    lsls r0, 16\n\
    adds r1, r0\n\
    ldrb r0, [r2, 0x9]\n\
    lsls r0, 24\n\
    adds r4, r1, r0\n\
    ldrb r5, [r3]\n\
    adds r0, r5, 0\n\
    cmp r0, 0x1\n\
    beq _080214FE\n\
    cmp r0, 0x11\n\
    beq _080214FE\n\
    cmp r0, 0x2\n\
    bne _08021524\n\
_080214FE:\n\
    ldrb r1, [r3]\n\
    ldrh r2, [r4]\n\
    movs r0, 0\n\
    bl EmitBattleAnimation\n\
    ldr r0, _08021520 @ =gActiveBank\n\
    ldrb r0, [r0]\n\
    bl MarkBufferBankForExecution\n\
    ldr r1, _0802151C @ =gBattlescriptCurrInstr\n\
    ldr r0, [r1]\n\
    adds r0, 0xA\n\
    str r0, [r1]\n\
    b _0802157A\n\
    .align 2, 0\n\
_0802151C: .4byte gBattlescriptCurrInstr\n\
_08021520: .4byte gActiveBank\n\
_08021524:\n\
    ldr r0, _08021534 @ =gHitMarker\n\
    ldr r0, [r0]\n\
    movs r1, 0x80\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _08021538\n\
    adds r0, r2, 0\n\
    b _08021576\n\
    .align 2, 0\n\
_08021534: .4byte gHitMarker\n\
_08021538:\n\
    adds r0, r5, 0\n\
    subs r0, 0xA\n\
    lsls r0, 24\n\
    lsrs r0, 24\n\
    cmp r0, 0x3\n\
    bls _08021564\n\
    ldr r1, _0802155C @ =gStatuses3\n\
    ldrb r0, [r7]\n\
    lsls r0, 2\n\
    adds r0, r1\n\
    ldr r0, [r0]\n\
    ldr r1, _08021560 @ =0x000400c0\n\
    ands r0, r1\n\
    cmp r0, 0\n\
    beq _08021564\n\
    adds r0, r2, 0\n\
    b _08021576\n\
    .align 2, 0\n\
_0802155C: .4byte gStatuses3\n\
_08021560: .4byte 0x000400c0\n\
_08021564:\n\
    ldrb r1, [r3]\n\
    ldrh r2, [r4]\n\
    movs r0, 0\n\
    bl EmitBattleAnimation\n\
    ldrb r0, [r7]\n\
    bl MarkBufferBankForExecution\n\
    ldr r0, [r6]\n\
_08021576:\n\
    adds r0, 0xA\n\
    str r0, [r6]\n\
_0802157A:\n\
    pop {r4-r7}\n\
    pop {r0}\n\
    bx r0\n\
    .syntax divided    ");
}
#endif // NONMATCHING

void atk47_setgraphicalstatchangevalues(void)
{
    u8 to_add = 0;
    switch (BATTLE_STRUCT->statChanger & 0xF0)
    {
    case 0x10: //+1
        to_add = 0xF;
        break;
    case 0x20: //+2
        to_add = 0x27;
        break;
    case 0x90: //-1
        to_add = 0x16;
        break;
    case 0xA0: //-2
        to_add = 0x2E;
        break;
    }
    BATTLE_STRUCT->AnimArg1 = (BATTLE_STRUCT->statChanger & 0xF) + to_add - 1;
    BATTLE_STRUCT->AnimArg2 = 0;
    gBattlescriptCurrInstr++;
}
