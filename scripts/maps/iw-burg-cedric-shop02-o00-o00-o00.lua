----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                               --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/libs/invertika"

atinit(function()
    --TODO change sprite
    create_npc("Toffi", 81, 22 * TILESIZE + 16, 27 * TILESIZE + 16, toffi_talk, nil)
end)

function toffi_talk(npc, ch)
    do_message(npc, ch, "Tag, Was gibt es?")
    
    while true do
        local v = do_choice(npc, ch,
          "Kaufen.",
          "Verkaufen.",
          "Nichts. Danke.")
                         
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {{10001, 20, 5},
              {10002, 60, 100},
              {10003, 80, 5000},
              {10004, 1, 50},
              {10005, 50, 2500},
              {10006, 50, 30000},
              {10007, 1, 1},
              {10008, 100, 200},
              {10009, 60, 100},
              {10010, 60, 3000},
              {10011, 100, 220},
              {10012, 120, 150000},
              {10013, 20, 14},
              {10014, 120, 100}})
            break
        elseif v == 2 then
            mana.npc_trade(npc, ch, true,
              {{10001, 20, 1},
              {10002, 60, 10},
              {10003, 80, 500},
              {10004, 1, 5},
              {10005, 50, 250},
              {10006, 50, 3000},
              {10007, 1, 1},
              {10008, 100, 20},
              {10009, 60, 10},
              {10010, 60, 300},
              {10011, 100, 22},
              {10012, 120, 15000},
              {10013, 20, 2},
              {10014, 120, 10}})
            break
        elseif v == 3 then
            do_message(npc, ch, "Beehren sie uns bald wieder.")
            break
        end
    end
    do_npc_close(npc, ch)
end
