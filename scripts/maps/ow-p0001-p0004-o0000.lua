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
require "scripts/libs/nethek"
dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(77, 87, 75, 65) --- Intermap warp
 nethek.create_netheksaeule(187 * TILESIZE, 173 * TILESIZE + 16) ---Netheksäule
 
 create_npc("Wache", 26, 140 * TILESIZE + 16, 180 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor
 create_npc("Wache", 26, 139 * TILESIZE + 16, 185 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor
 create_npc("Wache", 26, 162 * TILESIZE + 16, 185 * TILESIZE + 16, wache_talk, nil) -- Wache Innentor
end)

function wache_talk(npc, ch)
    if mana.chr_inv_count(ch, 40049) > 0 then
        do_message(npc, ch, "Um denn Zoo zu betreten, brauchst du eine Eintrittskarte.")
	else
	    do_message(npc, ch, "Viel Spaß.")
    end
    do_npc_close(npc, ch)
end
