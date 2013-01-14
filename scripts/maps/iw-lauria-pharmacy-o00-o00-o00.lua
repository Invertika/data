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



atinit(function()
    create_npc("Naltiae", 22, 27 * TILESIZE + 16, 36 * TILESIZE + 16, naltia_talk, nil)
end)

function naltia_talk(npc, ch)
    npc_message(npc, ch, "Möchtest du Medizin kaufen?")
    while true do
        local v = npc_choice(npc, ch, "Ja",
          "Nein")
        if v == 1 then
            npc_trade(npc, ch, true, {
              {30002, 999, 115},
              {30003, 999, 530},
              {30013, 999, 380}
              })
            break
        elseif v == 2 then
            break
        end
    end
    npc_message(npc, ch, "Tschüß")
end