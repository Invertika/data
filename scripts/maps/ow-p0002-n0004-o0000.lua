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
 create_inter_map_warp_trigger(80, 92, 82, 70) --- Intermap warp
 create_npc("Kaler", 36, 79 * TILESIZE + 16, 136 * TILESIZE + 16, kaler_talk, nil)
end)

function kaler_talk(npc, ch)
    mana.npc_trade(npc, ch, false, {
      {30037, 5, 40}
    })
    do_npc_close(npc, ch)
end