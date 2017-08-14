	.include "asm/macros.inc"
	.include "constants/constants.inc"

	.section .rodata

	.string "ターン$" @ "turn"

	.align 2
gUnknown_081FAD98:: @ 81FAD98
	.4byte dp01t_00_1_getattr
	.4byte sub_802ECF0
	.4byte dp01t_02_1_setattr
	.4byte sub_802F7CC
	.4byte sub_802F840
	.4byte sub_802F8A8
	.4byte sub_802FAA0
	.4byte sub_802FBB4
	.4byte sub_802FCE0
	.4byte sub_802FDBC
	.4byte sub_802FE7C
	.4byte sub_802FF60
	.4byte sub_802FF80
	.4byte sub_802FFD0
	.4byte sub_803002C
	.4byte dp01t_0F_1_move_anim
	.4byte sub_80302F4
	.4byte dp01t_11_1_message_for_player_only
	.4byte sub_803037C
	.4byte nullsub_42
	.4byte sub_8030468
	.4byte sub_8030530
	.4byte sub_8030594
	.4byte sub_8030674
	.4byte sub_8030698
	.4byte sub_8030798
	.4byte sub_8030834
	.4byte sub_80308A8
	.4byte sub_8030910
	.4byte sub_803097C
	.4byte sub_8030988
	.4byte sub_8030A3C
	.4byte sub_8030A6C
	.4byte sub_8030A78
	.4byte sub_8030A8C
	.4byte sub_8030AA0
	.4byte sub_8030AB4
	.4byte sub_8030AC8
	.4byte sub_8030AE4
	.4byte sub_8030B1C
	.4byte sub_8030B34
	.4byte dp01t_29_1_blink
	.4byte sub_8030BCC
	.4byte sub_8030BD8
	.4byte sub_8030C1C
	.4byte sub_8030C4C
	.4byte dp01t_2E_1_battle_intro
	.4byte sub_8030CC0
	.4byte sub_8030FAC
	.4byte sub_80310A4
	.4byte sub_80310F0
	.4byte dp01t_33_1_enemy_move
	.4byte bx_exec_buffer_A_ch0_tbl1
	.4byte dp01t_35_1_link_standby_message_and_free_vram
	.4byte sub_8031238
	.4byte sub_80312A0
	.4byte nullsub_43

gUnknown_081FAE7C:: @ 81FAE7C
	.byte 0, 2, 3, 1

gUnknown_081FAE80:: @ 81FAE80
	.string "{PALETTE 5}{COLOR_HIGHLIGHT_SHADOW WHITE LIGHT_BLUE WHITE2}$"

gUnknown_081FAE89:: @ 81FAE89
	.byte  8, 120
	.byte 88, 120
	.byte  8, 136
	.byte 88, 136

gUnknown_081FAE91:: @ 81FAE91
	.byte 144, 120
	.byte 190, 120
	.byte 144, 136
	.byte 190, 136
	.byte  72,  72
	.byte  32,  90
	.byte  80,  80
	.byte  80,  88

	.align 2
gUnknown_081FAEA4:: @ 81FAEA4
	obj_tiles gSmokescreenImpactTiles, 0x180, 55019

	.align 2
gUnknown_081FAEAC:: @ 81FAEAC
	obj_pal gSmokescreenImpactPalette, 55019

	.align 2
gOamData_81FAEB4:: @ 81FAEB4
	.2byte 0x0000
	.2byte 0x4000
	.2byte 0x0400

	.align 2
gSpriteAnim_81FAEBC:: @ 81FAEBC
	obj_image_anim_frame 0, 4
	obj_image_anim_frame 4, 4
	obj_image_anim_frame 8, 4
	obj_image_anim_end

	.align 2
gSpriteAnim_81FAECC:: @ 81FAECC
	obj_image_anim_frame 0, 4, OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_frame 4, 4, OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_frame 8, 4, OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_end

	.align 2
gSpriteAnim_81FAEDC:: @ 81FAEDC
	obj_image_anim_frame 0, 4, OBJ_IMAGE_ANIM_V_FLIP
	obj_image_anim_frame 4, 4, OBJ_IMAGE_ANIM_V_FLIP
	obj_image_anim_frame 8, 4, OBJ_IMAGE_ANIM_V_FLIP
	obj_image_anim_end

	.align 2
gSpriteAnim_81FAEEC:: @ 81FAEEC
	obj_image_anim_frame 0, 4, OBJ_IMAGE_ANIM_V_FLIP | OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_frame 4, 4, OBJ_IMAGE_ANIM_V_FLIP | OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_frame 8, 4, OBJ_IMAGE_ANIM_V_FLIP | OBJ_IMAGE_ANIM_H_FLIP
	obj_image_anim_end

	.align 2
gSpriteAnimTable_81FAEFC:: @ 81FAEFC
	.4byte gSpriteAnim_81FAEBC
	.4byte gSpriteAnim_81FAECC
	.4byte gSpriteAnim_81FAEDC
	.4byte gSpriteAnim_81FAEEC

	.align 2
gSpriteTemplate_81FAF0C:: @ 81FAF0C
	spr_template 55019, 55019, gOamData_81FAEB4, gSpriteAnimTable_81FAEFC, NULL, gDummySpriteAffineAnimTable, sub_80463CC

	.align 2
gUnknown_081FAF24:: @ 81FAF24
	obj_tiles gEnemyMonShadow_Gfx, 128, 0xD759

	.align 2
gOamData_81FAF2C:: @ 81FAF2C
	.2byte 0x4000
	.2byte 0x4000
	.2byte 0x0C00

	.align 2
gSpriteTemplate_81FAF34:: @ 81FAF34
	spr_template 55129, 55039, gOamData_81FAF2C, gDummySpriteAnimTable, NULL, gDummySpriteAffineAnimTable, sub_8032978

	.align 2
gUnknown_081FAF4C:: @ 81FAF4C
	.4byte 0x02008000
	.4byte 0x0200a000
	.4byte 0x0200c000
	.4byte 0x0200e000

	.align 2
gUnknown_081FAF5C:: @ 81FAF5C
	.4byte dp01t_00_7_getattr
	.4byte dp01t_01_2_read_pokmon_data_slice
	.4byte dp01t_02_7_setattr
	.4byte sub_8034744
	.4byte sub_80347B8
	.4byte sub_8034910
	.4byte sub_8034AE0
	.4byte sub_8034BFC
	.4byte sub_8034DC0
	.4byte sub_8034F84
	.4byte sub_8035030
	.4byte sub_80350D4
	.4byte sub_80350E0
	.4byte sub_80350EC
	.4byte sub_80350F8
	.4byte sub_8035104
	.4byte sub_803539C
	.4byte sub_8035400
	.4byte sub_803540C
	.4byte sub_803541C
	.4byte sub_8035428
	.4byte sub_8035590
	.4byte sub_80355C0
	.4byte sub_80356C0
	.4byte sub_80356CC
	.4byte sub_80357BC
	.4byte sub_80357C8
	.4byte sub_803583C
	.4byte sub_80358A4
	.4byte sub_80358B0
	.4byte sub_80358BC
	.4byte sub_80358C8
	.4byte sub_80358D4
	.4byte sub_80358E0
	.4byte sub_80358EC
	.4byte sub_80358F8
	.4byte sub_8035904
	.4byte sub_8035910
	.4byte sub_803592C
	.4byte sub_8035964
	.4byte sub_803597C
	.4byte dp01t_29_7_blink
	.4byte sub_8035A14
	.4byte sub_8035A20
	.4byte sub_8035A64
	.4byte sub_8035A94
	.4byte dp01t_2E_7_battle_intro
	.4byte sub_8035B04
	.4byte dp01t_30_7_0803D67C
	.4byte sub_8035E6C
	.4byte sub_8035EB8
	.4byte sub_8035EC4
	.4byte dp01t_34_7_move_anim_start_t3
	.4byte sub_8035F8C
	.4byte sub_8035F98
	.4byte sub_8035FA4
	.4byte nullsub_46

@ unreferenced unknown values
	.byte 0xB0, 0xB0, 0xC8, 0x98, 0x28, 0x28, 0x28, 0x20

	.align 2
gLinkOpponentBufferCommands:: @ 81FB048
	.4byte dp01t_00_4_getattr
	.4byte sub_803889C
	.4byte sub_80388A8
	.4byte sub_8039220
	.4byte sub_8039294
	.4byte sub_80393E4
	.4byte sub_80395B4
	.4byte sub_80396D0
	.4byte sub_80398A4
	.4byte sub_80398B0
	.4byte sub_803995C
	.4byte sub_8039A00
	.4byte sub_8039A0C
	.4byte sub_8039A18
	.4byte sub_8039A24
	.4byte sub_8039A30
	.4byte sub_8039CC8
	.4byte sub_8039D2C
	.4byte sub_8039D38
	.4byte sub_8039D44
	.4byte sub_8039D50
	.4byte sub_8039D5C
	.4byte sub_8039D68
	.4byte sub_8039D74
	.4byte sub_8039D80
	.4byte sub_8039E70
	.4byte sub_8039E7C
	.4byte sub_8039EF0
	.4byte sub_8039F58
	.4byte sub_8039F64
	.4byte sub_8039F70
	.4byte sub_8039F7C
	.4byte sub_8039F88
	.4byte sub_8039F94
	.4byte sub_8039FA0
	.4byte sub_8039FAC
	.4byte sub_8039FB8
	.4byte sub_8039FC4
	.4byte sub_8039FE0
	.4byte sub_803A018
	.4byte sub_803A030
	.4byte dp01t_29_4_blink
	.4byte sub_803A0C8
	.4byte sub_803A0D4
	.4byte sub_803A118
	.4byte sub_803A148
	.4byte dp01t_2E_4_battle_intro
	.4byte sub_803A1B8
	.4byte sub_803A3DC
	.4byte sub_803A520
	.4byte sub_803A56C
	.4byte sub_803A578
	.4byte bx_exec_buffer_A_ch0_tbl4
	.4byte sub_803A640
	.4byte sub_803A64C
	.4byte sub_803A658
	.4byte nullsub_48

@ 81FB12C
	.include "data/battle_moves.inc"
