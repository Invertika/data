----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"

atinit(function()
    create_npc("Worrany", 69, 22 * TILESIZE + 16, 27 * TILESIZE + 16, worrany_talk, worrany_update)
end)

function worrany_talk(npc, ch)
    do_message(npc, ch, "Willkommen, in meinem Kräuterladen")
    do_message(npc, ch, "Was kann ich für sie tun?")
    
    while true do
        local v = do_choice(npc, ch, "Kaufen.",
                             "Verkaufen.",
                             "Nichts. Danke.")
                         
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {{30015, 12, 250}, 
              {30016, 12, 500}, 
              {30017, 12, 750}, 
              {30018, 12, 250}, 
              {30019, 12, 550}, 
              {30020, 12, 750}
              })
            break
        elseif v == 2 then
            mana.npc_trade(npc, ch, true,
              {{30015, 12, 25}, 
              {30016, 12, 50}, 
              {30017, 12, 75}, 
              {30018, 12, 25}, 
              {30019, 12, 55}, 
              {30020, 12, 75}
              })
            break
        elseif v == 3 then
            do_message(npc, ch, "Beehren sie uns bald wieder.")
            break
        end
    end
    do_npc_close(npc, ch)
end

local walk_timer = {}
function worrany_update(npc)
    if walk_timer[npc] then
        walk_timer[npc] = walk_timer[npc] + 1
        local x = mana.posX(npc)
        
        if walk_timer[npc] % 100 == 0 then
            if x == 22 * TILESIZE + 16 then
                x = 18
            elseif x == 18 * TILESIZE + 16 then
                mana.effect_create(5, x * TILESIZE, 29 * TILESIZE)
                x = 27
            elseif x == 27 * TILESIZE + 16 then
                mana.effect_create(5, x * TILESIZE, 29 * TILESIZE)
                x = 22
            else
                x = nil
            end
            if not(x == nil) then 
                mana.being_walk(npc, x * 32 + 16, 880, 2)
            end
        end
    else
        walk_timer[npc] = 1
    end
end
