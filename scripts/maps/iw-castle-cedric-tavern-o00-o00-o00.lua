----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008-2010 The Invertika Development Team                          --
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
    create_npc("Egam", 19, 19 * TILESIZE + 16, 27 * TILESIZE + 16, egam_talk, nil)
end)

function egam_talk(npc, ch)
    do_message(npc, ch, "Was kann ich für sie tuen?")
    while true do
        local v = do_choice(npc, ch,
          "Kaufen.",
          "Nichts. Danke.")
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {{30009, 25, 150},
              {30010, 25, 150},
              {30011, 290, 205},
              {30012, 70, 150},
              {30014, 25, 1000},
              {30026, 10, 500},
              {30027, 1, 250},
              {30001, 25, 300},
              {30006, 400, 200},
              {30007, 300, 200}})
            break
        elseif v == 2 then
            do_message(npc, ch, "Einen guten Tag noch.")
            break
        end
    end
    do_npc_close(npc, ch)
end
