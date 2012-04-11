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
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    
    --Get Quest
    local quest_var_flower = invertika.get_quest_status(ch, queststring)
    
    if quest_var_flower == 0 then
        do_message(npc, ch, "Fremde hatten wir hier lange nicht mehr.")
        do_message(npc, ch, "Deshalb können wir euch nicht vertrauen.")
    elseif quest_var_flower == 1 then
        do_message(npc, ch, "Platzhalter")
    end
    do_npc_close(npc, ch)
end