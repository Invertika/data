-- Externe Map Skripting Datei
-- In dieser Datei stehen die entsprechenden externen NPCs, Trigger und anderer Dinge.
--
-- © 2008-2011 by The Invertika Development Team
--
-- This file is part of Invertika. Invertika is free software; you can redistribute 
-- it and/or modify it under the terms of the GNU General  Public License as published 
-- by the Free Software Foundation; either version 3 of the License, or any later version.


require "scripts/lua/npclib"
require "scripts/libs/invertika"

atinit(function()
  create_npc("Umach", 111, 13 * TILESIZE + 16, 25 * TILESIZE + 16, umach_talk, nil)
end)

function umach_talk(npc, ch)
    local queststring = "monument_of_bugfixer_flower_quest"
    local queststring_kill = "monument_of_bugfixer_kill_quest"
    local queststring_curr_kills_bat = "monument_of_bugfixer_kill_quest_current_bat"
    local queststring_curr_kills_vampire_bat = "monument_of_bugfixer_kill_quest_current_vampire_bat"
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    invertika.init_quest_status(ch, queststring_kill)
    invertika.init_quest_status(ch, queststring_curr_kills_bat)
    invertika.init_quest_status(ch, queststring_curr_kills_vampire_bat)
    
    --Get Quest
    local quest_var_flower = invertika.get_quest_status(ch, queststring)
    local quest_var_kill = invertika.get_quest_status(ch, queststring_kill)
    local quest_var_curr_kills_bat = invertika.get_quest_stauts(ch, queststring_curr_kills_bat)
    local quest_var_curr_kills_vampire_bat = invertika.qet_quest_status(ch, queststring_curr_kills_vampire_bat)
    npc_message(npc, ch, "quest_var_flower: "..quest_var_flower)
    npc_message(npc, ch, "quest_var_kill: "..quest_var_kill)
	
    if quest_var_flower == 0 then
        npc_message(npc, ch, "Fremde hatten wir hier lange nicht mehr.")
        npc_message(npc, ch, "Deshalb können wir dir nicht vertrauen.")
        npc_message(npc, ch, "Wenn du aber jemanden hier findest, der dir vertraut, rede ich mit dir.")
    elseif quest_var_flower == 1 and quest_var_kill == 0 then
        npc_message(npc, ch, "Ah, du hast anscheinend eine Verbündete gefunden..")
        npc_message(npc, ch, "Und dabei rein zufällig meine Tochter erwischt.")
        npc_message(npc, ch, "Wir sind hier nie herausgegangen, da unsere Vorfahren dem Fehlerbeheber einen Eid geleistet haben.")
        npc_message(npc, ch, "Für 100 Jahre, durfte keiner diese Höhlen betreten oder verlassen.")
        npc_message(npc, ch, "Dies ist aber seit einigen Jahrzenten abgelaufen.")
        npc_message(npc, ch, "Als wir versuchten, das Tageslicht zu erblicken, sahen wir, dass der Eingang verschüttet war.")
        npc_message(npc, ch, "Monster haben die äußere Höhle in ihren Besitz genommen.")
        npc_message(npc, ch, "Du siehst aus wie ein Kämpfer, bitte töte ein paar der Bestien.")
        npc_message(npc, ch, "Um die 10 von jeder Sorte dürfte reichen..")
    
        --Set Quest
        invertika.set_quest_status(ch, queststring_kill, 1)
        invertika.set_quest_status(ch, queststring_curr_kills_bat, chr_get_kill_count(ch, 8))
        invertika.set_quest_status(ch, queststring_curr_kills_vampire_bat, chr_get_kill_count(ch, 32))
    elseif quest_var_kill == 1 then
        local killed = (chr_get_kill_count(ch, 8) - quest_var_curr_kills_bat) + (chr_get_kill_count(ch, 32) - quest_var_curr_kills_vampire_bat)
        if killed >= 20 then
            npc_message(npc, ch, "Ah, du hast es geschafft!")
            npc_message(npc, ch, "Gehe bitte zu unserem Bürgermeister, er dürfte etwas mit dir zu bereden haben.")
            ---Set Quest
            invertika.set_quest_status(ch, queststring_kill, 2)
        else
            npc_message(npc, ch, "Nur noch ein paar, bitte")
        end
    elseif quest_var_kill == 2 then
        npc_message(npc, ch, "Gehe zum Bürgermeister!")
    end
    do_npc_close(npc, ch)
end
