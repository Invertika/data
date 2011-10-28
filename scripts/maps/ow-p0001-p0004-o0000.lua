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
require "scripts/libs/nethek"
require "scripts/libs/sign"
dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(77, 87, 75, 65) --- Intermap warp
 nethek.create_netheksaeule(187 * TILESIZE, 173 * TILESIZE + 16) ---Netheksäule
 sign.create_sign(153, 178, "Im Haus können Tickets für den Zoo Rundgang gekauft werden.")
 
 mana.trigger_create(138 * TILESIZE, 176 * TILESIZE, 9 * TILESIZE, 3 * TILESIZE, "wache_trigger", 1, true)
 mana.trigger_create(135 * TILESIZE, 186 * TILESIZE, 3 * TILESIZE, 4 * TILESIZE, "wache_trigger", 2, true)
 mana.trigger_create(168 * TILESIZE, 179 * TILESIZE, 3 * TILESIZE, 11 * TILESIZE, "wache_trigger", 3, true)
 mana.trigger_create(138 * TILESIZE, 190 * TILESIZE, 13 * TILESIZE, 2 * TILESIZE, "eingang_trigger", 1, true)
 mana.trigger_create(71 * TILESIZE, 189 * TILESIZE, 14 * TILESIZE, 2 * TILESIZE, "ausgang_trigger", 1, true)
 mana.trigger_create(71 * TILESIZE, 191 * TILESIZE, 14 * TILESIZE, 2 * TILESIZE, "ausgang_trigger", 2, true)

 
 wache_oben = create_npc("Wache", 26, 140 * TILESIZE + 16, 180 * TILESIZE + 16, wache_talk, nil)
 create_npc("Wache", 26, 138 * TILESIZE + 16, 186 * TILESIZE + 16, wache_talk, nil)
 create_npc("Wache", 26, 167 * TILESIZE + 16, 183 * TILESIZE + 16, wache_talk, nil)
 wache_ausgang = create_npc("Wache", 26, 71 * TILESIZE + 16, 192 * TILESIZE + 16, wache_ausgang_talk, nil)
end)

function wache_talk(npc, ch)
    if mana.chr_inv_count(ch, 40049) > 0 then
        do_message(npc, ch, "Um denn Zoo zu betreten, brauchst du eine Eintrittskarte.")
	else
	    do_message(npc, ch, "Viel Spaß.")
    end
    do_npc_close(npc, ch)
end

function wache_ausgang_talk(npc, ch)
    do_message(npc, ch, "Dies ist der Augang. Bitte benutze den Eingang im Osten.")
    do_npc_close(npc, ch)
end

function wache_trigger(ch, id)
    if mana.being_type(ch) ~= TYPE_MONSTER then
        if mana.chr_inv_count(ch, 40049) == 0 then
            local x = mana.posX(ch)
            local y = mana.posY(ch)
      
            if id == 1 then
                y = 179 * TILESIZE + 16
            elseif id == 2 then
                x = 138 * TILESIZE + 16
            elseif id == 3 then
                x = 165 * TILESIZE + 16
            end
            mana.chr_warp(ch, nil, x, y)
            mana.being_say(wache_oben, "Nur mit Ticket darfst du in den Zoo")
        elseif mana.chr_inv_count(ch, 40049) < 0 then
           mana.being_say(wache_oben, "Viel Spaß")
        end
    end
end

function ausgang_trigger(ch, id)
    if mana.being_type(ch) ~= TYPE_MONSTER then
        if id == 1 then
            if mana.chr_inv_count(ch, 40049) > 0 then
                mana.chr_inv_change(ch, 40049, -1)
            end
        elseif id == 2 then
            mana.chr_warp(ch, nil, mana.posX(ch), 192 * TILESIZE + 16)
            mana.being_say(wache_ausgang, "Bitte benutze den Eingang im Osten")
        end
    end
end

function eingang_trigger(ch, id)
    if mana.being_type(ch) ~= TYPE_MONSTER then
        if mana.chr_inv_count(ch, 40049) > 0 then
            mana.being_say(wache_oben, "Bitte benutze den Ausgang im Westen.")
            mana.chr_warp(ch, nil, mana.posX(ch), 189 * TILESIZE + 16)
        end
    end
end
