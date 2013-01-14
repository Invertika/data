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
require "scripts/libs/warp"
require "scripts/libs/invertika"

atinit(function()
 create_inter_map_warp_trigger(77, 87, 75, 65) --- Intermap warp
 nethek.create_netheksaeule(187 * TILESIZE, 173 * TILESIZE + 16) ---Netheksäule
 sign.create_sign(153, 178, "Im Haus können Tickets für den Zoo Rundgang gekauft werden.")
 
 trigger_create(138 * TILESIZE, 176 * TILESIZE, 10 * TILESIZE, 3 * TILESIZE, wache_trigger, 1, true)
 trigger_create(135 * TILESIZE, 186 * TILESIZE, 3 * TILESIZE, 4 * TILESIZE, wache_trigger, 2, true)
 trigger_create(138 * TILESIZE, 190 * TILESIZE, 13 * TILESIZE, 2 * TILESIZE, eingang_trigger, 1, true)
 trigger_create(71 * TILESIZE, 189 * TILESIZE, 14 * TILESIZE, 1 * TILESIZE, ausgang_trigger, 1, true)
 trigger_create(71 * TILESIZE, 191 * TILESIZE, 14 * TILESIZE, 1 * TILESIZE, ausgang_trigger, 2, true)

 
 wache_oben = npc_create("Wache", 26, GENDER_UNSPECIFIED, 140 * TILESIZE + 16, 180 * TILESIZE + 16, wache_talk, nil)
 npc_create("Wache", 26, GENDER_UNSPECIFIED, 138 * TILESIZE + 16, 186 * TILESIZE + 16, wache_talk, nil)
 wache_ausgang = npc_create("Wache", 26, GENDER_UNSPECIFIED, 71 * TILESIZE + 16, 192 * TILESIZE + 16, wache_ausgang_talk, nil)
end)

local function wache_talk(npc, ch)
    if chr_inv_count(ch, 40049) == 0 then
        npc_message(npc, ch, "Um den Zoo zu betreten, brauchst du eine Eintrittskarte.")
	else
	    npc_message(npc, ch, "Viel Spaß.")
    end
end

local function wache_ausgang_talk(npc, ch)
    npc_message(npc, ch, "Dies ist der Augang. Bitte benutze den Eingang im Osten.")
end

local function wache_trigger(ch, id)
    if being_type(ch) == TYPE_CHARACTER then
        if chr_inv_count(ch, 40049) == 0 then
            local x = posX(ch)
            local y = posY(ch)
      
            if id == 1 then
                y = 179 * TILESIZE + 16
            elseif id == 2 then
                x = 138 * TILESIZE + 16
            elseif id == 3 then
                x = 165 * TILESIZE + 16
            end
            chr_warp(ch, nil, x, y)
            being_say(wache_oben, "Nur mit Ticket darfst du in den Zoo")
        elseif chr_inv_count(ch, 40049) < 0 then
           being_say(wache_oben, "Viel Spaß")
        end
    end
end

local function ausgang_trigger(ch, id)
    if being_type(ch) == TYPE_CHARACTER then
        if id == 1 then
            if chr_inv_count(ch, 40049) > 0 then
                invertika.add_items(ch, 40049, -1, "Ticket für den Greganyzoo");
            end
            being_say(wache_ausgang, "Tschüß.")
        elseif id == 2 then
            chr_warp(ch, nil, posX(ch), 192 * TILESIZE + 16)
            being_say(wache_ausgang, "Bitte benutze den Eingang im Osten")
        end
    end
end

local function eingang_trigger(ch, id)
    if being_type(ch) == TYPE_CHARACTER then
        if chr_inv_count(ch, 40049) > 0 then
            being_say(wache_oben, "Bitte benutze den Ausgang im Westen.")
            chr_warp(ch, nil, posX(ch), 189 * TILESIZE + 16)
        end
    end
end
