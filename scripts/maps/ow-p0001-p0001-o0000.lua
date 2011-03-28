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
require "scripts/libs/nethek"

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_npc("Grabstein", 31, 70 * TILESIZE + 16, 39 * TILESIZE + 16, grabstein_talk, nil) --- Grabstein

 create_inter_map_warp_trigger(74, 84, 72, 62) --- Intermap warp
 nethek.create_netheksaeule(140 * TILESIZE, 43 * TILESIZE + 16) --- Netheksäule
end)

function grabstein_talk(npc, ch)
	do_message(npc, ch, "Ayume\n12430-12470\n\nIn Trauer: Saya und Tetse")
	do_npc_close(npc, ch)
end
