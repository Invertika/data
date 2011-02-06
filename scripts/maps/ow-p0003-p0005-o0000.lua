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

dofile("data/scripts/libs/warp.lua")

atinit(function()
 create_inter_map_warp_trigger(19001, 110, 98, 88) --- Intermap warp
 create_npc("Regret", 8, 55 * TILESIZE + 16, 173 * TILESIZE + 16, regret_talk, nil) --- Nepuret 
end)

function regret_talk(npc, ch)
	do_message(npc, ch, invertika.get_random_element("Verdammt, was mache ich hier? Ich bin im falschen Spiel!",
	    "Ich muss doch nach Leo. Wo bin ich? In Alexia? Gibt es auf unserem Kontinent nicht.",
	    "Ich muss jetzt echt los sonst komme ich zu spät zu der Fortsetzung meiner Spielereihe.",
	    "Wenn ich den kriege der mir das hier eingebrockt hat."))
	do_npc_close(npc, ch)
end