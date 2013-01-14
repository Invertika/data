----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 The Invertika Development Team                        --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"


local function vertox_talk(npc, ch)
    npc_message(npc, ch, "Du benötigst Sprengstoff? Da bist du hier genau richtig!")
    
    while true do 
        local v = npc_choice(npc, ch, "Kaufen.",
                         "Verkaufen.",
                         "Nichts. Danke.")
                                   
        if v == 1 then
            npc_trade(npc, ch, false, { {40025, 20, 650}})
            break
        elseif v == 2 then
            npc_trade(npc, ch, true)
            break
        elseif v == 3 then
            npc_message(npc, ch, "Bis zum nächsten Mal!")
            break
        end
    end
end

atinit(function()
 npc_create("Vertox", 29, GENDER_UNSPECIFIED, 28 * TILESIZE + 16, 25 * TILESIZE + 16, vertox_talk, nil) --- Vertox -> Verkauft Sprengstoff
end)
