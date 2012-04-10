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
require "scripts/libs/nethek"

atinit(function()
    nethek.create_netheksaeule(47 * TILESIZE, 8 * TILESIZE + 16)
    
    --TODO: bessere Namen
    create_npc("Priscilla", 18, 48 * TILESIZE + 16, 16 * TILESIZE + 16, maedchen_talk, nil)
    
end)

function maedchen_talk(npc, ch)
    local queststring = "monument_of_bugfixer_flower_quest"
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 0 then
        do_message(npc, ch, "Das da hinter uns ist der Große Fehlerbeheber.")
        do_message(npc, ch, "Wie gerne würde ich seine Statue mit einer Blume dekorieren.")
        do_message(npc, ch, "Leider wachsen bei uns keine.")
        do_message(npc, ch, "Und einfach rausgehen ist nicht.")
        do_message(npc, ch, "Unsere Augen haben sich zu stark an die hier unten herrschende Dunkelheit gewöhnt, sagt zumindest jeder..")
        do_message(npc, ch, "Du siehst aus wie jemand, der von weit herkommt.")
        do_message(npc, ch, "Würdest du mir bitte eine bringen?")
    
        while true do
            local c = do_choice(npc, ch, "Ja, natürlich.",
              "Nein, sorry")
            if c == 1 then
                do_message(npc, ch, "Ich danke dir.")
                --Set Quest
                invertika.set_quest_status(ch, queststring, 1)
                break
            elseif c == 2 then
                do_message(npc, ch, "ok")
                break
            end
        end
    
    elseif quest_var == 1 then
        if mana.chr_inv_count(ch, 40053) > 0 then
            do_message(npc, ch, "Ich danke dir.")
            --Set Quest
            invertika.set_quet_status(ch, queststring, 2)
        elseif mana.chr_inv_count(ch, 40053) == 0 then
            do_message(npc, ch, "Bitte, bringe mir die Blume.")
        end
    elseif quest_var == 2 then
        do_message(npc, ch, "Sieht die Statue nicht schön aus mit der Blume?")
    end
    do_npc_close(npc, ch)
end

