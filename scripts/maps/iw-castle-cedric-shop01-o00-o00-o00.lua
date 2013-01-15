----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"


local function worrany_talk(npc, ch)
    npc_message(npc, ch, "Willkommen, in meinem Kräuterladen")
    npc_message(npc, ch, "Was kann ich für sie tun?")
    
    while true do
        local v = npc_choice(npc, ch, "Kaufen.",
                             "Verkaufen.",
                             "Nichts. Danke.")
                         
        if v == 1 then
            npc_trade(npc, ch, false,
              {{30015, 12, 250}, 
              {30016, 12, 500}, 
              {30017, 12, 750}, 
              {30018, 12, 250}, 
              {30019, 12, 550}, 
              {30020, 12, 750}
              })
            break
        elseif v == 2 then
            npc_trade(npc, ch, true,
              {{30015, 12, 25}, 
              {30016, 12, 50}, 
              {30017, 12, 75}, 
              {30018, 12, 25}, 
              {30019, 12, 55}, 
              {30020, 12, 75}
              })
            break
        elseif v == 3 then
            npc_message(npc, ch, "Beehren sie uns bald wieder.")
            break
        end
    end
end

local function worrany_walkleft()
    being_walk(npc, 18 * 32 + 16, 880, 2)
    schedule_in(20, worrany_walkright)
end

local function worrany_walkright()
    being_walk(npc,  27 * 32 + 16, 880, 2)
    schedule_in(20, worrany_walkleft)
end

atinit(function()
    worrany = npc_create("Worrany", 69, GENDER_UNSPECIFIED, 22 * TILESIZE + 16, 27 * TILESIZE + 16, worrany_talk, nil)

    -- CRASHT DEN SERVER! Erst auskommentieren sobald der Bug gefixt ist.
    -- schedule_in(10, worrany_walkleft)
end)
