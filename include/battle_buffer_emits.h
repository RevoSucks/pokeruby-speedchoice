#ifndef GUARD_BATTLEBUFFEREMITS_H
#define GUARD_BATTLEBUFFEREMITS_H

//function declarations of buffer emits
void EmitGetAttributes(u8 buffID, u8 request, u8 c);    //0x0
void EmitSetAttributes(u8 a, u8 request, u8 c, u8 bytes, void *data);  //0x2
void EmitFaintAnimation(u8 a);  //0xA
void EmitMoveAnimation(u8 a, u16 move, u8 turn, u16 power, s32 dmg, u8 happiness, void *disable_struct); //0xF
void EmitPrintString(u8 a, u16 stringID);  //0x10
void EmitPrintStringPlayerOnly(u8 a, u16 stringID); //0x11
void EmitHealthBarUpdate(u8 a, u16 b); //0x18; Had to declare the second arg as u16 because s16 wont match in atk0b
void EmitExpBarUpdate(u8 a, u8 b, u16 c); //0x19
void EmitStatusIconUpdate(u8 a, u32 b, u32 c); //0x1A
void EmitStatusAnimation(u8 a, u8 b, u32 c); //0x1B
void EmitStatusXor(u8 a, u8 b); //0x1C
void EmitHitAnimation(u8 a); //0x29
void EmitEffectivenessSound(u8 a, u16 sound); //0x2B
void EmitPlaySound(u8 a, u16 sound);    //0x2C
void EmitFaintingCry(u8 a); //0x2D
void EmitBattleAnimation(u8 a, u8 b, u16 c); //0x34

void MarkBufferBankForExecution(u8 bank);

//defines for get and set attributes
#define REQUEST_SPECIES_BATTLE  0x1
#define REQUEST_HELDITEM_BATTLE 0x2
#define REQUEST_PPMOVE1_BATTLE  0x9
#define REQUEST_PPMOVE2_BATTLE  0xA
#define REQUEST_PPMOVE3_BATTLE  0xB
#define REQUEST_PPMOVE4_BATTLE  0xC
#define REQUEST_STATUS_BATTLE   0x28
#define REQUEST_HP_BATTLE 0x2A

#endif //GUARD_BATTLEBUFFEREMITS_H
