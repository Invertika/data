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


local function betirambo_talk(npc, ch)
    npc_message(npc, ch, invertika.get_random_element("Willst du ein Eis haben?",
      "Ein Eis?"))
    while true do
        local v = npc_choice(npc, ch,
          invertika.get_random_element("Jep",
          "Jap",
          "Jo",
          "Ja"),
          invertika.get_random_element("Nein",
          "Nö",
          "Zu kalt für Eis"))
        if v == 1 then
            npc_trade(npc, ch, false, {
              {30029, 1, 675}
              })
            break
        elseif v == 2 then
            break
        end
    end
    npc_message(npc, ch, "Bis bald")
end

local function betirambo_update(npc)
    --walkaround_map(npc)
end

atinit(function()
 create_inter_map_warp_trigger(43, 31, 41, 53) --- Intermap warp

 --TODO Change Sprite ID
 npc_create("Betirambo", 21, GENDER_UNSPECIFIED, 101 * TILESIZE + 16, 145 * TILESIZE + 16, betirambo_talk, betirambo_update)
end)
