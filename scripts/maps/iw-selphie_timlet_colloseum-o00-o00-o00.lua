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

atinit(function()
 ---create_npc("Banker", 11, 180 * TILESIZE + 16, 160 * TILESIZE + 16, banker.banker_talk, nil) --- Banker (Debug)
 wache_rechts = create_npc("Wache", 25, 83 * TILESIZE + 16, 44 * TILESIZE + 16, wache_talk, nil) --- Wache rechts
 wache_links = create_npc("Wache", 25, 46 * TILESIZE + 16, 44 * TILESIZE + 16, wache_talk, nil) --- Wache links

 mana.trigger_create(79 * TILESIZE, 40 * TILESIZE, 4 * TILESIZE, 4 * TILESIZE, "wache_trigger", 1, true)
 mana.trigger_create(47 * TILESIZE, 40 * TILESIZE, 4 * TILESIZE, 4 * TILESIZE, "wache_trigger", 2, true)
end)

function wache_talk(npc, ch)
    do_message(npc, ch, "Hier kommt man nur mit VIP-Karte rein!")
    do_npc_close(npc, ch)
end

function get_wache_say()
    return "Halt! Du brauchst eine VIP-Karte um hier rein zu kommen"
end

function wache_trigger(ch, id)
    if (mana.being_type(ch) ~= TYPE_MONSTER) then
        local count = mana.chr_inv_count(ch, 40026)
        if count == 0 then
            local x = mana.posX(ch)
            local y = mana.posY(ch)
            local warp_x = nil
            if id == 1 then
                warp_x = 84
                mana.being_say(wache_rechts, get_wache_say())
            elseif id == 2 then
                warp_x = 45
                mana.being_say(wache_links, get_wache_say())
            end
            mana.chr_warp(ch, mana.get_map_id(), warp_x * TILESIZE, y)
        end
    end
end
