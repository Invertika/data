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

require "scripts/libs/warp"


local function oughad_talk(npc, ch)
    local quest_string_kills = "more_mountains_maggot_kill_quest_kills" --Die anzahl der Kills an Maden, die der Spieler haben soll
    local quest_string_var = "more_mountains_maggot_kill_quest_var" --Die allgemeine Questvar
    local quest_string_number = "more_mountains_maggot_kill_quest_number" --Anzahl der erledigten Aufträge
    local quest_string_maggot = "more_mountains_maggot_start" --Start Anzahl der Maden
    
    --Init Quests
    invertika.init_quest_status(ch, quest_string_kills)
    invertika.init_quest_status(ch, quest_string_var)
    invertika.init_quest_status(ch, quest_string_number)
    invertika.init_quest_status(ch, quest_string_maggot)
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, quest_string_var)
    local number_of_jobs = invertika.get_quest_status(ch, quest_string_number)
    
    if quest_var == 0 then
        npc_message(npc, ch, "Ahrg.")
        npc_message(npc, ch, "Immer verderben diese bistigen Maden meine Ernte.")
        npc_message(npc, ch, "Und das bei den Saat Preisen..")
        npc_message(npc, ch, "...")
        npc_message(npc, ch, "Seit wann stehst denn du hier?")
        npc_message(npc, ch, "Egal, jetzt, wo du schon einmal hier bist, kanst du mir ja auch bei meinem Problem helfen.")
        while true do
            npc_message(npc, ch, "Und, hilfst du?")
            local v = npc_choice(npc, ch, "Ja", "Nein")
            if v == 1 then
                npc_message(npc, ch, "danke")
                --Set Quest Var
                invertika.set_quest_status(ch, quest_string_var, 1)
                break
            elseif v == 2 then
                npc_message(npc, ch, "ok")
                break
            end
        end
    end
    
    quest_var = invertika.get_quest_status(ch, quest_string_var)
    
    if quest_var == 1 then
        local number_of_kills = (number_of_jobs + 1) * 5 * math.random(1, 20)
        npc_message(npc, ch, string.format("Töte bitte mindestens %s Maden", number_of_kills))

        --Set Quest
        invertika.set_quest_status(ch, quest_string_var, 2)
        invertika.set_quest_status(ch, quest_string_kills, number_of_kills)
        invertika.set_quest_status(ch, quest_string_maggot, chr_get_kill_count(ch, 2))
    end
    
    --Get Quests
    local required_kills = invertika.get_quest_status(ch, quest_string_kills)
    local start_kills = invertika.get_quest_status(ch, quest_string_maggot)
    
    if quest_var == 2 then
        local kills = chr_get_kill_count(ch, 2)
        if kills - start_kills >= required_kills then
            number_of_jobs = number_of_jobs + 1
            npc_message(npc, ch, "Danke. Das sollte meiner Ernte helfen.")
            invertika.add_money(ch, number_of_jobs * 25)
            
            --Set Quests
            invertika.set_quest_status(ch, quest_string_var, 1)
            invertika.set_quest_status(ch, quest_string_number, number_of_jobs)           
        else
            npc_message(npc, ch, string.format("Du woltest mehr Maden töten. Töte bitte noch %s Maden.", required_kills - (kills - start_kills)))
        end
    end
end
atinit(function()
 create_inter_map_warp_trigger(98, 108, 96, 86) --- Intermap warp
 nethek.create_netheksaeule(107 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule

 npc_create("Oughad", 46, GENDER_UNSPECIFIED, 73 * TILESIZE + 16, 119 * TILESIZE + 16, oughad_talk, nil)
end)
