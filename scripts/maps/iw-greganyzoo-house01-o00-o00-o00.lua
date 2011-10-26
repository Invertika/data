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
    --TODO change Sprite id
    create_npc("Geban", 120, 23 * TILESIZE + 16, 27  * TILESIZE + 16, geban_talk, nil)
end)

function geban_talk(npc, ch)
    do_message(npc, ch, "Hallo, was kann ich für sie tuen?")
    
        while true do
        local v = do_choice(npc, ch,
          "Kaufen.",
          "Nichts. Danke.")
                         
        if v == 1 then
            mana.npc_trade(npc, ch, false,
              {10001, 10, 1500}
              })
            break
        elseif v == 2 then
            do_message(npc, ch, "Wiedersehen.")
            break
        end
    end
    do_npc_close(npc, ch)
end
