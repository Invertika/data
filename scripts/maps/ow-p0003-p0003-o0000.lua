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

atinit(function()
 create_inter_map_warp_trigger(98, 108, 96, 86) --- Intermap warp
 nethek.create_netheksaeule(107 * TILESIZE, 125 * TILESIZE + 16) --- Netheksäule

 create_npc("Oughad", 46, 73 * TILESIZE + 16, 119 * TILESIZE + 16, oughad_talk, nil)
end)

function oughad_talk(npc, ch)
    local quest_string_kills = "more_mountains_maden_kill_quest_kills" --Die anzahl der Kills an Maden, die der Spieler haben soll
    local quest_string_var = "more_mountains_maden_kill_quest_var" --Die allgemeine Questvar
    local quest_string_number = = "more_mountains_maden_kill_quest_number" --Anzahl der erledigten Aufträge
    
    --Init Quests
    invertika.init_quest_status(ch, quest_string_kills)
    invertika.init_quest_status(ch, quest_string_var)
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, quest_string_var)
    local number_of_jobs = imvertika.get_quest_status(ch, quest_string_number)
    
    if quest_var == 0 then
        do_message(npc, ch, "Ahrg.")
        do_message(npc, ch, "Immer verderben diese bistigen Maden meine Ernte.")
        do_message(npc, ch, "Und das bei den Saat Preisen..")
        do_message(npc, ch, "...")
        do_message(npc, ch, "Seit wann stehst denn du hier?")
        do_message(npc, ch, "Egal, jetzt, wo du schon einmal hier bist, kanst du mir ja auch bei meinem Problem helfen.")
        do while true
            local v = do_choice(npc, ch, "Und, hilfst du?")
            if v == 1 then
                do_message(npc, ch, "danke")
                --Set Quest Var
                invertika.set_quest_status(ch, quest_string_var, 1)
            else id v == 2 then
                do_message(npc, ch, "ok")
            end
        end
    end
    
    quest_var = invertika.get_quest_status(ch, quest_string_var)
    
    if quest_var == 1 then
        local number_of_kills = (number_of_jobs + 1) * 5 * math.random(1, 20)
        do_message(npc, ch, "Töte bitte mindestens %s Maden", number_of_kills)

        --Set Quest
        invertika.set_quest_status(ch, quest_string_var, 2)
        invertika.set_quest_status(ch, quest_string_kills, number_of_kills)
    end
    
    local required_kills = invertika.get_quest_status(ch, quest_string_kills)
    
    if quest_var == 2 then
        local kills = mana.chr_get_kill_count(ch, 2)
        if kills >= required_kills then
            number_of_jobs = number_of_jobs + 1
            do_message(npc, ch, "Danke. Das sollte meiner Ernte helfen.")
            invertika.add_money(ch, number_of_jobs * 25)
            
            --Set Quests
            invertika.set_quest_status(ch, quest_string_var, 1)
            invertika.set_quest_status(ch, quest_string_number, number_of_jobs)
    end
    do_npc_close(npc, ch)
end