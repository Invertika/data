----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------


require "scripts/lua/npclib"


atinit(function()
    --TODO Change Sprite ID
    create_npc("Rhosor", 2, 26 * 32 + 16, 38 * TILESIZE + 16, rhosor_talk, nil)
end)

function rhosor_talk(npc, ch)
    do_message(npc, ch, "Tag, Was gibt es?")
    
    while true do
        local v = do_choice(npc, ch,
          "Kaufen.",
          "Verkaufen.",
          "Nichts. Danke.")
                         
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {{10001, 20, 50},
              {10002, 60, 1000},
              {10009, 60, 1000},
              {10011, 100, 2200},
              {10013, 20, 140}
              })
            break
        elseif v == 2 then
            mana.npc_trade(npc, ch, true,
              {{10001, 20, 5},
              {10002, 60, 100},
              {10009, 60, 100},
              {10011, 100, 220},
              {10013, 20, 14}
              })
            break
        elseif v == 3 then
            do_message(npc, ch, "Beehren sie uns bald wieder.")
            break
        end
    end
    do_npc_close(npc, ch)
end