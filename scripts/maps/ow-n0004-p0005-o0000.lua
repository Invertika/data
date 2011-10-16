----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"

require "scripts/libs/invertika"
require "scripts/libs/nethek"
require "scripts/libs/sign"

dofile("data/scripts/libs/warp.lua")

atinit(function()
    create_inter_map_warp_trigger(nil, 33, 43, 55) --- Intermap warp
    nethek.create_netheksaeule(103 * TILESIZE, 107 * TILESIZE + 16) ---Netheksäule

    sign_entrance = "Burg Cedric"
    sign.create_sign(106, 182, sign_entrance) --- Schild Burgeingang

    --TODO change sprite id
    diem = create_npc("Diem", 120, 60 * TILESIZE + 16, 160 * TILESIZE + 16, diem_talk, diem_update)
    invertika.create_npc_talk_random(diem,
        {"Kauft Leute! Kauft!",
        "Beste Waren! Hergestellt in den königlichen Schmieden!",
        "Sehen Sie! Dieses Schert ist unzerbrechbar! ZACK. Oh...",
        "Kommen Sie meine Herren. Diese Waffen sind die besten."})

    create_npc("Chris", 72, 90 * TILESIZE + 16, 104 * TILESIZE + 16, chris_talk, npclib.walkaround_wide)

    --TODO change sprite id
    create_npc("Estjdan", 120, 60 * TILESIZE + 16, 160 * TILESIZE + 16, estjdan_talk, invertika.npc_greet_random)
	
	create_npc("Palstwache", 26, 58 * TILESIZE + 16, 100 * TILESIZE + 16, nil, invertika.npc_greet_random)
	create_npc("Palstwache", 26, 61 * TILESIZE + 16, 100 * TILESIZE + 16, nil, invertika.npc_greet_random)
	
	create_npc("Wache", 26, 150 * TIELSIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
	create_npc("Wache", 26, 153 * TIELSIZE + 16, 119 * TILESIZE + 16, wache_bank_talk, nil)
	create_npc("Wache", 26, 52 * TIELSIZE + 16, 149 * TILESIZE + 16, wache_casino_talk, nil)
end)

function diem_talk(npc, ch)
    npc.trade(npc, ch, false, {
        {10001, 30, 50},
        {10013, 30, 140},
        {10002, 30, 1000},
        {10009, 30, 1690},
        {20001, 30, 250},
        {20002, 30, 250},
        {20011, 30, 250},
        {20012, 30, 250},
        {20013, 30, 250},
        {20014, 30, 250},
        {20015, 30, 250},
        {20016, 30, 250},
        {20017, 30, 250},
        {20018, 30, 250},
        {20009, 30, 500}
    })
    do_npc_close(npc, ch)
end

function diem_update(npc)
    npclib.walkaround_wide(npc)
    invertika.npc_talk_random(npc)
end

function chris_talk(npc, ch)
    do_message(npc, ch, "Guten Tag der Herr.")
    do_npc_close(npc, ch)
end

function estjdan_talk(npc, ch)
    do_message(npc, ch, "Tag der Herr")
    do_npc_close(npc, ch)
end

function wache_bank_talk(npc, ch)
    do_message(npc, ch, "Wir bewachen die Bank.")
    do_npc_close(npc, ch);
end

function wache_casino_talk(npc, ch)
    do_message(npc, ch, "Wir bewachen das Kasino.")
    do_npc_close(npc, ch)
end