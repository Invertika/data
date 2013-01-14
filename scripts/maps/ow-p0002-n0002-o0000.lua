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
require "scripts/libs/sign"
require "scripts/libs/invertika"

require "scripts/libs/warp"

atinit(function()
  create_inter_map_warp_trigger(78, 90, 80, 68) --- Intermap warp
  sign.create_sign(147, 79, "Denkmal des großen Fehlerbehebers")
  
  trigger_create(36 * TILESIZE, 97 * TILESIZE, 2 * TILESIZE, 2 * TILESIZE, statue_trigger, 1, true);
  
  npc_create("Statue", 1, GENDER_UNSPECIFIED, 36 * TILESIZE + 16, 93 * TILESIZE + 16, statue_talk, nil)
end)

function statue_talk(npc, ch)
    queststring = "monument-of-bugfixer-entry-statue-quest"
    queststring_killed = "monument-of-bugfixer-entry-statue-quest-killed"
    queststring_needed = "monument-of-bugfixer-entry-statue-quest-needed"
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    invertika.init_quest_status(ch, queststring_killed)
    invertika.init_quest_status(ch, queststring_needed)
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    
    if quest_var == 0 then
        npc_message(npc, ch, "Du willst dich also als würdig erweisen, dass Denkmal zu betreten?")
        while true do
            local v = npc_choice(npc, ch, "Ja",
              "Nein")
            if v == 1 then
                --Set Quest
                invertika.set_quest_status(ch, queststring, 1)
                break
            elseif v == 2 then
                break
            end
        end
    end
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 1 then
        npc_message(npc, ch, "Gut")
        local needed_kills = math.random(1, 10) * ( chr_get_kill_count(ch, 14) + 1) / 10 -- Sandwürmer müssen gekillt werden. Hier sollte eigentlich mit dem level gerechnet werden. Ich (Postremus) fand aber keine Funktion, die genau dies anbietet.
        npc_message(npc, ch, string.format("Töte bitte %d Sandwürmer", needed_kills))
        -- Set Quest
        invertika.set_quest_status(ch, queststring, 2)
        invertika.set_quest_status(ch, queststring_killed, chr_get_kill_count(ch, 14))
        invertika.set_quest_status(ch, queststring_needed, needed_kills)
    end
    
    --Get Quest
    local quest_var_killed = invertika.get_quest_status(ch, queststring_killed)
    local quest_var_needed = invertika.get_quest_status(ch, queststring_needed)
    
    local curr_kills = chr_get_kill_count(ch, 14) - quest_var_killed
    
    
    if quest_var == 2 and curr_kills < quest_var_needed then
        npc_message(npc, ch, string.format("Was wagst du es, hier zu stehen, obwohl dir noch %d Sandwürmer fehlen?", quest_var_needed - curr_kills))
    elseif quest_var == 2 and curr_kills >= quest_var_needed then
        -- Set Quest
        invertika.set_quest_status(ch, queststring, 3)
        npc_message(npc, ch, "Du hast genügend Sandwürmer getötet.")
    end
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 3 then
        npc_message(npc, ch, "Du darfst passieren.")
        chr_warp(ch, nil, 38 * TILESIZE + 16, 97 * TILESIZE + 16)
    end
end

function statue_trigger(ch, id)
    if being_type(ch) == TYPE_CHARACTER then
        chatmessage(ch, "Ab hier beginnt das Denkmal des großen Fehlerbehebers.")
        chatmessage(ch, "Du darfst erst passieren, sobald du dich als würdig erwiesen hast!")
        chatmessage(ch, "Rede mit der Statue.")
        chr_warp(ch, nil, 33 * TILESIZE + 16, posY(ch))
    end
end