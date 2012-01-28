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

require "scripts/libs/warp"

atinit(function()
 create_inter_map_warp_trigger(41, 29, 39, 51) --- Intermap warp
 create_npc("Bolum", 42, 26 * TILESIZE + 16, 59 * TILESIZE + 16, nil, nil)
end)

function mikel_talk(npc, ch)
    local queststring = "nelaro_vodel_quests"
    
    --Init Quest
    invertika.init_quest_status(ch, queststring)
    --Get Quest
    local quest_var = invertika.get_quest_status(ch, queststring)
    
    if quest_var == 0 then
        do_message(npc, ch, "..")
    end
    
    if quest_var == 7 then
        do_message(npc, ch, "ah, der alte Vodel hat dich geschickt.")
        do_message(npc, ch, "Du wilst wahrscheinlich die Antwort auf Blubb wissen")
        do_message(npc, ch, "Sie lautet blubb")
        do_message(npc, ch, "Richte ihm bitte schöne Grüße aus.")
        
        --Set Quest
        --Set Quest
        invertika.set_quest_status(ch, queststring_vodel, 7) --Es wurde schon mit dem Vodel geraedet, die Quest angenommen, die zweite Runde ist begonnen und es wurde mit Bolum geredet.
    end
    
    if quest_var > 7
        do_message(npc, ch, "Hi.")
    end
    do_npc_close(npc, ch)
end