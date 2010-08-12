----------------------------------------------------------------------------------
-- Map File                                                                     --
--                                                                              --
-- In dieser Datei stehen die entsprechenden externen NPC's, Trigger und        --
-- anderer Dinge.                                                               --
--                                                                              --
----------------------------------------------------------------------------------
--  Copyright 2008 - 2010 by Invertika Project                                  --
--                                                                              --
--  This file is part of Invertika.                                             --
--                                                                              --
--  Invertika is free software; you can redistribute it and/or modify it        --
--  under the terms of the GNU General  Public License as published by the Free --
--  Software Foundation; either version 2 of the License, or any later version. --
----------------------------------------------------------------------------------

require "scripts/lua/npclib"
require "scripts/ivklibs/invertika"

dofile("data/scripts/ivklibs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19003, 19003, 19003, 19003) --- Intermap warp
 
 --- Zelan
 create_npc("Zelan", 58, 132 * TILESIZE + 16, 21 * TILESIZE + 16, zelan_talk, nil) --- Zelan
end)

function zelan_talk(npc, ch)
    do_message(npc, ch, "Wo du bist? Im Vacare. Jeder neue kommt hier her bevor es raus geht in die große Welt. Also pass auf dich auf.")
	do_npc_close(npc, ch)
end
