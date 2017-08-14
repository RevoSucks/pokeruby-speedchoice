#!/usr/bin/perl

use strict;
use warnings;

my $romBase = hex('0x08000000');
my %offsets = (
    'gRandomizerCheckValue' => '',
    'gBaseStats'            => '',
    'gLevelUpLearnsets'     => '',
    'gTMHMLearnsets'        => '',
    'gEvolutionTable'       => '',
    'sStarterMons'          => '',
    'CB2_GiveStarter'       => '',
    'gTrainers'             => '',
    'gTrainerClassNames'    => '',
    'gItems'                => '',
    'gBattleMoves'          => '',
    'gMoveDescriptions'     => '',
    'gMoveNames'            => '',
    'gAbilityNames'         => '',
    'gUnknown_08376504'     => '',
    'gMonFrontPicTable'     => '',
    'gMonPaletteTable'      => '',
    'gIngameTrades'         => '',
    'Task_NewGameSpeech7'     => '',
    'CreateAzurillSprite'     => '',
    'StartBattle_WallyTutorial'     => '',
    'PutZigzagoonInPlayerParty'     => '',
    'gNewGamePCItems'     => '',
#    'RustboroCity_DevonCorp_2F_EventScript_157661'     => '',
#    'RustboroCity_DevonCorp_2F_EventScript_1576B4'     => '',
#    'CaveOfOrigin_B4F_EventScript_1A04A0'     => '',
#    'CaveOfOrigin_B4F_EventScript_15DDD7'     => '',
#    'DesertRuins_EventScript_15CB85'     => '',
#    'IslandCave_EventScript_15EF9D'     => '',
#    'AncientTomb_EventScript_15F050'     => '',
#    'SouthernIsland_Interior_EventScript_160BA7'     => '',
#    'SkyPillar_Top_EventScript_15F316'     => '',
#    'Route119_EventScript_1A05C3'     => '',
#    'Route120_EventScript_15189D'     => '',
#    'NewMauville_Inside_EventScript_15E900'     => '',
#    'NewMauville_Inside_EventScript_15E91E'     => '',
#    'NewMauville_Inside_EventScript_15E93C'     => '',
#    'AquaHideout_B1F_EventScript_1A04FD'     => '',
#    'AquaHideout_B1F_EventScript_1A051B'     => '',
#    'LavaridgeTown_EventScript_14E75A'     => '',
#    'MossdeepCity_StevensHouse_EventScript_15AA7C'     => '',
#    'Route119_WeatherInstitute_2F_EventScript_163D7A'     => '',
);

sub println {print @_, "\n"}

(@ARGV == 1)
    or die "ERROR: please supply the name of the .elf file\n";
print STDERR "reading symbols from $ARGV[0]...";
open(my $readelfOutput, '-|', 'arm-none-eabi-readelf', '-s', $ARGV[0])
    or die "ERROR: could not execute $!\n";
while (my $line = <$readelfOutput>)
{
    if ($line =~ /.+:\s+(\w+)\s+\w+\s+\w+\s+\w+\s+\w+\s+\w+\s+(\w+)/)
    {
        if (exists($offsets{$2}))
        {
            $offsets{$2} = sprintf('0x%08X', hex($1) - $romBase);
        }
    }
}
print STDERR "done\n";
foreach my $key (keys %offsets)
{
    if ($offsets{$key} eq '')
    {
        die "ERROR: symbol $key was not found\n";
    }
}

println '[Sapphire Speedchoice (U)]';
println 'Game=SPDC';
println 'Version=0';
println 'Type=Sapphire';
println 'TableFile=gba_english';
println 'FreeSpace=0x700000';
println 'PokemonNameLength=11';
println 'PokemonCount=411';
println 'CheckValueOffset=', $offsets{'gRandomizerCheckValue'};
println 'PokemonStats=', $offsets{'gBaseStats'};
println 'PokemonMovesets=', $offsets{'gLevelUpLearnsets'};
println 'PokemonTMHMCompat=', $offsets{'gTMHMLearnsets'};
println 'PokemonEvolutions=', $offsets{'gEvolutionTable'};
println 'StarterPokemon=', $offsets{'sStarterMons'};
println 'StarterItems=', sprintf("0x%08X", hex($offsets{'CB2_GiveStarter'}) + hex('0x21'));
println 'TrainerData=', $offsets{'gTrainers'};
println 'TrainerEntrySize=40';
println 'TrainerCount=0x2B8';
println 'TrainerClassNames=', $offsets{'gTrainerClassNames'};
println 'TrainerClassCount=58';
println 'TrainerClassNameLength=13';
println 'TrainerNameLength=12';
println 'DoublesTrainerClasses=[27, 42, 55, 56, 57]';
println 'ItemData=', $offsets{'gItems'};
println 'ItemCount=348';
println 'ItemEntrySize=44';
println 'MoveData=', $offsets{'gBattleMoves'};
println 'MoveCount=354';
println 'MoveDescriptions=', $offsets{'gMoveDescriptions'};
println 'MoveNameLength=13';
println 'MoveNames=', $offsets{'gMoveNames'};
println 'AbilityNameLength=13';
println 'AbilityNames=', $offsets{'gAbilityNames'};
println 'TmMoves=', $offsets{'gUnknown_08376504'};
println 'IntroCryOffset=', sprintf("0x%08X", hex($offsets{'Task_NewGameSpeech7'}) + hex('0x4D'));
println 'IntroSpriteOffset=', sprintf("0x%08X", hex($offsets{'CreateAzurillSprite'}) + hex('0x5B'));
println 'IntroPaletteOffset=', sprintf("0x%08X", hex($offsets{'CreateAzurillSprite'}) + hex('0x67'));
println 'IntroOtherOffset=', sprintf("0x%08X", hex($offsets{'CreateAzurillSprite'}) + hex('0x29'));
println 'PokemonFrontSprites=', $offsets{'gMonFrontPicTable'};
println 'PokemonNormalPalettes=', $offsets{'gMonPaletteTable'};
println 'ItemBallPic=59';
println 'TradeTableOffset=', $offsets{'gIngameTrades'};
println 'TradeTableSize=3';
println 'TradesUnused=[]';
println 'RunIndoorsTweakOffset=0x6FFFFE';
println 'CatchingTutorialOpponentMonOffset=', sprintf("0x%08X", hex($offsets{'StartBattle_WallyTutorial'}) + hex('0x3'));
println 'CatchingTutorialPlayerMonOffset=', sprintf("0x%08X", hex($offsets{'PutZigzagoonInPlayerParty'}) + hex('0x5'));
println 'PCPotionOffset=', $offsets{'gNewGamePCItems'};
println 'StaticPokemonSupport=1';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'RustboroCity_DevonCorp_2F_EventScript_157661'}) + hex('0x2')), ', ', sprintf("0x%08X", hex($offsets{'RustboroCity_DevonCorp_2F_EventScript_157661'}) + hex('0x30')), '] // Lileep';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'RustboroCity_DevonCorp_2F_EventScript_1576B4'}) + hex('0x2')), ', ', sprintf("0x%08X", hex($offsets{'RustboroCity_DevonCorp_2F_EventScript_1576B4'}) + hex('0x30')), '] // Anorith';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'CaveOfOrigin_B4F_EventScript_1A04A0'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'CaveOfOrigin_B4F_EventScript_15DDD7'}) + hex('0x4F')), ', ', sprintf("0x%08X", hex($offsets{'CaveOfOrigin_B4F_EventScript_15DDD7'}) + hex('0x5D')), '] // Kyogre';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'DesertRuins_EventScript_15CB85'}) + hex('0x4')), ', ', sprintf("0x%08X", hex($offsets{'DesertRuins_EventScript_15CB85'}) + hex('0xD')), '] // Regirock';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'IslandCave_EventScript_15EF9D'}) + hex('0x4')), ', ', sprintf("0x%08X", hex($offsets{'IslandCave_EventScript_15EF9D'}) + hex('0xD')), '] // Regice';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'AncientTomb_EventScript_15F050'}) + hex('0x4')), ', ', sprintf("0x%08X", hex($offsets{'AncientTomb_EventScript_15F050'}) + hex('0xD')), '] // Registeel';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'SouthernIsland_Interior_EventScript_160BA7'}) + hex('0x27')), ', ', sprintf("0x%08X", hex($offsets{'SouthernIsland_Interior_EventScript_160BA7'}) + hex('0x4D')), '] // Latios (Southern Island)';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'SkyPillar_Top_EventScript_15F316'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'SkyPillar_Top_EventScript_15F316'}) + hex('0xA')), '] // Rayquaza';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'Route119_EventScript_1A05C3'}) + hex('0x1F')), ', ', sprintf("0x%08X", hex($offsets{'Route119_EventScript_1A05C3'}) + hex('0x28')), '] // Kecleons on OW (7)';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'Route120_EventScript_15189D'}) + hex('0x4B')), ', ', sprintf("0x%08X", hex($offsets{'Route120_EventScript_15189D'}) + hex('0x54')), '] // Kecleon w/ Steven';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E900'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E900'}) + hex('0xA')), '] // Voltorb 1';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E91E'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E91E'}) + hex('0xA')), '] // Voltorb 2';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E93C'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'NewMauville_Inside_EventScript_15E93C'}) + hex('0xA')), '] // Voltorb 3';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'AquaHideout_B1F_EventScript_1A04FD'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'AquaHideout_B1F_EventScript_1A04FD'}) + hex('0xA')), '] // Electrode 1';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'AquaHideout_B1F_EventScript_1A051B'}) + hex('0x3')), ', ', sprintf("0x%08X", hex($offsets{'AquaHideout_B1F_EventScript_1A051B'}) + hex('0xA')), '] // Electrode 2';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'LavaridgeTown_EventScript_14E75A'}) + hex('0x40')), '] // Wynaut Egg';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'MossdeepCity_StevensHouse_EventScript_15AA7C'}) + hex('0x33')), ', ', sprintf("0x%08X", hex($offsets{'MossdeepCity_StevensHouse_EventScript_15AA7C'}) + hex('0x43')), '] // Beldum';
#println 'StaticPokemon[]=[', sprintf("0x%08X", hex($offsets{'Route119_WeatherInstitute_2F_EventScript_163D7A'}) + hex('0x1F')), '] // Castform';
println 'TMText[]=[3,15,0,1,0x70,The TM I handed you contains [move].]';
println 'TMText[]=[4,14,0,1,0x74,TATE: That TM04 contains... LIZA: [move]!\pTATE: It’s a move that’s perfect... LIZA: For any POKéMON!]';
println 'TMText[]=[5,0,29,12,0x0D,All my POKéMON does is [move]... No one dares to come near me...\pSigh... If you would, please take this TM away...]';
println 'TMText[]=[5,0,29,12,0x2F,TM05 contains [move].]';
println 'TMText[]=[8,3,3,1,0x7C,That TM08 contains [move].]';
println 'TMText[]=[9,0,19,32,0x0D,I like filling my mouth with seeds, then spitting them out fast!\pI like you, so you can have this!\pUse it on a POKéMON, and it will learn [move].\pWhat does that have to do with firing seeds? Well, nothing!]';
println 'TMText[]=[24,0,2,8,0xE4,WATTSON: Wahahahaha!\pI knew it, \v01\v05! I knew I’d made the right choice asking you!\pThis is my thanks - a TM containing [move]!\pGo on, you’ve earned it!]';
println 'TMText[]=[31,15,5,1,0x24,TM31 contains [move]! It’s a move so horrible that I can’t describe it.]';
println 'TMText[]=[34,10,0,1,0x8B,That TM34 there contains [move]. You can count on it!]';
println 'TMText[]=[39,11,3,1,0x7F,That TM39 contains [move].\pIf you use a TM, it instantly teaches the move to a POKéMON.\pRemember, a TM can be used only once, so think before you use it.]';
println 'TMText[]=[40,12,1,1,0x67,TM40 contains [move].]';
println 'TMText[]=[41,9,3,13,0x2F,That’s, like, TM41, you know? Hey, it’s [move], you hearing me?\pHey, now, you listen here, like, I’m not laying a torment on you!]';
println 'TMText[]=[42,8,1,1,0x48F,DAD: TM42 contains [move].\pIt might be able to turn a bad situation into an advantage.]';
println 'TMText[]=[47,24,10,1,0x19,STEVEN: Okay, thank you.\pYou went through all this trouble to deliver that. I need to thank you.\pLet me see... I’ll give you this TM.\pIt contains my favorite move, [move].]';
println 'TMText[]=[50,4,1,1,0x7F,That TM50 contains [move].]';
